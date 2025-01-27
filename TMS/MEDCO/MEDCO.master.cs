using System;
using CareerPath.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;

partial class MEDCO_MEDCO : System.Web.UI.MasterPage
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    string pageName;
    private MasterData md = new MasterData();
    private LoginModule lm = new LoginModule();
    private DataTable dt = new DataTable();

    //const string AntiXsrfTokenKey = "__AntiXsrfToken";
    //const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    //private string _antiXsrfTokenValue;

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    HttpCookie requestCookie = Request.Cookies[AntiXsrfTokenKey];
    //    Guid requestCookieGuidValue;

    //    if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
    //    {
    //        // Use the Anti-XSRF token from the cookie
    //        _antiXsrfTokenValue = requestCookie.Value;
    //        Page.ViewStateUserKey = _antiXsrfTokenValue;
    //    }
    //    else
    //    {
    //        // Generate a new Anti-XSRF token and save to the cookie
    //        _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
    //        Page.ViewStateUserKey = _antiXsrfTokenValue;

    //        HttpCookie responseCookie = new HttpCookie(AntiXsrfTokenKey)
    //        {
    //            HttpOnly = true,
    //            Value = _antiXsrfTokenValue
    //        };
    //        if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
    //            responseCookie.Secure = true;
    //        Response.Cookies.Set(responseCookie);
    //    }

    //    Page.PreLoad += master_Page_PreLoad;
    //}

    //private void master_Page_PreLoad(object sender, EventArgs e)
    //{
    //    if (!IsPostBack)
    //    {
    //        // Set Anti-XSRF token
    //        ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
    //        ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? string.Empty;
    //    }
    //    else
    //    {
    //        // Validate the Anti-XSRF token
    //        if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue ||
    //            (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? string.Empty))
    //        {
    //            throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
    //            Response.Redirect("~/Unauthorize.aspx", false);
    //        }
    //    }
    //}
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else if (!IsPostBack)
            {
                if (Session["RoleId"].ToString() == "2" && Session["RoleName"].ToString() == "MEDCO")
                {
                    hdUserId.Value = Session["UserId"].ToString();
                    hdRoleId.Value = Session["RoleId"].ToString();
                    hdRoleName.Value = Session["RoleName"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    GetCaseCount();
                }
                else
                {
                    Response.Redirect("~/Unauthorize.aspx", false);
                }
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void GetCaseCount()
    {
        try
        {
            dt = lm.getMEDCOCaseCount(Convert.ToInt32(hdHospitalId.Value));
            if (dt.Rows.Count > 0)
            {
                lbPreAuthCount.Text = dt.Rows[0]["PreAuthOrReferCase"].ToString();
                lbTreatmentDischargecount.Text = dt.Rows[0]["CasesForTreatmentDischargeAndCancelPatient"].ToString();
                lbCasesForCancellation.Text = dt.Rows[0]["CasesForTreatmentDischargeAndCancelPatient"].ToString();
                lbReferPatient.Text = dt.Rows[0]["PreAuthOrReferCase"].ToString();
            }
            else
            {
                lbPreAuthCount.Text = "0";
                lbTreatmentDischargecount.Text = "0";
                lbCasesForCancellation.Text = "0";
                lbReferPatient.Text = "0";
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        SqlParameter[] p = new SqlParameter[1];
        p[0] = new SqlParameter("@UserId", hdUserId.Value);
        p[0].DbType = DbType.String;
        SqlHelper.ExecuteNonQuery(con, CommandType.StoredProcedure, "TMS_UpdateLogoutStatus", p);
        if (con.State == ConnectionState.Open)
            con.Close();
        Session.Clear();
        Session.Abandon();
        Session.RemoveAll();
        Response.AppendHeader("Cache-Control", "no-store");
        Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
        Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
        Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
        Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
        Response.Cookies.Add(new HttpCookie("__AntiXsrfToken", ""));
        // Response.Cookies.Add(New HttpCookie("__RequestVerificationToken", ""))
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Redirect("~/Default.aspx");
    }
}
