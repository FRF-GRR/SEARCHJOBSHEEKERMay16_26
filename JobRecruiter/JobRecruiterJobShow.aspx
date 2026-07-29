<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JobRecruiterMaster.Master" AutoEventWireup="true" CodeBehind="JobRecruiterJobShow.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobRecruiter.JobRecruiterJobShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        .page-card {
            max-width: 1300px;
            margin: 30px auto;
            background: #ffffff;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            animation: fadeIn 0.8s ease-in-out;
        }

        .page-title {
            text-align: center;
            font-size: 34px;
            font-weight: bold;
            color: #2563eb;
            margin-bottom: 25px;
        }

        .grid-wrapper {
            overflow-x: auto;
        }

        .grid-modern {
            width: 100%;
            border-collapse: collapse;
            border-radius: 15px;
            overflow: hidden;
        }

            .grid-modern th {
                background: linear-gradient(135deg,#2563eb,#4f46e5);
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 15px;
            }

            .grid-modern td {
                padding: 12px;
                border-bottom: 1px solid #e5e7eb;
                text-align: center;
                font-size: 14px;
            }

            .grid-modern tr:nth-child(even) {
                background: #f8fafc;
            }

            .grid-modern tr:hover {
                background: #dbeafe;
                transition: 0.3s;
            }

        .badge-exp {
            background: #10b981;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .badge-salary {
            background: #f59e0b;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .badge-vacancy {
            background: #dc2626;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(25px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media(max-width:768px) {
            .page-card {
                margin: 10px;
                padding: 15px;
            }

            .page-title {
                font-size: 24px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="page-card">

        <div class="page-title">
            Job Post Show
        </div>

        <div class="grid-wrapper">

            <asp:GridView ID="gvjobshow"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="grid-modern">

                <Columns>

                    <asp:TemplateField HeaderText="Job ID">
                        <ItemTemplate>
                            <%# Eval("JobPostId") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Company Name">
                        <ItemTemplate>
                            <%# Eval("JRName") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Job Profile">
                        <ItemTemplate>
                            <%# Eval("JName") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Required Experience">
                        <ItemTemplate>
                            <span class="badge-exp">
                                <%# Eval("JobPostMinExp") %> -
                                <%# Eval("JobPostMaxExp") %> Years
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Salary Package">
                        <ItemTemplate>
                            <span class="badge-salary">₹ <%# Eval("JobPostMinSalary") %>
                                -
                                ₹ <%# Eval("JobPostMaxSalary") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Location">
                        <ItemTemplate>
                            📍 <%# Eval("Cname") %>,
                            <%# Eval("Sname") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Vacancies">
                        <ItemTemplate>
                            <span class="badge-vacancy">
                                <%# Eval("JobPostVacancy") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>

    </div>

</asp:Content>
