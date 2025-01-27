using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PPD_PPDUnspecifiedCases : System.Web.UI.Page
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
            dt = ppdHelper.GetUnspecifiedCases(hdUserId.Value, CaseNumber, CardNumber, FromDate, ToDate);
            if (dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridUnspecifiedCases.DataSource = dt;
                gridUnspecifiedCases.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridUnspecifiedCases.DataSource = null;
                gridUnspecifiedCases.DataBind();
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

    protected void gridUnspecifiedCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridUnspecifiedCases.PageIndex = e.NewPageIndex;
        SearchAssignedCases("", "", "", CurrentDate, false);
    }

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbAdmissionId = (Label)row.FindControl("lbAdmissionId");
        Label lbClaimId = (Label)row.FindControl("lbClaimId");
        LinkButton lnkCaseNo = (LinkButton)row.FindControl("lnkCaseNo");
        string CaseNumber = lnkCaseNo.Text.ToString();
        string AdmissionId = lbAdmissionId.Text.ToString();
        Response.Redirect("PPDUnspecifiedCaseDetails.aspx?CaseNumber=" + CaseNumber + "&AdmissionId=" + AdmissionId + "&ClaimId=" + lbClaimId.Text.ToString(), false);
    }
}