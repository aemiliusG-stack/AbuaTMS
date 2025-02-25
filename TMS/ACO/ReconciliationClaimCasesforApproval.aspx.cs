using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class ACO_ReconciliationClaimCasesforApproval : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    ACOHelper aco = new ACOHelper();
    string pageName;
    MasterData md = new MasterData();
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
            LoadHospitalTypes();
            getSpecialityName();
        }
    }
    protected void getSpecialityName()
    {
        try
        {
            dt = aco.GetSpecialityName();
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
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    private void LoadHospitalTypes()
    {
        try
        {
            dt = aco.GetAllHospitalType(); // Use the class method to get the hospital list
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlHospitalType.DataSource = dt;
                ddlHospitalType.DataTextField = "Title";
                ddlHospitalType.DataValueField = "Id";
                ddlHospitalType.DataBind();
                ddlHospitalType.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                ddlHospitalType.Items.Clear();
                ddlHospitalType.Items.Add(new ListItem("---select---", ""));
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
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
            DataTable dt = aco.GetRecociliationCU_Filter(caseNumber, beneficiaryCardNumber, regFromDate, regToDate, schemeId, categoryId, procedureId);
            gridrptReconciliationCases.DataSource = dt;
            gridrptReconciliationCases.DataBind();
        }
        catch (Exception ex)
        {
            // Handle and display any errors
            lblError.Text = "An error occurred: " + ex.Message;
            lblError.Visible = true;
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
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
                dt = aco.GetProcedureName(packageId);
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
            tbCaseNumber.Text = string.Empty;
            tbBeneficiaryNo.Text = string.Empty;
            //ddlHospitals.SelectedIndex = 0;
            ddlHospitalType.SelectedIndex = 0;
            //DropDownListDistricts.SelectedIndex = 0;
            //GridView1.DataSource = null;
            //GridView1.DataBind();
            lblError.Visible = false;
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