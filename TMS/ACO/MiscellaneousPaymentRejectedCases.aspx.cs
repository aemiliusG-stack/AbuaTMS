using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ACO_MiscellaneousPaymentRejectedCases : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadHospitals();
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
        //txtHospitalCode.Text = string.Empty;
        //ddlHospitals.SelectedIndex = 0;
        //ddlTypeS.SelectedIndex = 0;
        //DropDownListDistricts.SelectedIndex = 0;
        //GridView1.DataSource = null;
        //GridView1.DataBind();
        //lblError.Visible = false;
    }
}