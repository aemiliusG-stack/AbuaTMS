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
using CareerPath.DAL;

public partial class CPD_CPDCaseSearch : System.Web.UI.Page
{
    string strMessage;
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    CPD cpd = new CPD();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetPatientStates();
            GetHospitalStates();
            //GetCaseTypes();
            GetHospitalName();
            getSpecialityName();
            LoadData(string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty);
        }
    }
    protected void GetPatientStates()
    {
        try
        {
            dt.Clear();
            dt = md.GetState();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddPatientState.Items.Clear();
                ddPatientState.DataValueField = "Id";
                ddPatientState.DataTextField = "Title";
                ddPatientState.DataSource = dt;
                ddPatientState.DataBind();
                ddPatientState.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddPatientState.Items.Clear();
                ddPatientState.Items.Insert(0, new ListItem("--No States Available--", "0"));
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void dropPatientState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int stateId;
            if (int.TryParse(ddPatientState.SelectedValue, out stateId))
            {
                dt = md.GetDistrictStateWise(stateId);
                if (dt.Rows.Count > 0)
                {
                    ddPatientDistrict.Items.Clear();
                    ddPatientDistrict.DataValueField = "Id";
                    ddPatientDistrict.DataTextField = "Title";
                    ddPatientDistrict.DataSource = dt;
                    ddPatientDistrict.DataBind();
                    ddPatientDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
                }
                else
                {
                    ddPatientDistrict.Items.Clear();
                }
            }
            else
            {
                ddPatientDistrict.Items.Clear();
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void GetHospitalStates()
    {
        try
        {
            dt.Clear();
            dt = md.GetState();
            if (dt.Rows.Count > 0)
            {
                ddHospitalState.Items.Clear();
                ddHospitalState.DataValueField = "Id";
                ddHospitalState.DataTextField = "Title";
                ddHospitalState.DataSource = dt;
                ddHospitalState.DataBind();
                ddHospitalState.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddHospitalState.Items.Clear();
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void dropHospitalState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int stateId = int.Parse(ddHospitalState.SelectedValue); 
            dt = md.GetDistrictStateWise(stateId);

            if (dt.Rows.Count > 0)
            {
                ddHospitalDistrict.Items.Clear();
                ddHospitalDistrict.DataValueField = "Id";
                ddHospitalDistrict.DataTextField = "Title";
                ddHospitalDistrict.DataSource = dt;
                ddHospitalDistrict.DataBind();
                ddHospitalDistrict.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                ddHospitalDistrict.Items.Clear();
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    //protected void GetCaseTypes()
    //{
    //    try
    //    {
    //        dt.Clear();
    //        CPD cpd = new CPD();
    //        dt = cpd.GetCaseType();
    //        if (dt.Rows.Count > 0)
    //        {
    //            ddCaseType.Items.Clear();
    //            ddCaseType.DataValueField = "Id";
    //            ddCaseType.DataTextField = "Title";
    //            ddCaseType.DataSource = dt;
    //            ddCaseType.DataBind();
    //            ddCaseType.Items.Insert(0, new ListItem("--Select--", "0"));
    //        }
    //        else
    //        {
    //            ddCaseType.Items.Clear();
    //        }
    //    }
    //    catch (Exception)
    //    {
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //        return;
    //    }
    //}
    protected void GetHospitalName()
    {
        try
        {
            dt.Clear();
            CPD cpd = new CPD();
            dt = cpd.GetHospitalName();
            if (dt.Rows.Count > 0)
            {
                ddHospitalName.Items.Clear();
                ddHospitalName.DataValueField = "Id";
                ddHospitalName.DataTextField = "HospitalName";
                ddHospitalName.DataSource = dt;
                ddHospitalName.DataBind();
                ddHospitalName.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddHospitalName.Items.Clear();
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    private void LoadData(string caseNumber, string cardNumber, string patientState, string patientDistrict, string packageId, string procedureId)
    {
        try
        {
            SqlParameter[] parameters = new SqlParameter[] {
            CreateSqlParameter("@CaseNumber", caseNumber),
            CreateSqlParameter("@CardNumber", cardNumber),
            CreateSqlParameter("@PStateTitle", patientState),
            CreateSqlParameter("@PDistrictTitle", patientDistrict),
            CreateSqlParameter("@PackageId", packageId),
            CreateSqlParameter("@ProcedureName", procedureId)  
        };

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDCaseSearch_Filter", parameters);
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvCaseSearch.DataSource = ds.Tables[0];
                gvCaseSearch.DataBind();
                paginationPanel.Visible = ds.Tables[0].Rows.Count > gvCaseSearch.PageSize;
            }
            else
            {
                gvCaseSearch.DataSource = null;
                gvCaseSearch.DataBind();
                paginationPanel.Visible = false;
            }
        }
        catch (Exception ex)
        {
            strMessage = "An error occurred while fetching data: " + ex.Message;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    protected void btnCPDSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string caseNumber = tbCaseNumber.Text;
            string cardNumber = tbCardNumber.Text;
            string patientState = ddPatientState.Text;
            string patientDistrict = ddPatientDistrict.Text;
            string packageId = ddCategory.SelectedValue;
            string procedureId = ddProcedureName.SelectedValue;
            LoadData(caseNumber, cardNumber, patientState, patientDistrict, packageId, procedureId);
        }
        catch (Exception ex)
        {
            strMessage = "An error occurred while processing your request: " + ex.Message;
        }
    }
    private SqlParameter CreateSqlParameter(string parameterName, string value)
    {
        SqlParameter param = new SqlParameter(parameterName, SqlDbType.NVarChar); 
        if (string.IsNullOrEmpty(value) || value == "0")
        {
            param.Value = DBNull.Value;
        }
        else
        {
            param.Value = value;
        }
        return param;
    }
    protected void gvCaseSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int rowIndex = e.Row.RowIndex + 1;
            Label lblSlNo = (Label)e.Row.FindControl("lbSlNo");
            if (lblSlNo != null)
            {
                lblSlNo.Text = rowIndex.ToString();
            }
        }
    }
    protected void btnCPDReset_Click1(object sender, EventArgs e)
    {
        ResetControls(this);
    }
    private void ResetControls(Control ctrl)
    {
        foreach (Control childCtrl in ctrl.Controls)
        {
            if (childCtrl is TextBox)
            {
                ((TextBox)childCtrl).Text = string.Empty;
            }
            if (childCtrl is DropDownList)
            {
                ((DropDownList)childCtrl).SelectedIndex = -1;
            }
            if (childCtrl.HasControls())
            {
                ResetControls(childCtrl);
            }
            LoadData(string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty);
        }
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
                    ddProcedureName.Items.Insert(0, new ListItem("--Select--", "0"));
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
}