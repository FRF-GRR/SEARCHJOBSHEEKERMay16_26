<%@ Page Title="Job Search" Language="C#" MasterPageFile="~/Master/JobSeekerMaster.Master" AutoEventWireup="true" CodeBehind="SeekerJobShow.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobSeeker.SeekerJobShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        .page-card {
            max-width: 100%;
            margin: 20px auto;
            background: #ffffff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }

        /* Header Layout: Title and Button side-by-side */
        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #eef2f7;
            padding-bottom: 15px;
        }

        .page-title-modern {
            font-size: 28px;
            font-weight: 800;
            color: #1e3a8a;
            margin: 0;
        }

        .btn-toggle-view {
            background: #2563eb;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.3s;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
        }

            .btn-toggle-view:hover {
                background: #1e40af;
                transform: translateY(-1px);
                color: white;
                text-decoration: none;
            }

        /* GridView Styling */
        .grid-modern {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
        }

            .grid-modern th {
                background: #1e3a8a;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 14px;
                border: none !important;
            }

            .grid-modern td {
                padding: 12px;
                border-bottom: 1px solid #edf2f7;
                text-align: center;
                font-size: 14px;
                vertical-align: middle;
            }

            .grid-modern tr:hover {
                background: #f8fafc;
                transition: 0.2s;
            }

        .badge-custom {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
            color: white;
            display: inline-block;
        }

        .bg-exp {
            background: #10b981;
        }

        .bg-salary {
            background: #f59e0b;
        }

        .bg-vacancy {
            background: #ef4444;
        }

        /* Hidden Section Animation */
        #appliedSection {
            display: none;
            margin-top: 30px;
            animation: slideDown 0.4s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-apply-main {
            background: #16a34a;
            border: none;
            padding: 6px 18px;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.3s;
        }

            .btn-apply-main:hover {
                background: #15803d;
                transform: scale(1.05);
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid">
        <div class="page-card">

            <!-- Header with Toggle Button -->
            <div class="header-flex">
                <h2 class="page-title-modern"><i class="fas fa-briefcase mr-2"></i>Job Post Show</h2>
                <button type="button" class="btn-toggle-view" onclick="toggleAppliedJobs()">
                    <i class="fas fa-history mr-2"></i>Applied Job Show
                </button>
            </div>

            <!-- Main Job Show Grid -->
            <div class="table-responsive">
                <asp:GridView ID="gvjobshow" runat="server" AutoGenerateColumns="False"
                    OnRowDataBound="gvjobshow_RowDataBound" CssClass="grid-modern" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Job ID">
                            <ItemTemplate><b class="text-primary"><%# Eval("JobPostId") %></b></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Company">
                            <ItemTemplate><span class="font-weight-bold"><%# Eval("JRName") %></span></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Job Profile">
                            <ItemTemplate><span class="text-dark"><%# Eval("JName") %></span></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Experience">
                            <ItemTemplate>
                                <span class="badge-custom bg-exp"><%# Eval("JobPostMinExp") %>-<%# Eval("JobPostMaxExp") %> Yrs</span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Salary Package">
                            <ItemTemplate>
                                <span class="badge-custom bg-salary">₹<%# Eval("JobPostMinSalary") %>-<%# Eval("JobPostMaxSalary") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate><i class="fas fa-map-marker-alt text-danger mr-1"></i><%# Eval("Cname") %>, <%# Eval("Sname") %></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Vacancies">
                            <ItemTemplate><span class="badge-custom bg-vacancy"><%# Eval("JobPostVacancy") %></span></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnn" runat="server" CommandArgument='<%# Eval("JobPostId") %>'
                                    OnCommand="btnn_Command" Text="Apply Now" CssClass="btn btn-sm btn-apply-main text-white" />
                                <asp:Label ID="lblApplied" runat="server" Text="✔ Applied" Visible="false"
                                    Style="background: #6b7280; color: white; padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: bold;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Hidden Section for Applied Jobs -->
        <div id="appliedSection" class="page-card" style="border-top: 4px solid #2563eb;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="text-primary font-weight-bold mb-0"><i class="fas fa-check-circle mr-2"></i>My Applied Job Records</h4>
                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="toggleAppliedJobs()">Close</button>
            </div>

            <div class="table-responsive">
                <asp:GridView runat="server" ID="gvappledjobshow" AutoGenerateColumns="false"
                    CssClass="table table-hover grid-modern" GridLines="None"
                    OnRowCommand="gvappledjobshow_RowCommand" UseAccessibleHeader="true">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate><%#Eval("JobId") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="JSJobApplyName" HeaderText="Candidate" />
                        <asp:BoundField DataField="JSJobApplyEmail" HeaderText="Email" />
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <small><b>Loca:</b> <%#Eval("CurrentLocation") %><br />
                                    <b>Exp:</b> <%#Eval("Experience") %></small>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CurrentCompany" HeaderText="Company" />
                        <asp:BoundField DataField="ExpectedSalary" HeaderText="Salary" />
                        <asp:TemplateField HeaderText="Resume">
                            <ItemTemplate>
                                <a href='<%# ResolveUrl(Eval("ResumePath").ToString()) %>' target="_blank" class="text-danger"><i class="fas fa-file-pdf"></i>View</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Skills">
                            <ItemTemplate><small><%#Eval("Skills") %></small></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AppliedDate" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" Text="Edit" CommandArgument='<%#Eval("JSJobApplyID") %>' CommandName="edit1" CssClass="btn btn-xs btn-primary py-1 px-2 mb-1" Style="font-size: 11px;" />
                                <asp:Button ID="btndelete" runat="server" Text="Delete" CommandArgument='<%#Eval("JSJobApplyID") %>' CommandName="delete1" CssClass="btn btn-xs btn-danger py-1 px-2" Style="font-size: 11px;" OnClientClick="return confirm('Delete this application?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="bg-dark text-white" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Toggle Script -->
    <script type="text/javascript">
        function toggleAppliedJobs() {
            var section = document.getElementById('appliedSection');
            if (section.style.display === 'none' || section.style.display === '') {
                section.style.display = 'block';
                window.scrollTo({ top: section.offsetTop - 50, behavior: 'smooth' });
            } else {
                section.style.display = 'none';
            }
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
