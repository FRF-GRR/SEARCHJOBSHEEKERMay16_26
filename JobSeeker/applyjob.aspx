<%@ Page Title="" Language="C#" MasterPageFile="~/Master/JobSeekerMaster.Master" AutoEventWireup="true" CodeBehind="applyjob.aspx.cs" Inherits="SEARCHJOBSHEEKERMay16_26.JobSeeker.applyjob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <h2>JobApply</h2>
    <table>
        <asp:Label ID="lblJobID" runat="server" Visible="false"></asp:Label>
        <tr>
            <td>Name :</td>
            <td>
                <asp:TextBox runat="server" ID="textname"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Email :</td>
            <td>
                <asp:TextBox runat="server" ID="textemail"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>ContactNumber :</td>
            <td>
                <asp:TextBox runat="server" ID="textcontactnumber"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>CurrentLocation :</td>
            <td>
                <asp:TextBox runat="server" ID="textcurrentlocation"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Experience :</td>
            <td>
                <asp:DropDownList ID="ddlexprience" runat="server">
                    <asp:ListItem Text="--Selected--" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Fresher" Value="Fresher"></asp:ListItem>
                    <asp:ListItem Text="Under 1 Year" Value="Under 1 Year"></asp:ListItem>
                    <asp:ListItem Text="Under 3 Year" Value="Under 3 Year"></asp:ListItem>
                    <asp:ListItem Text="Under 5 Year" Value="Under 5 Year"></asp:ListItem>
                    <asp:ListItem Text="Under 7 year" Value="Under 7 year"></asp:ListItem>
                    <asp:ListItem Text="Under 9 Year" Value="Under 9 Year"></asp:ListItem>
                    <asp:ListItem Text="Above 9 Year" Value="Above 9 Year"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>CurrentCompany :</td>
            <td>
                <asp:TextBox runat="server" ID="textcurrentcompany"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>ExpectedSalary :</td>
            <td>
                <asp:TextBox runat="server" ID="textexpectedsalary"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Skills :</td>
            <td>
                <asp:TextBox runat="server" ID="textskills" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>QueryMesage :</td>
            <td>
                <asp:TextBox runat="server" TextMode="MultiLine" ID="textquery"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>UploadResume :</td>
            <td>
                <asp:FileUpload runat="server" ID="furesume"></asp:FileUpload>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnapply" Text="ApplyJob" runat="server" OnClick="btnapply_Click" />
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td></td>
            <td>
                <asp:GridView runat="server" ID="gvjobapply"></asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
