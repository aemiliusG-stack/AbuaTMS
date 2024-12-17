using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using CareerPath.DAL;
using System.Web.UI;
using System.Web.Security;
using System.Web;

public partial class MEDCO_PreAuthCancellation : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private PreAuth preAuth = new PreAuth();
    private MasterData md = new MasterData();
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
                    BindGrid();
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
    protected void gridPatientForCancellation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gridPatientForCancellation.PageIndex = e.NewPageIndex;
            BindGrid();

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
    private void BindGrid()
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientForPreAuthCancellation(Convert.ToInt32(hdHospitalId.Value));
            if (dt.Rows.Count > 0)
            {
                gridPatientForCancellation.DataSource = dt;
                gridPatientForCancellation.DataBind();
            }
            else
            {
                gridPatientForCancellation.DataSource = dt;
                gridPatientForCancellation.DataBind();
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
    protected void cbHeaderCheckAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox cbHeaderCheckAll = (CheckBox)sender;
            foreach (GridViewRow row in gridPatientForCancellation.Rows)
            {
                CheckBox cbCheck = (CheckBox)row.FindControl("cbcheck");
                if (cbCheck != null)
                {
                    cbCheck.Checked = cbHeaderCheckAll.Checked;
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
    protected void cbcheckRow_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            bool allChecked = true;

            // Check all rows to see if all are checked
            foreach (GridViewRow row in gridPatientForCancellation.Rows)
            {
                CheckBox cbcheck = (CheckBox)row.FindControl("cbcheck");
                if (cbcheck != null && !cbcheck.Checked)
                {
                    allChecked = false;
                    break;
                }
            }

            // Set the "Check All" checkbox based on the state of all individual checkboxes
            CheckBox cbHeaderCheckAll = (CheckBox)gridPatientForCancellation.HeaderRow.FindControl("cbHeaderCheckAll");
            if (cbHeaderCheckAll != null)
            {
                cbHeaderCheckAll.Checked = allChecked;
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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow rowremark in gridPatientForCancellation.Rows)
            {
                CheckBox cbCheck = (CheckBox)rowremark.FindControl("cbcheck");
                TextBox tbRemarks = (TextBox)rowremark.FindControl("tbRemarks");
                if (tbRemarks.Text == "" & cbCheck.Checked == true)
                {
                    strMessage = "window.alert('Please fill remarks!');";
                    ScriptManager.RegisterStartupScript(btnCancel, btnCancel.GetType(), "Error", strMessage, true);
                    return;
                }
                //if (TextboxValidation.isAlphabet(tbRemarks.Text) == false)
                //{
                //    string strMessage = "window.alert('Invalid Entry!');";
                //    ScriptManager.RegisterStartupScript(btnCancel, btnCancel.GetType(), "AlertMessage", strMessage, true);
                //    return;
                //}
            }
            foreach (GridViewRow row in gridPatientForCancellation.Rows)
            {
                CheckBox cbCheck = (CheckBox)row.FindControl("cbcheck");
                Label lbCaseNo = (Label)row.FindControl("lbCaseNo");
                Label lbHospitalId = (Label)row.FindControl("lbHospitalId");
                Label lbCardNumber = (Label)row.FindControl("lbCardNumber");
                Label lbPatientRegId = (Label)row.FindControl("lbPatientRegId");
                TextBox tbRemarks = (TextBox)row.FindControl("tbRemarks");
                if (cbCheck != null && cbCheck.Checked && lbCaseNo != null)
                {
                    SqlParameter[] p = new SqlParameter[6];
                    p[0] = new SqlParameter("@CaseNo", lbCaseNo.Text);
                    p[0].DbType = DbType.String;
                    p[1] = new SqlParameter("@HospitalId", lbHospitalId.Text);
                    p[1].DbType = DbType.String;
                    p[2] = new SqlParameter("@PatientRegId", lbPatientRegId.Text);
                    p[2].DbType = DbType.String;
                    p[3] = new SqlParameter("@CardNumber", lbCardNumber.Text);
                    p[3].DbType = DbType.String;
                    p[4] = new SqlParameter("@Remarks", tbRemarks.Text);
                    p[4].DbType = DbType.String;
                    p[5] = new SqlParameter("@CancelledById", hdUserId.Value);
                    p[5].DbType = DbType.String;

                    SqlHelper.ExecuteNonQuery(con, CommandType.StoredProcedure, "TMS_PreAuthCancellation", p);
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    strMessage = "window.alert('Patient removed successfully!');";
                    ScriptManager.RegisterStartupScript(btnCancel, btnCancel.GetType(), "Error", strMessage, true);
                }
            }
            BindGrid();
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