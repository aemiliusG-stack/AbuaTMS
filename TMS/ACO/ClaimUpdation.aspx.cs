using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ACO_ClaimUpdation : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
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
            LoadClaimDetails();
        }
    }
    private void LoadClaimDetails()
    {
        DataTable dt = new DataTable();

        try
        {
            string UserId = Session["UserId"].ToString();
            if (UserId != null)
            {
                long userId;
                if (long.TryParse(Session["UserId"].ToString(), out userId))
                {
                    SqlParameter[] parameters = new SqlParameter[]
                    {
                    new SqlParameter("@UserId", userId)
                    };
                    //using (SqlCommand cmd = new SqlCommand("sp_GetClaimDetails", con))
                    using (SqlCommand cmd = new SqlCommand("ACO_GetClaimDetailsUpdated", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // Add parameters to the command
                        cmd.Parameters.AddRange(parameters);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                    // Check if there is data
                    if (dt.Rows.Count > 0)
                    {
                        gridrptClaimCases.DataSource = dt;
                        gridrptClaimCases.DataBind();
                    }
                    else
                    {
                        // If no data, clear the repeater
                        gridrptClaimCases.DataSource = null;
                        gridrptClaimCases.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error loading claim details: " + ex.Message;
            lblError.Visible = true;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddlTypeS.SelectedIndex = 0;
        ddlScheme.SelectedIndex = 0;
        ddlPhase.SelectedIndex = 0;
        ddlFinancialYear.SelectedIndex = 0;

        gridrptClaimCases.DataSource = null;
        gridrptClaimCases.DataBind();

        lblTotalCases.Text = "0";
        lblSelectedCases.Text = "0";
        lblTotalAmount.Text = "Rs 0";
        lblAmountApproved.Text = "Rs 0";

        lblError.Visible = false;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
    }
    protected void SearchSubmit_Click(object sender, EventArgs e)
    {
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {

        //decimal InsurerAmount = Convert.ToDecimal(hdInsurerAmount.Value);
        //decimal TrustAmount = Convert.ToDecimal(hdTrustAmount.Value);

        // Default values in case parsing fails
        int parsedUserId;
        int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
        int actionId = 2;
        decimal TrustAmount = 0;
        decimal InsurerAmount = 0;

        // Check if HiddenFields are not empty and parse values
        if (!string.IsNullOrEmpty(hdTrustAmount.Value))
        {
            decimal.TryParse(hdTrustAmount.Value, out TrustAmount);
            ApproveClaim(Convert.ToInt32(hdClaimId.Value), userId, actionId, " ", "", "", hdRemarks.Value, (int)TrustAmount);
        }
        if (!string.IsNullOrEmpty(hdInsurerAmount.Value))
        {
            decimal.TryParse(hdInsurerAmount.Value, out InsurerAmount);
            ApproveClaim(Convert.ToInt32(hdClaimId.Value), userId, actionId, " ", "", "", hdRemarks.Value, (int)InsurerAmount);
            Response.Redirect("~/ACO/ClaimUpdation.aspx");
        }
    }
    private void ApproveClaim(int claimId, long userId, int actionId, string queryReasonId, string querySubReasonId, string rejectReasonId, string remarks, int? totalFinalAmountByAco)
    {
        try
        {
            //reasonId = (long?)(selectedReason ?? (object)DBNull.Value) ?? 0;
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_InsertActions", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClaimId", claimId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ActionId", actionId);
                cmd.Parameters.AddWithValue("@ReasonId", queryReasonId ?? (object)DBNull.Value);
                //cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ??  (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ?? "");
                cmd.Parameters.AddWithValue("@RejectReasonId", rejectReasonId ?? "");
                cmd.Parameters.AddWithValue("@Remarks", remarks ?? "");
                //cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco ?? "");
                // Only add the Amount parameter when actionId is 1 (Approve)
                if (totalFinalAmountByAco.HasValue)
                {
                    cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Amount", 0); // Or omit this parameter entirely if you prefer
                }
                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblSuccess.Text = "Action processed successfully!";
            lblSuccess.Visible = true;
            //Response.Redirect("~/ACO/ClaimUpdation.aspx");
        }
        catch (Exception ex)
        {
            lblError.Text = "Error processing action: " + ex.Message;
            lblError.Visible = true;
        }
        finally
        {
            con.Close();
        }
    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkSelectAll = (CheckBox)sender;
        foreach (GridViewRow row in gridrptClaimCases.Rows)
        {
            CheckBox chkBox = (CheckBox)row.FindControl("cbCheckbox");
            chkBox.Checked = chkSelectAll.Checked;
        }
    }


    protected void cbCheckbox_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkBox = (CheckBox)sender;

        GridViewRow row = (GridViewRow)chkBox.NamingContainer;
        Label lbInsurerFinalAmount = (Label)row.FindControl("lbInsurerFinalAmount");
        Label lbTrustFinalAmount = (Label)row.FindControl("lbTrustFinalAmount");
        Label lbClaimId = (Label)row.FindControl("lbClaimId");
        TextBox tbExemptionRemarks = (TextBox)row.FindControl("tbExemptionRemarks");
        hdInsurerAmount.Value = lbInsurerFinalAmount.Text.ToString();
        hdTrustAmount.Value = lbTrustFinalAmount.Text.ToString();
        hdClaimId.Value = lbClaimId.Text.ToString();
        hdRemarks.Value = tbExemptionRemarks.Text.ToString();
    }
}