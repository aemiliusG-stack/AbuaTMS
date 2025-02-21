using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AbuaTMS;
using System.Reflection.Emit;
using Label = System.Web.UI.WebControls.Label;

public partial class ACO_ACOReconciliationPatientDetail : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    CEX cex = new CEX();
    CPD cpd = new CPD();
    ACOHelper aco = new ACOHelper();
    public static PPDHelper ppdHelper = new PPDHelper();
    private string caseNo;
    private string claimNo;
    string pageName;
    private string strMessage;

    protected void Page_Load(object sender, EventArgs e)
    {
        //mvCPDTabs.SetActiveView(ViewClaims);
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            string cardNo = Session["CardNumber"] as string;
            string claimId = Session["ClaimId"] as string;
            string patientRedgNo = Session["PatientRegId"] as string;
            string caseNumber = Request.QueryString["CaseNumber"];
            Session["CaseNumber"] = caseNumber;
            if (!string.IsNullOrEmpty(caseNumber))
            {
                hdRoleId.Value = Session["RoleId"].ToString();
                LoadPatientDetails(caseNumber);
            }
            else
            {
                lbName.Text = "No CaseNo provided.";
            }
            getPatientPrimaryDiagnosis();
            getPatientSecondaryDiagnosis();
            getTreatmentDischarge();
            getNetworkHospitalDetails();
            BindPreauthAdmissionDetails();
            BindGrid_TreatmentProtocol();
            BindGrid_ICHIDetails();
            BindGrid_PreauthWorkFlow();
            getTreatmentDischarge();
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
                gvPICDDetails_Claim.DataSource = dt;
                gvPICDDetails_Claim.DataBind();
            }
            else
            {
                gvPICDDetails_Claim.DataSource = "";
                gvPICDDetails_Claim.DataBind();
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
    protected void getPatientPrimaryDiagnosis()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetPatientPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gvPICDDetails_Claim.DataSource = dt;
                gvPICDDetails_Claim.DataBind();
            }
            else
            {
                gvPICDDetails_Claim.DataSource = null;
                gvPICDDetails_Claim.DataBind();
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
    protected void getPatientSecondaryDiagnosis()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetPatientSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gvSICDDetails_Claim.DataSource = dt;
                gvSICDDetails_Claim.DataBind();
                pClaimsSD.Visible = true;
            }
            else
            {
                gvSICDDetails_Claim.DataSource = null;
                gvSICDDetails_Claim.DataBind();
                pClaimsSD.Visible = false;
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
    private void getNetworkHospitalDetails()
    {
        try
        {
            dt.Clear();
            string caseNo = Session["CaseNumber"].ToString();
            dt = cpd.GetNetworkHospitalDetails(caseNo);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                tbHospitalName.Text = row["HospitalName"].ToString();
                tbType.Text = row["Title"].ToString();
                tbAddress.Text = row["Address"].ToString();
            }
            else
            {
                tbHospitalName.Text = "";
                tbType.Text = "";
                tbAddress.Text = "";
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
            throw;
        }

    }
    private void BindGrid_TreatmentProtocol()
    {
        try
        {
            string caseNo = Session["CaseNumber"].ToString();
            dt = cpd.GetTreatmentProtocol(caseNo);

            gvTreatmentProtocol.DataSource = dt;
            gvTreatmentProtocol.DataBind();
            if (dt == null || dt.Rows.Count == 0)
            {
                gvTreatmentProtocol.EmptyDataText = "No Treatment Protocol found.";
                gvTreatmentProtocol.DataBind();
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
            throw;
        }

    }
    private void BindGrid_ICHIDetails()
    {
        try
        {
            //dt.Clear();
            //dt = cpd.GetICHIDetails();
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    gvICHIDetails.DataSource = dt;
            //    gvICHIDetails.DataBind();
            //}
            //else
            //{
            //    gvICHIDetails.DataSource = null;
            //    gvICHIDetails.EmptyDataText = "No ICHI Details found.";
            //    gvICHIDetails.DataBind();
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
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
            throw;
        }

    }
    private void BindGrid_PreauthWorkFlow()
    {
        try
        {
            dt.Clear();
            string claimId = Session["ClaimId"].ToString();
            dt = cpd.GetClaimWorkFlow(claimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                dt.Columns.Add("SlNo", typeof(int));
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SlNo"] = i + 1;
                }
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
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }

    }
    private void BindPreauthAdmissionDetails()
    {
        try
        {
            string caseNo = Session["CaseNumber"].ToString();
            DataTable dt = cpd.GetAdmissionDetails(caseNo);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                lbAdmissionDate_Preauth.Text = Convert.ToDateTime(row["AdmissionDate"]).ToString("dd/MM/yyyy");
                lbPackageCost.Text = Convert.ToDecimal(row["PackageCost"]).ToString("C");
                lbHospitalIncentive.Text = "110%";
                lbIncentiveAmount.Text = Convert.ToDecimal(row["IncentiveAmount"]).ToString("C");
                lbTotalPackageCost.Text = Convert.ToDecimal(row["TotalPackageCost"]).ToString("C");
                //lbTotalAmtInsurance.Text = Convert.ToDecimal(row["InsurerClaimAmountRequested"]).ToString("C");
                //lbTotalAmtTrust.Text = Convert.ToDecimal(row["TrustClaimAmountRequested"]).ToString("C");
                tbRemarks.Text = row["Remarks"].ToString();

                bool isPlanned = row["AdmissionType"] != DBNull.Value && Convert.ToInt32(row["AdmissionType"]) == 0;
                RBPlanned.Checked = isPlanned;
                RBEmergency.Checked = !isPlanned;
                if (Session["RoleId"].ToString() == "7")
                {
                    lbRoleStatusPre.Text = "The amount liable by insurance is";
                    lbAmountLiablePre.Text = Convert.ToDecimal(row["InsurerClaimAmountRequested"]).ToString("C");
                }
                else if (Session["RoleId"].ToString() == "8")
                {
                    lbRoleStatusPre.Text = "The amount liable by trust is";
                    lbAmountLiablePre.Text = Convert.ToDecimal(row["TrustClaimAmountRequested"]).ToString("C");
                }

            }
            else
            {
                lbAdmissionDate_Preauth.Text = "No data found";
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
            throw;
        }

    }
    //Tratment and discharge
    private void getTreatmentDischarge()
    {
        try
        {
            //string claimId = Session["ClaimId"] as string;
            long claimId2 = Convert.ToInt64(Session["ClaimId"]);
            string claimId = claimId2.ToString();
            dt.Clear();
            dt = cpd.GetTreatmentDischarge(claimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                lbDoctorType.Text = row["TypeOfMedicalExpertise"] != DBNull.Value ? row["TypeOfMedicalExpertise"].ToString() : "NA";
                lbDoctorName.Text = row["DoctorName"] != DBNull.Value ? row["DoctorName"].ToString() : "NA";
                lbDocRegnNo.Text = row["DoctorRegistrationNumber"] != DBNull.Value ? row["DoctorRegistrationNumber"].ToString() : "NA";
                lbDocQualification.Text = row["Qualification"] != DBNull.Value ? row["Qualification"].ToString() : "NA";
                lbDocContactNo.Text = row["DoctorContactNumber"] != DBNull.Value ? row["DoctorContactNumber"].ToString() : "NA";
                lbAnaesthetistName.Text = row["AnaesthetistName"] != DBNull.Value ? row["AnaesthetistName"].ToString() : "NA";
                lbAnaesthetistRegNo.Text = row["AnaesthetistRegNo"] != DBNull.Value ? row["AnaesthetistRegNo"].ToString() : "NA";
                lbAnaesthetistContactNo.Text = row["AnaesthetistMobNo"] != DBNull.Value ? row["AnaesthetistMobNo"].ToString() : "NA";
                lbIncisionType.Text = row["IncisionType"] != DBNull.Value ? row["IncisionType"].ToString() : "NA";
                rbOPPhotoYes.Checked = row["OPPhotosWebexTaken"] != DBNull.Value && Convert.ToBoolean(row["OPPhotosWebexTaken"]);
                rbOPPhotoNo.Checked = row["OPPhotosWebexTaken"] != DBNull.Value && !Convert.ToBoolean(row["OPPhotosWebexTaken"]);
                rbVedioRecDoneYes.Checked = row["VideoRecordingDone"] != DBNull.Value && Convert.ToBoolean(row["VideoRecordingDone"]);
                rbVedioRecDoneNo.Checked = row["VideoRecordingDone"] != DBNull.Value && !Convert.ToBoolean(row["VideoRecordingDone"]);
                lbSwabCounts.Text = row["SwabCountInstrumentsCount"] != DBNull.Value ? row["SwabCountInstrumentsCount"].ToString() : "NA";
                lbSurutes.Text = row["SuturesLigatures"] != DBNull.Value ? row["SuturesLigatures"].ToString() : "NA";
                rbSpecimenRemoveYes.Checked = row["SpecimenRequired"] != DBNull.Value && Convert.ToBoolean(row["SpecimenRequired"]);
                rbSpecimenRemoveNo.Checked = row["SpecimenRequired"] != DBNull.Value && !Convert.ToBoolean(row["SpecimenRequired"]);
                lbDranageCount.Text = row["DrainageCount"] != DBNull.Value ? row["DrainageCount"].ToString() : "NA";
                lbBloodLoss.Text = row["BloodLoss"] != DBNull.Value ? row["BloodLoss"].ToString() : "NA";
                lbOperativeInstructions.Text = row["PostOperativeInstructions"] != DBNull.Value ? row["PostOperativeInstructions"].ToString() : "NA";
                lbPatientCondition.Text = row["PatientCondition"] != DBNull.Value ? row["PatientCondition"].ToString() : "NA";
                rbComplicationsYes.Checked = row["ComplicationsIfAny"] != DBNull.Value && Convert.ToBoolean(row["ComplicationsIfAny"]);
                rbComplicationsNo.Checked = row["ComplicationsIfAny"] != DBNull.Value && !Convert.ToBoolean(row["ComplicationsIfAny"]);
                lbTraetmentDate.Text = row["TreatmentSurgeryStartDate"] != DBNull.Value ? Convert.ToDateTime(row["TreatmentSurgeryStartDate"]).ToString("dd/MM/yyyy") : "NA";
                tbSurgeryStartTime.Text = row["SurgeryStartTime"] != DBNull.Value ? TimeSpan.Parse(row["SurgeryStartTime"].ToString()).ToString(@"hh\:mm") : "NA";
                tbSurgeryEndTime.Text = row["SurgeryEndTime"] != DBNull.Value ? TimeSpan.Parse(row["SurgeryEndTime"].ToString()).ToString(@"hh\:mm") : "NA";
                tbTreatmentGiven.Text = row["TreatmentGiven"] != DBNull.Value ? row["TreatmentGiven"].ToString() : "NA";
                tbOperativeFindings.Text = row["OperativeFindings"] != DBNull.Value ? row["OperativeFindings"].ToString() : "NA";
                tbPostOperativePeriod.Text = row["PostOperativePeriod"] != DBNull.Value ? row["PostOperativePeriod"].ToString() : "NA";
                tbSpecialInvestigationGiven.Text = row["PostSurgeryInvestigationGiven"] != DBNull.Value ? row["PostSurgeryInvestigationGiven"].ToString() : "NA";
                tbStatusAtDischarge.Text = row["StatusAtDischarge"] != DBNull.Value ? row["StatusAtDischarge"].ToString() : "NA";
                tbReview.Text = row["Review"] != DBNull.Value ? row["Review"].ToString() : "NA";
                tbAdvice.Text = row["Advice"] != DBNull.Value ? row["Advice"].ToString() : "NA";
                rbDischarge.Checked = row["IsDischarged"] != DBNull.Value && Convert.ToBoolean(row["IsDischarged"]);
                rbDeath.Checked = row["IsDischarged"] != DBNull.Value && !Convert.ToBoolean(row["IsDischarged"]);
                lbDischargeDate.Text = row["DischargeDate"] != DBNull.Value ? Convert.ToDateTime(row["DischargeDate"]).ToString("dd-MM-yyyy") : "NA";
                lbNextFollowUp.Text = row["NextFollowUpDate"] != DBNull.Value ? Convert.ToDateTime(row["NextFollowUpDate"]).ToString("dd-MM-yyyy") : "NA";
                lbConsultBlockName.Text = row["ConsultAtBlock"] != DBNull.Value ? row["ConsultAtBlock"].ToString() : "NA";
                lbFloor.Text = row["FloorNo"] != DBNull.Value ? row["FloorNo"].ToString() : "NA";
                lbRoomNo.Text = row["RoomNo"] != DBNull.Value ? row["RoomNo"].ToString() : "NA";
                rbIsSpecialCaseYes.Checked = row["IsSpecialCase"] != DBNull.Value && Convert.ToBoolean(row["IsSpecialCase"]);
                rbIsSpecialCaseNo.Checked = row["IsSpecialCase"] != DBNull.Value && !Convert.ToBoolean(row["IsSpecialCase"]);
                if (rbIsSpecialCaseYes.Checked)
                {
                    pnlSpecialCaseValue.Visible = true;
                    lbSpecialCaseValue.Text = row["SpecialCaseValue"].ToString();
                }
                lbFinalDiagnosis.Text = row["FinalDiagnosis"] != DBNull.Value ? row["FinalDiagnosis"].ToString() : "NA";
                rbConsentYes.Checked = row["ProcedureConsent"] != DBNull.Value && Convert.ToBoolean(row["ProcedureConsent"]);
                rbConsentNo.Checked = row["ProcedureConsent"] != DBNull.Value && !Convert.ToBoolean(row["ProcedureConsent"]);
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
            throw;
        }

    }
    private void BindDeductionTypes()
    {
        try
        {
            dropDeductionTypeACO.Items.Clear();
            dropDeductionTypeACO.Items.Add(new ListItem("--Select--", "Select"));
            DataTable dt = aco.GetDeductionTypesForACO(); // Get the DataTable from the GetDeductionTypesForACO method
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    string deductionTypeId = row["DeductionTypeId"].ToString();
                    string deductionType = row["DeductionType"].ToString();

                    // Add items to the DropDownList
                    dropDeductionTypeACO.Items.Add(new ListItem(deductionType, deductionTypeId));
                }
            }
            else
            {
                lblError.Text = "No deduction types found for ACO.";
                lblError.Visible = true;
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
            throw;
        }

    }

    private void BindACORemarks()
    {
        try
        {
            dt.Clear();
            int parsedUserId;
            int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
            //string claimId = Session["ClaimId"].ToString();
            long claimId = Convert.ToInt64(Session["ClaimId"]);
            if (claimId == null)
            {
                lblError.Text = "Claim ID is missing!";
                lblError.Visible = true;
                return;
            }
            dt = aco.GetACORemarksFromSP(claimId, userId);
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                Label8.Text = row["TotalClaims"].ToString();
                //Label9.Text = row["TrustLiable"].ToString();
                //Label10.Text = row["Final Approved Amount"].ToString();
                if (hdRoleId.Value == "9")
                {
                    pnlInsuranceamount.Visible = true;
                    pnlTrustAmount.Visible = false;
                    lbpnlInsuranceAmount.Text = row["InsurerLiable"].ToString();
                    tbFinalAmountByAco.Text = row["InsurerLiable"].ToString();

                }
                else if (hdRoleId.Value == "10")
                {
                    pnlInsuranceamount.Visible = false;
                    pnlTrustAmount.Visible = true;
                    lbpnlTrustAmount.Text = row["TrustLiable"].ToString();
                    tbFinalAmountByAco.Text = row["TrustLiable"].ToString();
                }
            }
            else
            {
                //Label8.Text = "N/A";
                //Label9.Text = "N/A";
                //Label10.Text = "N/A";
                tbFinalAmountByAco.Text = "N/A";
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
            throw;
            throw;
        }

    }
    private void BindClaimWorkflow()
    {
        try
        {
            dt.Clear();
            string claimId = Session["ClaimId"].ToString();
            dt = aco.GetClaimWorkFlow(claimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                dt.Columns.Add("SerialNo", typeof(int));
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SerialNo"] = i + 1;
                }
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
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }

    }
    private void BindTechnicalChecklistData()
    {
        try
        {
            dt.Clear();
            int parsedUserId;
            int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
            string caseNo = Session["CaseNumber"].ToString();
            long claimId = Convert.ToInt64(Session["ClaimId"]);
            //string cardNo = Session["CardNumber"].ToString();

            if (claimId != null)
            {

                dt = aco.GetTechnicalChecklist(claimId);
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    tbTotalClaims.Text = row["TotalClaims"].ToString();
                    if (hdRoleId.Value == "9")
                    {
                        plTechfinalAmountInusure.Visible = true;
                        plTechfinalAmountTrust.Visible = false;
                        lbTechfinalAmountInusure.Text = row["InsurerClaimAmountApproved"].ToString();
                        tbTechRemarks.Text = row["Remarks"].ToString();
                    }
                    else if (hdRoleId.Value == "10")
                    {
                        plTechfinalAmountInusure.Visible = false;
                        plTechfinalAmountTrust.Visible = true;
                        lbTechfinalAmountTrust.Text = row["TrustClaimAmountApproved"].ToString();
                        tbTechRemarks.Text = row["Remarks"].ToString();
                    }
                    //tbInsuranceApprovedAmt.Text = row["InsurerClaimAmountApproved"].ToString();
                    //tbTrustApprovedAmt.Text = row["TrustClaimAmountApproved"].ToString();
                    //rbDiagnosisSupportedYes.Checked = row["DiagnosisSupportedEvidence"] != DBNull.Value && !Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);
                    //rbDiagnosisSupportedNo.Checked = row["DiagnosisSupportedEvidence"] != DBNull.Value && !Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);
                    //rbCaseManagementYes.Checked = row["CaseManagementSTP"] != DBNull.Value && !Convert.ToBoolean(row["CaseManagementSTP"]);
                    //rbCaseManagementNo.Checked = row["CaseManagementSTP"] != DBNull.Value && !Convert.ToBoolean(row["CaseManagementSTP"]);
                    //rbEvidenceTherapyYes.Checked = row["EvidenceTherapyConducted"] != DBNull.Value && !Convert.ToBoolean(row["EvidenceTherapyConducted"]);
                    //rbEvidenceTherapyNo.Checked = row["EvidenceTherapyConducted"] != DBNull.Value && !Convert.ToBoolean(row["EvidenceTherapyConducted"]);
                    //rbMandatoryReportsYes.Checked = row["MandatoryReports"] != DBNull.Value && !Convert.ToBoolean(row["MandatoryReports"]);
                    //rbMandatoryReportsNo.Checked = row["MandatoryReports"] != DBNull.Value && !Convert.ToBoolean(row["MandatoryReports"]);


                    //rbDiagnosisSupportedYes.Checked = Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);
                    //rbCaseManagementYes.Checked = Convert.ToBoolean(row["CaseManagementSTP"]);
                    //rbEvidenceTherapyYes.Checked = Convert.ToBoolean(row["EvidenceTherapyConducted"]);
                    //rbMandatoryReportsYes.Checked = Convert.ToBoolean(row["MandatoryReports"]);

                    rbDiagnosisSupportedYes.Checked = row["DiagnosisSupportedEvidence"] != DBNull.Value && Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);
                    rbDiagnosisSupportedNo.Checked = row["DiagnosisSupportedEvidence"] == DBNull.Value || !Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);

                    rbCaseManagementYes.Checked = row["CaseManagementSTP"] != DBNull.Value && Convert.ToBoolean(row["CaseManagementSTP"]);
                    rbCaseManagementNo.Checked = row["CaseManagementSTP"] == DBNull.Value || !Convert.ToBoolean(row["CaseManagementSTP"]);

                    rbEvidenceTherapyYes.Checked = row["EvidenceTherapyConducted"] != DBNull.Value && Convert.ToBoolean(row["EvidenceTherapyConducted"]);
                    rbEvidenceTherapyNo.Checked = row["EvidenceTherapyConducted"] == DBNull.Value || !Convert.ToBoolean(row["EvidenceTherapyConducted"]);

                    rbMandatoryReportsYes.Checked = row["MandatoryReports"] != DBNull.Value && Convert.ToBoolean(row["MandatoryReports"]);
                    rbMandatoryReportsNo.Checked = row["MandatoryReports"] == DBNull.Value || !Convert.ToBoolean(row["MandatoryReports"]);


                    if (row["IsSpecialCase"] != DBNull.Value)
                    {
                        bool isSpecialCase = Convert.ToBoolean(row["IsSpecialCase"]);
                        tbSpecialCase.Text = isSpecialCase ? "Yes" : "No";
                    }
                    else
                    {
                        tbSpecialCase.Text = string.Empty;
                    }

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
    public void BindNonTechnicalChecklist()
    {
        try
        {
            long claimId = Convert.ToInt64(Session["ClaimId"]);
            DataTable dtNonTechChecklist = aco.GetNonTechnicalChecklist(claimId);

            if (dtNonTechChecklist.Rows.Count > 0)
            {
                DataRow row = dtNonTechChecklist.Rows[0];
                rbIsNameCorrectYes.Checked = row["IsNameCorrect"] != DBNull.Value && Convert.ToBoolean(row["IsNameCorrect"]);
                rbIsNameCorrectNo.Checked = row["IsNameCorrect"] != DBNull.Value && !Convert.ToBoolean(row["IsNameCorrect"]);
                rbIsGenderCorrectYes.Checked = row["IsGenderCorrect"] != DBNull.Value && Convert.ToBoolean(row["IsGenderCorrect"]);
                rbIsGenderCorrectNo.Checked = row["IsGenderCorrect"] != DBNull.Value && !Convert.ToBoolean(row["IsGenderCorrect"]);
                rbIsPhotoVerifiedYes.Checked = row["DoesPhotoMatch"] != DBNull.Value && Convert.ToBoolean(row["DoesPhotoMatch"]);
                rbIsPhotoVerifiedNo.Checked = row["DoesPhotoMatch"] != DBNull.Value && !Convert.ToBoolean(row["DoesPhotoMatch"]);
                rbIsAdmissionDateVerifiedYes.Checked = row["DoesAddDateMatchCS"] != DBNull.Value && Convert.ToBoolean(row["DoesAddDateMatchCS"]);
                rbIsAdmissionDateVerifiedNo.Checked = row["DoesAddDateMatchCS"] != DBNull.Value && !Convert.ToBoolean(row["DoesAddDateMatchCS"]);
                rbIsSurgeryDateVerifiedYes.Checked = row["DoesSurDateMatchCS"] != DBNull.Value && Convert.ToBoolean(row["DoesSurDateMatchCS"]);
                rbIsSurgeryDateVerifiedNo.Checked = row["DoesSurDateMatchCS"] != DBNull.Value && !Convert.ToBoolean(row["DoesSurDateMatchCS"]);
                rbIsDischargeDateCSVerifiedYes.Checked = row["DoesDischDateMatchCS"] != DBNull.Value && Convert.ToBoolean(row["DoesDischDateMatchCS"]);
                rbIsDischargeDateCSVerifiedNo.Checked = row["DoesDischDateMatchCS"] != DBNull.Value && !Convert.ToBoolean(row["DoesDischDateMatchCS"]);
                rbIsSignVerifiedYes.Checked = row["IsPatientSignVerified"] != DBNull.Value && Convert.ToBoolean(row["IsPatientSignVerified"]);
                rbIsSignVerifiedNo.Checked = row["IsPatientSignVerified"] != DBNull.Value && !Convert.ToBoolean(row["IsPatientSignVerified"]);
                rbIsReportCorrectYes.Checked = row["IsReportVerified"] != DBNull.Value && Convert.ToBoolean(row["IsReportVerified"]);
                rbIsReportCorrectNo.Checked = row["IsReportVerified"] != DBNull.Value && !Convert.ToBoolean(row["IsReportVerified"]);
                rbIsReportVerifiedYes.Checked = row["IsDateAndNameCorrect"] != DBNull.Value && Convert.ToBoolean(row["IsDateAndNameCorrect"]);
                rbIsReportVerifiedNo.Checked = row["IsDateAndNameCorrect"] != DBNull.Value && !Convert.ToBoolean(row["IsDateAndNameCorrect"]);
                lbNonTechAdmissionDate.Text = row["AdmissionDateCS"] != DBNull.Value ? Convert.ToDateTime(row["AdmissionDateCS"]).ToString("yyyy-MM-dd") : "";
                lbCSAdmissionDate.Text = row["AdmissionDateCS"] != DBNull.Value ? Convert.ToDateTime(row["AdmissionDateCS"]).ToString("yyyy-MM-dd") : "";
                lbNonTechSurgeryDate.Text = row["SurgeryDateCS"] != DBNull.Value ? Convert.ToDateTime(row["SurgeryDateCS"]).ToString("yyyy-MM-dd") : "";
                lbCSTherepyDate.Text = row["SurgeryDateCS"] != DBNull.Value ? Convert.ToDateTime(row["SurgeryDateCS"]).ToString("yyyy-MM-dd") : "";
                lbNonTechDeathDate.Text = row["DischargeDateCS"] != DBNull.Value ? Convert.ToDateTime(row["DischargeDateCS"]).ToString("yyyy-MM-dd") : "";
                lbCSDischargeDate.Text = row["DischargeDateCS"] != DBNull.Value ? Convert.ToDateTime(row["DischargeDateCS"]).ToString("yyyy-MM-dd") : "";
                tbNonTechFormRemark.Text = row["NonTechChecklistRemarks"] != DBNull.Value ? row["NonTechChecklistRemarks"].ToString() : "";
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error loading data: " + ex.Message;
        }
    }
    public void BindClaimsDetails()
    {
        try
        {
            string caseNo = Session["CaseNumber"].ToString();
            if (string.IsNullOrEmpty(caseNo))
            {
                lbPreauthApprovedAmt.Text = "Case number is missing or invalid.";
                return;
            }
            if (!string.IsNullOrEmpty(caseNo))
            {
                DataTable dtClaimsDetails = cpd.GetClaimsDetails(caseNo);

                if (dtClaimsDetails != null && dtClaimsDetails.Rows.Count > 0)
                {
                    DataRow row = dtClaimsDetails.Rows[0];
                    lbPreauthApprovedAmt.Text = Convert.ToDecimal(row["PreAuthApprovedAmt"]).ToString("C");
                    lbPreauthDate.Text = Convert.ToDateTime(row["PreAuthApprovedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                    lbClaimSubmittedDate.Text = Convert.ToDateTime(row["ClaimSubmittedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                    lbLastClaimUpadted.Text = Convert.ToDateTime(row["ClaimUpdatedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                    lbPenaltyAmt.Text = "NA";
                    lbClaimAmount.Text = Convert.ToDecimal(row["ClaimAmount"]).ToString("C");
                    lbInsuranceLiableAmt.Text = Convert.ToDecimal(row["InsuranceLiableAmt"]).ToString("C");
                    lbTrustLiableAmt.Text = Convert.ToDecimal(row["TrustLiableAmt"]).ToString("C");
                    lbBillAmt.Text = Convert.ToDecimal(row["BillAmt"]).ToString("C");
                    lbFinalErupiAmt.Text = "0";
                    //lbRemark.Text = row["ClaimRemarks"].ToString();
                    string claimId = row["ClaimId"].ToString();
                    Session["ClaimId"] = claimId;

                }
                else
                {
                    lbPreauthApprovedAmt.Text = "No data found for the specified case.";
                }
            }
            else
            {
                lbPreauthApprovedAmt.Text = "Case number is missing.";
            }
        }
        catch (Exception ex)
        {
            lbPreauthApprovedAmt.Text = "Error: " + ex.Message;
        }
    }
    //private void BindICDDetailsGrid()
    //{
    //    // Create a DataTable with the same structure as the GridView columns
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("SNo", typeof(string));
    //    dt.Columns.Add("ICDCode", typeof(string));
    //    dt.Columns.Add("ICDDescription", typeof(string));
    //    dt.Columns.Add("ActedByRole", typeof(string));

    //    // Add rows with "N/A" values
    //    for (int i = 1; i <= 3; i++) // Create 3 placeholder rows
    //    {
    //        DataRow row = dt.NewRow();
    //        row["SNo"] = "N/A";
    //        row["ICDCode"] = "N/A";
    //        row["ICDDescription"] = "N/A";
    //        row["ActedByRole"] = "N/A";
    //        dt.Rows.Add(row);
    //    }

    //    // Bind the DataTable to the GridView
    //    gvICDDetails.DataSource = dt;
    //    gvICDDetails.DataBind();
    //}
    //private void BindActionTypeDropdown()
    //{
    //    try
    //    {
    //        ACOHelper helper = new ACOHelper();
    //        DataTable actionTypes = helper.GetActionTypes();

    //        if (actionTypes != null && actionTypes.Rows.Count > 0)
    //        {
    //            actionType.DataSource = actionTypes;
    //            actionType.DataTextField = "ActionName"; // Display ActionName in the dropdown
    //            actionType.DataValueField = "ActionId";  // Use ActionId as the value
    //            actionType.DataBind();
    //        }

    //        // Add the default "Select Action Type" option
    //        actionType.Items.Insert(0, new ListItem("-- Select Action Type --", ""));
    //    }
    //    catch (Exception ex)
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //        md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //        throw;
    //    }

    //}

    private void LoadPatientDetails(string caseNumber)
    {
        try
        {
            string UserId = Session["UserId"].ToString();

            if (UserId != null)
            {
                long userId;
                if (long.TryParse(Session["UserId"].ToString(), out userId))
                {
                    //using (SqlCommand cmd = new SqlCommand("ACOInsurer_ClaimUpdationDeatilsByCaseNumber", con))
                    using (SqlCommand cmd = new SqlCommand("TMS_ACOInsurer_ClaimUpdationDeatilsByCaseNumberUpdated", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CaseNumber", caseNumber);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mvACSTabs.SetActiveView(ViewClaims);
                                btnPastHistory.CssClass = "btn btn-primary";
                                btnPreauth.CssClass = "btn btn-primary";
                                btnTreatandDischaarge.CssClass = "btn btn-primary";
                                btnACaseSheet.CssClass = "btn btn-primary";
                                lnkClaimTab.CssClass = "btn btn-warning";
                                btnAttachments.CssClass = "btn btn-primary";
                                lbCaseNoHead.Text = caseNumber;
                                lbName.Text = reader["Name"].ToString() ?? "N/A";
                                lbBeneficiaryId.Text = reader["BeneficiaryCardID"].ToString() ?? "N/A";
                                hdAbuaId.Value = reader["BeneficiaryCardID"].ToString().Trim();
                                lbRegNo.Text = reader["RegistrationNo"].ToString() ?? "N/A";
                                hdPatientRegId.Value = reader["RegistrationNo"].ToString() ?? "N/A";
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
                                hdHospitalId.Value = reader["HospitalId"].ToString().Trim();
                                Label17.Text = reader["Gender"].ToString() ?? "N/A";
                                Label18.Text = reader["PatientFamilyId"].ToString() ?? "N/A";
                                Label19.Text = reader["Age"].ToString() ?? "N/A";
                                Label20.Text = reader["IsAadharVerified"].ToString() == "1" ? "Yes" : "No";
                                lbAuthentication.Text = reader["IsBiometricVerified"].ToString() == "1" ? "Yes" : "No";
                                Label21.Text = reader["PatientDistrict"].ToString() ?? "N/A";
                                lbPatientScheme.Text = reader["PatientScheme"].ToString() ?? "N/A";

                                getPatientPrimaryDiagnosis();
                                getPatientSecondaryDiagnosis();
                                //getPatientPrimaryDiagnosis();
                                //getPatientSecondaryDiagnosis();
                                //BindActionTypeDropdown();
                                //BindICDDetailsGrid();
                                BindClaimsDetails();
                                BindNonTechnicalChecklist();
                                BindTechnicalChecklistData();
                                BindClaimWorkflow();
                                BindACORemarks();
                                BindDeductionTypes();
                                getTreatmentDischarge();
                                BindGrid_PrimaryDiagnosis();
                                getClaimQuery(Session["ClaimId"].ToString());
                                bool IfSecondaryDiagnosisPresent = cex.IfSecondaryDiagnosisPresent(hdAbuaId.Value, hdPatientRegId.Value);
                                if (IfSecondaryDiagnosisPresent)
                                {
                                    pClaimsSD.Visible = true;
                                    pPreauthSD.Visible = true;
                                    BindGrid_SecondaryDiagnosis();
                                    BindGrid_ClaimSecondaryDiagnosis();
                                }
                                string patientImageBase64 = Convert.ToString(reader["ImageURL"].ToString());
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
                            }
                            else
                            {
                                lblError.Text = "No details found for the provided Case Number.";
                                lblError.Visible = true;
                            }
                        }
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

    protected void BindGrid_SecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = cex.getSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                gvPraauthSD.DataSource = dt;
                gvPraauthSD.DataBind();
            }
            else
            {
                gvPraauthSD.DataSource = "";
                gvPraauthSD.DataBind();
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
                gvSICDDetails_Claim.DataSource = dt;
                gvSICDDetails_Claim.DataBind();
            }
            else
            {
                gvSICDDetails_Claim.DataSource = "";
                gvSICDDetails_Claim.DataBind();
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
    protected void btnAddDeduction_Click(object sender, EventArgs e)
    {
        try
        {
            decimal finalDeductedAmount = 0;
            if (hdRoleId.Value == "9")
            {
                decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
                //decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
                decimal totalClaimAmount = Convert.ToDecimal(lbpnlInsuranceAmount.Text.ToString().Trim());
                finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;

                if (finalDeductedAmount < 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deduction cannot exceed total claim amount.');", true);
                    return;
                }
                lbFinalAmount.Text = finalDeductedAmount.ToString();

            }
            else if (hdRoleId.Value == "10")
            {
                decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
                //decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
                decimal totalClaimAmount = Convert.ToDecimal(lbpnlTrustAmount.Text.ToString().Trim());
                finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;

                if (finalDeductedAmount < 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deduction cannot exceed total claim amount.');", true);
                    return;
                }
                lbFinalAmount.Text = finalDeductedAmount.ToString();
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
            throw;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            int parsedUserId;
            int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
            string roleName = "";
            roleName = cpd.GetUserRole(userId);
            string caseNo = Session["CaseNumber"].ToString();
            long claimId = Convert.ToInt64(Session["ClaimId"]); // Ensure ClaimId is stored in the session
            string deductionType = dropDeductionTypeACO.SelectedItem.Value;
            //string remarks = txtRemarks.Text.Trim(); // Assuming a textbox for remarks exists
            decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.Trim());
            decimal totalClaimAmount = 0;
            if (hdRoleId.Value == "9")
            {
                totalClaimAmount = Convert.ToDecimal(lbpnlInsuranceAmount.Text.Trim());


            }
            else if (hdRoleId.Value == "10")
            {
                totalClaimAmount = Convert.ToDecimal(lbpnlTrustAmount.Text.Trim());
            }
            decimal finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;
            lbFinalAmount.Text = finalDeductedAmount.ToString();
            if (finalDeductedAmount > 0)
            {
                //aco.SaveDeductionAmount(userId, Convert.ToInt32(Session["RoleId"].ToString()), finalDeductedAmount, totalFinalAmountByAco, claimId, remarks, deductionType);
            }
            // Save the deduction amount to the database
            //long actionId = Convert.ToInt64(actionType.SelectedValue);
            //string selectedQueryReasonId = ddlReason.SelectedValue;
            //string selectedSubQueryReasonId = ddlSubReason.SelectedValue;
            //switch (actionId)
            //{
            //    case 2: // Approve
            //        DoAction(claimId, userId, actionId, " ", "", "", /*remarks,*/ (int)totalFinalAmountByAco);
            //        //string result = cpd.ExecuteTDSCalculation(Convert.ToInt32(claimId));
            //        strMessage = "window.alert('Claim has been approved by ACO. " + caseNo + "'); window.location.href = 'ClaimUpdation.aspx';";
            //        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            //        //Response.Redirect("~/ACO/ClaimUpdation.aspx");
            //        break;
            //    case 5: // Raise Query
            //            //long reasonId = Convert.ToInt64(reasonDropdown.SelectedValue);
            //            //long subReasonId = Convert.ToInt64(subReasonDropdown.SelectedValue);
            //        DoAction(claimId, userId, actionId, /*selectedQueryReasonId, selectedSubQueryReasonId,*/ null, remarks, (int)totalFinalAmountByAco);
            //        strMessage = "window.alert('Query Raised Successfully.'); window.location.href = 'ClaimUpdation.aspx';";
            //        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            //        //Response.Redirect("~/ACO/ClaimUpdation.aspx");
            //        break;
            //    case 6: // Reject
            //        string rejectReasonId = ddlReason.SelectedItem.Value;
            //        DoAction(claimId, userId, actionId, "", "", rejectReasonId, remarks, (int)totalFinalAmountByAco);
            //        strMessage = "window.alert('Case Rejected Successfully.'); window.location.href = 'ClaimUpdation.aspx';";
            //        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            //        //Response.Redirect("~/ACO/ClaimUpdation.aspx");
            //        break;
            //    default:
            //        lblError.Text = "Invalid action selected.";
            //        lblError.Visible = true;
            //        break;
            //}
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
    }
    //protected void DoAction(long claimId, long userId, long actionId, string queryReasonId, string querySubReasonId, string rejectReasonId, string remarks, int? totalFinalAmountByAco)
    //{
    //    try
    //    {
    //        //reasonId = (long?)(selectedReason ?? (object)DBNull.Value) ?? 0;
    //        using (SqlCommand cmd = new SqlCommand("TMS_ACO_InsertActions", con))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@ClaimId", claimId);
    //            cmd.Parameters.AddWithValue("@UserId", userId);
    //            cmd.Parameters.AddWithValue("@ActionId", actionId);
    //            cmd.Parameters.AddWithValue("@ReasonId", queryReasonId ?? (object)DBNull.Value);
    //            //cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ??  (object)DBNull.Value);
    //            cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ?? "");
    //            cmd.Parameters.AddWithValue("@RejectReasonId", rejectReasonId ?? "");
    //            cmd.Parameters.AddWithValue("@Remarks", remarks ?? "");
    //            //cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco ?? "");
    //            // Only add the Amount parameter when actionId is 1 (Approve)
    //            if (totalFinalAmountByAco.HasValue)
    //            {
    //                cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco.Value);
    //            }
    //            else
    //            {
    //                cmd.Parameters.AddWithValue("@Amount", 0); // Or omit this parameter entirely if you prefer
    //            }
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //        }

    //        lblSuccess.Text = "Action processed successfully!";
    //        lblSuccess.Visible = true;
    //        //Response.Redirect("~/ACO/ClaimUpdation.aspx");
    //    }
    //    catch (Exception ex)
    //    {
    //        lblError.Text = "Error processing action: " + ex.Message;
    //        lblError.Visible = true;
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    //private void BindRejectReason()
    //{
    //    try
    //    {
    //        DataTable dt = cpd.GetRejectReason();
    //        ddlReason.DataSource = dt;
    //        ddlReason.DataTextField = "RejectName";
    //        ddlReason.DataValueField = "RejectId";
    //        ddlReason.DataBind();
    //        ddlReason.Items.Insert(0, new ListItem("--Select--", ""));
    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine("Error: " + ex.Message);
    //    }
    //}
    //private void BindQueryReason()
    //{
    //    try
    //    {
    //        DataTable dt = cpd.GetQueryReason();
    //        ddlReason.DataSource = dt;
    //        ddlReason.DataTextField = "ReasonName";
    //        ddlReason.DataValueField = "ReasonId";
    //        ddlReason.DataBind();
    //        ddlReason.Items.Insert(0, new ListItem("--Select--", ""));
    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine("Error: " + ex.Message);
    //    }
    //}
    //private void BindQuerySubReason(string ReasonId)
    //{
    //    try
    //    {
    //        DataTable dt = cpd.GetQuerySubReason(ReasonId);
    //        ddlSubReason.DataSource = dt;
    //        ddlSubReason.DataTextField = "SubReasonName";
    //        ddlSubReason.DataValueField = "SubReasonId";
    //        ddlSubReason.DataBind();
    //        ddlSubReason.Items.Insert(0, new ListItem("--Select--", ""));
    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine("Error: " + ex.Message);
    //    }
    //}
    //protected void ActionType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        pReason.Visible = false;
    //        //pRemarks.Visible = false;
    //        pSubReason.Visible = false;
    //        // Show/hide the remarks TextBox based on selected value
    //        if (actionType.SelectedValue == "2") // Assuming "1" is for "Approve"
    //        {
    //            txtRemarks.Visible = true; // Show remarks section
    //        }
    //        else if (actionType.SelectedValue == "6")
    //        {
    //            pReason.Visible = true;
    //            //pRemarks.Visible = true;
    //            txtRemarks.Visible = true;
    //            BindRejectReason();
    //        }
    //        else if (actionType.SelectedValue == "5")
    //        {
    //            pReason.Visible = true;
    //            pSubReason.Visible = true;
    //            //pRemarks.Visible = true;
    //            txtRemarks.Visible = true;
    //            BindQueryReason();
    //            BindQuerySubReason("1");

    //        }
    //        else
    //        {
    //            txtRemarks.Visible = false; // Hide remarks section
    //            pReason.Visible = false;
    //            pSubReason.Visible = false;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //        md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //        throw;
    //    }
    //}
    //protected void ddlReason_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string selectedValue = ddlReason.SelectedItem.Value;
    //        BindQuerySubReason(selectedValue);
    //    }
    //    catch (Exception ex)
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //        md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //        throw;
    //    }
    //}
    protected void lnkClaimTab_Click(object sender, EventArgs e)
    {
        try
        {
            // Set all panels to visible
            //pnlICDDetails.Visible = true;
            //pnlClaimDetails.Visible=true;
            //pnlNonTechnicalChecklist.Visible = true;
            //pnlTechnicalChecklist.Visible = true;
            //pnlACORemarks.Visible = true;
            //pnlAddDeduction.Visible = true;
            //pnlWorkflow.Visible = true;
            //pnlActionType.Visible = true;

            // Optionally, set focus to the first section (e.g., ICD Details)
            //pnlICDDetails.Focus();
            mvACSTabs.SetActiveView(ViewClaims);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-warning";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
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
            throw;
        }
    }
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewPast);
            btnPastHistory.CssClass = "btn btn-warning";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
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
            throw;
        }
    }
    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewPreauth);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-warning";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
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
            throw;
        }
    }

    protected void btnTreatandDischaarge_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewTreatmentDischarge);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-warning";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
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
            throw;
        }
    }

    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewAttachment);
            MultiView2.SetActiveView(viewPreauthorization);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-warning";
            btnPreauthorization.CssClass = "btn btn-warning";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
            }
            btnDischarge.CssClass = "btn btn-primary";
            //btnDeath.CssClass = "btn btn-primary";
            //btnClaim.CssClass = "btn btn-primary";
            //btnGenInvestigation.CssClass = "btn btn-primary";
            btnSpecialInvestigation.CssClass = "btn btn-primary";
            btnPostIvestigation.CssClass = "btn btn-primary";
            getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
            //btnFraudDoc.CssClass = "btn btn-primary";
            //btnAuditDoc.CssClass = "btn btn-primary";
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
    }

    protected void btnACaseSheet_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewCaseSheet);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-warning";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-primary";
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
            throw;
        }
    }

    protected void btnOncology_Click(object sender, EventArgs e)
    {
        try
        {
            mvACSTabs.SetActiveView(ViewPreauth);
            btnPastHistory.CssClass = "btn btn-primary";
            btnPreauth.CssClass = "btn btn-primary";
            btnTreatandDischaarge.CssClass = "btn btn-primary";
            lnkClaimTab.CssClass = "btn btn-primary";
            btnACaseSheet.CssClass = "btn btn-primary";
            btnAttachments.CssClass = "btn btn-primary";
            if (btnOncology.Visible)
            {
                btnOncology.CssClass = "btn btn-warning";
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
            throw;
        }
    }

    protected void btnPreauthorization_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.SetActiveView(viewPreauthorization);
            btnPreauthorization.CssClass = "btn btn-warning";
            btnDischarge.CssClass = "btn btn-primary";
            //btnDeath.CssClass = "btn btn-primary";
            //btnClaim.CssClass = "btn btn-primary";
            //btnGenInvestigation.CssClass = "btn btn-primary";
            btnSpecialInvestigation.CssClass = "btn btn-primary";
            btnPostIvestigation.CssClass = "btn btn-primary";
            getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
            //btnFraudDoc.CssClass = "btn btn-primary";
            //btnAuditDoc.CssClass = "btn btn-primary";
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
    }

    protected void btnDischarge_Click(object sender, EventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
    }

    protected void btnSpecialInvestigation_Click(object sender, EventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
    }

    protected void btnPostIvestigation_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.SetActiveView(viewPostInvestigation);
            btnPreauthorization.CssClass = "btn btn-primary";
            btnDischarge.CssClass = "btn btn-primary";
            //btnDeath.CssClass = "btn btn-primary";
            //btnClaim.CssClass = "btn btn-primary";
            //btnGenInvestigation.CssClass = "btn btn-primary";
            btnSpecialInvestigation.CssClass = "btn btn-primary";
            btnPostIvestigation.CssClass = "btn btn-warning";
            //btnFraudDoc.CssClass = "btn btn-primary";
            //btnAuditDoc.CssClass = "btn btn-primary";
            getPostInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            throw;
        }
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
    public void getPostInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetPostInvestigationDocuments(HospitalId, hdAbuaId.Value, PatientRegId);
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

    protected void gridSpecialInvestigation_RowDataBound(object sender, GridViewRowEventArgs e)
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
    public void getPreInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cex.GetPreInvestigationDocuments(HospitalId, hdAbuaId.Value, PatientRegId);
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
    protected void gridManditoryDocument_RowDataBound(object sender, GridViewRowEventArgs e)
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
    public void getClaimQuery(string ClaimId)
    {
        try
        {
            string claimId = Session["ClaimId"].ToString();
            DataTable dt = new DataTable();
            dt = ppdHelper.GetClaimQuery(claimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridClaimQuery.DataSource = dt;
                gridClaimQuery.DataBind();
            }
            else
            {
                gridClaimQuery.DataSource = null;
                gridClaimQuery.DataBind();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridClaimQuery_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnClaimViewAudit = (Button)e.Row.FindControl("btnClaimViewAudit");
            Label lbClaimIsQueryReplied = (Label)e.Row.FindControl("lbClaimIsQueryReplied");
            string IsQueryReplied = lbClaimIsQueryReplied.Text.ToString();
            if (IsQueryReplied != null && !IsQueryReplied.Equals("0"))
            {
                btnClaimViewAudit.Text = "View Audit";
                btnClaimViewAudit.Enabled = true;
                btnClaimViewAudit.CssClass = "btn btn-primary btn-sm rounded-pill";
            }
            else
            {
                btnClaimViewAudit.Text = "Query Pending";
                btnClaimViewAudit.Enabled = false;
                btnClaimViewAudit.CssClass = "btn btn-warning btn-sm rounded-pill";
            }
        }
    }

    protected void btnClaimViewAudit_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbClaimMainReason = (Label)row.FindControl("lbClaimMainReason");
            Label lbClaimSubReason = (Label)row.FindControl("lbClaimSubReason");
            Label lbFolderName = (Label)row.FindControl("lbClaimQueryFolderName");
            Label lbFileName = (Label)row.FindControl("lbClaimQueryUploadedFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string DocumentName = lbClaimMainReason.Text.ToString() + " (" + lbClaimSubReason.Text.ToString() + ")";
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
}