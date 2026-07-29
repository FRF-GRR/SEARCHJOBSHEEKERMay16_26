<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="~/Admin/Welcome.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.Admin.Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Welcome,&nbsp;
        <asp:Label ID="LabelUserName" runat="server" Text=""></asp:Label>
        !</h1>
</asp:Content>
