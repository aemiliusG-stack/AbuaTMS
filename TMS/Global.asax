<%@ Application Language="C#" %>

<script runat="server">
    public void Application_Start(object sender, EventArgs e)
    {
    }

    public void Application_End(object sender, EventArgs e)
    {
    }

    // Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
    // ' Code that runs when an unhandled error occurs
    // End Sub

    public void Session_Start(object sender, EventArgs e)
    {
    }

    public void Session_End(object sender, EventArgs e)
    {

        // Try
        // Dim objClsUSer As New ClsUser()
        // objClsUSer.Userid = Convert.ToInt32(Session("UserId"))
        // objClsUSer.UpdateLoginStatus(False)
        // objClsUSer.LogOutTime = DateTime.Now
        // objClsUSer.SetLogOutTime()
        // objClsUSer.UpdateLoginStatus(False)
        // objClsUSer.UpdateLogoutTime()
        // Catch ex As Exception
        // clsFunctions.ErrorLog(DateAndTime.Today, "global", "global", "FillLisession_endcencee", ex.Message)
        // End Try
        Session.Abandon();
        Session.Clear();
    }
    private void Application_BeginRequest(object sender, EventArgs e)
    {
    }
    protected void Application_PreSendRequestHeaders()
    {
        Response.Headers.Remove("Server");
        Response.Headers.Remove("X-AspNet-Version");
        Response.Headers.Remove("X-AspNetMvc-Version");
        HttpContext.Current.Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
        HttpContext.Current.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
        HttpContext.Current.Response.Headers.Add("X-Content-Type-Options", "nosniff");
        HttpContext.Current.Response.Headers.Add("X-Download-Options", "noopen");
        HttpContext.Current.Response.Headers.Add("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        HttpContext.Current.Response.Headers.Add("Content-Security-Policy", "default-src 'self'; connect-src *; font-src *; frame-src *; img-src * data:; media-src *; object-src *; script-src * 'unsafe-inline' 'unsafe-eval'; style-src * 'unsafe-inline';");
        HttpContext.Current.Response.Headers.Add("Referrer-Policy", "strict-origin");
    }
</script>
