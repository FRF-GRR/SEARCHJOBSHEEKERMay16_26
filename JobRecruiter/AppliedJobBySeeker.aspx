<%@ Page Title="Job Applications" Language="C#" MasterPageFile="~/Master/JobRecruiterMaster.Master" AutoEventWireup="true" CodeBehind="AppliedJobBySeeker.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobRecruiter.AppliedJobBySeeker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap & FontAwesome Icons -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />

    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        .dashboard-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            background: #fff;
            margin-bottom: 30px;
        }

        .card-header-blue {
            background: linear-gradient(135deg, #1e3a8a, #2563eb);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 20px;
        }

        /* GridView Styling */
        .gv-custom {
            width: 100%;
            border: none !important;
        }

            .gv-custom th {
                background-color: #f8fafc !important;
                color: #1e3a8a !important;
                padding: 15px !important;
                text-align: center;
                border-bottom: 2px solid #dee2e6 !important;
                font-size: 12px;
                text-transform: uppercase;
            }

            .gv-custom td {
                padding: 12px !important;
                text-align: center;
                border-bottom: 1px solid #edf2f7;
                font-size: 14px;
                vertical-align: middle;
                color: #444;
            }

            .gv-custom tr:hover {
                background-color: #f1f5f9;
                transition: 0.2s;
            }

        /* Action Buttons */
        .btn-action {
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 12px;
            font-weight: 600;
            border: none;
            transition: 0.3s;
            margin: 2px;
        }

        .btn-approve {
            background-color: #10b981;
            color: white;
        }

        .btn-reject {
            background-color: #ef4444;
            color: white;
        }

        /* Links */
        .view-details-btn {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid #2563eb;
            padding: 3px 8px;
            border-radius: 4px;
            transition: 0.3s;
            font-size: 11px;
        }

            .view-details-btn:hover {
                background: #2563eb;
                color: white;
                text-decoration: none;
            }

        .resume-link {
            color: #dc2626;
            font-weight: 600;
            text-decoration: none;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 15px;
            border: none;
        }

        .modal-header {
            background: #1e3a8a;
            color: white;
            border-radius: 15px 15px 0 0;
        }

        .detail-row {
            border-bottom: 1px solid #f1f1f1;
            padding: 8px 0;
        }

        .detail-label {
            font-weight: bold;
            color: #1e3a8a;
            width: 140px;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid py-4">
        <div class="card dashboard-card">
            <div class="card-header-blue d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="fas fa-users-cog mr-2"></i>Job Applications Management</h4>
                <span class="badge badge-light p-2 text-primary font-weight-bold">Recruiter Panel</span>
            </div>

            <div class="card-body p-0">
                <div class="table-responsive">

                    <asp:GridView ID="GridViewApplications" runat="server" AutoGenerateColumns="false"
                        CssClass="table gv-custom" GridLines="None"
                        OnRowCommand="GridViewApplications_RowCommand"
                        DataKeyNames="JSJobApplyID,JSJobApplyEmail,JSJobApplyName"
                        OnRowDataBound="GridViewApplications_RowDataBound"
                        UseAccessibleHeader="true">
                        <Columns>
                            <asp:BoundField DataField="JSJobApplyID" HeaderText="App ID" />

                            <asp:TemplateField HeaderText="Candidate">
                                <ItemTemplate>
                                    <div class="font-weight-bold text-dark"><%# Eval("JSJobApplyName") %></div>
                                    <a href="javascript:void(0);" class="view-details-btn mt-1 d-inline-block"
                                        onclick='showDetails("<%# Eval("JSJobApplyName") %>", "<%# Eval("JSJobApplyEmail") %>", "<%# Eval("JSJobApplyContact") %>", "<%# Eval("CurrentCompany") %>", "<%# Eval("CurrentLocation") %>", "<%# Eval("Experience") %>", "<%# Eval("Skills") %>")'>
                                        <i class="fas fa-eye mr-1"></i>View Profile
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="JName" HeaderText="Job Profile" />
                            <asp:BoundField DataField="CurrentCompany" HeaderText="Current Co." />
                            <asp:BoundField DataField="CurrentLocation" HeaderText="Current Location" />
                            <asp:BoundField DataField="AppliedDate" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}" />

                            <asp:TemplateField HeaderText="Documents">
                                <ItemTemplate>
                                    <a href='<%# ResolveUrl(Eval("ResumePath").ToString()) %>' target="_blank" class="resume-link">
                                        <i class="fas fa-file-pdf mr-1"></i>Resume
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" CssClass="font-weight-bold small"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-center">
                                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="Approve"
                                            CommandArgument='<%# Eval("JSJobApplyID") %>' CssClass="btn-action btn-approve" />
                                        <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="Reject"
                                            CommandArgument='<%# Eval("JSJobApplyID") %>' CssClass="btn-action btn-reject" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Candidate Details Modal -->
    <div class="modal fade" id="detailsModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-circle mr-2"></i>Candidate Profile</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-4">
                    <div class="detail-row"><span class="detail-label">Name:</span> <span id="detName"></span></div>
                    <div class="detail-row"><span class="detail-label">Email:</span> <span id="detEmail"></span></div>
                    <div class="detail-row"><span class="detail-label">Contact:</span> <span id="detContact"></span></div>
                    <div class="detail-row"><span class="detail-label">Current Company:</span> <span id="detCompany"></span></div>
                    <div class="detail-row"><span class="detail-label">Current Location:</span> <span id="detLocation"></span></div>
                    <div class="detail-row"><span class="detail-label">Experience:</span> <span id="detExp"></span></div>
                    <div class="detail-row"><span class="detail-label">Skills:</span> <span id="detSkills" class="text-muted small"></span></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript to Handle the Modal -->
    <script type="text/javascript">
        function showDetails(name, email, contact, company, location, exp, skills) {
            document.getElementById('detName').innerText = name;
            document.getElementById('detEmail').innerText = email;
            document.getElementById('detContact').innerText = contact;
            document.getElementById('detCompany').innerText = company;
            document.getElementById('detLocation').innerText = location;
            document.getElementById('detExp').innerText = exp;
            document.getElementById('detSkills').innerText = skills;
            $('#detailsModal').modal('show');
        }
    </script>

    <!-- Bootstrap JS Dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
