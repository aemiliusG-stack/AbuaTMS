using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using CareerPath.DAL;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;
using Antlr.Runtime.Misc;
using System.Collections.Generic;
using iText.IO.Image;
using System.Web.WebPages;
using System.Web.Security;
using AbuaTMS;

public partial class CPD_CPDcaseSearchPatientDetail : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    CPD cpd = new CPD();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    string pageName;
    private PreAuth preAuth = new PreAuth();
    public static PPDHelper ppdHelper = new PPDHelper();


    protected void Page_Load(object sender, EventArgs e)
    {
        pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            string caseNo = Request.QueryString["CaseNo"];
            if (!string.IsNullOrEmpty(caseNo))
            {
                Session["CaseNumber"] = caseNo;
                
                BindPatientName(caseNo);
            }
            else
            {
                lbName.Text = "No CaseNo provided.";
            }
            
        }
    }
    public void BindPatientName(string caseNo)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@CaseNo", caseNo);
            p[0].DbType = DbType.String;
           
            DataSet ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDCaseSearchPatientDetails", p);
            if (con.State == ConnectionState.Open)
                con.Close();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt != null)
                {
                    mvCPDTabs.SetActiveView(ViewClaims);
                    btnAttachments.CssClass = "btn btn-primary ";
                    btnPreauth.CssClass = "btn btn-primary ";
                    btnPastHistory.CssClass = "btn btn-primary ";
                    btnTreatment.CssClass = "btn btn-primary ";
                    btnClaims.CssClass = "btn btn-warning";
                    btnCaseSheet.CssClass = "btn btn-primary ";
                    btnQuestionnaire.CssClass = "btn btn-primary";
                    DateTime registrationDate = Convert.ToDateTime(dt.Rows[0]["RegDate"].ToString().Trim());
                    DateTime admissionDate = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"].ToString().Trim());
                    Session["AdmissionId"] = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    Session["ClaimId"] = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString().Trim();
                    hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    hdHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
                    lbName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                    lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                    string cardNo = dt.Rows[0]["CardNumber"].ToString();
                    Session["CardNumber"] = cardNo;
                    lbRegNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbCaseNo.Text = "Case No: " + dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    Session["CaseNumber"] = caseNo;
                    lbCaseNo.Text = caseNo;
                    lbActualRegDate.Text = registrationDate.ToString("dd-MM-yyyy");
                    lbContactNo.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();
                    lbGender.Text = string.IsNullOrEmpty(dt.Rows[0]["Gender"].ToString().Trim()) ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                    lbFamilyId.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                    lbIsChild.Text = dt.Rows[0]["IsChild"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbBiometricVerified.Text = dt.Rows[0]["IsBiometricVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbPatientDistrict.Text = dt.Rows[0]["District"].ToString().Trim();
                    lbAge.Text = dt.Rows[0]["Age"].ToString().Trim();
                    tbHospitalName.Text = dt.Rows[0]["HospitalName"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();

                    MultiViewMain.ActiveViewIndex = 0;
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";

                    base64String = cpd.DisplayImage(folderName, imageFileName);
                    if (!string.IsNullOrEmpty(base64String))
                    {
                        imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                    else
                    {
                        imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";
                    }
                    if (cpd.IsCaseNumberExists(caseNo))
                    {
                        pnlAddDeduction.Visible = true;
                    }
                    else
                    {
                        pnlAddDeduction.Visible = false;
                    }
                    displayPatientAdmissionImage();
                    BindGrid_PICDDetails_Claims();
                    getNetworkHospitalDetails();
                    BindClaimsDetails();
                    BindTechnicalChecklistData();
                    BindGrid_ICDDetails_Preauth();
                    BindGrid_TreatmentProtocol();
                    BindGrid_ICHIDetails();
                    BindPreauthAdmissionDetails();
                    BindClaimWorkflow();
                    getPatientPrimaryDiagnosis();
                    getPatientSecondaryDiagnosis();
                    getTreatmentDischarge();
                    BindNonTechnicalChecklist(caseNo);
                    BindDeductionGrid();
                    gvQuestionnaire.DataSource = CreateQuestionnaireData();
                    gvQuestionnaire.DataBind();
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
    public void displayPatientAdmissionImage()
    {
        try
        {
            dt.Clear();
            dt = cpd.GetManditoryDocument(hdAbuaId.Value.ToString());
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


    //Claims Updation
    private void BindGrid_PICDDetails_Claims()
    {
        string cardNo = Session["CardNumber"] as string;
        int patientRedgNo = Session["PatientRegId"] != null ? Convert.ToInt32(Session["PatientRegId"]) : 0;

        dt.Clear();
        dt = cpd.GetPICDDetails(cardNo, patientRedgNo);

        if (dt != null && dt.Rows.Count > 0)
        {
            gvPICDDetails_Claim.DataSource = dt;
            gvPICDDetails_Claim.DataBind();
        }
        else
        {
            gvPICDDetails_Claim.DataSource = null;
            gvPICDDetails_Claim.EmptyDataText = "No ICD details found.";
            gvPICDDetails_Claim.DataBind();
        }
    }
    public void BindNonTechnicalChecklist(string caseNo)
    {
        try
        {
            DataTable dtNonTechChecklist = cpd.GetNonTechnicalChecklist(caseNo);

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
            lblMessage.Text = "Error loading data: " + ex.Message;
        }
    }
    private void BindDeductionGrid()
    {
        string CaseNo = Session["CaseNumber"] as string;
        DataTable dtDeduction = cpd.GetAddDeduction_CaseSearch(CaseNo);

        gvDeduction.DataSource = dtDeduction;
        gvDeduction.DataBind();
    }
    //public void CheckCaseNumberAndBindData(string CaseNo)
    //{
    //    try
    //    {
    //        if (!string.IsNullOrEmpty(CaseNo))
    //        {
    //            if (cpd.IsCaseNumberExists(CaseNo))
    //            {
    //                divAddDeduction.Visible = true; 
    //            }
    //            else
    //            {
    //                divAddDeduction.Visible = false; 
    //            }
    //            BindPatientName(CaseNo);
    //        }
    //        else
    //        {
    //            divAddDeduction.Visible = false; 
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine("Error: " + ex.Message);
    //        md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //    }
    //}
    //Preauthorization
    private void getNetworkHospitalDetails()
    {
        string caseNo = Session["CaseNumber"] as string;
        dt.Clear();
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
    private void BindPreauthAdmissionDetails()
    {
        string caseNo = Session["CaseNumber"] as string;
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

    private void BindGrid_ICHIDetails()
    {
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
    protected void btnTransactionDataReferences_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Transaction Data References";
        //MultiView3.SetActiveView(viewEnhancement);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPast);
        btnAttachments.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-warning ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPreauth);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-warning";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-warning";
        btnCaseSheet.CssClass = "btn btn-primary ";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    //protected void btnAttachments_Click(object sender, EventArgs e)
    //{
    //    mvCPDTabs.SetActiveView(ViewAttachment);
    //    btnAttachments.CssClass = "btn btn-warning ";
    //    btnPreauth.CssClass = "btn btn-primary ";
    //    btnPastHistory.CssClass = "btn btn-primary ";
    //    btnTreatment.CssClass = "btn btn-primary ";
    //    btnClaims.CssClass = "btn btn-primary ";
    //    btnCaseSheet.CssClass = "btn btn-primary ";
    //    btnQuestionnaire.CssClass = "btn btn-primary";

    //}

    protected void btnCaseSheet_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewCaseSheet);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnCaseSheet.CssClass = "btn btn-warning ";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    protected void btnQuestionnaire_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewQuestionnaire);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnQuestionnaire.CssClass = "btn btn-warning";
        btnCaseSheet.CssClass = "btn btn-primary ";
    }
    public void BindClaimsDetails()
    {
        try
        {
            string caseNo = Session["CaseNumber"].ToString();
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
                    lbBillAmt.Text = Convert.ToDecimal(row["BillAmt"]).ToString("C");
                    lbFinalErupiAmt.Text = "0";
                    lbRemark.Text = row["ClaimRemarks"].ToString();
                    string claimId = row["ClaimId"].ToString();
                    Session["ClaimId"] = claimId;
                    if (Session["RoleId"].ToString() == "7")
                    {
                        lbRoleStatus.Text = "Insurance Liable Amount:";
                        tbAmountLiable.Text = Convert.ToDecimal(row["InsuranceLiableAmt"]).ToString("C");
                    }
                    else if (Session["RoleId"].ToString() == "8")
                    {
                        lbRoleStatus.Text = "Trust Liable Amount:";
                        tbAmountLiable.Text = Convert.ToDecimal(row["TrustLiableAmt"]).ToString("C");
                    }

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
    private void BindTechnicalChecklistData()
    {
        dt.Clear();
        string caseNo = Session["CaseNumber"].ToString();
        string cardNo = Session["CardNumber"].ToString();
        if (!string.IsNullOrEmpty(caseNo))
        {
            dt = cpd.GetTechnicalChecklist(caseNo);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                tbTotalClaims.Text = row["TotalClaims"].ToString();
                tbInsuranceApprovedAmt.Text = row["InsurerClaimAmountRequested"].ToString();
                tbTrustApprovedAmt.Text = row["TrustClaimAmountRequested"].ToString();
                hfInsurerApprovedAmount.Value = row["InsurerClaimAmountRequested"].ToString();
                hfTrustApprovedAmount.Value = row["TrustClaimAmountRequested"].ToString();
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
    private void BindClaimWorkflow()
    {
        dt.Clear();
        string claimId = Session["ClaimId"].ToString();
        dt = cpd.GetClaimWorkFlow(Convert.ToInt32(claimId));
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
    protected void getPatientPrimaryDiagnosis()
    {
        try
        {
            string caseNo = Session["CaseNumber"] as string;
            if (!string.IsNullOrEmpty(caseNo))
            {
                dt.Clear();
                dt = cpd.GetPatientPrimaryDiagnosis(caseNo);
                if (dt.Rows.Count > 0)
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
            string CardNo = Session["CardNumber"] as string;
            
            dt = cpd.GetPatientSecondaryDiagnosis_CaseSearch(CardNo);
            if (dt.Rows.Count > 0)
            {
                gvSICDDetails_Claim.DataSource = dt;
                gvSICDDetails_Claim.DataBind();
            }
            else
            {
                gvSICDDetails_Claim.DataSource = "NA";
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
    public void getClaimQuery(string ClaimId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetClaimQuery(ClaimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridClaimQueryRejectionReason.DataSource = dt;
                gridClaimQueryRejectionReason.DataBind();
            }
            else
            {
                gridClaimQueryRejectionReason.DataSource = "";
                gridClaimQueryRejectionReason.DataBind();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    //Treatment and Discharge tab
    private void getTreatmentDischarge()
    {
        string claimId = Session["ClaimId"] as string;
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
            lbFinalDiagnosis.Text = row["FinalDiagnosis"] != DBNull.Value ? row["FinalDiagnosis"].ToString() : "NA";
            rbConsentYes.Checked = row["ProcedureConsent"] != DBNull.Value && Convert.ToBoolean(row["ProcedureConsent"]);
            rbConsentNo.Checked = row["ProcedureConsent"] != DBNull.Value && !Convert.ToBoolean(row["ProcedureConsent"]);
        }
    }

    //Attachments
    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        btnQuestionnaire.CssClass = "btn btn-primary";
        lnkPreauthorization.CssClass = "btn btn-warning";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }

    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        lnkPreauthorization.CssClass = "btn btn-warning";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "hideModal();", true);
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }


    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewSpecialInvestigation);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        lnkSpecialInvestigation.CssClass = "btn btn-warning";
        lnkPreauthorization.CssClass = "btn btn-primary";
        getPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }

    public void getManditoryDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetManditoryDocuments(HospitalId, PatientRegId);
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
    public void getPreInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetPreInvestigationDocuments(HospitalId, CardNumber, PatientRegId);
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
            mvCPDTabs.SetActiveView(ViewAttachment);
            MultiView2.SetActiveView(viewSpecialInvestigation);
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
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
            mvCPDTabs.SetActiveView(ViewAttachment);
            MultiView2.SetActiveView(viewPreauthorization);
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
            DataTable dt = new DataTable();
            List<string> images = new List<string>();
            dt = ppdHelper.GetPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
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
                if (images.Count > 0)
                {
                    byte[] pdfBytes = ppdHelper.CreatePdfWithImagesInMemory(images);
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=merged.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    //Questionnaire
    private DataTable CreateQuestionnaireData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Question", typeof(string)); // Column for questions

        // Add sample questions
        dt.Rows.Add("Investigation reports (if done) submitted?");
        dt.Rows.Add("Are the detailed procedure notes with indication available (optional)?");
        dt.Rows.Add("Is the Discharge summary with follow-up advice at the time of discharge?");

        return dt;
    }
}