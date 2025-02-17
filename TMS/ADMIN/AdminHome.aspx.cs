using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

public partial class Admin_AdminHome : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    string pageName;
    private MasterData md = new MasterData();
    private LoginModule lm = new LoginModule();
    private DataTable dt = new DataTable();
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
                    hdAdminUserId.Value = Session["UserId"].ToString();
                    GetDashboardDetail();
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
            md.InsertErrorLog(hdAdminUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void GetDashboardDetail()
    {
        try
        {
            dt = lm.getAdminDashboardData();
            if (dt.Rows.Count > 0)
            {
                lbAdmin.Text = dt.Rows[0]["TotalActiveUsers"].ToString();
                lbMedco.Text = dt.Rows[0]["MEDCOUsers"].ToString();
                lbPPDInsurer.Text = dt.Rows[0]["PPDInsurer"].ToString();
                lbPPDTrust.Text = dt.Rows[0]["PPDTrust"].ToString();
                lbCEXInsurer.Text = dt.Rows[0]["CEXInsurer"].ToString();
                lbCEXTrust.Text = dt.Rows[0]["CEXTrust"].ToString();
                lbCPDInsurer.Text = dt.Rows[0]["CPDInsurer"].ToString();
                lbCPDTrust.Text = dt.Rows[0]["CPDTrust"].ToString();
                lbACOInsurer.Text = dt.Rows[0]["ACOInsurer"].ToString();
                lbACOTrust.Text = dt.Rows[0]["ACOTrust"].ToString();
                lbSHAInsurer.Text = dt.Rows[0]["SHAInsurer"].ToString();
                lbSHATrust.Text = dt.Rows[0]["CEOSHA"].ToString();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdAdminUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
}