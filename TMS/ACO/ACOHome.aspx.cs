using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CareerPath.DAL;

public partial class ACO_ACOHome : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    ACOHelper aco = new ACOHelper();
    MasterData md = new MasterData();
    string pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            hdRoleId.Value = Session["RoleId"].ToString();
            BindDashboardData();
        }
    }
    private void BindDashboardData()
    {
        try
        {
            int parsedUserId;
            int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_Dashboard", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    if (hdRoleId.Value == "9")
                    {
                        // Preauth Panel Doctor Insurer
                        //lbPreauthPanelDoctorInsurerToday.Text = row["PreauthPanelDoctorInsurerToday"].ToString();
                        //lbPreauthPanelDoctorInsurerOverall.Text = row["PreauthPanelDoctorInsurerOverall"].ToString();
                        //lbPreauthPanelDoctorTrustToday.Text = row["PreauthPanelDoctorTrustToday"].ToString();
                        //// Preauth Panel Doctor Insurer (Assigned)
                        //lbPreauthPanelDoctorInsurerAssignedToday.Text = row["PreauthPanelDoctorInsurerAssignedToday"].ToString();
                        //lbPreauthPanelDoctorInsurerAssignedOverall.Text = row["PreauthPanelDoctorInsurerAssignedOverall"].ToString();
                        //// Claim Executive Officer Insurer
                        //lbClaimExecutiveInsurerToday.Text = row["ClaimExecutiveInsurerToday"].ToString();
                        //lbClaimExecutiveInsurerOverall.Text = row["ClaimExecutiveInsurerTodayrOverall"].ToString();
                        ////Claim Panel Doctor Insurer
                        //lbClaimPanelDoctorInsurerToday.Text = row["ClaimPanelDoctorInsurerToday"].ToString();
                        //lbClaimPanelDoctorInsurerOverall.Text = row["ClaimPanelDoctorInsurerOverall"].ToString();
                        ////Claim Panel Doctor Insurer Assigned
                        //lbClaimPanelDoctorInsurerAssignedToday.Text = row["ClaimPanelDoctorInsurerAssignedToday"].ToString();
                        //lbClaimPanelDoctorInsurerAssignedOverall.Text = row["ClaimPanelDoctorInsurerAssignedOverall"].ToString();
                        ////Account Claim Officer Insurer
                        //lbACOInsurerToday.Text = row["AccountOfficerInsurerToday"].ToString();
                        //lbACOInsurerOverall.Text = row["AccountOfficerInsurerOverall"].ToString();
                        ////SHA Insurer
                        //lbSHAInsurerToday.Text = row["SHAInsurerToday"].ToString();
                        //lbSHAInsurerOverall.Text = row["SHAInsurerOverall"].ToString();

                        // Hide 
                        // Preauth Panel Doctor Trust
                        lbPreauthPanelDoctorTrustAssignedToday.Visible = false;
                        lbPreauthPanelDoctorTrustAssignedOverall.Visible = false;
                        // Claim Executive Trust
                        lbClaimExecutiveTrustToday.Visible = false;
                        lbClaimExecutiveTrustOverall.Visible = false;
                        //Claim Panel Doctor Trust
                        lbClaimPanelDoctorTrustAssignedToday.Visible = false;
                        lbClaimPanelDoctorTrustAssignedOverall.Visible = false;
                        //Account Claim Officer Trust
                        lbACOTrustAssignedToday.Visible = false;
                        lbACOTrustAssignedOverall.Visible = false;
                        //SHA Trust
                        lbSHATrustAssignedToday.Visible = false;
                        lbSHATrustAssignedOverall.Visible = false;
                    }
                    else if (hdRoleId.Value == "10")
                    {
                        // Preauth Panel Doctor Trust
                        lbPreauthPanelDoctorTrustAssignedToday.Text = row["PreauthPanelDoctorTrustToday"].ToString();
                        lbPreauthPanelDoctorTrustAssignedOverall.Text = row["PreauthPanelDoctorTrustOverall"].ToString();
                        lbPreauthPanelDoctorTrustOverall.Text = row["PreauthPanelDoctorTrustOverall"].ToString();
                        // Claim Executive Trust
                        lbClaimExecutiveTrustToday.Text = row["ClaimExecutiveTrustToday"].ToString();
                        lbClaimExecutiveTrustOverall.Text = row["ClaimExecutiveTrustTodayrOverall"].ToString();
                        //Claim Panel Doctor Trust
                        lbClaimPanelDoctorTrustToday.Text = row["ClaimPanelDoctorTrustToday"].ToString();
                        lbClaimPanelDoctorTrustOverall.Text = row["ClaimPanelDoctorTrustOverall"].ToString();
                        lbClaimPanelDoctorTrustAssignedToday.Text = row["ClaimPanelDoctorTrustToday"].ToString();
                        lbClaimPanelDoctorTrustAssignedOverall.Text = row["ClaimPanelDoctorTrustOverall"].ToString();
                        //Account Claim Officer Trust
                        lbACOTrustAssignedToday.Text = row["AccountOfficerTrustToday"].ToString();
                        lbACOTrustAssignedOverall.Text = row["AccountOfficerTrustOverall"].ToString();
                        //SHA Trust
                        lbSHATrustAssignedToday.Text = row["SHATrustToday"].ToString();
                        lbSHATrustAssignedOverall.Text = row["SHATrustOverall"].ToString();

                        // Hide
                        // Preauth Panel Doctor Insurer
                        //lbPreauthPanelDoctorInsurerToday.Visible = false;
                        //lbPreauthPanelDoctorInsurerOverall.Visible = false;
                        // Preauth Panel Doctor Insurer (Assigned)
                        //lbPreauthPanelDoctorInsurerAssignedToday.Visible = false;
                        //lbPreauthPanelDoctorInsurerAssignedOverall.Visible = false;
                        //// Claim Executive Officer Insurer
                        //lbClaimExecutiveInsurerToday.Visible = false;
                        //lbClaimExecutiveInsurerOverall.Visible = false;
                        ////Claim Panel Doctor Insurer
                        //lbClaimPanelDoctorInsurerToday.Visible = false;
                        //lbClaimPanelDoctorInsurerOverall.Visible = false;
                        ////Claim Panel Doctor Insurer Assigned
                        //lbClaimPanelDoctorInsurerAssignedToday.Visible = false;
                        //lbClaimPanelDoctorInsurerAssignedOverall.Visible = false;
                        ////Account Claim Officer Insurer
                        //lbACOInsurerToday.Visible = false;
                        //lbACOInsurerOverall.Visible = false;
                        ////SHA Insurer
                        //lbSHAInsurerToday.Visible = false;
                        //lbSHAInsurerOverall.Visible = false;
                    }
                }
                else
                {
                    lblError.Text = "No details found for the provided Case Number.";
                    lblError.Visible = true;
                }
            }

        }
        catch (Exception ex)
        {
            lblError.Text = "An error occurred while retrieving hospital details: " + ex.Message;
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

}