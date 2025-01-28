using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using WebGrease.Css.Ast;

partial class Unauthorize : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private LoginModule lm = new LoginModule();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
        }
        // Dim objClsUSer As New ClsUser()
        // Dim objClsDemand As New ClsDemand()
        // objClsUSer.Userid = Convert.ToInt32(Session("UserId"))
        // objClsDemand.userid = Convert.ToInt32(Session("UserId"))
        // 'objClsUSer.UpdateLoginStatus(False)
        // 'If objClsDemand.getRoleIDByUserId(Convert.ToInt32(Session("UserId"))) = 13 Then
        // '    objClsDemand.releaseStock()
        // '    objClsDemand.DeleteTempLicensee()
        // 'End If
        // objClsUSer.UpdateLoginStatus(False)
        // objClsUSer.LogOutTime = DateTime.Now
        // objClsUSer.SetLogOutTime()
        // objClsUSer.UpdateLogoutTime()
        // objClsUSer.UpdateSessionCode()

        catch (Exception ex)
        {
        }

        Session.Clear();
        Session.Abandon();
    }

    protected void lnkLogoutComplete_Click(object sender, EventArgs e)
    {
        string strIPAddress;
        string strHostName;
        strHostName = System.Net.Dns.GetHostName();
        strIPAddress = System.Net.Dns.GetHostByName(strHostName).AddressList[0].ToString();
        if (strIPAddress == null)
            strIPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        lm.UpdateLogoutStatus(strIPAddress.ToString());
        Response.Redirect("~/Default.aspx");
    }
}
