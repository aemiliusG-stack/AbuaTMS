using AbuaTMS;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class CPD_CPDDashboard : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    CPD cpd = new CPD();
    string pageName;
    MasterData md = new MasterData();

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
                GetCPDPendencyCount();
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
        GetCPDPendencyCount();
    }

    private void GetCPDPendencyCount()
    {
        DataTable cpdCounts = cpd.GetCPDCounts(); // Fetch the data using your existing method

        if (cpdCounts.Rows.Count > 0)
        {
            DataRow row = cpdCounts.Rows[0]; // Assuming you want to bind the first record from the result

            // Extract counts from the result set
            int insurerTodayCount = Convert.ToInt32(row["CPDInsurerToday"]);
            int insurerOverallCount = Convert.ToInt32(row["CPDInsurerOverall"]);
            int trustTodayCount = Convert.ToInt32(row["CPDTrustToday"]);
            int trustOverallCount = Convert.ToInt32(row["CPDTrustOverall"]);
            int insurerTodayCountAssigned = Convert.ToInt32(row["CPDInsurerTodayAssigned"]);
            int insurerOverallCountAssigned = Convert.ToInt32(row["CPDInsurerOverallAssigned"]);
            int trustTodayCountAssigned = Convert.ToInt32(row["CPDTrustTodayAssigned"]);
            int trustOverallCountAssigned = Convert.ToInt32(row["CPDTrustOverallAssigned"]);
            //// Bind Insurer data to labels
            //lbTodayPendency.Text = row["CPDInsurerToday"].ToString();
            //lbOverallPendency.Text = row["CEXInsurerOverall"].ToString();

            //// Bind Trust data to labels
            //lbTrustToday.Text = row["CPDTrustToday"].ToString();
            //lbTrustOverall.Text = row["CPDTrustOverall"].ToString();

            //// Bind additional insurer counts (if needed)
            //lbInsurerforToday.Text = row["CPDInsurerToday"].ToString();
            //lbInsurerforOverall.Text = row["CPDInsurerOverall"].ToString();

            if (hdRoleId.Value == "7") // Insurer Role
            {
                // Show only Insurer counts
                lbTodayPendency.Text = " " + insurerTodayCount.ToString();
                lbOverallPendency.Text = insurerOverallCount.ToString();
                lbTodayPendencyAssigned.Text = " " + insurerTodayCountAssigned.ToString();
                lbOverallPendencyAssigned.Text = insurerOverallCountAssigned.ToString();
                MultiView1.SetActiveView(ViewForInsurer);
            }
            else if (hdRoleId.Value == "8") // Trust Role
            {
                // Show both Insurer and Trust counts
                lbTrustToday.Text = trustTodayCount.ToString();
                lbTrustOverall.Text = trustOverallCount.ToString();
                lbTrustTodayAssigned.Text = trustTodayCountAssigned.ToString();
                lbTrustOverallAssigned.Text = trustOverallCountAssigned.ToString();
                //lbInsurerforToday.Text = " " + insurerTodayCount.ToString();

                //lbInsurerforOverall.Text = insurerOverallCount.ToString();

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
            // Handle no data scenario (optional)
            lbTodayPendency.Text = "0";
            lbOverallPendency.Text = "0";
            lbTrustToday.Text = "0";
            lbTrustOverall.Text = "0";
            //lbInsurerforToday.Text = "0";
            //lbInsurerforOverall.Text = "0";
        }
    }

}