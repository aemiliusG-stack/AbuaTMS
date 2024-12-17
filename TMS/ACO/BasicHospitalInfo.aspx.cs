using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

public partial class ACO_BasicHospitalInfo : System.Web.UI.Page
{
    //private string connectionString = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private string sortDirection;
    private string sortExpression = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadHospitals();
            LoadHospitalTypes();
            LoadDistricts();
        }
    }

    //private void LoadHospitals()
    //{
    //    try
    //    {
    //        using (SqlCommand cmd = new SqlCommand("sp_GetAllHospitalsFromExcelHospital", con))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            con.Open();
    //            DataTable dt = new DataTable();
    //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
    //            {
    //                adapter.Fill(dt);
    //            }
    //            ddlHospitals.DataSource = dt;
    //            ddlHospitals.DataTextField = "HospitalName";
    //            ddlHospitals.DataValueField = "BasicHospitalId";
    //            ddlHospitals.DataBind();
    //        }
    //    }
    //    finally
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //    ddlHospitals.Items.Insert(0, new ListItem("---select---", ""));
    //} 
    private void LoadHospitals()
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand("sp_HospitalNamelist", con))
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
                ddlHospitals.DataValueField = "HospitalId";
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
            DropDownListDistricts.DataTextField = "Title";
            DropDownListDistricts.DataValueField = "Id";
            DropDownListDistricts.DataBind();
        }
        else
        {
            DropDownListDistricts.Items.Clear();
            DropDownListDistricts.Items.Add(new ListItem("No districts available", string.Empty));
        }
    }
    //private DataTable GetDistrictData()
    //{
    //    DataTable dt = new DataTable();
    //    try
    //    {
    //        using (SqlCommand command = new SqlCommand("sp_GetAllDistrictsFromExcelHospital", con))
    //        {
    //            command.CommandType = CommandType.StoredProcedure;
    //            con.Open();
    //            using (SqlDataReader reader = command.ExecuteReader())
    //            {
    //                dt.Load(reader);
    //            }
    //        }
    //    }
    //    finally
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //    return dt;
    //}
    private DataTable GetDistrictData()
    {
        DataTable dt = new DataTable();
        try
        {
            using (SqlCommand command = new SqlCommand("sp_GetAllDistrictsFromMasterDistrict", con))
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
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        // Get the input from the search form
    //        string hospitalCodeOrId = txtHospitalCode.Text.Trim();
    //        string hospitalName = ddlHospitals.SelectedIndex == 0 ? null : ddlHospitals.SelectedValue;
    //        string hospitalType = ddlTypeS.SelectedIndex == 0 ? null : ddlTypeS.SelectedValue;
    //        string district = DropDownListDistricts.SelectedIndex == 0 ? null : DropDownListDistricts.SelectedItem.Text;

    //        // SQL connection and command to call the stored procedure
    //        using (SqlCommand cmd = new SqlCommand("sp_SearchHospitalsFromExcelHospital", con))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;

    //            // Add parameters for search
    //            cmd.Parameters.AddWithValue("@HemRefNumber", string.IsNullOrEmpty(hospitalCodeOrId) ? DBNull.Value : (object)hospitalCodeOrId);
    //            cmd.Parameters.AddWithValue("@HospitalName", string.IsNullOrEmpty(hospitalName) ? DBNull.Value : (object)hospitalName);
    //            cmd.Parameters.AddWithValue("@HospitalType", string.IsNullOrEmpty(hospitalType) ? DBNull.Value : (object)hospitalType);
    //            cmd.Parameters.AddWithValue("@District", string.IsNullOrEmpty(district) ? DBNull.Value : (object)district);

    //            con.Open();

    //            // Create a DataTable to hold the search results
    //            DataTable dt = new DataTable();
    //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
    //            {
    //                adapter.Fill(dt);
    //            }

    //            // Bind the search results to the GridView
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        // Handle and display any errors
    //        lblError.Text = "An error occurred: " + ex.Message;
    //        lblError.Visible = true;
    //    }
    //    finally
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}


    // Handle the paging event

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        PerformSearch(); // Call the search method on search button click
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex; // Set the new page index
        PerformSearch(); // Re-run the search to fetch the data for the new page
    }

    private void PerformSearch()
    {
        try
        {
            // Get the input from the search form
            string hospitalCodeOrId = txtHospitalCode.Text.Trim();
            string hospitalName = ddlHospitals.SelectedIndex == 0 ? null : ddlHospitals.SelectedValue;
            string hospitalType = ddlTypeS.SelectedIndex == 0 ? null : ddlTypeS.SelectedValue;
            string district = DropDownListDistricts.SelectedIndex == 0 ? null : DropDownListDistricts.SelectedItem.Text;

            // SQL connection and command to call the stored procedure
            using (SqlCommand cmd = new SqlCommand("sp_SearchHospitalsDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                // Add parameters for search
                cmd.Parameters.AddWithValue("@HemRefNumber", string.IsNullOrEmpty(hospitalCodeOrId) ? DBNull.Value : (object)hospitalCodeOrId);
                //cmd.Parameters.AddWithValue("@BasicHospitalId", string.IsNullOrEmpty(hospitalName) ? DBNull.Value : (object)hospitalName);
                cmd.Parameters.AddWithValue("@HospitalId", string.IsNullOrEmpty(hospitalName) ? DBNull.Value : (object)hospitalName);
                cmd.Parameters.AddWithValue("@HospitalType", string.IsNullOrEmpty(hospitalType) ? DBNull.Value : (object)hospitalType);
                //cmd.Parameters.AddWithValue("@District", string.IsNullOrEmpty(district) ? DBNull.Value : (object)district);
                cmd.Parameters.AddWithValue("@DistrictId", string.IsNullOrEmpty(district) ? DBNull.Value : (object)district);

                con.Open();

                // Create a DataTable to hold the search results
                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }

                // Bind the search results to the GridView
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
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
        GridView1.DataSource = null;
        GridView1.DataBind();
        lblError.Visible = false;
    }
}
