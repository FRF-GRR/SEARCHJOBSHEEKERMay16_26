<%@ Page Title="User Information" Language="C#" MasterPageFile="~/Master/Site1.Master" AutoEventWireup="true" CodeBehind="~/Admin/PrashantInformation.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Admin.personalInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS for Modern UI -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            padding-top: 40px;
            padding-bottom: 50px;
        }

        .info-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            background-color: #ffffff;
        }

        .card-header-blue {
            background: #007bff;
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 25px;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-top: 10px;
        }

        .btn-custom {
            background: #007bff;
            border: none;
            padding: 12px 40px;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s;
            border-radius: 8px;
        }

            .btn-custom:hover {
                background: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,123,255,0.3);
            }

        /* GridView Header and Row Styling */
        .table-container {
            margin-top: 40px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .gv-style {
            width: 100%;
            border: none !important;
        }

            .gv-style th {
                background-color: #007bff !important;
                color: white !important;
                padding: 15px !important;
                border: none !important;
            }

            .gv-style td {
                padding: 12px !important;
                vertical-align: middle;
                border-bottom: 1px solid #eee;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container main-container">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <!-- Input Section -->
                <div class="card info-card">
                    <div class="card-header-blue">
                        <h3 class="mb-1">Personal Information</h3>
                        <p class="mb-0 text-white-50">Manage your profile details below</p>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label class="form-label">User Name</label>
                                <asp:TextBox ID="textname" runat="server" CssClass="form-control form-control-lg" placeholder="Enter full name"></asp:TextBox>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">User Email</label>
                                <asp:TextBox ID="textemail" runat="server" CssClass="form-control form-control-lg" placeholder="example@mail.com"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label class="form-label">Phone Number</label>
                                <asp:TextBox ID="textphone" runat="server" CssClass="form-control" placeholder="+91 XXXXX XXXXX"></asp:TextBox>
                            </div>
                            <div class="col-md-4 form-group">
                                <label class="form-label">Date of Birth</label>
                                <asp:TextBox ID="textdob" runat="server" CssClass="form-control" placeholder="MM-DD-YYYY"></asp:TextBox>
                            </div>
                            <div class="col-md-4 form-group">
                                <label class="form-label">Current Salary</label>
                                <asp:TextBox ID="textsalary" runat="server" CssClass="form-control" placeholder="Monthly INR"></asp:TextBox>
                            </div>
                        </div>


                        <div class="text-center mt-4">
                            <asp:Button ID="btnsubmit" runat="server" Text="Save Information" OnClick="btnsubmit_Click" CssClass="btn btn-primary btn-custom" />
                        </div>
                    </div>
                </div>

                <!-- GridView Display Section -->
                <div class="table-container">
                    <h4 class="mb-4 text-primary border-bottom pb-2">Registered Users Database</h4>
                    <div class="table-responsive">
                        <asp:GridView ID="gvUsers" runat="server"
                            CssClass="table table-hover gv-style"
                            GridLines="None" CellPadding="4" ForeColor="#333333">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle CssClass="thead-dark" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS (Optional for functionality) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
