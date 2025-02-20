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

public partial class PPD_PPDUnspecifiedCases : System.Web.UI.Page
{
    private string pageName, strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();
    private PPDHelper ppdHelper = new PPDHelper();
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
                hdRoleId.Value = Session["RoleId"].ToString();
                if (!IsPostBack)
                {
                    SearchUnspecifiedCases("", "", "", "", false);
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
        try
        {
            tbCaseNo.Text = string.Empty;
            tbBeneficiaryCardNo.Text = string.Empty;
            tbRegisteredFromDate.Text = string.Empty;
            tbRegisteredToDate.Text = string.Empty;
            SearchUnspecifiedCases("", "", "", "", false);
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
            if (tbCaseNo.Text.ToString().IsEmpty() && tbBeneficiaryCardNo.Text.ToString().IsEmpty() && tbRegisteredFromDate.Text.ToString().IsEmpty() && tbRegisteredToDate.Text.ToString().IsEmpty())
            {
                strMessage = "window.alert('Any of the criteria is required for filtering!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else if ((!tbRegisteredFromDate.Text.ToString().IsEmpty() && tbRegisteredToDate.Text.ToString().IsEmpty()) || (!tbRegisteredToDate.Text.ToString().IsEmpty() && tbRegisteredFromDate.Text.ToString().IsEmpty()))
            {
                strMessage = "window.alert('From Date and To Date are required for filtering!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else
            {
                if ((!tbCaseNo.Text.ToString().IsEmpty() && !TextboxValidation.isAlphaNumeric(tbCaseNo.Text)) || (!tbBeneficiaryCardNo.Text.ToString().IsEmpty() && !TextboxValidation.isAlphaNumeric(tbBeneficiaryCardNo.Text)))
                {
                    strMessage = "window.alert('Invalid input by user!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else
                {
                    SearchUnspecifiedCases(tbCaseNo.Text.ToString(), tbBeneficiaryCardNo.Text.ToString(), tbRegisteredFromDate.Text.ToString(), tbRegisteredToDate.Text.ToString(), true);
                }
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    public void SearchUnspecifiedCases(string CaseNumber, string CardNumber, string FromDate, string ToDate, bool isButtonClicked)
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetUnspecifiedCases(hdRoleId.Value, hdUserId.Value, CaseNumber, CardNumber, FromDate, ToDate);
            if (dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridUnspecifiedCases.DataSource = dt;
                gridUnspecifiedCases.DataBind();
                panelNoData.Visible = false;
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

    protected void gridUnspecifiedCases_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridUnspecifiedCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gridUnspecifiedCases.PageIndex = e.NewPageIndex;
            SearchUnspecifiedCases("", "", "", "", false);
        }
        catch (Exception ex)
        {
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
            Response.Redirect("PPDUnspecifiedCaseDetails.aspx?CaseNumber=" + CaseNumber + "&AdmissionId=" + AdmissionId + "&ClaimId=" + lbClaimId.Text.ToString(), false);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
}