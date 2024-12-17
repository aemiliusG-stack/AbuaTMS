using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CPD_CPDReconciliationPatientDetail : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        if (IsPostBack)
        {
            string eventTarget = Request["__EVENTTARGET"];
            string eventArgument = Request["__EVENTARGUMENT"];

            if (!string.IsNullOrEmpty(eventTarget) && eventTarget.Contains("mvCPDTabs"))
            {
                mvCPDTabs.ActiveViewIndex = Convert.ToInt32(eventArgument);
            }
        }

        if (!IsPostBack)
        {
            BindGrid_ICDDetails();
            BindGrid_TreatmentProtocol();
            BindGrid_ICHIDetails();
            BindGrid_PreauthWorkFlow();

            string caseNo = Request.QueryString["CaseNo"];
            if (!string.IsNullOrEmpty(caseNo))
            {
                lbName.Text = "Received CaseNo: " + caseNo;
                BindPatientName(caseNo);
            }
            else
            {
                lbName.Text = "No CaseNo provided.";
                lbBeneficiaryId.Text = "";
                lbCaseNo.Text = "";
            }
        }
    }

    private void BindGrid_ICDDetails()
    {
        string query = "SELECT * FROM TMS_PrimaryDiagnosisICDVales";
        SqlCommand sqlCommand = new SqlCommand(query, con);
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
        DataTable dataTable = new DataTable();

        try
        {
            con.Open();
            sqlDataAdapter.Fill(dataTable);
            gvICDDetails.DataSource = dataTable;
            gvICDDetails.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            sqlDataAdapter.Dispose();
            sqlCommand.Dispose();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    private void BindGrid_TreatmentProtocol()
    {
        string query = "SELECT * FROM TMS_TreatmentProtocol";
        SqlCommand sqlCommand = new SqlCommand(query, con);
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
        DataTable dataTable = new DataTable();

        try
        {
            con.Open();
            sqlDataAdapter.Fill(dataTable);
            gvTreatmentProtocol.DataSource = dataTable;
            gvTreatmentProtocol.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            sqlDataAdapter.Dispose();
            sqlCommand.Dispose();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    private void BindGrid_ICHIDetails()
    {
        string query = "SELECT * FROM TMS_ICHIDetails";
        SqlCommand sqlCommand = new SqlCommand(query, con);
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
        DataTable dataTable = new DataTable();

        try
        {
            con.Open();
            sqlDataAdapter.Fill(dataTable);
            gvICHIDetails.DataSource = dataTable;
            gvICHIDetails.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            sqlDataAdapter.Dispose();
            sqlCommand.Dispose();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    private void BindGrid_PreauthWorkFlow()
    {
        string query = "SELECT * FROM TMS_PreauthWorkFlow";
        SqlCommand sqlCommand = new SqlCommand(query, con);
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
        DataTable dataTable = new DataTable();

        try
        {
            con.Open();
            sqlDataAdapter.Fill(dataTable);
            gvPreauthWorkFlow.DataSource = dataTable;
            gvPreauthWorkFlow.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            sqlDataAdapter.Dispose();
            sqlCommand.Dispose();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPast);
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPreauth);
    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        // mvCPDTabs.SetActiveView(ViewClaims);
    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
    }

    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
    }

    private void BindPatientName(string caseNo)
    {
        string query = "TMS_CPDPatientDetails";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CaseNo", caseNo);

        try
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                if (reader.Read())
                {
                    lbName.Text = reader["PatientName"].ToString();
                    lbBeneficiaryId.Text = reader["CardNumber"].ToString();
                    lbCaseNo.Text = reader["CaseNo"].ToString();
                    lbCaseStatus.Text = reader["CaseStatus"].ToString();
                    lbContactNo.Text = reader["MobileNumber"].ToString();

                    string gender = reader["Gender"].ToString().Trim().ToUpper();
                    lbGender.Text = gender == "M" ? "Male" : gender == "F" ? "Female" : "Other";

                    lbFamilyId.Text = reader["PatientFamilyId"].ToString();
                    lbPatientDistrict.Text = reader["Title"].ToString();
                    lbAadharVerified.Text = reader["IsAadharVerified"].ToString();
                    lbAge.Text = reader["Age"].ToString();

                    if (!reader.IsDBNull(reader.GetOrdinal("RegDate")))
                    {
                        lbActualRegDate.Text = Convert.ToDateTime(reader["RegDate"]).ToString("dd/MM/yyyy hh:mm tt");
                    }
                    else
                    {
                        lbActualRegDate.Text = "N/A";
                    }
                }
            }
            else
            {
                lbName.Text = "No data found for the given CaseNo.";
                ClearLabels();
            }
        }
        catch (Exception ex)
        {
            lbName.Text = "Error: " + ex.Message;
            ClearLabels();
        }
        finally
        {
            con.Close();
        }
    }

    private void ClearLabels()
    {
        lbBeneficiaryId.Text = "";
        lbCaseNo.Text = "";
        lbCaseStatus.Text = "";
        lbContactNo.Text = "";
        lbGender.Text = "";
        lbFamilyId.Text = "";
        lbPatientDistrict.Text = "";
        lbAadharVerified.Text = "";
        lbActualRegDate.Text = "";
        lbAge.Text = "";
    }
}
