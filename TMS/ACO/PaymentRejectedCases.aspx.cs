using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class ACO_PaymentRejectedCases : System.Web.UI.Page
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
        }
    }
    private void LoadHospitals()
    {
        try
        {
            //using (SqlCommand cmd = new SqlCommand("sp_GetAllHospitalsFromExcelHospital", con))
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblError.Visible = false; // Hide error label at the beginning of the method

        try
        {
            var hospitalId = string.IsNullOrEmpty(ddlHospitals.SelectedValue) ? DBNull.Value : (object)ddlHospitals.SelectedValue;
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_GetHospitalPaymentRejectedCases", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BasicHospitalId", ddlHospitals.SelectedValue == "" ? DBNull.Value : (object)ddlHospitals.SelectedValue);
                cmd.Parameters.AddWithValue("@RejectedFromDate", string.IsNullOrEmpty(tbRegisteredFromDate.Text) ? (object)DBNull.Value : DateTime.Parse(tbRegisteredFromDate.Text));
                cmd.Parameters.AddWithValue("@RejectedToDate", string.IsNullOrEmpty(TextBox1.Text) ? (object)DBNull.Value : DateTime.Parse(TextBox1.Text));
                cmd.Parameters.AddWithValue("@Scheme", ddlScheme.SelectedValue);

                con.Open();
                DataTable dt = new DataTable();

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
                // Debug: Output column names to verify presence of "CaseNumber" and other expected columns
                System.Diagnostics.Debug.WriteLine("Columns in DataTable:");
                foreach (DataColumn column in dt.Columns)
                {
                    System.Diagnostics.Debug.WriteLine(column.ColumnName);
                }
                // Check if any rows are returned
                if (dt.Rows.Count == 0)
                {
                    lblError.Text = "No records found.";
                    lblError.Visible = true;
                    rptClaimCases.DataSource = null;
                    rptClaimCases.DataBind();
                }
                else
                {
                    // Clear any previous data bindings and bind the new data
                    rptClaimCases.DataSource = dt;
                    rptClaimCases.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            // Display error message in case of an exception
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
        ddlHospitals.SelectedIndex = 0;
        tbRegisteredFromDate.Text = "";
        TextBox1.Text = "";
        ddlScheme.SelectedIndex = 0;
        lblError.Visible = false;
        rptClaimCases.DataSource = null;
        rptClaimCases.DataBind();
    }
}