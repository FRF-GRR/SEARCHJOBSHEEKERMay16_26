<%@ Page Title="JobSeeker Registration" Language="C#" MasterPageFile="~/Master/Site1.Master" AutoEventWireup="true" CodeBehind="~/Admin/Registration_Jobsheeker.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Admin.Registration_Jobsheeker" %>

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
            margin-bottom: 50px;
        }

        .card-header-blue {
            background: linear-gradient(135deg, #007bff, #0056b3);
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

        /* Dropdown Fix: Word na kate iske liye height aur padding */
        .form-control {
            border-radius: 8px;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            height: 45px !important;
            line-height: 1.5;
            transition: 0.3s;
        }

        select.form-control {
            padding-right: 30px !important;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.1);
        }

        .section-title {
            color: #007bff;
            border-bottom: 2px solid #eef2f7;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 1.1rem;
            margin-top: 10px;
        }

        /* List Controls (Gender/Hobbies) */
        .list-control label {
            margin-left: 8px;
            margin-right: 20px;
            font-weight: 400;
            cursor: pointer;
            color: #555;
        }

        .list-control input {
            cursor: pointer;
        }

        .btn-register-custom {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border: none;
            padding: 12px 60px;
            border-radius: 8px;
            font-weight: bold;
            letter-spacing: 0.5px;
            transition: 0.3s;
            color: white;
            font-size: 18px;
        }

            .btn-register-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(0,123,255,0.3);
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
                        <h3 class="mb-1">JobSeeker Registration</h3>
                        <p class="mb-0 text-white-50">Create your professional profile and find your dream job</p>
                    </div>
                    <div class="card-body p-4 p-md-5">

                        <!-- Personal Details Section -->
                        <div class="section-title"><i class="fas fa-user mr-2"></i>Personal Information</div>
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Full Name</label>
                                <asp:TextBox ID="textName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Email Address</label>
                                <asp:TextBox ID="textEmail" runat="server" CssClass="form-control" placeholder="name@email.com" TextMode="Email"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Password</label>
                                <asp:TextBox ID="textPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="form-label">Gender Selection</label>
                            <div class="list-control p-2 border rounded bg-light">
                                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="1" Text="Male"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Female"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Transgender"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>

                        <!-- Professional Details Section -->
                        <div class="section-title"><i class="fas fa-briefcase mr-2"></i>Professional Details</div>
                        <div class="row mb-4">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Desired Job Profile</label>
                                <asp:DropDownList ID="ddlJobProfile" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="form-label">Hobbies / Key Skills</label>
                            <div class="list-control border rounded p-3 bg-light">
                                <asp:CheckBoxList ID="cblHobbies" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" RepeatLayout="Table" Width="100%"></asp:CheckBoxList>
                            </div>
                        </div>

                        <!-- Location & Identity Section -->
                        <div class="section-title"><i class="fas fa-map-marker-alt mr-2"></i>Location & Identity</div>
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State</label>
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"
                                    OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City</label>
                                <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Profile Image</label>
                                <div class="upload-box">
                                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control-file" />
                                </div>
                                <small class="text-muted">Max size 2MB (JPG/PNG)</small>
                            </div>
                        </div>

                        <!-- Action Button -->
                        <div class="text-center mt-5">
                            <asp:Button ID="btnRegister" runat="server" Text="Register Now"
                                OnClick="btnRegister_Click" CssClass="btn-register-custom" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
