using CareerPath.DAL;
using System;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using WebGrease.Css.Ast;
using System.Configuration;
using System.Web;
using AbuaTMS;
using Org.BouncyCastle.Crypto.General;
using System.Security.Cryptography;


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
                BindGridPrimaryDiagnosis();
                BindGridPrimaryICDValue();
                BindGridICHIDetail();
                BindGridSurgeryDate();
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
                    Session["AdmissionId"] = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    Session["ClaimId"] = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hdClaimId.Value = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString().Trim();
                    hdAdmissionId.Value = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                    lbBenCardId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                    lbRegistrationNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbCaseNumber.Text = "Case No: " + dt.Rows[0]["CaseNumber"].ToString().Trim();

                    string caseNumber = dt.Rows[0]["CaseNumber"].ToString().Trim();

                    Session["CaseNumber"] = caseNumber;

                    hdCaseNo.Value = caseNumber;
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";

                    base64String = cex.DisplayImage(folderName, imageFileName);
                    if (base64String != "")
                    {
                        imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                        //imgPatientPhotosecond.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }

                    else
                    {
                        imgPatientPhoto.ImageUrl = "~/img/profile.jpg";
                        //imgPatientPhotosecond.ImageUrl = "~/img/profile.jpg";
                    }


                    lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbRegDate.Text = registrationDate.ToString("dd-MM-yyyy");
                    lbComContactNo.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalParentType"].ToString().Trim();
                    lbGender.Text = dt.Rows[0]["Gender"].ToString().Trim() == "" ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                    lbFamilyID.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                    lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    //lbBiometricVerified.Text = dt.Rows[0]["IsBiometricVerified"].ToString().Trim() == "False" ? "No" : "Yes";
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

                    displayPatientAdmissionImage();
                    BindGrid_TreatmentProtocol();
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
                        //lbpnlInsuranceAmount.Text = dt.Rows[0]["InsurerClaimAmountApproved"].ToString().Trim();
                        lbpnlTrustAmount.Text = dt.Rows[0]["TrustClaimAmountApproved"].ToString().Trim();
                        //lbTotalLiableAmountByInsurer.Text = dt.Rows[0]["InsurerClaimAmountApproved"].ToString().Trim();
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
        string claimId = Session["ClaimId"] as string;
        dt.Clear();
        dt = cex.GetTreatmentDischarge(claimId);
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
            lbDocType.Text = "";
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
                    //lblMessage.Text = "Please enter a valid date.";
                }
            }
            else
            {
                //lblMessage.Text = "No patient details available.";
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
                    //lblMessage.Text = "Please enter a valid date.";
                }
            }
            else
            {
                //lblMessage.Text = "No patient details available.";
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

                //DataTable dt = new DataTable();
                dt = ds.Tables[0];
                //DataRow row = dt.Rows[0];
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
                    if (hdRoleId.Value == "5")
                    {
                        bool result = cex.UpdateClaimMasterForCEXInsurer(caseNo, userId, claimId);

                        if (result)
                        {
                            bool ActionResult = cex.PatientActionForCEXInsurer(userId, claimId, amount, nonTechChecklistRemarks);
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
                            bool ActionResult = cex.PatientActionForCEXTrust(userId, claimId, amount, nonTechChecklistRemarks);
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


    private void BindGridPrimaryDiagnosis()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("S No");
        dt.Columns.Add("ICD Code");
        dt.Columns.Add("ICD Description");
        dt.Columns.Add("Acted By Role");

        dt.Rows.Add("1", "N/A", "N/A)", "N/A");

        GridPrimaryDiagnosis.DataSource = dt;
        GridPrimaryDiagnosis.DataBind();
    }
    private void BindGridPrimaryICDValue()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("S No");
        dt.Columns.Add("ICD Code");
        dt.Columns.Add("ICD Description");
        dt.Columns.Add("Acted By Role");

        dt.Rows.Add("1", "N/A", "N/A)", "N/A");

        GridPrimaryICDValue.DataSource = dt;
        GridPrimaryICDValue.DataBind();
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

        dt.Rows.Add("Secondary suturing of episiotomy - Secondary suturing of episiotomy(SO-SO056A)-S400073", "Repair of perineum(PAW MK AA)", "NA", "NA", "NA", "NA");

        GridICHIDetail.DataSource = dt;
        GridICHIDetail.DataBind();
    }
    //private void BindGridWorkflow()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("S No");
    //    dt.Columns.Add("Date and Time");
    //    dt.Columns.Add("Role");
    //    dt.Columns.Add("Remarks");
    //    dt.Columns.Add("Action");
    //    dt.Columns.Add("Amount");
    //    dt.Columns.Add("Preauth Querry Rejection");

    //    dt.Rows.Add("1", "14/06/2024 17:01:02", "MEDCO(MEDCO)", "NA", "Patient Regisered", "NA", "NA");
    //    dt.Rows.Add("2", "18/06/2024 17:01:02", "MEDCO(MEDCO)", "Procedure Auto Approved", "Procedure auto approved insurance(insurance)", "2750", "NA");
    //    dt.Rows.Add("3ss", "29/06/2024 17:01:02", "MEDCO(MEDCO)", "NA", "Discharge Date update by Medco(Insurance)", "2750", "NA");

    //    GridWorkflow.DataSource = dt;
    //    GridWorkflow.DataBind();
    //}
    private void BindGridSurgeryDate()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Procedure Code");
        dt.Columns.Add("Procedure Name");
        dt.Columns.Add("Surgery Date/Treatment Start Date");

        dt.Rows.Add("SO056A", "Secondary sutiuring of episiotomy", "14-06-2024");

        GridSurgeryDate.DataSource = dt;
        GridSurgeryDate.DataBind();
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
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewPreauth);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-warning";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewTreatmentDischarge);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCEXTabs.SetActiveView(ViewClaim);
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-warning";
        btnAttachments.CssClass = "btn btn-primary";
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
        lnkPreauthorization.CssClass = "btn btn-warning";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }
    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPreauthorization);
        lnkPreauthorization.CssClass = "btn btn-warning";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }
    protected void lnkDischarge_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDischarge);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-warning";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }

    protected void lnkDeath_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDeath);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-warning";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }
    protected void lnkClaim_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewClaims);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-warning";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }

    protected void lnkGeneralInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewGeneralInvestigation);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-warning";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }

    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewSpecialInvestigation);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-warning";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }

    protected void lnkFraudDocuments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewFraudDocuments);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-warning";
        lnkAuditDocuments.CssClass = "btn btn-primary";
    }

    protected void lnkAuditDocuments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAuditDocuments);
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkDeath.CssClass = "btn btn-primary";
        lnkClaim.CssClass = "btn btn-primary";
        lnkGeneralInvestigation.CssClass = "btn btn-primary";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkFraudDocuments.CssClass = "btn btn-primary";
        lnkAuditDocuments.CssClass = "btn btn-warning";
    }
    private void BindGrid_PreauthWorkFlow()
    {
        dt.Clear();
        string caseNo = Session["CaseNumber"].ToString();
        dt = cex.GetClaimWorkFlow(caseNo);
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
        string claimId = Session["ClaimId"].ToString();
        dt = cex.GetClaimWorkFlow(claimId);
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

    protected void btnDownloadPdf_Click1(object sender, EventArgs e)
    {
        try
        {
            string image1Url = "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png";
            string image2Url = "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png";
            byte[] pdfBytes = cex.CreatePdfWithImagesInMemory(new[] { image1Url, image2Url });

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=merged.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.Flush();
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        MultiView3.SetActiveView(viewPhoto);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }
}
