<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
    <title>Abua Swasthya Bima Yojana</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=1" rel="stylesheet">
    <link href="css/asby-style.css" asp-append-version="true" rel="stylesheet" />
    <script src="js/sha.js"></script>
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
        <div id="DivCSRF" runat="server"></div>
        <div class="asby-login-register">
            <header>
                <div class="row">
                    <div class="col-md-6">
                        <div class="asby-logo-context">
                            <div class="logo">
                                <img src="img/jhlogo.png" width="76" />
                            </div>
                            <div class="context">
                                <div class="title">
                                    <span style="font-weight: bold; font-size: 20px;">Mukhya Mantri ABUA Swasthya Suraksha Yojana</span><br />
                                    <span style="font-weight: bold; font-size: 19px; text-transform: uppercase;">मुख्यमंत्री अबुआ स्वास्थ्य सुरक्षा योजना</span>
                                </div>
                                <div class="sub-title"></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 d-flex align-items-center justify-content-md-end">
                        <nav class="asby-navbar d-flex flex-column flex-md-column justify-content-end">
                            <ul class="d-flex flex-column flex-md-row justify-content-end list-unstyled m-0">
                                <li>
                                    <a href="#">
                                        <span>USER MANUAL</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span>CONTACT US</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span>CYBER SURAKSHA DISHAANIRDESH</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </header>
            <asp:HiddenField ID="hdRndNum" runat="server" />
            <div class="loginColumns animated fadeInDown">
                <div class="ibox-content" style="width: 100%;">
                    <h4 class="font-bold m-0">Please Login</h4>
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <p class="text-danger" id="login_error"></p>
                    <div class="form-group">
                        <label>
                            Username <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="tbUsername" runat="server" class="form-control" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                        <span asp-validation-for="UserName" class="text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label>
                            Password <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="tbPassword" TextMode="Password" class="form-control" runat="server" AutoCompleteType="Disabled" autocomplete="off" Onchange="ConvertToSHA('tbPassword')" OnKeypress="return isPassword(event);"></asp:TextBox>
                    </div>
                    <asp:UpdatePanel runat="server" ID="uptadte1">
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Image ID="imgCaptcha" runat="server" ImageUrl="~/CaptchaImageHandler.ashx" />
                                <asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-primary btn-sm" Text="Refresh" OnClick="btnRefresh_Click" UseSubmitBehavior="false" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="control-group">

                        <asp:TextBox class="input-block-level" ID="txt_Captcha" runat="server" AutoCompleteType="Disabled" autocomplete="off" OnKeypress="return isNumeric(event);"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txt_Captcha" ErrorMessage="Can't Left Blank Captcha Field" />

                    </div>
                    <div class="control-group">
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="Medium"></asp:Label>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary block full-width m-b" OnClick="btnSubmit_Click" UseSubmitBehavior="true" />
                    <a href="/Account/ForgotPassword">
                        <small>Forgot password?</small>
                    </a>
                </div>
            </div>
            <footer>
                <div class="row m-0 my-2">
                    <div class="col-md-6 text-white">
                        Copyright ©
                    <script>document.write(new Date().getFullYear())</script>
                    </div>
                    <div class="col-md-6 text-white text-right">
                        <small>Version 1.0</small>
                    </div>
                </div>
            </footer>

            @*
        <div class="bg-img"></div>
            *@
            <figure class="login-panel-bg">
                <img src="/images/doctor-bg.png" />
            </figure>
        </div>
    </form>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
</body>
</html>
