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
using AbuaTMS;
using CareerPath.DAL;

public partial class CPD_CPDReconciliationPatientDetail : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    CPD cpd = new CPD();
    public static PPDHelper ppdHelper = new PPDHelper();
    private string caseNo;
    private string claimNo;
    string pageName;
    private string strMessage;

    protected void Page_Load(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            //string caseNo = Session["CaseNumber"] as string;
            string cardNo = Session["CardNumber"] as string;
            string claimId = Session["ClaimId"] as string;
            string patientRedgNo = Session["PatientRegId"] as string;

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

            //if (!IsPostBack)
            //{
            //    BindGrid_ICDDetails();
            //    BindGrid_TreatmentProtocol();
            //    BindGrid_ICHIDetails();
            //    BindGrid_PreauthWorkFlow();

            //    string caseNo = Request.QueryString["CaseNo"];
            //    if (!string.IsNullOrEmpty(caseNo))
            //    {
            //        lbName.Text = "Received CaseNo: " + caseNo;
            //        BindPatientName(caseNo);
            //    }
            //    else
            //    {
            //        lbName.Text = "No CaseNo provided.";
            //        lbBeneficiaryId.Text = "";
            //        lbCaseNo.Text = "";
            //    }
            //}
        }
    }
    private void BindGrid_ICDDetails_Preauth()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("PreauthId");
        dt.Columns.Add("ICDCode");
        dt.Columns.Add("ICDDescription");
        dt.Columns.Add("ActedByRole");
        DataRow row = dt.NewRow();
        row["PreauthId"] = "NA";
        row["ICDCode"] = "NA";
        row["ICDDescription"] = "NA";
        row["ActedByRole"] = "NA";
        dt.Rows.Add(row);

        gvICDDetails_Preauth.DataSource = dt;
        gvICDDetails_Preauth.DataBind();
    }
    //private void BindGrid_ICDDetails()
    //{
    //    string query = "SELECT * FROM TMS_PrimaryDiagnosisICDVales";
    //    SqlCommand sqlCommand = new SqlCommand(query, con);
    //    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
    //    DataTable dataTable = new DataTable();

    //    try
    //    {
    //        con.Open();
    //        sqlDataAdapter.Fill(dataTable);
    //        gvICDDetails.DataSource = dataTable;
    //        gvICDDetails.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("Error: " + ex.Message);
    //    }
    //    finally
    //    {
    //        sqlDataAdapter.Dispose();
    //        sqlCommand.Dispose();
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}
    private void BindGrid_TreatmentProtocol()
    {
        string caseNo = Session["CaseNumber"] as string;
        dt = cpd.GetTreatmentProtocol(caseNo);

        gvTreatmentProtocol.DataSource = dt;
        gvTreatmentProtocol.DataBind();
        if (dt == null || dt.Rows.Count == 0)
        {
            gvTreatmentProtocol.EmptyDataText = "No Treatment Protocol found.";
            gvTreatmentProtocol.DataBind();
        }
    }
    //private void BindGrid_TreatmentProtocol()
    //{
    //    string query = "SELECT * FROM TMS_TreatmentProtocol";
    //    SqlCommand sqlCommand = new SqlCommand(query, con);
    //    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
    //    DataTable dataTable = new DataTable();

    //    try
    //    {
    //        con.Open();
    //        sqlDataAdapter.Fill(dataTable);
    //        gvTreatmentProtocol.DataSource = dataTable;
    //        gvTreatmentProtocol.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("Error: " + ex.Message);
    //    }
    //    finally
    //    {
    //        sqlDataAdapter.Dispose();
    //        sqlCommand.Dispose();
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}
    private void BindGrid_ICHIDetails()
    {
        //string query = "SELECT * FROM TMS_ICHIDetails";
        //SqlCommand sqlCommand = new SqlCommand(query, con);
        //SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
        //DataTable dataTable = new DataTable();
        //try
        //{
        //    con.Open();
        //    sqlDataAdapter.Fill(dataTable);
        //    gvICHIDetails.DataSource = dataTable;
        //    gvICHIDetails.DataBind();
        //}
        //catch (Exception ex)
        //{
        //    Response.Write("Error: " + ex.Message);
        //}
        //finally
        //{
        //    sqlDataAdapter.Dispose();
        //    sqlCommand.Dispose();
        //    if (con != null && con.State == ConnectionState.Open)
        //    {
        //        con.Close();
        //    }
        //}
        DataTable dt = new DataTable();
        dt.Columns.Add("lbProcedureName");
        dt.Columns.Add("lbICHIMedco");
        dt.Columns.Add("lbICHIPPD");
        dt.Columns.Add("lbICHIPPDInsurer");
        dt.Columns.Add("lbICHICPD");
        dt.Columns.Add("lbICHICPDInsurer");
        dt.Columns.Add("lbICHISAFO");
        dt.Columns.Add("lbICHINAFO");

        DataRow row = dt.NewRow();
        row["lbProcedureName"] = "NA";
        row["lbICHIMedco"] = "NA";
        row["lbICHIPPD"] = "NA";
        row["lbICHIPPDInsurer"] = "NA";
        row["lbICHICPD"] = "NA";
        row["lbICHICPDInsurer"] = "NA";
        row["lbICHISAFO"] = "NA";
        row["lbICHINAFO"] = "NA";

        dt.Rows.Add(row);

        gvICHIDetails.DataSource = dt;
        gvICHIDetails.DataBind();
    }

    //private void BindGrid_ICHIDetails()
    //{
    //    string query = "SELECT * FROM TMS_ICHIDetails";
    //    SqlCommand sqlCommand = new SqlCommand(query, con);
    //    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
    //    DataTable dataTable = new DataTable();

    //    try
    //    {
    //        con.Open();
    //        sqlDataAdapter.Fill(dataTable);
    //        gvICHIDetails.DataSource = dataTable;
    //        gvICHIDetails.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("Error: " + ex.Message);
    //    }
    //    finally
    //    {
    //        sqlDataAdapter.Dispose();
    //        sqlCommand.Dispose();
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}

    //private void BindGrid_PreauthWorkFlow()
    //{
    //    string query = "SELECT * FROM TMS_PreauthWorkFlow";
    //    SqlCommand sqlCommand = new SqlCommand(query, con);
    //    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
    //    DataTable dataTable = new DataTable();

    //    try
    //    {
    //        con.Open();
    //        sqlDataAdapter.Fill(dataTable);
    //        gvPreauthWorkFlow.DataSource = dataTable;
    //        gvPreauthWorkFlow.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("Error: " + ex.Message);
    //    }
    //    finally
    //    {
    //        sqlDataAdapter.Dispose();
    //        sqlCommand.Dispose();
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}

    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPast);
        btnAttachments.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-warning ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnQuestionnaier.CssClass = "btn btn-primary";
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPreauth);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-warning";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnQuestionnaier.CssClass = "btn btn-primary";
    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
        btnQuestionnaier.CssClass = "btn btn-primary";

    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-warning";
        btnQuestionnaier.CssClass = "btn btn-primary";
    }

    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaier.CssClass = "btn btn-primary";
    }
    protected void btnCasSheet_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnCaseSheet.CssClass = "btn btn-warning ";
        btnQuestionnaier.CssClass = "btn btn-primary";
    }
    protected void btnQuestionnaier_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaier.CssClass = "btn btn-warning";
    }
    private void BindPatientName(string caseNo)
    {
        //string query = "TMS_CPDPatientDetails";
        //SqlCommand cmd = new SqlCommand(query, con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@CaseNo", caseNo);

        //try
        //{
        //    con.Open();
        //    SqlDataReader reader = cmd.ExecuteReader();
        //    if (reader.HasRows)
        //    {
        //        if (reader.Read())
        //        {
        //            lbName.Text = reader["PatientName"].ToString();
        //            lbBeneficiaryId.Text = reader["CardNumber"].ToString();
        //            lbCaseNo.Text = reader["CaseNo"].ToString();
        //            lbCaseStatus.Text = reader["CaseStatus"].ToString();
        //            lbContactNo.Text = reader["MobileNumber"].ToString();

        //            string gender = reader["Gender"].ToString().Trim().ToUpper();
        //            lbGender.Text = gender == "M" ? "Male" : gender == "F" ? "Female" : "Other";

        //            lbFamilyId.Text = reader["PatientFamilyId"].ToString();
        //            lbPatientDistrict.Text = reader["Title"].ToString();
        //            lbAadharVerified.Text = reader["IsAadharVerified"].ToString();
        //            lbAge.Text = reader["Age"].ToString();

        //            if (!reader.IsDBNull(reader.GetOrdinal("RegDate")))
        //            {
        //                lbActualRegDate.Text = Convert.ToDateTime(reader["RegDate"]).ToString("dd/MM/yyyy hh:mm tt");
        //            }
        //            else
        //            {
        //                lbActualRegDate.Text = "N/A";
        //            }
        //            BindGrid_ICDDetails_Preauth();
        //            BindGrid_TreatmentProtocol();
        //            BindGrid_ICHIDetails();
        //            //BindGrid_PreauthWorkFlow();

        //        }
        //    }
        //    else
        //    {
        //        lbName.Text = "No data found for the given CaseNo.";
        //        ClearLabels();
        //    }
        //}
        //catch (Exception ex)
        //{
        //    lbName.Text = "Error: " + ex.Message;
        //    ClearLabels();
        //}
        //finally
        //{
        //    con.Close();
        //}

        try
        {
            if (string.IsNullOrEmpty(caseNo))
            {
                lbName.Text = "Case number is missing.";
                ClearLabels();
                return;
            }
            SqlParameter[] parameters = new SqlParameter[]
            {
            new SqlParameter("@CaseNo", caseNo)
            };
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDPatientDetails", parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                mvCPDTabs.SetActiveView(ViewClaims);
                btnAttachments.CssClass = "btn btn-primary ";
                btnQuestionnaier.CssClass = "btn btn-primary ";
                btnPreauth.CssClass = "btn btn-primary ";
                btnPastHistory.CssClass = "btn btn-primary ";
                btnTreatment.CssClass = "btn btn-primary ";
                btnClaims.CssClass = "btn btn-warning";
                btnCaseSheet.CssClass = "btn btn-primary ";
                dt = ds.Tables[0];
                lbCaseNoHead.Text = dt.Rows[0]["CaseNumber"].ToString();
                lbName.Text = dt.Rows[0]["PatientName"].ToString();
                lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString();
                hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString();
                string cardNo = dt.Rows[0]["CardNumber"].ToString();
                Session["CardNumber"] = cardNo;
                lbRegNo.Text = dt.Rows[0]["PatientRegId"].ToString();
                string patientRedgNo = dt.Rows[0]["PatientRegId"].ToString();
                Session["PatientRegId"] = patientRedgNo;
                caseNo = dt.Rows[0]["CaseNumber"].ToString();
                lbCaseNo.Text = caseNo;
                Session["CaseNumber"] = caseNo;
                lbCaseStatus.Text = dt.Rows[0]["CaseStatus"].ToString();
                lbContactNo.Text = dt.Rows[0]["MobileNumber"].ToString();
                string gender = dt.Rows[0]["Gender"].ToString().Trim().ToUpper();
                lbGender.Text = gender == "M" ? "Male" : gender == "F" ? "Female" : "Other";
                lbFamilyId.Text = dt.Rows[0]["PatientFamilyId"].ToString();
                lbPatientDistrict.Text = dt.Rows[0]["District"].ToString();
                int isAadharVerified = Convert.ToInt32(dt.Rows[0]["IsAadharVerified"]);
                lbAadharVerified.Text = isAadharVerified == 1 ? "Yes" : "No";
                lbAge.Text = dt.Rows[0]["Age"].ToString();
                lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString();
                if (!string.IsNullOrEmpty(dt.Rows[0]["RegDate"].ToString()))
                {
                    lbActualRegDate.Text = Convert.ToDateTime(dt.Rows[0]["RegDate"]).ToString("dd/MM/yyyy hh:mm tt");
                }
                else
                {
                    lbActualRegDate.Text = "N/A";
                }
                multiViewRecords.ActiveViewIndex = 0;
                string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                string folderName = hdAbuaId.Value;
                string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                string base64String = "";

                base64String = cpd.DisplayImage(folderName, imageFileName);
                if (base64String != "")
                {
                    imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                    imgPatientPhotosecond.ImageUrl = "data:image/jpeg;base64," + base64String;
                }

                else
                {
                    imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";
                    imgPatientPhotosecond.ImageUrl = "~/img/profile.jpeg";
                }
                BindGrid_ICDDetails_Preauth();
                BindGrid_TreatmentProtocol();
                BindGrid_ICHIDetails();
                getTreatmentDischarge();
            }
            else
            {
                lbName.Text = "No data found.";
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
            if (con.State == ConnectionState.Open)
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

    //Treatment and Discharge
    private void getTreatmentDischarge()
    {
        string claimId = Session["ClaimId"] as string;
        dt.Clear();
        dt = cpd.GetTreatmentDischarge(claimId);
        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            lbDoctorType.Text = row["TypeOfMedicalExpertise"].ToString();
            lbDoctorName.Text = row["DoctorName"].ToString();
            lbDocRegnNo.Text = row["DoctorRegistrationNumber"].ToString();
            lbDocQualification.Text = row["Qualification"].ToString();
            lbDocContactNo.Text = row["DoctorContactNumber"].ToString();
            lbAnaesthetistName.Text = row["AnaesthetistName"].ToString();
            lbAnaesthetistRegNo.Text = row["AnaesthetistRegNo"].ToString();
            lbAnaesthetistContactNo.Text = row["AnaesthetistMobNo"].ToString();
            //lbAnaesthetistType.Text = row["DoctorContactNumber"].ToString();
            lbIncisionType.Text = row["IncisionType"].ToString();
            rbOPPhotoYes.Checked = row["OPPhotosWebexTaken"] != DBNull.Value && Convert.ToBoolean(row["OPPhotosWebexTaken"]);
            rbOPPhotoNo.Checked = row["OPPhotosWebexTaken"] != DBNull.Value && !Convert.ToBoolean(row["OPPhotosWebexTaken"]);
            rbVedioRecDoneYes.Checked = row["VideoRecordingDone"] != DBNull.Value && Convert.ToBoolean(row["VideoRecordingDone"]);
            rbVedioRecDoneNo.Checked = row["VideoRecordingDone"] != DBNull.Value && !Convert.ToBoolean(row["VideoRecordingDone"]);
            lbSwabCounts.Text = row["SwabCountInstrumentsCount"].ToString();
            lbSurutes.Text = row["SuturesLigatures"].ToString();
            rbSpecimenRemoveYes.Checked = row["SpecimenRequired"] != DBNull.Value && Convert.ToBoolean(row["SpecimenRequired"]);
            rbSpecimenRemoveNo.Checked = row["SpecimenRequired"] != DBNull.Value && !Convert.ToBoolean(row["SpecimenRequired"]);
            lbDranageCount.Text = row["DrainageCount"].ToString();
            lbBloodLoss.Text = row["BloodLoss"].ToString();
            lbOperativeInstructions.Text = row["PostOperativeInstructions"].ToString();
            lbPatientCondition.Text = row["PatientCondition"].ToString();
            rbComplicationsYes.Checked = row["ComplicationsIfAny"] != DBNull.Value && Convert.ToBoolean(row["ComplicationsIfAny"]);
            rbComplicationsNo.Checked = row["ComplicationsIfAny"] != DBNull.Value && !Convert.ToBoolean(row["ComplicationsIfAny"]);
            lbTraetmentDate.Text = Convert.ToDateTime(row["TreatmentSurgeryStartDate"]).ToString("dd/MM/yyyy");
            tbSurgeryStartTime.Text = TimeSpan.Parse(row["SurgeryStartTime"].ToString()).ToString(@"hh\:mm");
            tbSurgeryEndTime.Text = TimeSpan.Parse(row["SurgeryEndTime"].ToString()).ToString(@"hh\:mm");
            tbTreatmentGiven.Text = row["TreatmentGiven"].ToString();
            tbOperativeFindings.Text = row["OperativeFindings"].ToString();
            tbPostOperativePeriod.Text = row["PostOperativePeriod"].ToString();
            tbSpecialInvestigationGiven.Text = row["PostSurgeryInvestigationGiven"].ToString();
            tbStatusAtDischarge.Text = row["StatusAtDischarge"].ToString();
            tbReview.Text = row["Review"].ToString();
            tbAdvice.Text = row["Advice"].ToString();
            rbDischarge.Checked = row["IsDischarged"] != DBNull.Value && Convert.ToBoolean(row["IsDischarged"]);
            rbDeath.Checked = row["IsDischarged"] != DBNull.Value && !Convert.ToBoolean(row["IsDischarged"]);
            lbDischargeDate.Text = Convert.ToDateTime(row["DischargeDate"]).ToString("dd-MM-yyyy");
            lbNextFollowUp.Text = Convert.ToDateTime(row["NextFollowUpDate"]).ToString("dd-MM-yyyy");
            lbConsultBlockName.Text = row["ConsultAtBlock"].ToString();
            lbFloor.Text = row["FloorNo"].ToString();
            lbRoomNo.Text = row["RoomNo"].ToString();
            rbIsSpecialCaseYes.Checked = row["IsSpecialCase"] != DBNull.Value && Convert.ToBoolean(row["IsSpecialCase"]);
            rbIsSpecialCaseNo.Checked = row["IsSpecialCase"] != DBNull.Value && !Convert.ToBoolean(row["IsSpecialCase"]);
            lbFinalDiagnosis.Text = row["FinalDiagnosis"].ToString();
            rbConsentYes.Checked = row["ProcedureConsent"] != DBNull.Value && Convert.ToBoolean(row["ProcedureConsent"]);
            rbConsentNo.Checked = row["ProcedureConsent"] != DBNull.Value && !Convert.ToBoolean(row["ProcedureConsent"]);
        }
        else
        {
            lbDoctorType.Text = "";
            lbDoctorName.Text = "";
            lbDocRegnNo.Text = "";
            lbDocQualification.Text = "";
            lbDocContactNo.Text = "";
            lbAnaesthetistName.Text = "";
            lbAnaesthetistRegNo.Text = "";
            lbAnaesthetistContactNo.Text = "";
            //lbAnaesthetistType.Text = "";
            lbSwabCounts.Text = "";
            lbSurutes.Text = "";
            lbDranageCount.Text = "";
            lbBloodLoss.Text = "";
            lbOperativeInstructions.Text = "";
            lbPatientCondition.Text = "";
            lbTraetmentDate.Text = "";
            tbSurgeryStartTime.Text = "";
            tbSurgeryEndTime.Text = "";
            tbTreatmentGiven.Text = "";
            tbOperativeFindings.Text = "";
            tbPostOperativePeriod.Text = "";
            tbSpecialInvestigationGiven.Text = "";
            tbStatusAtDischarge.Text = "";
            tbReview.Text = "";
            tbAdvice.Text = "";
            lbDischargeDate.Text = "";
            lbNextFollowUp.Text = "";
            lbConsultBlockName.Text = "";
            lbFloor.Text = "";
            lbRoomNo.Text = "";
            lbFinalDiagnosis.Text = "";

        }
    }
    protected void btnUpdateDischarge_Click(object sender, EventArgs e)
    {
        if (!tbDischargeTypeRemarks.Visible)
        {
            tbDischargeTypeRemarks.Visible = true;
            lbDischargeTypeRemarks.Visible = true;
            rbDischarge.Enabled = true;
            rbDeath.Enabled = true;
            mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter Discharge/Death type update remarks.');", true);
        }
        else
        {
            string remarks = tbDischargeTypeRemarks.Text.Trim();
            bool isDischarge = rbDischarge.Checked;
            bool isDeath = rbDeath.Checked;
            if (string.IsNullOrEmpty(remarks))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Remarks are required.');", true);
                return;
            }
            if (!isDischarge && !isDeath)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select either Discharge or Death.');", true);
                return;
            }
            int dischargeStatus = isDischarge ? 1 : 0;
            string claimId = Session["ClaimId"] as string;

            try
            {
                bool isUpdated = cpd.UpdateDischarge(claimId, dischargeStatus, remarks);
                if (isUpdated)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Discharge/Death type updated successfully.');", true);
                    tbDischargeTypeRemarks.Text = string.Empty;
                    tbDischargeTypeRemarks.Visible = false;
                    lbDischargeTypeRemarks.Visible = false;
                    rbDischarge.Enabled = false;
                    rbDeath.Enabled = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Update failed. Please try again.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: {ex.Message}');", true);
            }
        }
    }
}
