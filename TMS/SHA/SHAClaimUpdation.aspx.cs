
using AbuaTMS;
using CareerPath.DAL;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class SHA_SHAClaimUpdation : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SHA_GetClaimDetailsUpdated", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddRange(parameters);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                    if (dt.Rows.Count > 0)
                    {
                        gridClaimCases.DataSource = dt;
                        gridClaimCases.DataBind();
                    }
                    else
                    {
                        gridClaimCases.DataSource = null;
                        gridClaimCases.DataBind();
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
        //ddlTypeS.SelectedIndex = 0;
        //ddlScheme.SelectedIndex = 0;
        //ddlPhase.SelectedIndex = 0;
        //ddlFinancialYear.SelectedIndex = 0;

        //rptClaimCases.DataSource = null;
        //rptClaimCases.DataBind();

        //lblTotalCases.Text = "0";
        //lblSelectedCases.Text = "0";
        //lblTotalAmount.Text = "Rs 0";
        //lblAmountApproved.Text = "Rs 0";

        lblError.Visible = false;
    }

    protected void SearchSubmit_Click(object sender, EventArgs e)
    {
    }

    protected void gridClaimCases_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {

    }

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        LinkButton lnkCaseNo = (LinkButton)row.FindControl("lnkCaseNo");
        string CaseNumber = lnkCaseNo.Text.ToString();
        Response.Redirect("CaseDetails.aspx?CaseNumber=" + CaseNumber, false);
    }
}