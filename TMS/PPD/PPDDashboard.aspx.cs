using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class PPD_PPDDashboard : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private MasterData md = new MasterData();
    public static PPDHelper ppdHelper = new PPDHelper();
    string pageName;

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
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                getDashboardData();
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

    protected void getDashboardData()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetDashboardData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbPreauthToday.Text = dt.Rows[0]["PreauthCountToday"].ToString();
                lbPreauthOverall.Text = dt.Rows[0]["PreauthCountOverall"].ToString();
                if (Session["RoleId"].ToString() == "3")
                {
                    lbTitle.Text = "Pendency At Insurer";
                    lbUserRole.Text = "Preauth Panel Doctor Insurer";
                    lbUserRoleAssigned.Text = "Preauth Panel Doctor Insurer (Assigned)";
                    lbUserTodayCount.Text = dt.Rows[0]["PPDInsurerToday"].ToString();
                    lbUserOverallCount.Text = dt.Rows[0]["PPPDInsurerOverall"].ToString();
                    lbAssignedToday.Text = dt.Rows[0]["PPDInsurerAssignedToday"].ToString();
                    lbAssignedOverall.Text = dt.Rows[0]["PPPDInsurerAssignedOverall"].ToString();
                }
                else if (Session["RoleId"].ToString() == "4")
                {
                    lbTitle.Text = "Pendency At Trust";
                    lbUserRole.Text = "Preauth Panel Doctor Trust";
                    lbUserRoleAssigned.Text = "Preauth Panel Doctor Trust (Assigned)";
                    lbUserTodayCount.Text = dt.Rows[0]["PPDInsurerToday"].ToString();
                    lbUserOverallCount.Text = dt.Rows[0]["PPPDTrustOverall"].ToString();
                    lbAssignedToday.Text = dt.Rows[0]["PPDTrustAssignedToday"].ToString();
                    lbAssignedOverall.Text = dt.Rows[0]["PPPDTrustAssignedOverall"].ToString();
                }
            }
            else
            {
                if (Session["RoleId"].ToString() == "3")
                {
                    lbTitle.Text = "Pendency At Insurer";
                    lbUserRole.Text = "Preauth Panel Doctor Insurer";
                    lbUserRoleAssigned.Text = "Preauth Panel Doctor Insurer (Assigned)";
                }
                else if (Session["RoleId"].ToString() == "4")
                {
                    lbTitle.Text = "Pendency At Trust";
                    lbUserRole.Text = "Preauth Panel Doctor Trust";
                    lbUserRoleAssigned.Text = "Preauth Panel Doctor Trust (Assigned)";
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

}