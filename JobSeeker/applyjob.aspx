<%@ Page Title="Apply for Job" Language="C#" MasterPageFile="~/Master/JobSeekerMaster.Master" AutoEventWireup="true" CodeBehind="applyjob.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobSeeker.applyjob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS & Icons -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        .apply-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            background: #fff;
            margin-top: 20px;
        }

        .card-header-main {
            background: linear-gradient(135deg, #2563eb, #1e40af);
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

        /* Input & Dropdown Styling */
        .form-control {
            border-radius: 8px;
            padding: 10px;
            border: 1px solid #ced4da;
            height: 45px !important;
            transition: 0.3s;
        }

        textarea.form-control {
            height: auto !important;
        }

        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.1);
        }

        .section-title {
            color: #1e40af;
            border-bottom: 2px solid #eef2f7;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .btn-apply-custom {
            background: linear-gradient(135deg, #2563eb, #1e40af);
            border: none;
            padding: 12px 60px;
            border-radius: 8px;
            font-weight: bold;
            color: white;
            transition: 0.3s;
            width: 100%;
            max-width: 300px;
        }

            .btn-apply-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(37,99,235,0.3);
                color: white;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container py-4">
        <asp:Label ID="lblJobID" runat="server" Visible="false"></asp:Label>

        <div class="card apply-card">
            <div class="card-header-main">
                <h3 class="mb-1">Application Form</h3>
                <p class="mb-0 text-white-50">Provide your professional details to apply for this job</p>
            </div>
            <div class="card-body p-4 p-md-5">

                <!-- Row 1: 3 Columns -->
                <div class="section-title"><i class="fas fa-id-card mr-2"></i>Contact Details</div>
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox runat="server" ID="textname" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Email Address</label>s
                        <asp:TextBox runat="server" ID="textemail" CssClass="form-control" TextMode="Email" placeholder="john@example.com"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Contact Number</label>
                        <asp:TextBox runat="server" ID="textcontactnumber" CssClass="form-control" placeholder="+91 XXXXX XXXXX"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 2: 3 Columns -->
                <div class="section-title"><i class="fas fa-briefcase mr-2"></i>Professional Info</div>
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Current Location</label>
                        <asp:TextBox runat="server" ID="textcurrentlocation" CssClass="form-control" placeholder="City Name"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Experience Level</label>
                        <asp:DropDownList ID="ddlexprience" runat="server" CssClass="form-control">
                            <asp:ListItem Text="--Select Experience--" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Fresher" Value="Fresher"></asp:ListItem>
                            <asp:ListItem Text="Under 1 Year" Value="Under 1 Year"></asp:ListItem>
                            <asp:ListItem Text="Under 3 Year" Value="Under 3 Year"></asp:ListItem>
                            <asp:ListItem Text="Under 5 Year" Value="Under 5 Year"></asp:ListItem>
                            <asp:ListItem Text="Under 7 year" Value="Under 7 year"></asp:ListItem>
                            <asp:ListItem Text="Under 9 Year" Value="Under 9 Year"></asp:ListItem>
                            <asp:ListItem Text="Above 9 Year" Value="Above 9 Year"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Current Company</label>
                        <asp:TextBox runat="server" ID="textcurrentcompany" CssClass="form-control" placeholder="Company Name"></asp:TextBox>
                    </div>
                </div>

                <!-- Row 3: Salary & Resume -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Expected Salary</label>
                        <asp:TextBox runat="server" ID="textexpectedsalary" CssClass="form-control" placeholder="Monthly Salary"></asp:TextBox>
                    </div>
                    <div class="col-md-8 mb-3">
                        <label class="form-label">Upload Resume (PDF/Doc)</label>
                        <div class="upload-wrapper">
                            <asp:FileUpload runat="server" ID="furesume" CssClass="form-control-file py-1" />
                        </div>
                    </div>
                </div>

                <!-- Row 4: Multi-line Fields -->
                <div class="row mb-4">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Your Skills</label>
                        <asp:TextBox runat="server" ID="textskills" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="C#, ASP.NET, SQL, etc."></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Query/Message</label>
                        <asp:TextBox runat="server" TextMode="MultiLine" ID="textquery" Rows="3" CssClass="form-control" placeholder="Any questions for the recruiter?"></asp:TextBox>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-center mt-4">
                    <asp:Button ID="btnapply" Text="Submit Application" runat="server" OnClick="btnapply_Click" CssClass="btn-apply-custom" />
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
