<%@ Page Title="Post a Job" Language="C#" MasterPageFile="~/Master/JobRecruiterMaster.Master" AutoEventWireup="true" CodeBehind="~/JobRecruiter/JobRecruiterJobPost.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobRecruiter.JobRecruiterJobPost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS for modern layout -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .page-card { border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); background: #fff; margin-bottom: 30px; }
        .card-header-blue { background: #1e3a8a; color: white; border-radius: 12px 12px 0 0 !important; padding: 20px; text-align: center; }
        .form-label { font-weight: 600; color: #444; margin-bottom: 5px; font-size: 14px; }
        .form-control:focus { border-color: #1e3a8a; box-shadow: 0 0 0 0.2rem rgba(30, 58, 138, 0.15); }
        
        /* GridView Styling */
        .grid-wrapper { overflow-x: auto; background: white; border-radius: 12px; padding: 15px; }
        .gv-custom { width: 100%; border: none !important; margin-bottom: 0; }
        .gv-custom th { background-color: #1e3a8a !important; color: white !important; padding: 15px !important; text-align: center; border: none !important; font-size: 13px; text-transform: uppercase; }
        .gv-custom td { padding: 12px !important; text-align: center; border-bottom: 1px solid #edf2f7; font-size: 14px; vertical-align: middle; }
        .gv-custom tr:hover { background-color: #f8fafc; transition: 0.2s; }

        .btn-status { border-radius: 20px; padding: 4px 15px; font-size: 12px; font-weight: 600; text-transform: uppercase; border: none; }
        .btn-action { border-radius: 6px; padding: 6px 12px; font-size: 13px; font-weight: 600; border: none; color: white; transition: 0.3s; }
        .btn-delete { background-color: #ef4444; }
        .btn-delete:hover { background-color: #dc2626; transform: scale(1.05); }
        .btn-edit { background-color: #10b981; }
        .btn-edit:hover { background-color: #059669; transform: scale(1.05); }
        .btn-submit-main { background: linear-gradient(135deg,#1e3a8a,#2563eb); border: none; padding: 12px 40px; border-radius: 8px; font-weight: bold; letter-spacing: 0.5px; transition: 0.3s; }
        .btn-submit-main:hover { transform: translateY(-2px); box-shadow: 0 10px 15px rgba(30,58,138,0.25); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid py-4">
        <div class="row justify-content-center">
            <div class="col-xl-11">
                
                <!-- Job Post Form Card -->
                <div class="card page-card">
                    <div class="card-header-blue">
                        <h3 class="mb-1">Post a New Job Opportunity</h3>
                        <p class="mb-0 text-white-50">Enter job details to attract the best talent</p>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        
                        <!-- Row 1: 3 Columns -->
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Job Profile</label>
                                <asp:DropDownList ID="ddljp" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Minimum Experience</label>
                                <asp:DropDownList ID="ddlminexp" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Fresher" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="1 year" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2 year" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3 year" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4 year" Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Maximum Experience</label>
                                <asp:DropDownList ID="ddlmaxexp" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Fresher" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="1 year" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2 year" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3 year" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4 year" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5 year" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6 year" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7 year" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8 year" Value="8"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <!-- Row 2: 3 Columns -->
                        <div class="row mt-2">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Minimum Salary</label>
                                <asp:TextBox ID="minsalary" runat="server" CssClass="form-control" placeholder="e.g. 20000"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Maximum Salary</label>
                                <asp:TextBox ID="maxsalary" runat="server" CssClass="form-control" placeholder="e.g. 50000"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Number of Vacancies</label>
                                <asp:TextBox ID="numberofvacancies" runat="server" CssClass="form-control" placeholder="Total openings"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Row 3: 3 Columns (Using 2 cols for Location) -->
                        <div class="row mt-2">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Job Location State</label>
                                <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged1" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Job Location City</label>
                                <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="text-center mt-4">
                            <asp:Button ID="btnjobpost" runat="server" Text="Submit Post" OnClick="btnsubmit_Click" CssClass="btn btn-primary btn-submit-main" />
                        </div>
                    </div>
                </div>

                <!-- GridView Display Card -->
                <div class="card page-card">
                    <div class="p-3 border-bottom d-flex align-items-center justify-content-between">
                        <h5 class="mb-0 text-primary font-weight-bold">Recent Job Posts</h5>
                        <span class="badge badge-primary">Database Records</span>
                    </div>
                    <div class="card-body">
                        <div class="grid-wrapper">
                            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView> <br /> <br />
                            <asp:GridView ID="gvjobshow" runat="server" AutoGenerateColumns="False" 
                                OnRowCommand="gvjobshow_RowCommand" 
                                CssClass="table gv-custom" 
                                GridLines="None" 
                                UseAccessibleHeader="true">
                                <Columns>

                                    <asp:TemplateField HeaderText="ID">
                                        <ItemTemplate><%#Eval("JobPostId") %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Profile">
                                        <ItemTemplate><b><%#Eval("JobPostJobProfile") %></b></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Exp (Yrs)">
                                        <ItemTemplate><%#Eval("JobPostMinExp")%> - <%#Eval("JobPostMaxExp") %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Salary (Monthly)">
                                        <ItemTemplate>₹<%#Eval("JobPostMinSalary")%>- ₹<%#Eval("JobPostMaxSalary") %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Location">
                                        <ItemTemplate><%#Eval("JobPostState") %>, <%#Eval("JobPostCity") %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vacancy">
                                        <ItemTemplate><span class="badge badge-light p-2"><%#Eval("JobPostVacancy") %></span></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label id="lblStatus" visible="false" runat="server" Text='<%# Eval("JobPostStatus") %>' > </asp:Label>
                                            <asp:Button ID="btnstatus" runat="server" 
                                                CommandName="ChangeStatus" 
                                                CommandArgument='<%# Eval("JobPostId") %>' 
                                                Text='<%# Convert.ToInt32(Eval("JobPostStatus"))==1 ? "Active" : "Inactive" %>' 
                                                CssClass='<%# Convert.ToInt32(Eval("JobPostStatus"))==1 ? "btn-status bg-success text-white" : "btn-status bg-danger text-white" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:Button ID="btnedit" runat="server" Text="Edit" CommandArgument='<%# Eval("JobPostId") %>' CommandName="Edit1" CssClass="btn-action btn-edit mr-1" />
                                            <asp:Button ID="btndelete" runat="server" Text="Delete" CommandArgument='<%# Eval("JobPostId") %>' CommandName="Delete1" CssClass="btn-action btn-delete" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="thead-dark" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap & Popper JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>