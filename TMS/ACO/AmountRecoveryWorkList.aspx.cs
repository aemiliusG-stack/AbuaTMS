using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class ACO_AmountRecoveryWorkList : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadHospitals();
            LoadHospitalTypes();
            LoadDistricts();
        }
    }
    private void LoadHospitals()
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand("sp_GetAllHospitalsFromExcelHospital", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
                ddlHospitals.DataSource = dt;
                ddlHospitals.DataTextField = "HospitalName";
                ddlHospitals.DataValueField = "HospitalName";
                ddlHospitals.DataBind();
            }
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        ddlHospitals.Items.Insert(0, new ListItem("---select---", ""));
    }
    private void LoadHospitalTypes()
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand("sp_GetAllHospitalTypesFromExcelHospital", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
                ddlTypeS.DataSource = dt;
                ddlTypeS.DataTextField = "HospitalType";
                ddlTypeS.DataValueField = "HospitalType";
                ddlTypeS.DataBind();
            }
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        ddlTypeS.Items.Insert(0, new ListItem("---select---", ""));
    }
    private void LoadDistricts()
    {
        DataTable dt = GetDistrictData();
        if (dt != null && dt.Rows.Count > 0)
        {
            DropDownListDistricts.DataSource = dt;
            DropDownListDistricts.DataTextField = "District";
            DropDownListDistricts.DataValueField = "District";
            DropDownListDistricts.DataBind();
        }
        else
        {
            DropDownListDistricts.Items.Clear();
            DropDownListDistricts.Items.Add(new ListItem("No districts available", string.Empty));
        }
    }
    private DataTable GetDistrictData()
    {
        DataTable dt = new DataTable();
        try
        {
            using (SqlCommand command = new SqlCommand("sp_GetAllDistrictsFromExcelHospital", con))
            {
                command.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    dt.Load(reader);
                }
            }
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return dt;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            
        }
        catch (Exception ex)
        {
            // Handle and display any errors
            lblError.Text = "An error occurred: " + ex.Message;
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
        txtHospitalCode.Text = string.Empty;
        ddlHospitals.SelectedIndex = 0;
        ddlTypeS.SelectedIndex = 0;
        DropDownListDistricts.SelectedIndex = 0;
        //GridView1.DataSource = null;
        //GridView1.DataBind();
        lblError.Visible = false;
    }
}