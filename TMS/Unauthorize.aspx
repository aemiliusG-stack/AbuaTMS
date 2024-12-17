<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Unauthorize.aspx.cs" Inherits="Unauthorize" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unauthorized Page</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
</head>
<body style="margin: 0px;">
    <%

        Session.Abandon();
    %>
    <form id="form1" runat="server">
    <section class="py-3 py-md-5 min-vh-100 d-flex justify-content-center align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="text-center">
                        <h2 class="d-flex justify-content-center align-items-center gap-2">
                            <span class="display-1 fw-bold">4</span>
                            <span class="display-1 fw-bold">0</span>
                            <span class="display-1 fw-bold bsb-flip-h">4</span>
                        </h2>
                        <h3 class="h2 m-0">Unauthorized Access.</h3>
                        <p class="mb-4">The page you are looking for was not found.</p>
                        <asp:LinkButton ID="lnkLogoutComplete" runat="server" CssClass="btn bsb-btn-5xl btn-success rounded-pill px-5 fs-6 m-0" OnClick="lnkLogoutComplete_Click">Back to Login</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </form>
</body>
</html>