using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CEX_MasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else
        {
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                hdUserName.Value = Session["Username"].ToString();
                hdUserRole.Value = Session["RoleName"].ToString();
            }
        }
    }
    protected void LogOutButton_Click(object sender, EventArgs e)
    {
        SqlParameter[] p = new SqlParameter[1];
        p[0] = new SqlParameter("@UserId", hdUserId.Value);
        p[0].DbType = DbType.String;

        SqlHelper.ExecuteNonQuery(con, CommandType.StoredProcedure, "TMS_UpdateLogoutStatus", p);

        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        Session.Clear();
        Session.Abandon();
        Session.RemoveAll();
        Response.AppendHeader("Cache-Control", "no-store");
        Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
        Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
        Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
        Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
        Response.Cookies.Add(new HttpCookie("__AntiXsrfToken", ""));
        //Response.Cookies.Add(new HttpCookie("__RequestVerificationToken", ""));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Redirect("~/Default.aspx");
    }
}
