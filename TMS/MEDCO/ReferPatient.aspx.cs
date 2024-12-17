using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.Security;
using System.Web;

public partial class MEDCO_ReferPatient : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    string pageName;
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
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    getRegisteredPatient();
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
    protected void getRegisteredPatient()
    {
        try
        {
            gridRegisteredPatient.DataSource = "";
            gridRegisteredPatient.DataBind();
            dt.Clear();
            dt = preAuth.GetRegisteredPatientForReferal(Convert.ToInt32(hdHospitalId.Value));
            if (dt.Rows.Count > 0)
            {
                gridRegisteredPatient.DataSource = dt;
                gridRegisteredPatient.DataBind();
            }
            else
            {
                gridRegisteredPatient.DataSource = "";
                gridRegisteredPatient.DataBind();
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
    protected void lnkReferPatient(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbGridRegId = (Label)gridRegisteredPatient.Rows[i].FindControl("lbPatientRegId");
            hdRegId.Value = lbGridRegId.Text;
            Label lbGridCardNo = (Label)gridRegisteredPatient.Rows[i].FindControl("lbPatientCardNo");
            hdCardNo.Value = lbGridCardNo.Text;

            dt.Clear();
            dt = md.GetHospitalList();
            if (dt.Rows.Count > 0)
            {
                dropHospitalList.Items.Clear();
                dropHospitalList.DataValueField = "HospitalId";
                dropHospitalList.DataTextField = "HospitalName";
                dropHospitalList.DataSource = dt;
                dropHospitalList.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCommonPopUpModal", "showCommonPopUpModal();", true);
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

    protected void hideCommonModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCommonPopUpModal", "hideCommonPopUpModal();", true);
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

    protected void btnReferPatient_Click(object sender, EventArgs e)
    {
        try
        {
            if (tbRemarks.Text == "")
            {
                string strMessage = "window.alert('Please fill remarks!');";
                ScriptManager.RegisterStartupScript(btnReferPatient, btnReferPatient.GetType(), "AlertMessage", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCommonPopUpModal", "showCommonPopUpModal();", true);
                return;
            }
            if (TextboxValidation.isAlphaNumericSpecial(tbRemarks.Text) == false)
            {
                string strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnReferPatient, btnReferPatient.GetType(), "AlertMessage", strMessage, true);
                return;
            }
            dt.Clear();
            dt = preAuth.checkPatientToReferBeforePreAuth(Convert.ToInt32(hdHospitalId.Value), hdCardNo.Value, Convert.ToInt32(hdRegId.Value), Convert.ToInt32(dropHospitalList.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                string strMessage = "window.alert('Cannot Refer!Patient treatment under process!');";
                ScriptManager.RegisterStartupScript(btnReferPatient, btnReferPatient.GetType(), "AlertMessage", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showCommonPopUpModal", "showCommonPopUpModal();", true);
                return;
            }
            int affectedRow = 0;
            affectedRow = preAuth.ReferPatientBeforePreAuth(Convert.ToInt32(hdHospitalId.Value), hdCardNo.Value, Convert.ToInt32(hdRegId.Value), Convert.ToInt32(dropHospitalList.SelectedValue));
            if (affectedRow > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCommonPopUpModal", "hideCommonPopUpModal();", true);
                string strMessage = "window.alert('Patient Refered Successfully!');";
                ScriptManager.RegisterStartupScript(btnReferPatient, btnReferPatient.GetType(), "AlertMessage", strMessage, true);
                getRegisteredPatient();
                return;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hideCommonPopUpModal", "hideCommonPopUpModal();", true);
                string strMessage = "window.alert('Something went wrong!');";
                ScriptManager.RegisterStartupScript(btnReferPatient, btnReferPatient.GetType(), "AlertMessage", strMessage, true);
                return;
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
}