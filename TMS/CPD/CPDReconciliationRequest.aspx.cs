using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AbuaTMS;

public partial class CPD_CPDReconciliationRequest : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    CPD cpd = new CPD();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid_RecociliationClaimUpdation();
            getSpecialityName();
        }
    }

    protected void gvReconciliationClaim_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int rowIndex = e.Row.RowIndex + 1;
            Label lbSlNo = (Label)e.Row.FindControl("lbSlNo");
            lbSlNo.Text = rowIndex.ToString();
        }
    }

    private void BindGrid_RecociliationClaimUpdation()
    {
        dt.Clear();
        dt = cpd.GetRecociliationClaimUpdation();

        if (dt != null && dt.Rows.Count > 0)
        {
            gvReconciliationClaim.DataSource = dt;
            gvReconciliationClaim.DataBind();
        }
        else
        {
            gvReconciliationClaim.DataSource = null;
            gvReconciliationClaim.EmptyDataText = "No record found.";
            gvReconciliationClaim.DataBind();
        }
    }


    protected void btnCPDSearch_Click(object sender, EventArgs e)
    {
        string caseNumber = tbCaseNumber.Text.Trim();
        string beneficiaryCardNumber = tbBeneficiaryNo.Text.Trim();
        DateTime? regFromDate = string.IsNullOrEmpty(tbRegFromDate.Text) ? (DateTime?)null : Convert.ToDateTime(tbRegFromDate.Text);
        DateTime? regToDate = string.IsNullOrEmpty(tbRegToDate.Text) ? (DateTime?)null : Convert.ToDateTime(tbRegToDate.Text);
        int schemeId;
        if (!int.TryParse(ddSchemeId.SelectedValue, out schemeId))
        {
            schemeId = 0;
        }
        int categoryId;
        if (!int.TryParse(ddCategory.SelectedValue, out categoryId))
        {
            categoryId = 0;
        }
        int procedureId;
        if (!int.TryParse(ddProcedureName.SelectedValue, out procedureId))
        {
            procedureId = 0;
        }
        DataTable dt = cpd.GetRecociliationCU_Filter(caseNumber, beneficiaryCardNumber, regFromDate, regToDate, schemeId, categoryId, procedureId);
        gvReconciliationClaim.DataSource = dt;
        gvReconciliationClaim.DataBind();
    }

    protected void getSpecialityName()
    {
        try
        {
            dt = cpd.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddCategory.Items.Clear();
                ddCategory.DataValueField = "PackageId";
                ddCategory.DataTextField = "SpecialityName";
                ddCategory.DataSource = dt;
                ddCategory.DataBind();
                ddCategory.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddCategory.Items.Clear();
                ddCategory.Items.Insert(0, new ListItem("--No Speciality Name Available--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void ddCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int packageId;
            if (int.TryParse(ddCategory.SelectedValue, out packageId))
            {
                dt = cpd.GetProcedureName(packageId);
                if (dt.Rows.Count > 0)
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.DataValueField = "ProcedureId";
                    ddProcedureName.DataTextField = "ProcedureName";
                    ddProcedureName.DataSource = dt;
                    ddProcedureName.DataBind();
                    ddProcedureName.Items.Insert(0, new ListItem("--SELECT--", "0"));
                }
                else
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.Items.Insert(0, new ListItem("--No Procedure Available--", "0"));
                }
            }
            else
            {
                ddProcedureName.Items.Clear();
                ddProcedureName.Items.Insert(0, new ListItem("--SELECT SPECIALITY FIRST--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void btnCPDReset_Click(object sender, EventArgs e)
    {
        tbCaseNumber.Text = string.Empty;
        BindGrid_RecociliationClaimUpdation();
    }


}