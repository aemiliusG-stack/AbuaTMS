using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class PPD_PPDHome : System.Web.UI.Page
{

    private string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PPDHelper ppdHelper = new PPDHelper();
    string CurrentDate = DateTime.Now.ToString("yyyy-MM-dd");
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                SearchAssignedCases("", "", "", CurrentDate);
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
        SearchAssignedCases("", "", "", CurrentDate);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SearchAssignedCases(tbCaseNo.Text.ToString(), tbBeneficiaryCardNo.Text.ToString(), tbRegisteredFromDate.Text.ToString(), tbRegisteredToDate.Text.ToString());
    }

    public void SearchAssignedCases(string CaseNumber, string CardNumber, string FromDate, string ToDate)
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetAssignedCases(hdUserId.Value, CaseNumber, CardNumber, FromDate, ToDate);
            if (dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridAssignedCases.DataSource = dt;
                gridAssignedCases.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridAssignedCases.DataSource = null;
                gridAssignedCases.DataBind();
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

    protected void gridAssignedCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridAssignedCases.PageIndex = e.NewPageIndex;
        SearchAssignedCases("", "", "", CurrentDate);
    }

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbAdmissionId = (Label) row.FindControl("lbAdmissionId");
        Label lbClaimId = (Label) row.FindControl("lbClaimId");
        LinkButton lnkCaseNo = (LinkButton) row.FindControl("lnkCaseNo");
        string CaseNumber = lnkCaseNo.Text.ToString();
        string AdmissionId = lbAdmissionId.Text.ToString();
        Response.Redirect("PPDPatientDetails.aspx?CaseNumber=" + CaseNumber + "&AdmissionId=" + AdmissionId + "&ClaimId=" + lbClaimId.Text.ToString(), false);
    }

}