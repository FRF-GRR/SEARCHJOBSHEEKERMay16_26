<%@ Page Title="Professional Personal CRUD" Language="C#" MasterPageFile="~/Master/Site1.Master" AutoEventWireup="true" CodeBehind="FullIPresonalCRUD.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Admin.FullIPresonalCRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap & FontAwesome -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />

    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .registration-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            background: #fff;
            margin-top: 25px;
        }

        .card-header-main {
            background: linear-gradient(135deg, #1e3a8a, #2563eb);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 26px;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #444;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            border-radius: 6px;
            padding: 10px;
            border: 1px solid #d1d5db;
        }

        /* GridView Image Styling */
        .gv-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #e2e8f0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .gv-sig {
            width: 80px;
            height: 40px;
            object-fit: contain;
            border: 1px solid #e2e8f0;
            background: #fff;
        }

        .grid-wrapper {
            margin-top: 35px;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .gv-style {
            width: 100%;
            border: none !important;
        }

            .gv-style th {
                background-color: #1e3a8a !important;
                color: white !important;
                padding: 12px !important;
                text-align: center;
                font-size: 13px;
                border: none !important;
            }

            .gv-style td {
                padding: 10px !important;
                text-align: center;
                border-bottom: 1px solid #edf2f7;
                vertical-align: middle;
                font-size: 14px;
            }

        .status-active {
            background: #dcfce7;
            color: #166534;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 11px;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 11px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-lg-5 py-4">
        <div class="row justify-content-center">
            <div class="col-xl-12">

                <!-- Registration Form -->
                <div class="card registration-card">
                    <div class="card-header-main">
                        <h4 class="mb-1 font-weight-bold">Personal Record Management</h4>
                        <p class="mb-0 text-white-50">Fill details and upload documents</p>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Contact</label>
                                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Aadhar</label>
                                <asp:TextBox ID="txtAddhar" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">DOB</label>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Photo</label>
                                <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control-file border p-1 rounded" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Signature</label>
                                <asp:FileUpload ID="fuSignature" runat="server" CssClass="form-control-file border p-1 rounded" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <asp:Button ID="btnSubmit" runat="server" Text="Save Record" OnClick="btnSubmit_Click1" CssClass="btn btn-primary btn-block py-2 font-weight-bold" />
                        </div>
                    </div>
                </div>

                <!-- Records Display -->
                <div class="grid-wrapper">
                    <h5 class="text-primary font-weight-bold mb-4 border-bottom pb-2">System Database Records</h5>
                    <div class="table-responsive">
                        <asp:GridView ID="gvpshow" runat="server" AutoGenerateColumns="False" CssClass="table table-hover gv-style" GridLines="None" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate><b><%# Eval("pid") %></b></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Photo">
                                    <ItemTemplate>
                                        <asp:Image ID="imgP" runat="server" ImageUrl='<%# "~/Admin/PImgSave/" + Eval("pimage") %>' CssClass="gv-image" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate><%# Eval("pname") %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact">
                                    <ItemTemplate><%# Eval("pcontact") %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Aadhar">
                                    <ItemTemplate><small><%# Eval("paddhar") %></small></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Signature">
                                    <ItemTemplate>
                                        <asp:Image ID="imgS" runat="server" ImageUrl='<%# "~/Admin/PImgSave/" + Eval("psignature") %>' CssClass="gv-sig" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Eval("pstatus").ToString() == "1" ? "status-active" : "status-inactive" %>'>
                                            <%# Eval("pstatus").ToString() == "1" ? "ACTIVE" : "INACTIVE" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Added On">
                                    <ItemTemplate><small class="text-muted"><%# Eval("pdatetime") %></small></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
