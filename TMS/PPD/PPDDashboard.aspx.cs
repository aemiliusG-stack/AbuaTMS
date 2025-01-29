using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class PPD_PPDDashboard : System.Web.UI.Page
{
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
            else
            {
                hdUserId.Value = Session["UserId"].ToString();
                if (!IsPostBack)
                {
                    getDashboardData();
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

    protected void getDashboardData()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetDashboardData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbInsurerCountToday.Text = dt.Rows[0]["PPDInsurerToday"].ToString();
                lbInsurerCountOverall.Text = dt.Rows[0]["PPPDInsurerOverall"].ToString();
                lbTrustCountToday.Text = dt.Rows[0]["PPDTrustToday"].ToString();
                lbTrustOverall.Text = dt.Rows[0]["PPPDTrustOverall"].ToString();
                lbInsurerAssignedToday.Text = dt.Rows[0]["PPDInsurerAssignedToday"].ToString();
                lbInsurerAssignedOverall.Text = dt.Rows[0]["PPPDInsurerAssignedOverall"].ToString();
                lbTrustAssignedToday.Text = dt.Rows[0]["PPDTrustAssignedToday"].ToString();
                lbTrustAssignedOverall.Text = dt.Rows[0]["PPPDTrustAssignedOverall"].ToString();
                lbPreauthCountToday.Text = dt.Rows[0]["PreauthCountToday"].ToString();
                lbPreauthCountOverall.Text = dt.Rows[0]["PreauthCountOverall"].ToString();
                if (Session["RoleId"].ToString() == "3")
                {
                    lbTitle.Text = "Pendency At Insurer";
                    panelInsurerCountToday.Visible = true;
                    panelInsurerCountOverall.Visible = true;
                    panelInsurerAssignedToday.Visible = true;
                    panelInsurerAssignedOverall.Visible = true;
                    panelTrustCountToday.Visible = false;
                    panelTrustCountOverall.Visible = false;
                    panelTrustAssignedToday.Visible = false;
                    panelTrustAssignedOverall.Visible = false;
                }
                else if (Session["RoleId"].ToString() == "4")
                {
                    lbTitle.Text = "Pendency At Trust";
                    panelTrustCountToday.Visible = true;
                    panelTrustCountOverall.Visible = true;
                    panelTrustAssignedToday.Visible = true;
                    panelTrustAssignedOverall.Visible = true;
                    panelInsurerCountToday.Visible = false;
                    panelInsurerCountOverall.Visible = false;
                    panelInsurerAssignedToday.Visible = false;
                    panelInsurerAssignedOverall.Visible = false;
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