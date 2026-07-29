<%@ Page Title="Recruiter Registration" Language="C#" MasterPageFile="~/Master/Site1.Master" AutoEventWireup="true" CodeBehind="~/Admin/Registration_JobRecruiter.aspx.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Admin.Registration_JobRecruiter_aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS & FontAwesome -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <style>
        body {
            background-color: #f4f7f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .reg-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            background: #fff;
            margin-top: 30px;
        }

        .card-header-blue {
            background: linear-gradient(135deg, #0d47a1, #1976d2);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 25px;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #444;
            font-size: 14px;
            margin-bottom: 8px;
        }

        /* Dropdown Fix: Height aur Padding adjust kari hai taaki word na kate */
        .form-control {
            border-radius: 8px;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            transition: 0.3s;
            height: 45px !important; /* Fixed Height */
            line-height: 1.5;
        }

        select.form-control {
            padding-right: 30px !important; /* Arrow ke liye space */
        }

        .form-control:focus {
            border-color: #1976d2;
            box-shadow: 0 0 0 0.2rem rgba(25, 118, 210, 0.1);
        }

        .section-title {
            color: #0d47a1;
            border-bottom: 2px solid #eef2f7;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .btn-register-custom {
            background: linear-gradient(135deg, #0d47a1, #1976d2);
            border: none;
            padding: 12px 60px;
            border-radius: 8px;
            font-weight: bold;
            letter-spacing: 0.5px;
            transition: 0.3s;
            color: white;
        }

            .btn-register-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(13,71,161,0.3);
                color: white;
            }

        .upload-box {
            background: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 8px;
            padding: 5px 10px;
            height: 45px;
            display: flex;
            align-items: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-xl-11">

                <div class="card reg-card">
                    <div class="card-header-blue">
                        <h3 class="mb-1">Recruiter Registration Panel</h3>
                        <p class="mb-0 text-white-50">Empower your hiring process by joining us today</p>
                    </div>
                    <div class="card-body p-4 p-md-5">

                        <!-- Account Information -->
                        <div class="section-title"><i class="fas fa-user-shield mr-2"></i>Account Credentials</div>
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Recruiter Name</label>
                                <asp:TextBox ID="txtname" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Business Email</label>
                                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="name@company.com" TextMode="Email"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Password</label>
                                <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Company Details -->
                        <div class="section-title"><i class="fas fa-building mr-2"></i>Company Information</div>
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Recruiter Type</label>
                                <asp:DropDownList ID="ddljrtype" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Contact Person</label>
                                <asp:TextBox ID="txtcontactperson" runat="server" CssClass="form-control" placeholder="HR Manager Name"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Contact Number</label>
                                <asp:TextBox ID="txtcontactnumber" runat="server" CssClass="form-control" placeholder="Phone/Mobile"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Location & Media -->
                        <div class="section-title"><i class="fas fa-map-marker-alt mr-2"></i>Location & Media</div>
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State</label>
                                <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control"
                                    OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City</label>
                                <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Company Logo/Image</label>
                                <div class="upload-box">
                                    <asp:FileUpload ID="fuimage" runat="server" CssClass="form-control-file" />
                                </div>
                            </div>
                        </div>

                        <div class="text-center mt-5">
                            <asp:Button ID="btnregister" runat="server" Text="Complete Registration"
                                OnClick="btnregister_Click1" CssClass="btn-register-custom" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
