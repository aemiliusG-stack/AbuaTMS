using CareerPath.DAL;
using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.UI;
using System.Configuration;
using System.Web;
using System.Web.UI.WebControls;
using System.Collections.Generic;


public partial class CEX_CEXClaimUpdation : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private PreAuth preAuth = new PreAuth();
    private MasterData md = new MasterData();
    private static CEX cex = new CEX();
    string pageName;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                hdRoleId.Value = Session["RoleId"].ToString();
                BindGridICHIDetail();
                getpatient();
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
    public void getpatient()
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEX_GetPatientForClaimUpdation", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                MultiView1.SetActiveView(ViewClaimupdationpage);
                mvCEXTabs.SetActiveView(ViewClaim);

                btnPastHistory.CssClass = "btn btn-primary";
                btnPreauth.CssClass = "btn btn-primary";
                btnTreatment.CssClass = "btn btn-primary";
                btnClaims.CssClass = "btn btn-warning";
                btnAttachments.CssClass = "btn btn-primary";
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null)
                {
                    DateTime registrationDate = Convert.ToDateTime(dt.Rows[0]["RegDate"].ToString().Trim());
                    DateTime admissionDate = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"].ToString().Trim());
                    DateTime ClaimSubmittedDate = Convert.ToDateTime(dt.Rows[0]["ClaimSubmissionDate"].ToString().Trim());
                    DateTime ClaimUpdatedDate = Convert.ToDateTime(dt.Rows[0]["ClaimUpdationDate"].ToString().Trim());
                    DateTime surgeryDate = Convert.ToDateTime(dt.Rows[0]["ProposedSurgeryDate"].ToString().Trim());
                    DateTime DischargeDate = Convert.ToDateTime(dt.Rows[0]["DischargeDate"].ToString().Trim());
                    string minDateadmission = admissionDate.ToString("yyyy-MM-dd");
                    string minDateSurgerydate = surgeryDate.ToString("yyyy-MM-dd");
                    string minDateDischargedate = DischargeDate.ToString("yyyy-MM-dd");
                    string maxDate = DateTime.Now.ToString("yyyy-MM-dd");
                    tbCSDischargeDate.Attributes["min"] = minDateDischargedate;
                    tbCSDischargeDate.Attributes["max"] = maxDate;
                    tbCSTherepyDate.Attributes["min"] = minDateSurgerydate;
                    tbCSTherepyDate.Attributes["max"] = maxDate;
                    tbCSAdmissionDate.Attributes["min"] = minDateadmission;
                    tbCSAdmissionDate.Attributes["max"] = maxDate;
                    hdClaimId.Value = dt.Rows[0]["ClaimId"].ToString().Trim();
                    Session["ClaimId"] = hdClaimId.Value;
                    hdHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
                    hdClaimMode.Value = dt.Rows[0]["ClaimMode"].ToString();
                    if (hdClaimMode.Value == "3")
                    {
                        bool result = cex.UpdateIfHybride(hdClaimId.Value, hdUserId.Value);
                        if (!result)
                        {
                            string errorMessage = "window.alert('.');";
                            ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                            return;
                        }
                    }
                    hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString().Trim();
                    hdAdmissionId.Value = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                    lbBenCardId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                    lbRegistrationNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbCaseNumber.Text = "Case No: " + dt.Rows[0]["CaseNumber"].ToString().Trim();
                    hdCaseNo.Value = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";
                    base64String = cex.DisplayImage(folderName, imageFileName);
                    if (base64String != "")
                    {
                        imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                    else
                    {
                        imgPatientPhoto.ImageUrl = "~/img/profile.jpg";
                    }
                    lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbRegDate.Text = registrationDate.ToString("dd-MM-yyyy");
                    lbComContactNo.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalParentType"].ToString().Trim();
                    lbGender.Text = dt.Rows[0]["Gender"].ToString().Trim() == "" ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                    lbFamilyID.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                    lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbPatientDistrict.Text = dt.Rows[0]["District"].ToString().Trim();
                    lbAge.Text = dt.Rows[0]["Age"].ToString().Trim();
                    tbRemark.Text = dt.Rows[0]["Remarks"].ToString().Trim();
                    lbHosName.Text = dt.Rows[0]["HospitalName"].ToString().Trim();
                    lbHosType.Text = dt.Rows[0]["HospitalParentType"].ToString().Trim();
                    lbHosAddress.Text = dt.Rows[0]["HospitalAddress"].ToString().Trim();
                    lbAdmissionDate.Text = admissionDate.ToString("dd-MM-yyyy");
                    lbPreauthApprAmount.Text = dt.Rows[0]["TotalPackageCost"].ToString().Trim();
                    lbPreauthDate.Text = admissionDate.ToString("dd-MM-yyyy");
                    lbClaimSubmittedDate.Text = ClaimSubmittedDate.ToString("dd-MM-yyyy");
                    lbLastClaimUpdatedDate.Text = ClaimUpdatedDate.ToString("dd-MM-yyyy");
                    lbClaimAmount.Text = dt.Rows[0]["TotalPackageCost"].ToString().Trim();
                    lbBillAmount.Text = dt.Rows[0]["TotalPackageCost"].ToString().Trim();
                    lbNonTechAdmissionDate.Text = admissionDate.ToString("dd-MM-yyyy");
                    lbNonTechSurgeryDate.Text = surgeryDate.ToString("dd-MM-yyyy");
                    lbPackageCostshow.Text = dt.Rows[0]["PackageCost"].ToString().Trim();
                    lbIncentiveAmountShow.Text = dt.Rows[0]["IncentiveAmount"].ToString().Trim();
                    lbHospitalIncentive.Text = dt.Rows[0]["IncentivePercentage"].ToString().Trim() + "%";
                    lbTotalPackageCostShow.Text = dt.Rows[0]["TotalPackageCost"].ToString().Trim();
                    lbNonTechDeathDate.Text = DischargeDate.ToString("dd-MM-yyyy");
                    bool IfSecondaryDiagnosisPresent = cex.IfSecondaryDiagnosisPresent(hdAbuaId.Value, hdPatientRegId.Value);
                    if (IfSecondaryDiagnosisPresent)
                    {
                        PanelSecondaryDiagnosis.Visible = true;
                        pnlSecondaryDiagnosisICDValue.Visible = true;
                        BindGrid_SecondaryDiagnosis();
                        BindGrid_ClaimSecondaryDiagnosis();
                    }
                    bool IsOncologyCase = cex.IsOncologyCase(hdCaseNo.Value);
                    if (IsOncologyCase)
                    {
                        btnOncology.Visible = true;
                        btnOncology.CssClass = "btn btn-primary";
                    }
                    displayPatientAdmissionImage();
                    BindGrid_TreatmentProtocol();
                    BindGrid_TreatmentSurgeryDate();
                    BindGrid_PrimaryDiagnosis();
                    BindGrid_ClaimPrimaryDiagnosis();
                    BindGrid_PreauthWorkFlow();
                    BindClaimWorkflow();
                    getTreatmentDischarge();


                    if (hdRoleId.Value == "5")
                    {
                        pnlInsuranceamount.Visible = true;
                        pnlTrustAmount.Visible = false;
                        PanelTotLiableInsurance.Visible = true;
                        PanelTotLiableInsuranceIs.Visible = true;
                        PanelTotLiableTrust.Visible = false;
                        PanelTotLiableTrustIs.Visible = false;

                        lbpnlInsuranceAmount.Text = dt.Rows[0]["InsurerClaimAmountApproved"].ToString().Trim();
                        lbTotalLiableAmountByInsurer.Text = dt.Rows[0]["InsurerClaimAmountApproved"].ToString().Trim();
                    }
                    else if (hdRoleId.Value == "6")
                    {
                        pnlInsuranceamount.Visible = false;
                        pnlTrustAmount.Visible = true;
                        PanelTotLiableInsurance.Visible = false;
                        PanelTotLiableInsuranceIs.Visible = false;
                        PanelTotLiableTrust.Visible = true;
                        PanelTotLiableTrustIs.Visible = true;
                        lbpnlTrustAmount.Text = dt.Rows[0]["TrustClaimAmountApproved"].ToString().Trim();
                        lbTotalLiableAmountByTrust.Text = dt.Rows[0]["TrustClaimAmountApproved"].ToString().Trim();
                    }

                    if (dt.Rows[0]["AdmissionType"].ToString().Trim() == "0")
                    {
                        rbAdmissionTypePlanned.Checked = true;
                        rbAdmissionTypeEmergency.Checked = false;
                    }
                    else
                    {
                        rbAdmissionTypePlanned.Checked = false;
                        rbAdmissionTypeEmergency.Checked = true;
                    }
                }
            }
            else
            {
                MultiView1.SetActiveView(ViewNoPendingDataPage);
                lbNodataPending.Text = "There Is No Pending Case Right Now";
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

    public void displayPatientAdmissionImage()
    {
        try
        {
            dt.Clear();
            dt = cex.GetManditoryDocument(hdAbuaId.Value.ToString());
            if (dt.Rows.Count > 0)
            {
                string DocumentId = dt.Rows[0]["DocumentId"].ToString().Trim();
                string FolderName = dt.Rows[0]["FolderName"].ToString().Trim();
                string UploadedFileName = dt.Rows[0]["UploadedFileName"].ToString().Trim() + ".jpeg";
                string base64Image = preAuth.DisplayImage(FolderName, UploadedFileName);
                if (base64Image != "")
                {
                    imgPatientPhotosecond.ImageUrl = "data:image/jpeg;base64," + base64Image;
                }
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
    private void getTreatmentDischarge()
    {
        dt.Clear();
        dt = cex.GetTreatmentDischarge(hdClaimId.Value);
        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            lbDocType.Text = row["TypeOfMedicalExpertise"].ToString();
            lbDoctorName.Text = row["DoctorName"].ToString();
            lbDocRegnNo.Text = row["DoctorRegistrationNumber"].ToString();
            lbDocQualification.Text = row["Qualification"].ToString();
            lbDocContactNo.Text = row["DoctorContactNumber"].ToString();
            lbAnaesthetistName.Text = row["AnaesthetistName"].ToString();
            lbAnaesthetistRegNo.Text = row["AnaesthetistRegNo"].ToString();
            lbAnaesthetistContactNo.Text = row["AnaesthetistMobNo"].ToString();
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
            if (rbIsSpecialCaseYes.Checked)
            {
                pnlSpecialCaseValue.Visible = true; 
                lbSpecialCaseValue.Text = row["SpecialCaseValue"].ToString(); 
            }
            lbFinalDiagnosis.Text = row["FinalDiagnosis"].ToString();
            rbConsentYes.Checked = row["ProcedureConsent"] != DBNull.Value && Convert.ToBoolean(row["ProcedureConsent"]);
            rbConsentNo.Checked = row["ProcedureConsent"] != DBNull.Value && !Convert.ToBoolean(row["ProcedureConsent"]);
        }
        else
        {

        }
    }
    protected void tbCSAdmissionDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEX_GetPatientForClaimUpdation", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null)
                {
                    DateTime admissionDate = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"].ToString().Trim());
                    DateTime selectedDate;
                    if (DateTime.TryParse(tbCSAdmissionDate.Text, out selectedDate))
                    {
                        if (selectedDate.Date == admissionDate.Date)
                        {
                            rbIsAdmissionDateVerifiedYes.Checked = true;
                            rbIsAdmissionDateVerifiedNo.Checked = false;
                        }
                        else
                        {
                            rbIsAdmissionDateVerifiedYes.Checked = false;
                            rbIsAdmissionDateVerifiedNo.Checked = true;
                        }
                    }
                    else
                    {

                    }
                }
            }
            else
            {

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
    protected void tbCSTherepyDate_TextChanged(object sender, EventArgs e)
    {

        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEX_GetPatientForClaimUpdation", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null)
                {
                    DateTime surgeryDate = Convert.ToDateTime(dt.Rows[0]["ProposedSurgeryDate"].ToString().Trim());
                    DateTime selectedDate;
                    if (DateTime.TryParse(tbCSTherepyDate.Text, out selectedDate))
                    {
                        if (selectedDate.Date == surgeryDate.Date)
                        {
                            rbIsSurgeryDateVerifiedYes.Checked = true;
                            rbIsSurgeryDateVerifiedNo.Checked = false;
                        }
                        else
                        {
                            rbIsSurgeryDateVerifiedYes.Checked = false;
                            rbIsSurgeryDateVerifiedNo.Checked = true;
                        }
                    }
                }
                else
                {
                   
                }
            }
            else
            {
              
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
    protected void tbCSDischargeDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEX_GetPatientForClaimUpdation", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null)
                {
                    DateTime DischargeDate = Convert.ToDateTime(dt.Rows[0]["DischargeDate"].ToString().Trim());
                    DateTime selectedDate;
                    if (DateTime.TryParse(tbCSDischargeDate.Text, out selectedDate))
                    {
                        if (selectedDate.Date == DischargeDate.Date)
                        {
                            rbIsDischargeDateCSVerifiedYes.Checked = true;
                            rbIsDischargeDateCSVerifiedNo.Checked = false;
                        }
                        else
                        {
                            rbIsDischargeDateCSVerifiedYes.Checked = false;
                            rbIsDischargeDateCSVerifiedNo.Checked = true;
                        }
                    }
                }
                else
                {
                    
                }
            }
            else
            {
               
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
    protected void btnSubmitNonTechChecklist_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEX_GetPatientForClaimUpdation", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                if ((!rbIsNameCorrectYes.Checked && !rbIsNameCorrectNo.Checked) ||
                    (!rbIsGenderCorrectYes.Checked && !rbIsGenderCorrectNo.Checked) ||
                    (!rbIsPhotoVerifiedYes.Checked && !rbIsPhotoVerifiedNo.Checked) ||
                    (!rbIsAdmissionDateVerifiedYes.Checked && !rbIsAdmissionDateVerifiedNo.Checked) ||
                    (!rbIsSurgeryDateVerifiedYes.Checked && !rbIsSurgeryDateVerifiedNo.Checked) ||
                    (!rbIsDischargeDateCSVerifiedYes.Checked && !rbIsDischargeDateCSVerifiedNo.Checked) ||
                    (!rbIsSignVerifiedYes.Checked && !rbIsSignVerifiedNo.Checked) ||
                    (!rbIsReportCorrectYes.Checked && !rbIsReportCorrectNo.Checked) ||
                    (!rbIsReportVerifiedYes.Checked && !rbIsReportVerifiedNo.Checked))
                {
                    string errorMessage = "window.alert('Please select all the necessary fields.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }
                if (dropActionType.SelectedValue == "0")
                {
                    string errorMessage = "window.alert('Please select Action Type.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }
                string caseNo = hdCaseNo.Value;
                string cardNumber = hdAbuaId.Value;
                string userId = hdUserId.Value;
                string claimId = hdClaimId.Value;
                string admissionId = hdAdmissionId.Value;
                string claimMode = hdClaimMode.Value;
                int isNameCorrect = rbIsNameCorrectYes.Checked ? 1 : 0;
                int isGenderCorrect = rbIsGenderCorrectYes.Checked ? 1 : 0;
                int doesPhotoMatch = rbIsPhotoVerifiedYes.Checked ? 1 : 0;
                string admissionDateCS = tbCSAdmissionDate.Text;
                string admissionDateCSText = tbCSAdmissionDate.Text;
                int doesAddDateMatchCS = rbIsAdmissionDateVerifiedYes.Checked ? 1 : 0;
                string surgeryDateCS = tbCSTherepyDate.Text;
                int doesSurDateMatchCS = rbIsSurgeryDateVerifiedYes.Checked ? 1 : 0;
                string dischargeDateCS = tbCSDischargeDate.Text;
                int doesDischargeDateMatchCS = rbIsDischargeDateCSVerifiedYes.Checked ? 1 : 0;
                int isPatientSignVerified = rbIsSignVerifiedYes.Checked ? 1 : 0;
                int isReportVerified = rbIsReportCorrectYes.Checked ? 1 : 0;
                int isDateAndNameCorrect = rbIsReportVerifiedYes.Checked ? 1 : 0;
                string nonTechChecklistRemarks = tbNonTechFormRemark.Text;
                string Role = hdRoleId.Value;
                dt = ds.Tables[0];
                string demo = dt.Rows[0]["TotalPackageCost"].ToString().Trim();
                int amount = Convert.ToInt32(Convert.ToDecimal(dt.Rows[0]["TotalPackageCost"].ToString().Trim()));

                DateTime admissionDate;
                if (DateTime.TryParse(tbCSAdmissionDate.Text, out admissionDate))
                {
                    string formattedAdmissionDate = admissionDate.ToString("yyyy-MM-dd");
                }
                else
                {
                    string errorMessage = "window.alert('Invalid Admission Date format. Please use yyyy-MM-dd.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }

                DateTime surgeryDate;
                if (DateTime.TryParse(tbCSTherepyDate.Text, out surgeryDate))
                {
                    string formattedSurgeryDate = surgeryDate.ToString("yyyy-MM-dd");
                }
                else
                {
                    string errorMessage = "window.alert('Invalid Surgery Date format. Please use yyyy-MM-dd.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }

                DateTime dischargeDate;
                if (DateTime.TryParse(tbCSDischargeDate.Text, out dischargeDate))
                {
                    string formattedDischargeDate = dischargeDate.ToString("yyyy-MM-dd");
                }
                else
                {
                    string errorMessage = "window.alert('Invalid Discharge Date format. Please use yyyy-MM-dd.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }

                bool checkDuplicate = cex.DoesNonTechChecklistExist(caseNo, Role);
                if (checkDuplicate)
                {
                    string errorMessage = "window.alert('Record already exists.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Error", errorMessage, true);
                    return;
                }

                bool resultId = cex.InsertCEXNonTechChecklist(caseNo, Role, cardNumber, userId, claimId, admissionId, isNameCorrect, isGenderCorrect, doesPhotoMatch, admissionDateCS, doesAddDateMatchCS, surgeryDateCS, doesSurDateMatchCS, dischargeDateCS, doesDischargeDateMatchCS, isPatientSignVerified, isReportVerified, isDateAndNameCorrect, nonTechChecklistRemarks);

                if (resultId)
                {
                    if (hdClaimMode.Value == "3")
                    {
                        bool result = cex.UpdateClaimMasterForCEXHybrid(caseNo, userId, claimId);
                        if (result)
                        {
                            bool ActionResult = cex.PatientActionForCEXHybrid(userId, claimId, admissionId, amount, nonTechChecklistRemarks);
                            if (ActionResult)
                            {
                                string strMessage = "window.alert('Saved Successfully!');window.location.reload();";
                                ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Something Went Wrong.');window.location.reload();";
                            ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                        }
                    }
                    else
                    {
                        if (hdRoleId.Value == "5")
                        {
                            bool result = cex.UpdateClaimMasterForCEXInsurer(caseNo, userId, claimId);
                            if (result)
                            {
                                bool ActionResult = cex.PatientActionForCEXInsurer(userId, claimId, admissionId, amount, nonTechChecklistRemarks);
                                if (ActionResult)
                                {
                                    string strMessage = "window.alert('Saved Successfully!');window.location.reload();";
                                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                                }
                            }
                            else
                            {
                                strMessage = "window.alert('Something Went Wrong.');window.location.reload();";
                                ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                            }
                        }
                        else if (hdRoleId.Value == "6")
                        {
                            bool result = cex.UpdateClaimMasterForCEXTrust(caseNo, userId, claimId);

                            if (result)
                            {
                                bool ActionResult = cex.PatientActionForCEXTrust(userId, claimId, admissionId, amount, nonTechChecklistRemarks);
                                if (ActionResult)
                                {
                                    strMessage = "window.alert('Saved Successfully.');window.location.reload();";
                                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                                }
                            }
                            else
                            {
                                strMessage = "window.alert('Something Went Wrong.');window.location.reload();";
                                ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                            }
                        }
                    }
                }
                else
                {
                    strMessage = "window.alert('Failed to Saved.');";
                    ScriptManager.RegisterStartupScript(btnSubmitNonTechChecklist, btnSubmitNonTechChecklist.GetType(), "Result", strMessage, true);
                }
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
    private void BindGridICHIDetail()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Procedure Name");
        dt.Columns.Add("ICHI Code given By Medco");
        dt.Columns.Add("ICHI Code given By PPD Insurer");
        dt.Columns.Add("ICHI Code given By CPD Insurer");
        dt.Columns.Add("ICHI Code given By SAFO");
        dt.Columns.Add("ICHI Code given By NAFO");

        dt.Rows.Add("NA", "NA", "NA", "NA", "NA", "NA");

        GridICHIDetail.DataSource = dt;
        GridICHIDetail.DataBind();
    }
  
    [WebMethod]
    public static string NotifyInactivity(string message)
    {
        var session = HttpContext.Current.Session;
        if (session["ClaimId"] != null)
        {
            int affectedRows = cex.TransferCase(session["ClaimId"].ToString(), session["RoleName"].ToString());
        }
        return System.Web.VirtualPathUtility.ToAbsolute("~/Unauthorize.aspx");
    }
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewPast);
        btnPastHistory.CssClass = "btn btn-warning";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
        if (btnOncology.Visible)
        {
            btnOncology.CssClass = "btn btn-primary"; 
        }

    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewPreauth);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-warning";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
        if (btnOncology.Visible)
        {
            btnOncology.CssClass = "btn btn-primary";
        }
    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewTreatmentDischarge);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
        if (btnOncology.Visible)
        {
            btnOncology.CssClass = "btn btn-primary";
        }
    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewClaim);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-warning";
        btnAttachments.CssClass = "btn btn-primary";
        if (btnOncology.Visible)
        {
            btnOncology.CssClass = "btn btn-primary";
        }
    }

    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewPreauthorization);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-warning";
        if (btnOncology.Visible)
        {
            btnOncology.CssClass = "btn btn-primary";
        }
        btnPreauthorization.CssClass = "btn btn-warning";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }
    private void BindGrid_PreauthWorkFlow()
    {
        dt.Clear();
        string claimId = hdClaimId.Value;
        dt = cex.GetClaimWorkFlow(Convert.ToInt32(claimId));
        if (dt != null && dt.Rows.Count > 0)
        {
            gvPreauthWorkFlow.DataSource = dt;
            gvPreauthWorkFlow.DataBind();
        }
        else
        {
            gvPreauthWorkFlow.DataSource = null;
            gvPreauthWorkFlow.EmptyDataText = "No record found.";
            gvPreauthWorkFlow.DataBind();
        }
    }
    private void BindClaimWorkflow()
    {
        dt.Clear();
        string claimId = hdClaimId.Value;
        dt = cex.GetClaimWorkFlow(Convert.ToInt32(claimId));
        if (dt != null && dt.Rows.Count > 0)
        {
            gvClaimWorkFlow.DataSource = dt;
            gvClaimWorkFlow.DataBind();
        }
        else
        {
            gvClaimWorkFlow.DataSource = null;
            gvClaimWorkFlow.EmptyDataText = "No record found.";
            gvClaimWorkFlow.DataBind();
        }
    }
    protected void BindGrid_TreatmentProtocol()
    {
        try
        {
            dt.Clear();
            dt = cex.getTreatmentProtocol(hdCaseNo.Value);
            if (dt.Rows.Count > 0)
            {
                GridTreatmentProtocol.DataSource = dt;
                GridTreatmentProtocol.DataBind();
            }
            else
            {
                GridTreatmentProtocol.DataSource = "";
                GridTreatmentProtocol.DataBind();
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
    protected void BindGrid_TreatmentSurgeryDate()
    {
        try
        {
            dt.Clear();
            dt = cex.getTreatmentSurgeryDate(hdHospitalId.Value, hdPatientRegId.Value, hdAbuaId.Value);
            if (dt.Rows.Count > 0)
            {
                gridSurgeryTreatmentDate.DataSource = dt;
                gridSurgeryTreatmentDate.DataBind();
            }
            else
            {
                gridSurgeryTreatmentDate.DataSource = "";
                gridSurgeryTreatmentDate.DataBind();
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
    protected void BindGrid_PrimaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = cex.getPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                GridPrimaryDiagnosis.DataSource = dt;
                GridPrimaryDiagnosis.DataBind();
            }
            else
            {
                GridPrimaryDiagnosis.DataSource = "";
                GridPrimaryDiagnosis.DataBind();
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
    protected void BindGrid_ClaimPrimaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = cex.getPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                GridClaimPrimaryDiagnosisICDValue.DataSource = dt;
                GridClaimPrimaryDiagnosisICDValue.DataBind();
            }
            else
            {
                GridClaimPrimaryDiagnosisICDValue.DataSource = "";
                GridClaimPrimaryDiagnosisICDValue.DataBind();
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
    protected void BindGrid_SecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = cex.getSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                GridSecondaryDiagnosis.DataSource = dt;
                GridSecondaryDiagnosis.DataBind();
            }
            else
            {
                GridSecondaryDiagnosis.DataSource = "";
                GridSecondaryDiagnosis.DataBind();
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
    protected void BindGrid_ClaimSecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = cex.getSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                GridClaimSecondaryDiagnosisICDValue.DataSource = dt;
                GridClaimSecondaryDiagnosisICDValue.DataBind();
            }
            else
            {
                GridClaimSecondaryDiagnosisICDValue.DataSource = "";
                GridClaimSecondaryDiagnosisICDValue.DataBind();
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

   
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        MultiView3.SetActiveView(viewPhoto);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void btnOncology_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewOncology);
        btnOncology.Visible = true;
        btnOncology.CssClass = "btn btn-warning";
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
    }
    public void getManditoryDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridManditoryDocument.DataSource = dt;
                gridManditoryDocument.DataBind();
            }
            else
            {
                gridManditoryDocument.DataSource = null;
                gridManditoryDocument.DataBind();
                panelNoManditoryDocument.Visible = true;
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridManditoryDocument_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var uploadedFileName = DataBinder.Eval(e.Row.DataItem, "UploadedFileName") as string;
            Button btnViewMandateDocument = (Button)e.Row.FindControl("btnViewMandateDocument");
            Label lbDocumentFor = (Label)e.Row.FindControl("lbDocumentFor");
            string DocumentFor = lbDocumentFor.Text.ToString();
            if (DocumentFor == "1")
            {
                lbDocumentFor.Text = "Pre Investigation";
            }
            else
            {
                lbDocumentFor.Text = "Post Investigation";
            }
            if (string.IsNullOrEmpty(uploadedFileName))
            {
                btnViewMandateDocument.Text = "No Document";
                btnViewMandateDocument.CssClass = "btn btn-warning btn-sm rounded-pill";
                btnViewMandateDocument.Enabled = false;
            }
            else
            {
                btnViewMandateDocument.Text = "View Document";
                btnViewMandateDocument.CssClass = "btn btn-success btn-sm rounded-pill";
                btnViewMandateDocument.Enabled = true;
            }
        }
    }
    public void getPreInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetPreInvestigationDocuments(HospitalId, CardNumber, PatientRegId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridSpecialInvestigation.DataSource = dt;
                gridSpecialInvestigation.DataBind();
            }
            else
            {
                gridSpecialInvestigation.DataSource = null;
                gridSpecialInvestigation.DataBind();
                panelNoSpecialInvestigation.Visible = true;
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    public void getPostInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetPostInvestigationDocuments(HospitalId, CardNumber, PatientRegId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridPostInvestigationDocument.DataSource = dt;
                gridPostInvestigationDocument.DataBind();
            }
            else
            {
                gridPostInvestigationDocument.DataSource = null;
                gridPostInvestigationDocument.DataBind();
                panelPostInvestigationDocument.Visible = true;
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    public void getDischargeDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetDischargeDocuments(HospitalId, PatientRegId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridDischargeDocument.DataSource = dt;
                gridDischargeDocument.DataBind();
            }
            else
            {
                gridDischargeDocument.DataSource = null;
                gridDischargeDocument.DataBind();
                panelDischargeDocument.Visible = true;
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridSpecialInvestigation_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var uploadedFileName = DataBinder.Eval(e.Row.DataItem, "UploadedFileName") as string;
            Button btnViewDocument = (Button)e.Row.FindControl("btnViewDocument");
            if (string.IsNullOrEmpty(uploadedFileName))
            {
                btnViewDocument.Text = "No Document";
                btnViewDocument.CssClass = "btn btn-warning btn-sm rounded-pill";
                btnViewDocument.Enabled = false;
            }
            else
            {
                btnViewDocument.Text = "View Document";
                btnViewDocument.CssClass = "btn btn-success btn-sm rounded-pill";
                btnViewDocument.Enabled = true;
            }
        }
    }

    protected void btnViewMandateDocument_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbDocumentName = (Label)row.FindControl("lbDocumentName");
            Label lbFolderName = (Label)row.FindControl("lbFolder");
            Label lbFileName = (Label)row.FindControl("lbUploadedFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string DocumentName = lbDocumentName.Text;
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }


    protected void btnViewDocument_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbPackageName = (Label)row.FindControl("lbPackageName");
            Label lbInvestigationName = (Label)row.FindControl("lbInvestigationName");
            Label lbFolderName = (Label)row.FindControl("lbFolderName");
            Label lbFileName = (Label)row.FindControl("lbFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string packageName = lbPackageName.Text;
            string investigationName = lbInvestigationName.Text;
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = packageName + " / " + investigationName;
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnDownloadPdf_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dtSpecialDocument = new DataTable();
            DataTable dtManditoryDocument = new DataTable();
            DataTable dtDischargeDocument = new DataTable();
            DataTable dtPostInvestigationDocument = new DataTable();
            List<string> images = new List<string>();
            dtSpecialDocument = cex.GetPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
            dtManditoryDocument = cex.GetManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
            dtDischargeDocument = cex.GetDischargeDocuments(hdHospitalId.Value, hdPatientRegId.Value);
            dtPostInvestigationDocument = cex.GetPostInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
            if (dtManditoryDocument != null && dtManditoryDocument.Rows.Count > 0)
            {
                foreach (DataRow row in dtManditoryDocument.Rows)
                {
                    string folderName = row["FolderName"].ToString().Trim();
                    string fileName = row["UploadedFileName"].ToString().Trim() + ".jpeg";
                    if (!string.IsNullOrEmpty(folderName) && !string.IsNullOrEmpty(fileName))
                    {
                        string base64Image = preAuth.DisplayImage(folderName, fileName);
                        if (!string.IsNullOrEmpty(base64Image))
                        {
                            images.Add("data:image/jpeg;base64," + base64Image);
                        }
                    }
                }
            }
            if (dtSpecialDocument != null && dtSpecialDocument.Rows.Count > 0)
            {
                foreach (DataRow row in dtSpecialDocument.Rows)
                {
                    string folderName = row["FolderName"].ToString().Trim();
                    string fileName = row["UploadedFileName"].ToString().Trim() + ".jpeg";
                    if (!string.IsNullOrEmpty(folderName) && !string.IsNullOrEmpty(fileName))
                    {
                        string base64Image = preAuth.DisplayImage(folderName, fileName);
                        if (!string.IsNullOrEmpty(base64Image))
                        {
                            images.Add("data:image/jpeg;base64," + base64Image);
                        }
                    }
                }
            }
            if (dtDischargeDocument != null && dtDischargeDocument.Rows.Count > 0)
            {
                foreach (DataRow row in dtDischargeDocument.Rows)
                {
                    string folderName = row["FolderName"].ToString().Trim();
                    string fileName = row["UploadedFileName"].ToString().Trim() + ".jpeg";
                    if (!string.IsNullOrEmpty(folderName) && !string.IsNullOrEmpty(fileName))
                    {
                        string base64Image = preAuth.DisplayImage(folderName, fileName);
                        if (!string.IsNullOrEmpty(base64Image))
                        {
                            images.Add("data:image/jpeg;base64," + base64Image);
                        }
                    }
                }
            }
            if (dtPostInvestigationDocument != null && dtPostInvestigationDocument.Rows.Count > 0)
            {
                foreach (DataRow row in dtPostInvestigationDocument.Rows)
                {
                    string folderName = row["FolderName"].ToString().Trim();
                    string fileName = row["UploadedFileName"].ToString().Trim() + ".jpeg";
                    if (!string.IsNullOrEmpty(folderName) && !string.IsNullOrEmpty(fileName))
                    {
                        string base64Image = preAuth.DisplayImage(folderName, fileName);
                        if (!string.IsNullOrEmpty(base64Image))
                        {
                            images.Add("data:image/jpeg;base64," + base64Image);
                        }
                    }
                }
            }
            if (images.Count > 0)
            {
                byte[] pdfBytes = cex.CreatePdfWithImagesInMemory(images);
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=merged.pdf");
                Response.BinaryWrite(pdfBytes);
                Response.Flush();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnViewDischargeDocument_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbDocumentName = (Label)row.FindControl("lbDocumentName");
            Label lbFolderName = (Label)row.FindControl("lbFolder");
            Label lbFileName = (Label)row.FindControl("lbUploadedFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string DocumentName = lbDocumentName.Text;
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridDischargeDocument_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var uploadedFileName = DataBinder.Eval(e.Row.DataItem, "UploadedFileName") as string;
            Button btnViewDischargeDocument = (Button)e.Row.FindControl("btnViewDischargeDocument");
            if (string.IsNullOrEmpty(uploadedFileName))
            {
                btnViewDischargeDocument.Text = "No Document";
                btnViewDischargeDocument.CssClass = "btn btn-warning btn-sm rounded-pill";
                btnViewDischargeDocument.Enabled = false;
            }
            else
            {
                btnViewDischargeDocument.Text = "View Document";
                btnViewDischargeDocument.CssClass = "btn btn-success btn-sm rounded-pill";
                btnViewDischargeDocument.Enabled = true;
            }
        }
    }

    protected void btnlnkPreauthorization_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPreauthorization);
        btnPreauthorization.CssClass = "btn btn-warning";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }

    protected void btnDischarge_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDischarge);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-warning";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
        getDischargeDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }

    protected void btnDeath_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDeath);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-warning";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
    }

    protected void btnClaim_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewClaims);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-warning";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
    }

    protected void btnGenInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewGeneralInvestigation);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-warning";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
    }

    protected void btnSpecialInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewSpecialInvestigation);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-warning";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
        getPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }

    protected void btnFraudDoc_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewFraudDocuments);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-warning";
        //btnAuditDoc.CssClass = "btn btn-primary";
    }

    protected void btnAuditDoc_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAuditDocuments);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass = "btn btn-primary";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-warning";
    }

    protected void btnPostIvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPostInvestigation);
        btnPreauthorization.CssClass = "btn btn-primary";
        btnDischarge.CssClass = "btn btn-primary";
        //btnDeath.CssClass = "btn btn-primary";
        //btnClaim.CssClass = "btn btn-primary";
        //btnGenInvestigation.CssClass = "btn btn-primary";
        btnSpecialInvestigation.CssClass = "btn btn-primary";
        btnPostIvestigation.CssClass= "btn btn-warning";
        //btnFraudDoc.CssClass = "btn btn-primary";
        //btnAuditDoc.CssClass = "btn btn-primary";
        getPostInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }

    protected void btnViewPostInvestigationDocument_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbPackageName = (Label)row.FindControl("lbPackageName");
            Label lbInvestigationName = (Label)row.FindControl("lbInvestigationName");
            Label lbFolderName = (Label)row.FindControl("lbFolderName");
            Label lbFileName = (Label)row.FindControl("lbFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string packageName = lbPackageName.Text;
            string investigationName = lbInvestigationName.Text;
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = packageName + " / " + investigationName;
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridPostInvestigationDocument_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var uploadedFileName = DataBinder.Eval(e.Row.DataItem, "UploadedFileName") as string;
            Button btnViewPostInvestigationDocument = (Button)e.Row.FindControl("btnViewPostInvestigationDocument");
            if (string.IsNullOrEmpty(uploadedFileName))
            {
                btnViewPostInvestigationDocument.Text = "No Document";
                btnViewPostInvestigationDocument.CssClass = "btn btn-warning btn-sm rounded-pill";
                btnViewPostInvestigationDocument.Enabled = false;
            }
            else
            {
                btnViewPostInvestigationDocument.Text = "View Document";
                btnViewPostInvestigationDocument.CssClass = "btn btn-success btn-sm rounded-pill";
                btnViewPostInvestigationDocument.Enabled = true;
            }
        }
    }
}
