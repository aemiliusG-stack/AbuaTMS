using System;
using CareerPath.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Web.Helpers;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

partial class Admin_CreateUser : System.Web.UI.Page
{
    private string strMessage;
    string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
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
                if (Session["RoleId"].ToString() == "1" && Session["RoleName"].ToString() == "ADMIN")
                {
                    GetRoles();
                    GetUserDetail();
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
    protected void GetUserDetail()
    {
        dt.Clear();
        dt = md.GetCreatedUserDetail();
        if (dt.Rows.Count > 0)
        {
            gridUserDetail.DataSource = dt;
            gridUserDetail.DataBind();
        }
        else
        {
            gridUserDetail.DataSource = "";
            gridUserDetail.DataBind();
        }
    }
    protected void GetRoles()
    {
        try
        {
            dt.Clear();
            dt = md.GetUserRoles();
            if (dt.Rows.Count > 0)
            {
                dropRole.Items.Clear();
                dropRole.DataValueField = "RoleId";
                dropRole.DataTextField = "RoleName";
                dropRole.DataSource = dt;
                dropRole.DataBind();
                dropRole.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropRole.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void dropRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (dropRole.SelectedItem.Text == "MEDCO")
            {
                divMEDCO.Visible = true;
                lbDistrict.Visible = true;
                lbHospital.Visible = true;
                dropDistrict.Visible = true;
                dropHospital.Visible = true;
            }
            else
            {
                divMEDCO.Visible = false;
                lbDistrict.Visible = false;
                lbHospital.Visible = false;
                dropDistrict.Visible = false;
                dropHospital.Visible = false;
            }

            dt.Clear();
            dt = md.GetDistrict();
            dropDistrict.Items.Clear();
            if (dt.Rows.Count > 0)
            {
                dropDistrict.Items.Clear();
                dropDistrict.DataValueField = "Id";
                dropDistrict.DataTextField = "Title";
                dropDistrict.DataSource = dt;
                dropDistrict.DataBind();
                dropDistrict.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropDistrict.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void dropDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = md.GetHospitalList();
            dropHospital.Items.Clear();
            if (dt.Rows.Count > 0)
            {
                dropHospital.Items.Clear();
                dropHospital.DataValueField = "HospitalId";
                dropHospital.DataTextField = "HospitalName";
                dropHospital.DataSource = dt;
                dropHospital.DataBind();
                dropHospital.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropHospital.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void ClearAll()
    {
        dropRole.Items.Clear();
        dropDistrict.Items.Clear();
        dropHospital.Items.Clear();
        tbUserName.Text = "";
        tbPassword.Text = "";
        tbFullName.Text = "";
        tbAddress.Text = "";
        tbMobileNo.Text = "";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextboxValidation.isAlphaNumeric(tbUserName.Text) == false || TextboxValidation.isAlphabet(tbFullName.Text) == false || TextboxValidation.isAlphaNumericSpecial(tbAddress.Text) == false || TextboxValidation.isNumeric(tbMobileNo.Text) == false || TextboxValidation.IsValidMobileNumber(tbMobileNo.Text) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Entry')", true);
                return;
            }
            if (dropRole.SelectedValue == "0")
            {
                strMessage = "window.alert('Please Select Role!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else if (dropRole.SelectedValue == "2")
            {
                if (dropDistrict.SelectedValue == "0")
                {
                    strMessage = "window.alert('Please Select District!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (dropHospital.SelectedValue == "0")
                {
                    strMessage = "window.alert('Please Select Hospital!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (tbUserName.Text == "" | tbFullName.Text == "" | tbMobileNo.Text == "")
                {
                    strMessage = "window.alert('Please Fill Required Details!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
                else
                    goto Register;
            }
            else if (tbUserName.Text == "" | tbPassword.Text == "" | tbFullName.Text == "" | tbMobileNo.Text == "")
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else
                goto Register;
Register:
            ;
            string StrPasswd;
            // Dim StrSql As String
            StrPasswd = Crypto.SHA256("TMS@123");
            SqlParameter[] p = new SqlParameter[9];
            p[0] = new SqlParameter("@Username", tbUserName.Text);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@UserPassword", StrPasswd.ToString());
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@HospitalId", dropHospital.SelectedValue);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@RoleId", dropRole.SelectedValue);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@RoleName", dropRole.SelectedItem.Text);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@DistrictId", dropDistrict.SelectedValue);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@FullName", tbFullName.Text);
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@UserAddress", tbAddress.Text);
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@MobileNo", tbMobileNo.Text);
            p[8].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CreateUser", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0 & ds.Tables[0].Rows[0]["Id"].ToString() == "0")
            {
                strMessage = "window.alert('Username/MobileNo. Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
            }
            else if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
            {
                ClearAll();
                GetRoles();
                GetUserDetail();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
}