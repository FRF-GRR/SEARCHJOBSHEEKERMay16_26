<%@ Page Title="Login - Search Job" Language="C#" MasterPageFile="~/Master/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap & FontAwesome Icons -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />

    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            background: #fff;
            margin-top: 50px;
        }

        .login-header {
            background: #007bff;
            color: white;
            padding: 30px;
            text-align: center;
        }

            .login-header h3 {
                font-weight: 700;
                margin-bottom: 5px;
            }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

            .form-group i {
                position: absolute;
                left: 15px;
                top: 42px;
                color: #007bff;
                z-index: 10;
            }

        .form-control {
            border-radius: 8px;
            padding-left: 45px;
            height: 50px;
            border: 1px solid #e1e5eb;
            transition: 0.3s;
        }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.1);
            }

        .btn-login {
            background: #007bff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            transition: 0.3s;
            width: 100%;
            color: white;
        }

            .btn-login:hover {
                background: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

        .label-error {
            display: block;
            text-align: center;
            font-weight: 600;
            margin-top: 15px;
            font-size: 14px;
        }

        .usertype-dropdown {
            background-image: url('https://cdn0.iconfinder.com/data/icons/ui-grid-6/128/Arrow_Down-512.png');
            background-position: right 15px center;
            background-size: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card login-card">
                    <div class="login-header">
                        <i class="fas fa-user-lock fa-3x mb-3"></i>
                        <h3>Secure Login</h3>
                        <p class="mb-0 text-white-50">Welcome back! Please login to your account.</p>
                    </div>
                    <div class="card-body p-4 p-md-5">

                        <!-- User Type Selection -->
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">USER CATEGORY</label>
                            <i class="fas fa-users"></i>
                            <asp:DropDownList ID="ddlUsertype" runat="server" CssClass="form-control usertype-dropdown">
                                <asp:ListItem Value="0" Text="Select User Type"></asp:ListItem>
                                <asp:ListItem Value="1" Text="JobSeeker"></asp:ListItem>
                                <asp:ListItem Value="2" Text="JobRecruiter"></asp:ListItem>
                                <asp:ListItem Value="3" Text="Admin"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Email Input -->
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">EMAIL ADDRESS</label>
                            <i class="fas fa-envelope"></i>
                            <asp:TextBox ID="TextEmail" runat="server" CssClass="form-control" placeholder="example@mail.com" TextMode="Email"></asp:TextBox>
                        </div>

                        <!-- Password Input -->
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">PASSWORD</label>
                            <i class="fas fa-key"></i>
                            <asp:TextBox ID="TextPassword" runat="server" CssClass="form-control" placeholder="••••••••" TextMode="Password"></asp:TextBox>
                        </div>

                        <!-- Login Button -->
                        <div class="mt-4">
                            <asp:Button ID="ButtonLogin" runat="server" Text="Login to Dashboard" OnClick="ButtonLogin_Click" CssClass="btn-login" />
                        </div>

                        <!-- Error Message -->
                        <asp:Label ID="LabelMessage" runat="server" CssClass="label-error" ForeColor="Red"></asp:Label>

                        <!-- Footer Links -->
                        <div class="text-center mt-4 border-top pt-3">
                            <p class="text-muted small mb-0">Don't have an account? <a href="#" class="text-primary font-weight-bold">Register Now</a></p>
                        </div>

                    </div>
                </div>
                <div class="text-center mt-3 text-muted">
                    <small>&copy; 2026 SEARCHJOBSHEEKER. All rights reserved.</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
