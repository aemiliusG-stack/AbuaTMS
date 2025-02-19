<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/ValidationJS.js"></script>
<script src="js/ValidationSHA256.js"></script>
<script src="js/TextboxValidation.js"></script>
<script type="text/javascript">

    function md5(a) {

        hex_md5(a);
        var b = document.getElementById(a).value
        var c = document.getElementById('hfRnd').value;
        var d = b + c;
        document.getElementById(a).value = d

        hex_md5(a);
    }

</script>
<script type="text/javascript">
    function ConvertToSHA(a) {
        var a, b, c, d, e;
        b = document.getElementById('tbPassword').value;
        b = sha256(b).toUpperCase();
        var length = 5;
        var result = '';
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        c = result.toString()
        c = sha256(c).toUpperCase();
        document.getElementById('hdRndNum').value = c;
        d = b + c;
        document.getElementById('tbPassword').value = sha256(d).toUpperCase();
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdRndNum" runat="server" />
        <asp:TextBox ID="tbUsername" runat="server" class="form-control" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
        <asp:TextBox ID="tbPassword" TextMode="Password" class="form-control" runat="server" AutoCompleteType="Disabled" autocomplete="off" Onchange="ConvertToSHA('tbPassword')" OnKeypress="return isPassword(event);"></asp:TextBox>
        <asp:TextBox class="input-block-level" ID="txt_Captcha" runat="server" AutoCompleteType="Disabled" autocomplete="off" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary block full-width m-b" OnClick="btnSubmit_Click" UseSubmitBehavior="true" />
    </form>
</body>
</html>
