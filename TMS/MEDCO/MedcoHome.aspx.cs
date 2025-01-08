using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
public partial class MEDCO_MedcoHome : System.Web.UI.Page
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
                if (Session["RoleId"].ToString() == "2" && Session["RoleName"].ToString() =="MEDCO") {
                    hdMasterUserId.Value = Session["UserId"].ToString();
                    hdMasterRoleId.Value = Session["RoleId"].ToString();
                    hdMasterRoleName.Value = Session["RoleName"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    getDashboardData();
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
            md.InsertErrorLog(hdMasterUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void getDashboardData()
    {
        try
        {
            dt = lm.getMEDCODashboardData(Convert.ToInt32(hdHospitalId.Value));
            if (dt.Rows.Count > 0)
            {
                lbTodayPatientRegistered.Text = dt.Rows[0]["PatientRegistered_Today"].ToString();
                lbTodayPreAuth.Text = dt.Rows[0]["PreAuthInitiated_Today"].ToString();
                lbTodayCancelled.Text = dt.Rows[0]["PatientCancelled_Today"].ToString();
                lbTodayRefered.Text = dt.Rows[0]["PatientRefered_Today"].ToString();
                lbTodayClaim.Text = dt.Rows[0]["ClaimInitiated_Today"].ToString();

                lbTodayPatientRegistered.Text = dt.Rows[0]["PatientRegistered_Overall"].ToString();
                lbTodayPreAuth.Text = dt.Rows[0]["PreAuthInitiated_Overall"].ToString();
                lbTodayCancelled.Text = dt.Rows[0]["PatientCancelled_Overall"].ToString();
                lbTodayRefered.Text = dt.Rows[0]["PatientRefered_Overall"].ToString();
                lbTodayClaim.Text = dt.Rows[0]["ClaimInitiated_Overall"].ToString();
            }
            else
            {
                lbTodayPatientRegistered.Text = "0";
                lbTodayPreAuth.Text = "0";
                lbTodayCancelled.Text = "0";
                lbTodayRefered.Text = "0";
                lbTodayClaim.Text = "0";

                lbTodayPatientRegistered.Text = "0";
                lbTodayPreAuth.Text = "0";
                lbTodayCancelled.Text = "0";
                lbTodayRefered.Text = "0";
                lbTodayClaim.Text = "0";
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdMasterUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
}