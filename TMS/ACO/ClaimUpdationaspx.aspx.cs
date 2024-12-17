using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ACO_ClaimUpdationaspx : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadClaimDetails();
        }
    }
    private void LoadClaimDetails()
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlCommand cmd = new SqlCommand("sp_GetClaimDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            // Check if there is data
            if (dt.Rows.Count > 0)
            {
                rptClaimCases.DataSource = dt;
                rptClaimCases.DataBind();
            }
            else
            {
                // If no data, clear the repeater
                rptClaimCases.DataSource = null;
                rptClaimCases.DataBind();
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

        rptClaimCases.DataSource = null;
        rptClaimCases.DataBind();

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
}