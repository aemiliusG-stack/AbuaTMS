using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using AbuaTMS;
using System.Xml.Linq;
using WebGrease.Css.Ast;
using CareerPath.DAL;
using System.Web.UI;

public partial class CEX_CEXDashboard : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private CEX cex = new CEX();
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
            else if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                hdRoleId.Value = Session["RoleId"].ToString();
                GetCEXPendencyCount();
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


    private void GetCEXPendencyCount()
    {
        try
        {
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_GetCEXCounts");

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                int insurerTodayCount = Convert.ToInt32(row["CEXInsurerToday"]);
                int insurerOverallCount = Convert.ToInt32(row["CEXInsurerOverall"]);
                int trustTodayCount = Convert.ToInt32(row["CEXTrustToday"]);
                int trustOverallCount = Convert.ToInt32(row["CEXTrustOverall"]);

                if (hdRoleId.Value == "5") 
                {
                    lbTodayPendency.Text = " " + insurerTodayCount.ToString();
                    lbOverallPendency.Text = insurerOverallCount.ToString();
                    MultiView1.SetActiveView(ViewForInsurer);
                }
                else if (hdRoleId.Value == "6") 
                {
                    lbTrustToday.Text = trustTodayCount.ToString();
                    lbTrustOverall.Text = trustOverallCount.ToString();
                    lbInsurerforToday.Text = " " + insurerTodayCount.ToString();
                    lbInsurerforOverall.Text = insurerOverallCount.ToString();
                    MultiView1.SetActiveView(ViewForTrust);
                }
                else
                {
                    string errorMessage = "window.alert('User role not recognized. Please contact support.');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", errorMessage, true);
                }
            }
            else
            {
                string noRecordsMessage = "window.alert('No records found for the given user.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NoRecords", noRecordsMessage, true);
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