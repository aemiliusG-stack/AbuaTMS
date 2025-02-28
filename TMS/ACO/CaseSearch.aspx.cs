using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;
using System.IO;

public partial class ACO_CaseSearch : System.Web.UI.Page
{
    private string pageName, strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();
    ACOHelper aco = new ACOHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = Path.GetFileName(Request.Url.AbsolutePath);
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
                    GetPatients("", "", "", "", "", false);
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

    protected void gridCaseSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gridCaseSearch.PageIndex = e.NewPageIndex;
            GetPatients("", "", "", "", "", false);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridCaseSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbCaseStatus = (Label)e.Row.FindControl("lbCaseStatus");
                Label lbClaimId = (Label)e.Row.FindControl("lbClaimId");
                Label lbDischargeDate = (Label)e.Row.FindControl("lbDischargeDate");
                string DischargeDate = lbDischargeDate.Text.ToString();
                DataTable dt = aco.GetCaseStatus(lbClaimId.Text.ToString());
                if (dt != null && dt.Rows.Count > 0)
                {
                    string actionTaken = dt.Rows[0]["ActionTaken"].ToString().Trim();
                    lbCaseStatus.Text = actionTaken;
                }
                if (DischargeDate.IsEmpty())
                {
                    lbDischargeDate.Text = "Under Treatement";
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

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbAdmissionId = (Label)row.FindControl("lbAdmissionId");
            Label lbClaimId = (Label)row.FindControl("lbClaimId");
            LinkButton lnkCaseNo = (LinkButton)row.FindControl("lnkCaseNo");
            string CaseNumber = lnkCaseNo.Text.ToString();
            string AdmissionId = lbAdmissionId.Text.ToString();
            Response.Redirect("ACOCaseSearchPatientDetail.aspx?CaseNumber=" + CaseNumber + "&AdmissionId=" + AdmissionId + "&ClaimId=" + lbClaimId.Text.ToString(), false);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (tbCaseNo.Text.ToString().IsEmpty() && tbBeneficiaryCardNo.Text.ToString().IsEmpty() && tbClaimNumber.Text.ToString().IsEmpty() && tbFromDate.Text.ToString().IsEmpty() && tbToDate.Text.ToString().IsEmpty())
            {
                strMessage = "window.alert('Any of the criteria is required for filtering!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else if ((!tbFromDate.Text.ToString().IsEmpty() && tbToDate.Text.ToString().IsEmpty()) || (!tbToDate.Text.ToString().IsEmpty() && tbFromDate.Text.ToString().IsEmpty()))
            {
                strMessage = "window.alert('From Date and To Date are required for filtering!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else
            {
                if ((!tbCaseNo.Text.ToString().IsEmpty() && !TextboxValidation.isAlphaNumeric(tbCaseNo.Text)) || (!tbClaimNumber.Text.ToString().IsEmpty() && !TextboxValidation.isAlphaNumeric(tbClaimNumber.Text)) || (!tbBeneficiaryCardNo.Text.ToString().IsEmpty() && !TextboxValidation.isAlphaNumeric(tbBeneficiaryCardNo.Text)))
                {
                    strMessage = "window.alert('Invalid input by user!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else
                {
                    GetPatients(tbCaseNo.Text.ToString(), tbBeneficiaryCardNo.Text.ToString(), tbClaimNumber.Text.ToString(), tbFromDate.Text.ToString(), tbToDate.Text.ToString(), true);
                }
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbCaseNo.Text = string.Empty;
        tbBeneficiaryCardNo.Text = string.Empty;
        tbClaimNumber.Text = string.Empty;
        tbFromDate.Text = string.Empty;
        tbToDate.Text = string.Empty;
        GetPatients("", "", "", "", "", false);
    }

    public void GetPatients(string CaseNumber, string CardNumber, string ClaimNumber, string FromDate, string ToDate, bool isButtonClicked)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = aco.SearchCase(CaseNumber, CardNumber, ClaimNumber, FromDate, ToDate);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridCaseSearch.DataSource = dt;
                gridCaseSearch.DataBind();
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                panelNoData.Visible = false;
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridCaseSearch.DataSource = null;
                gridCaseSearch.DataBind();
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
}