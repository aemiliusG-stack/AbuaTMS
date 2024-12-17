using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class ACO_HospitalDetails : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string hospitalId = Request.QueryString["HospitalId"];
            // Check if the HospitalId is not null or empty
            if (!string.IsNullOrEmpty(hospitalId))
            {
                // Load hospital details using the hospitalId as a string
                LoadHospitalDetails(hospitalId);
            }
            else
            {
                // Handle the case where HospitalId is invalid or missing
                lblErrorMessage.Text = "Invalid or missing Hospital ID.";
                lblErrorMessage.Visible = true;
            }
        }
    }
    private void LoadHospitalDetails(string hospitalId)
    {
        try
        {
            // Open a SQL connection

            using (SqlCommand cmd = new SqlCommand("sp_HospitalDetailsByHospitalCode", con))
            //using (SqlCommand cmd = new SqlCommand("sp_GetHospitalDetailsByHospitalCode", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@HospitalId", hospitalId);
                // Open the database connection
                con.Open();
                // Execute the command and get a data reader
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // Check if the reader has rows (i.e., hospital details exist)
                    if (reader.HasRows)
                    {
                        // Read through the results
                        while (reader.Read())
                        {
                            // Assign the values from the reader to the label controls
                            lblHospitalCode.Text = reader["HospitalId"].ToString();
                            lblHospitalName.Text = reader["HospitalName"].ToString();
                            lblHospitalType.Text = reader["HospitalType"].ToString();
                            lblDistrict.Text = reader["District"].ToString();
                            lblScheme.Text = reader["Scheme"].ToString();

                            // Add City, State, and Total Bed Strength
                            lblCity.Text = reader["City"].ToString();            // City
                            lblState.Text = reader["State"].ToString();          // State
                            lblTotalBedStrength.Text = reader["TotalBedStrengths"].ToString(); // Total Bed Strength

                            lblContactNumber.Text = reader["HospitalContact"].ToString(); // Contact Number
                            lblEmail.Text = reader["HospitalEmailId"].ToString();   // Email
                        }
                    }
                    else
                    {
                        // Handle the case where no hospital details were found
                        lblErrorMessage.Text = "No hospital details found for the provided Hospital ID.";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Handle any exceptions that occur during the database operation
            lblErrorMessage.Text = "An error occurred while retrieving hospital details: " + ex.Message;
        }
        finally
        {
            // Ensure the connection is closed
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        // Create a new FileUpload control
        FileUpload fileUpload = new FileUpload();
        //fileUpload.ID = "fileUpload" + (fileUpload1.Controls.Count + 1);
        fileUpload.ID = "fileUpload" + (fileUploadContainer.Controls.Count + 1);
        fileUpload.CssClass = "form-control";

        // Add the new FileUpload to the container
        //fileUpload1.Controls.Add(fileUpload);
        fileUploadContainer.Controls.Add(fileUpload);
    }

    protected void btnMinus_Click(object sender, EventArgs e)
    {
        //if (fileUpload1.Controls.Count > 0)
        if (fileUploadContainer.Controls.Count > 0)
        {
            // Remove the last FileUpload control
            //fileUpload1.Controls.RemoveAt(fileUpload1.Controls.Count - 1);
            fileUploadContainer.Controls.RemoveAt(fileUploadContainer.Controls.Count - 1);
        }
    }

}