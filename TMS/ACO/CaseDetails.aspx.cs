using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class ACO_CaseDetails : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private PreAuth preAuth = new PreAuth();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Get the CaseNumber from the query string
            string caseNumber = Request.QueryString["CaseNumber"];
            if (!string.IsNullOrEmpty(caseNumber))
            {
                // Call a method to fetch and display details for the given CaseNumber
                LoadPatientDetails(caseNumber);
            }
            else
            {
                // Handle the case where no CaseNumber is provided
                lblError.Text = "No Case Number provided!";
                lblError.Visible = true;
            }
        }

    }

    private void LoadPatientDetails(string caseNumber)
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand("ACOInsurer_ClaimUpdationDeatilsByCaseNumber", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CaseNumber", caseNumber);

                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lbCaseNoHead.Text = caseNumber;
                        Label11.Text = reader["Name"].ToString() ?? "N/A";
                        lbBeneficiaryId.Text = reader["BeneficiaryCardID"].ToString() ?? "N/A";
                        lbRegNo.Text = reader["RegistrationNo"].ToString() ?? "N/A";
                        Label12.Text = reader["CaseNo"].ToString() ?? "N/A";
                        Label13.Text = reader["CaseStatus"].ToString() ?? "N/A";
                        Label14.Text = reader["AdmissionId"].ToString() ?? "N/A";
                        //lbIPRegDate.Text = ConvertToDate(reader["IPRegisteredDate"]);
                        //Label15.Text = ConvertToDate(reader["ActualRegistrationDate"]);

                        // Directly return formatted date as a string
                        lbIPRegDate.Text = reader["IPRegisteredDate"] != DBNull.Value
                            ? Convert.ToDateTime(reader["IPRegisteredDate"]).ToString("dd-MM-yyyy")
                            : "N/A";
                        Label15.Text = reader["ActualRegistrationDate"] != DBNull.Value
                            ? Convert.ToDateTime(reader["ActualRegistrationDate"]).ToString("dd-MM-yyyy")
                            : "N/A";

                        lbContactNo.Text = reader["CommunicationContactNo"].ToString() ?? "N/A";
                        Label16.Text = reader["HospitalType"].ToString() ?? "N/A";
                        Label17.Text = reader["Gender"].ToString() ?? "N/A";
                        Label18.Text = reader["PatientFamilyId"].ToString() ?? "N/A";
                        Label19.Text = reader["Age"].ToString() ?? "N/A";
                        Label20.Text = reader["IsAadharVerified"].ToString() == "1" ? "Yes" : "No";
                        lbAuthentication.Text = reader["IsBiometricVerified"].ToString() == "1" ? "Yes" : "No";
                        Label21.Text = reader["PatientDistrict"].ToString() ?? "N/A";
                        lbPatientScheme.Text = reader["PatientScheme"].ToString() ?? "N/A";

                        string folderName = lbBeneficiaryId.Text;
                        string imageFileName = lbBeneficiaryId.Text + "_Profile_Image.jpg";
                        string base64String = "";

                        base64String = preAuth.DisplayImage(folderName, imageFileName);
                        if (base64String != "")
                            Image1.ImageUrl = "data:image/jpeg;base64," + base64String;
                        else
                            Image2.ImageUrl = "~/img/profile.jpg";
                    }
                    else
                    {
                        lblError.Text = "No details found for the provided Case Number.";
                        lblError.Visible = true;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            lblError.Text = "An error occurred while retrieving hospital details: " + ex.Message;
            throw;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

}
