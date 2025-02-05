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

public partial class CEO_SHA_CEOSHAUnspecifiedCases : System.Web.UI.Page
{
    string strMessage;
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    CPD cpd = new CPD();
    CEOSHA CEOSHA = new CEOSHA();
    string pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            getSpecialityName();
            BindGrid_RecociliationClaimUpdation();
        }
    }
    protected void getSpecialityName()
    {
        try
        {
            dt = cpd.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                dropCategory.Items.Clear();
                dropCategory.DataValueField = "PackageId";
                dropCategory.DataTextField = "SpecialityName";
                dropCategory.DataSource = dt;
                dropCategory.DataBind();
                dropCategory.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                dropCategory.Items.Clear();
                dropCategory.Items.Insert(0, new ListItem("--No Speciality Name Available--", "0"));
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void dropCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int packageId;
            if (int.TryParse(dropCategory.SelectedValue, out packageId))
            {
                dt = cpd.GetProcedureName(packageId);
                if (dt.Rows.Count > 0)
                {
                    dropProcedureName.Items.Clear();
                    dropProcedureName.DataValueField = "ProcedureId";
                    dropProcedureName.DataTextField = "ProcedureName";
                    dropProcedureName.DataSource = dt;
                    dropProcedureName.DataBind();
                    dropProcedureName.Items.Insert(0, new ListItem("--Select--", "0"));
                }
                else
                {
                    dropProcedureName.Items.Clear();
                    dropProcedureName.Items.Insert(0, new ListItem("--No Procedure Available--", "0"));

                }
            }
            else
            {
                dropProcedureName.Items.Clear();
                dropProcedureName.Items.Insert(0, new ListItem("--SELECT SPECIALITY FIRST--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void ClearAll()
    {
        tbCaseNo.Text = "";
        tbBeneficiaryCardNo.Text = "";
        tbPatientName.Text = "";
        tbRegisteredFromDate.Text = "";
        tbRegisteredToDate.Text = "";
        dropCategory.SelectedIndex = 0;
        dropProcedureName.SelectedIndex = 0;
    }
    private void BindGrid_RecociliationClaimUpdation()
    {
        dt.Clear();
        dt = CEOSHA.GetRecociliationClaimUpdation();

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
    protected void gvReconciliationClaim_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int rowIndex = e.Row.RowIndex + 1;
            Label lbSlNo = (Label)e.Row.FindControl("lbSlNo");
            lbSlNo.Text = rowIndex.ToString();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

}