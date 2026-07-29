<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JobRecruiterMaster.Master" AutoEventWireup="true" CodeBehind="JobRecruiterJobManage.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobRecruiter.JobRecruiterJobManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        .grid-modern {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,.12);
            margin-top: 20px;
        }

            .grid-modern th {
                background: linear-gradient(135deg,#2563eb,#1d4ed8);
                color: #fff;
                padding: 16px;
                font-size: 15px;
                text-transform: uppercase;
                letter-spacing: .5px;
                border: none;
            }

            .grid-modern td {
                padding: 15px;
                border-bottom: 1px solid #ececec;
                text-align: center;
                font-size: 14px;
                color: #444;
            }

            .grid-modern tr:nth-child(even) {
                background: #f8fbff;
            }

            .grid-modern tr:hover {
                background: #edf5ff;
                transition: .3s;
            }

        .badge-exp {
            background: #dbeafe;
            color: #1d4ed8;
            padding: 7px 15px;
            border-radius: 30px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-salary {
            background: #dcfce7;
            color: #15803d;
            padding: 7px 15px;
            border-radius: 30px;
            font-weight: bold;
            display: inline-block;
        }

        .badge-vacancy {
            background: #fef3c7;
            color: #b45309;
            padding: 7px 16px;
            border-radius: 30px;
            font-weight: bold;
            display: inline-block;
            min-width: 45px;
        }

        .btn-delete {
            background: linear-gradient(135deg,#ef4444,#dc2626);
            color: #fff;
            border: none;
            padding: 10px 22px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: .3s;
        }

            .btn-delete:hover {
                background: linear-gradient(135deg,#dc2626,#b91c1c);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(220,38,38,.35);
            }

        table {
            width: 100%;
        }

        td {
            padding: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <table>
        <tr>
            <td></td>

            <td>

                <asp:GridView ID="gvManage"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="grid-modern"
                    GridLines="None"
                    CellPadding="8"
                    HeaderStyle-HorizontalAlign="Center"
                    RowStyle-HorizontalAlign="Center"
                    OnRowCommand="gvManage_RowCommand">

                    <Columns>

                        <asp:BoundField DataField="JobPostId" HeaderText="Job ID" />

                        <asp:BoundField DataField="JRName" HeaderText="Company Name" />

                        <asp:BoundField DataField="JName" HeaderText="Job Profile" />

                        <asp:TemplateField HeaderText="Experience">
                            <ItemTemplate>
                                <span class="badge-exp">
                                    <%# Eval("JobPostMinExp") %> -
                    <%# Eval("JobPostMaxExp") %> Years
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Salary">
                            <ItemTemplate>
                                <span class="badge-salary">₹ <%# Eval("JobPostMinSalary") %> -
                    ₹ <%# Eval("JobPostMaxSalary") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                📍 <%# Eval("Cname") %>, <%# Eval("Sname") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Vacancy">
                            <ItemTemplate>
                                <span class="badge-vacancy">
                                    <%# Eval("JobPostVacancy") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>

                                <asp:Button ID="btndelete"
                                    runat="server"
                                    Text="🗑 Delete"
                                    CssClass="btn-delete"
                                    CommandName="Delete1"
                                    CommandArgument='<%# Eval("JobPostId") %>' />


                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </td>
        </tr>
    </table>
</asp:Content>
