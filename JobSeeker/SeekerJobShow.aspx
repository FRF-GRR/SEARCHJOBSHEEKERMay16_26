<%@ Page Title="Job Search" Language="C#" MasterPageFile="~/Master/JobSeekerMaster.Master" AutoEventWireup="true" CodeBehind="SeekerJobShow.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobSeeker.SeekerJobShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap & FontAwesome -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <style>
        body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, sans-serif; }
        
        /* Main Page Container */
        .page-card-modern {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 25px;
            margin-top: 20px;
        }

        /* Responsive Header: Title and Search Section */
        .header-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .page-title { font-size: 26px; font-weight: 800; color: #1e3a8a; margin: 0; }

        /* Modern Search Styling */
        .search-area { flex: 1; max-width: 500px; margin: 10px 20px; }
        .input-group-custom { display: flex; box-shadow: 0 2px 8px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden; }
        .search-input { border: 1px solid #dee2e6; border-right: none; height: 45px !important; font-size: 14px; }
        .btn-search-custom { background: #1e3a8a; color: white; border: none; padding: 0 25px; font-weight: 600; transition: 0.3s; }
        .btn-search-custom:hover { background: #1e40af; color: white; }

        .btn-history {
            background: #f8fafc;
            color: #1e3a8a;
            border: 1px solid #e2e8f0;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-history:hover { background: #1e3a8a; color: white; transform: translateY(-1px); }

        /* GridView Professional Styling */
        .gv-modern { width: 100%; border: none !important; }
        .gv-modern th { background: #1e3a8a !important; color: white !important; padding: 15px !important; font-size: 13px; text-transform: uppercase; text-align: center; border: none !important; }
        .gv-modern td { padding: 12px !important; border-bottom: 1px solid #f1f5f9; text-align: center; font-size: 14px; vertical-align: middle; color: #334155; }
        .gv-modern tr:hover { background-color: #f8fafc; }

        /* Status Badges */
        .badge-pill-custom { padding: 5px 12px; border-radius: 50px; font-size: 11px; font-weight: bold; color: white; display: inline-block; }
        .badge-exp { background: #10b981; }
        .badge-salary { background: #f59e0b; }
        .badge-vacancy { background: #ef4444; }

        .btn-apply { background: #1e3a8a; border: none; color: white; padding: 6px 20px; border-radius: 6px; font-weight: bold; transition: 0.3s; }
        .btn-apply:hover { background: #1e40af; transform: scale(1.05); }

        #appliedSection { display: none; margin-top: 30px; animation: fadeIn 0.4s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        @media (max-width: 768px) {
            .header-section { flex-direction: column; text-align: center; }
            .search-area { max-width: 100%; width: 100%; margin: 20px 0; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid">
        <div class="page-card-modern">
            
            <!-- Header: Title, Search & Toggle Button -->
            <div class="header-section">
                <h2 class="page-title"><i class="fas fa-search-dollar mr-2"></i>Find Your Job</h2>
                
                <div class="search-area">
                    <div class="input-group-custom">
                        <asp:TextBox runat="server" ID="txtSearchJob" CssClass="form-control search-input" placeholder="Search by company, profile, or location..."></asp:TextBox>
                        <asp:Button ID="btnSearchJob" runat="server" Text="Search" OnClick="btnSearchJob_Click" CssClass="btn-search-custom" />
                    </div>
                </div>

                <button type="button" class="btn-history" onclick="toggleAppliedJobs()">
                    <i class="fas fa-history mr-2"></i>My Applications
                </button>
            </div>

            <!-- Main Job Listing Grid -->
            <div class="table-responsive">
                <asp:GridView ID="gvjobshow" runat="server" AutoGenerateColumns="False"
                    OnRowDataBound="gvjobshow_RowDataBound" CssClass="gv-modern" GridLines="None" UseAccessibleHeader="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Job ID">
                            <ItemTemplate><span class="text-muted small">#<%# Eval("JobPostId") %></span></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Company & Profile">
                            <ItemTemplate>
                                <div class="text-left px-3">
                                    <div class="font-weight-bold text-dark" style="font-size:15px;"><%# Eval("JRName") %></div>
                                    <div class="text-primary small"><i class="fas fa-user-tag mr-1"></i><%# Eval("JName") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Requirements">
                            <ItemTemplate>
                                <span class="badge-pill-custom badge-exp"><%# Eval("JobPostMinExp") %>-<%# Eval("JobPostMaxExp") %> Yrs</span><br />
                                <span class="badge-pill-custom badge-vacancy mt-1"><%# Eval("JobPostVacancy") %> Openings</span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Package">
                            <ItemTemplate>
                                <span class="badge-pill-custom badge-salary">₹ <%# Eval("JobPostMinSalary") %> - ₹ <%# Eval("JobPostMaxSalary") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                <small class="text-muted"><i class="fas fa-map-marker-alt text-danger mr-1"></i><%# Eval("Cname") %>, <%# Eval("Sname") %></small>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnn" runat="server" CommandArgument='<%# Eval("JobPostId") %>'
                                    OnCommand="btnn_Command" Text="Apply Now" CssClass="btn-apply" />
                                <asp:Label ID="lblApplied" runat="server" Text="✔ Applied" Visible="false"
                                    Style="background: #e2e8f0; color: #475569; padding: 6px 14px; border-radius: 6px; font-size: 12px; font-weight: bold;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="thead-dark" />
                </asp:GridView>
            </div>
        </div>

        <!-- Hidden Applied Jobs Section -->
        <div id="appliedSection" class="page-card-modern" style="border-left: 5px solid #1e3a8a;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="text-primary font-weight-bold mb-0"><i class="fas fa-clipboard-check mr-2"></i>My Applied Job History</h4>
                <button type="button" class="btn btn-sm btn-light" onclick="toggleAppliedJobs()"><i class="fas fa-times"></i></button>
            </div>

            <div class="table-responsive">
                <asp:GridView runat="server" ID="gvappledjobshow" AutoGenerateColumns="false"
                    CssClass="table table-hover gv-modern" GridLines="None"
                    OnRowCommand="gvappledjobshow_RowCommand" UseAccessibleHeader="true">
                    <Columns>
                        <asp:BoundField DataField="JobId" HeaderText="ID" />
                        <asp:BoundField DataField="JSJobApplyName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Contact Info">
                            <ItemTemplate>
                                <small><%#Eval("JSJobApplyEmail") %><br /><b><%#Eval("JSJobApplyContact") %></b></small>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CurrentCompany" HeaderText="Previous Co." />
                        <asp:TemplateField HeaderText="Resume">
                            <ItemTemplate>
                                <a href='<%# ResolveUrl(Eval("ResumePath").ToString()) %>' target="_blank" class="text-primary"><i class="fas fa-external-link-alt"></i> View</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Applied On">
                            <ItemTemplate><%#Eval("AppliedDate", "{0:dd-MMM-yyyy}") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Management">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" Text="Edit" CommandArgument='<%#Eval("JSJobApplyID") %>' CommandName="edit1" CssClass="btn btn-sm btn-info py-1 px-2 mb-1" style="font-size:11px;" />
                                <asp:Button ID="btndelete" runat="server" Text="Delete" CommandArgument='<%#Eval("JSJobApplyID") %>' CommandName="delete1" CssClass="btn btn-sm btn-danger py-1 px-2" style="font-size:11px;" OnClientClick="return confirm('Remove this application?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="bg-dark text-white" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- JavaScript Toggle -->
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