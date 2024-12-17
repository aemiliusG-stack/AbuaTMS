<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestNew.aspx.cs" Inherits="TestNew" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CAPTCHA Verification</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Captcha Verification</h2>
            <asp:Image ID="CaptchaImage" runat="server" ImageUrl="~/CaptchaImageHandler.ashx" />
            <br /><br />
            <asp:TextBox ID="txtCaptcha" runat="server" placeholder="Enter Captcha"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCaptcha" runat="server" ControlToValidate="txtCaptcha"
                ErrorMessage="Please enter the captcha" ForeColor="Red"></asp:RequiredFieldValidator>
            <br /><br />
            <asp:Button ID="btnVerify" runat="server" Text="Verify" OnClick="btnVerify_Click" />
            <br /><br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
