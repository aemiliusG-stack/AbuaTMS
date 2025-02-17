using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PPD_PPDHome : System.Web.UI.Page
{

    private string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();
    private PPDHelper ppdHelper = new PPDHelper();
    string CurrentDate = DateTime.Now.ToString("yyyy-MM-dd");
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
                    SearchAssignedCases("", "", "", CurrentDate, false);
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbCaseNo.Text = string.Empty;
        tbBeneficiaryCardNo.Text = string.Empty;
        tbRegisteredFromDate.Text = string.Empty;
        tbRegisteredToDate.Text = string.Empty;
        SearchAssignedCases("", "", "", CurrentDate, false);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SearchAssignedCases(tbCaseNo.Text.ToString(), tbBeneficiaryCardNo.Text.ToString(), tbRegisteredFromDate.Text.ToString(), tbRegisteredToDate.Text.ToString(), true);
    }

    public void SearchAssignedCases(string CaseNumber, string CardNumber, string FromDate, string ToDate, bool isButtonClicked)
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetAssignedCases(hdUserId.Value, CaseNumber, CardNumber, FromDate, ToDate);
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridAssignedCases.DataSource = dt;
                gridAssignedCases.DataBind();
                panelNoData.Visible = false;
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridAssignedCases.DataSource = null;
                gridAssignedCases.DataBind();
                panelNoData.Visible = true;
                if (isButtonClicked)
                {
                    string strMessage = "window.alert('No records found for the given search criteria.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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

    protected void gridAssignedCases_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbCaseStatus = (Label)e.Row.FindControl("lbCaseStatus");
            Label lbClaimId = (Label)e.Row.FindControl("lbClaimId");
            DataTable dt = ppdHelper.GetCaseStatus(lbClaimId.Text.ToString());
            if (dt != null && dt.Rows.Count > 0)
            {
                string actionTaken = dt.Rows[0]["ActionTaken"].ToString().Trim();
                lbCaseStatus.Text = actionTaken;
            }
        }
    }

    protected void gridAssignedCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridAssignedCases.PageIndex = e.NewPageIndex;
        SearchAssignedCases("", "", "", CurrentDate, false);
    }

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbAdmissionId = (Label)row.FindControl("lbAdmissionId");
        Label lbClaimId = (Label)row.FindControl("lbClaimId");
        Label lbClaimMode = (Label)row.FindControl("lbClaimMode");
        Label lbPackageId = (Label)row.FindControl("lbPackageId");
        LinkButton lnkCaseNo = (LinkButton)row.FindControl("lnkCaseNo");
        if (!lbPackageId.Text.ToString().Equals("28"))
        {
            Response.Redirect("PPDPatientDetails.aspx?CaseNumber=" + lnkCaseNo.Text.ToString() + "&AdmissionId=" + lbAdmissionId.Text.ToString() + "&ClaimId=" + lbClaimId.Text.ToString(), false);
        }
        else
        {
            Response.Redirect("PPDUnspecifiedCaseDetails.aspx?CaseNumber=" + lnkCaseNo.Text.ToString() + "&AdmissionId=" + lbAdmissionId.Text.ToString() + "&ClaimId=" + lbClaimId.Text.ToString(), false);
        }
    }
}