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

public partial class CPD_CPDClaimUpdation : System.Web.UI.Page
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
        pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            string caseNo = Session["CaseNumber"] as string;
            string cardNo = Session["CardNumber"] as string;
            string claimId = Session["ClaimId"] as string;
            string patientRedgNo = Session["PatientRegId"] as string;

            BindPatientName();


        }
    }

    //[System.Web.Services.WebMethod]
    //public static void HandleWindowClose()
    //{
    //    var session = HttpContext.Current.Session;
    //    CPD cpd = new CPD();
    //    if (session["CaseNumber"] != null)
    //    {
    //        int affectedRows = cpd.TransferCase(session["CaseNumber"].ToString());
    //    }
    //    HttpContext.Current.Response.Redirect(System.Web.VirtualPathUtility.ToAbsolute("~/Unauthorize.aspx"));
    //}

    private void BindPatientName()
    {
        try
        {
            string UserId = Session["UserId"].ToString();
            if (UserId != null)
            {
                long userId;
                if (long.TryParse(Session["UserId"].ToString(), out userId))
                {
                    SqlParameter[] parameters = new SqlParameter[]
                    {
                    new SqlParameter("@UserId", userId)
                    };
                    ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDClaimPatientDetails", parameters);
                    if (con.State == ConnectionState.Open)
                        con.Close();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        mvCPDTabs.SetActiveView(ViewClaims);
                        btnAttachments.CssClass = "btn btn-primary ";
                        btnPreauth.CssClass = "btn btn-primary ";
                        btnPastHistory.CssClass = "btn btn-primary ";
                        btnTreatment.CssClass = "btn btn-primary ";
                        btnClaims.CssClass = "btn btn-warning";
                        dt = ds.Tables[0];
                        string claimId = dt.Rows[0]["ClaimId"].ToString();
                        Session["ClaimId"] = claimId;
                        lbCaseNoHead.Text = dt.Rows[0]["CaseNumber"].ToString();
                        lbName.Text = dt.Rows[0]["PatientName"].ToString();
                        lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString();
                        hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString();
                        string cardNo = dt.Rows[0]["CardNumber"].ToString();
                        Session["CardNumber"] = cardNo;
                        lbRegNo.Text = dt.Rows[0]["PatientRegId"].ToString();
                        hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString();
                        string patientRedgNo = dt.Rows[0]["PatientRegId"].ToString();
                        Session["PatientRegId"] = patientRedgNo;
                        string caseNo = dt.Rows[0]["CaseNumber"].ToString();
                        Session["CaseNumber"] = caseNo;
                        lbCaseNo.Text = caseNo;
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
                        hdHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
                        hfAdmissionId.Value = dt.Rows[0]["AdmissionId"].ToString();
                        if (!string.IsNullOrEmpty(dt.Rows[0]["RegDate"].ToString()))
                        {
                            lbActualRegDate.Text = Convert.ToDateTime(dt.Rows[0]["RegDate"]).ToString("dd/MM/yyyy hh:mm tt");
                        }
                        else
                        {
                            lbActualRegDate.Text = "N/A";
                        }
                        MultiViewMain.ActiveViewIndex = 0;
                        string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                        string folderName = hdAbuaId.Value;
                        string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                        string base64String = "";

                        base64String = cpd.DisplayImage(folderName, imageFileName);
                        if (base64String != "")
                        {
                            imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                            //imgPatientPhotosecond.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }

                        else
                        {
                            imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";
                            //imgPatientPhotosecond.ImageUrl = "~/img/profile.jpeg";
                        }
                        displayPatientAdmissionImage();
                        BindGrid_ICDDetails_Preauth();
                        BindGrid_TreatmentProtocol();
                        BindGrid_ICHIDetails();
                        BindGrid_PreauthWorkFlow();
                        BindGrid_PICDDetails_Claims();
                        BindGrid_SICDDetails_Claims();
                        BindTechnicalChecklistData();
                        BindClaimWorkflow();
                        getPrimaryDiagnosis();
                        getSecondaryDiagnosis();
                        getPatientPrimaryDiagnosis();
                        getPatientSecondaryDiagnosis();
                        BindPreauthAdmissionDetails();
                        BindClaimsDetails();
                        getNetworkHospitalDetails();
                        BindActionType();
                        BindNonTechnicalChecklist(caseNo);
                        getTreatmentDischarge();

                    }
                    else
                    {
                        lbName.Text = "No data found.";
                        ClearLabels();
                        //multiViewRecords.ActiveViewIndex = 1;
                        MultiViewMain.ActiveViewIndex = 1;
                    }
                }
            }
            else
            {
                lbName.Text = "User ID not found in session.";
                ClearLabels();
                MultiViewMain.ActiveViewIndex = 1;
            }
        }
        catch (Exception ex)
        {
            lbName.Text = "Error: " + ex.Message;
            ClearLabels();
            MultiViewMain.ActiveViewIndex = 1;
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
        tbTotalClaims.Text = "";
        tbInsuranceApprovedAmt.Text = "";
        tbTrustApprovedAmt.Text = "";
        tbSpecialCase.Text = "";
       

    }


    //Preauthorization Tab
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
    //private void BindGrid_ICDDetails_Preauth()
    //{
    //    dt.Clear();
    //    dt = cpd.GetICDDetails();
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        gvICDDetails_Preauth.DataSource = dt;
    //        gvICDDetails_Preauth.DataBind();
    //    }
    //    else
    //    {
    //        gvICDDetails_Preauth.DataSource = null;
    //        gvICDDetails_Preauth.EmptyDataText = "No ICD details found.";
    //        gvICDDetails_Preauth.DataBind();
    //    }
    //}
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

    private void BindGrid_ICHIDetails()
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
    //private void BindGrid_PreauthWorkFlow()
    //{
    //    dt.Clear();
    //    dt = cpd.GetClaimWorkFlow(caseNo);
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        gvPreauthWorkFlow.DataSource = dt;
    //        gvPreauthWorkFlow.DataBind();
    //    }
    //    else
    //    {
    //        gvPreauthWorkFlow.DataSource = null;
    //        gvPreauthWorkFlow.EmptyDataText = "No record found.";
    //        gvPreauthWorkFlow.DataBind();
    //    }
    //}
    private void BindGrid_PreauthWorkFlow()
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
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPast);
        btnAttachments.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-warning ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewPreauth);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-warning";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
    }
    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        btnAttachments.CssClass = "btn btn-primary ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-warning";
    }
    //Claims Updation Tab
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
    private void BindGrid_SICDDetails_Claims()
    {
        string cardNo = Session["CardNumber"] as string;
        int patientRedgNo = Session["PatientRegId"] != null ? Convert.ToInt32(Session["PatientRegId"]) : 0;

        dt.Clear();
        dt = cpd.GetSICDDetails(cardNo, patientRedgNo);

        if (dt != null && dt.Rows.Count > 0)
        {
            gvSICDDetails_Claim.DataSource = dt;
            gvSICDDetails_Claim.DataBind();
        }
        else
        {
            gvSICDDetails_Claim.DataSource = null;
            gvSICDDetails_Claim.EmptyDataText = "No ICD details found.";
            gvSICDDetails_Claim.DataBind();
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
                tbInsuranceApprovedAmt.Text = row["InsurerClaimAmountApproved"].ToString();
                tbTrustApprovedAmt.Text = row["TrustClaimAmountApproved"].ToString();
                hfInsurerApprovedAmount.Value = row["InsurerClaimAmountApproved"].ToString();
                hfTrustApprovedAmount.Value = row["TrustClaimAmountApproved"].ToString();
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
    protected void AddDeduction_Click(object sender, EventArgs e)
    {
        try
        {
            decimal totalClaims = 0, deductionAmount = 0, totalDeductionAmount = 0;
            string roleName = cpd.GetUserRole(Convert.ToInt32(Session["UserId"].ToString()));
            if (roleName == "CPD(INSURER)")
            {
                totalClaims = Convert.ToDecimal(hfInsurerApprovedAmount.Value.ToString());
                deductionAmount = Convert.ToDecimal(tbAmount.Text.ToString());
                if (deductionAmount > totalClaims)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deduction cannot exceed total claims');", true);
                    return;
                }
                totalDeductionAmount = totalClaims - deductionAmount;
                tbTotalDeductionAmt.Text = totalDeductionAmount.ToString();
            }
            else if (roleName == "CPD(TRUST)")
            {
                totalClaims = Convert.ToDecimal(hfTrustApprovedAmount.Value.ToString());
                deductionAmount = Convert.ToDecimal(tbAmount.Text.ToString());
                if (deductionAmount > totalClaims)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deduction cannot exceed total claims');", true);
                    return;
                }
                totalDeductionAmount = totalClaims - deductionAmount;
                tbTotalDeductionAmt.Text = totalDeductionAmount.ToString();
            }
            hfDeductedAmount.Value = deductionAmount.ToString();
            hfFinalAmount.Value = totalDeductionAmount.ToString();
        }
        catch (Exception ex)
        {
            
        }
    }
    private void BindClaimWorkflow()
    {
        dt.Clear();
        string claimId = Session["ClaimId"].ToString();
        dt = cpd.GetClaimWorkFlow(claimId);
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
    private void BindActionType()
    {
        try
        {
            DataTable dt = cpd.GetActionType();
            ddlActionType.DataSource = dt;
            ddlActionType.DataTextField = "ActionName";
            ddlActionType.DataValueField = "ActionId";
            ddlActionType.DataBind();
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
        ddlActionType.Items.Insert(0, new ListItem("--Select--", ""));
    }
    private void BindRejectReason()
    {
        try
        {
            DataTable dt = cpd.GetRejectReason();
            ddlReason.DataSource = dt;
            ddlReason.DataTextField = "RejectName";
            ddlReason.DataValueField = "RejectId";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, new ListItem("--Select--", ""));
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
    private void BindQueryReason()
    {
        try
        {
            DataTable dt = cpd.GetQueryReason();
            ddlReason.DataSource = dt;
            ddlReason.DataTextField = "ReasonName";
            ddlReason.DataValueField = "ReasonId";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, new ListItem("--Select--", ""));
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
    private void BindQuerySubReason(string ReasonId)
    {
        try
        {
            DataTable dt = cpd.GetQuerySubReason(ReasonId);
            ddlSubReason.DataSource = dt;
            ddlSubReason.DataTextField = "SubReasonName";
            ddlSubReason.DataValueField = "SubReasonId";
            ddlSubReason.DataBind();
            ddlSubReason.Items.Insert(0, new ListItem("--Select--", ""));
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
    public void getForwardUsers()
    {
        DataTable dt = new DataTable();
        dt = cpd.GetUsersByRole(Session["RoleId"].ToString(), Session["UserId"].ToString());
        if (dt != null && dt.Rows.Count > 0)
        {
            ddlUserToAssign.Items.Clear();
            ddlUserToAssign.DataValueField = "UserId";
            ddlUserToAssign.DataTextField = "FullName";
            ddlUserToAssign.DataSource = dt;
            ddlUserToAssign.DataBind();
            ddlUserToAssign.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        else
        {
            ddlUserToAssign.Items.Clear();
            ddlUserToAssign.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }
    private void BindTriggerType()
    {
        try
        {
            DataTable dt = cpd.GetTriggerType();
            ddTriggerType.DataSource = dt;
            ddTriggerType.DataTextField = "TriggerType";
            ddTriggerType.DataValueField = "Id";
            ddTriggerType.DataBind();
            ddTriggerType.Items.Insert(0, new ListItem("--Select--", ""));
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
    protected void ddlReason_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedValue = ddlReason.SelectedItem.Value;
        BindQuerySubReason(selectedValue);
    }
    protected void ddlActionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        pUserRole.Visible = false;
        pReason.Visible = false;
        pRemarks.Visible = false;
        pSubReason.Visible = false;
        pUserRole.Visible = false;
        pUserToAssign.Visible = false;

        if (ddlActionType.SelectedValue == "5")
        {
            pReason.Visible = true;
            pRemarks.Visible = true;
            BindRejectReason();
        }
        else if (ddlActionType.SelectedValue == "2")
        {
            pUserRole.Visible = true;
            pUserToAssign.Visible = true;
            getForwardUsers();
        }
        else if (ddlActionType.SelectedValue == "3")
        {
            pTriggerType.Visible = true;
            BindTriggerType();
        }
        else if (ddlActionType.SelectedValue == "4")
        {
            pReason.Visible = true;
            pSubReason.Visible = true;
            pRemarks.Visible = true;
            BindQueryReason();
            BindQuerySubReason("1");

        }
        else
        {
            pReason.Visible = false;
            pSubReason.Visible = false;
            pRemarks.Visible = false;
            pUserRole.Visible = false;
            pUserToAssign.Visible = false;
            pTriggerType.Visible = false;


        }
    }
    protected void getPrimaryDiagnosis()
    {
        try
        {
            string caseNo = Session["CaseNumber"] as string;
            dt.Clear();
            dt = cpd.getPrimaryDiagnosis(caseNo);
            if (dt.Rows.Count > 0)
            {
                dropPrimaryDiagnosis.Items.Clear();
                dropPrimaryDiagnosis.DataValueField = "PDId";
                dropPrimaryDiagnosis.DataTextField = "PrimaryDiagnosisName";
                dropPrimaryDiagnosis.DataSource = dt;
                dropPrimaryDiagnosis.DataBind();
                dropPrimaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropPrimaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
                dropPrimaryDiagnosis.Items.Clear();
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
    protected void dropPrimaryDiagnosis_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            string patientRedgNo = Session["PatientRegId"] as string;
            string caseNo = Session["CaseNumber"] as string;
            string cardNo = Session["CardNumber"] as string;

            SqlParameter[] p = new SqlParameter[5];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PDId", dropPrimaryDiagnosis.SelectedValue);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@ICDValue", "Test");
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[4].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertPrimaryDiagnosis", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            getPrimaryDiagnosis();
            getSecondaryDiagnosis();
            getPatientPrimaryDiagnosis();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            strMessage = "window.alert('Already Added!');";
            //ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }
    protected void dropSecondaryDiagnosis_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string patientRedgNo = Session["PatientRegId"] as string;
            string caseNo = Session["CaseNumber"] as string;
            string cardNo = Session["CardNumber"] as string;

            SqlParameter[] p = new SqlParameter[5];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PDId", dropSecondaryDiagnosis.SelectedValue);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@ICDValue", "Test");
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[4].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertSecondaryDiagnosis", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            getPrimaryDiagnosis();
            getSecondaryDiagnosis();
            getPatientSecondaryDiagnosis();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            strMessage = "window.alert('Already Added!');";
            //ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }

    protected void getSecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            string caseNo = Session["CaseNumber"] as string;

            dt = cpd.getSecondaryDiagnosis(caseNo);
            if (dt.Rows.Count > 0)
            {
                dropSecondaryDiagnosis.Items.Clear();
                dropSecondaryDiagnosis.DataValueField = "PDId";
                dropSecondaryDiagnosis.DataTextField = "PrimaryDiagnosisName";
                dropSecondaryDiagnosis.DataSource = dt;
                dropSecondaryDiagnosis.DataBind();
                dropSecondaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropSecondaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
                dropSecondaryDiagnosis.Items.Clear();
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
            string caseNo = Session["CaseNumber"] as string;
            if (!string.IsNullOrEmpty(caseNo))
            {
                dt.Clear();
                dt = cpd.GetPatientPrimaryDiagnosis(caseNo);
                if (dt.Rows.Count > 0)
                {
                    gridPrimaryDiagnosis.DataSource = dt;
                    gridPrimaryDiagnosis.DataBind();
                }
                else
                {
                    gridPrimaryDiagnosis.DataSource = null;
                    gridPrimaryDiagnosis.DataBind();
                }
            }
            else
            {
                gridPrimaryDiagnosis.DataSource = null;
                gridPrimaryDiagnosis.DataBind();
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
            string caseNo = Session["CaseNumber"] as string;
            dt = cpd.GetPatientSecondaryDiagnosis(caseNo);
            if (dt.Rows.Count > 0)
            {
                gridSecondaryDiagnosis.DataSource = dt;
                gridSecondaryDiagnosis.DataBind();
            }
            else
            {
                gridSecondaryDiagnosis.DataSource = "";
                gridSecondaryDiagnosis.DataBind();
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
    protected void lnkDeletePrimaryDiagnosis_Click(object sender, EventArgs e)
    {
        try
        {
            string caseNo = Session["CaseNumber"] as string ?? Request.QueryString["CaseNumber"];
            LinkButton lnkButton = (LinkButton)sender;
            int PDId = Convert.ToInt32(lnkButton.CommandArgument);
            if (!string.IsNullOrEmpty(caseNo) && PDId > 0)
            {
                int rowsAffected = cpd.DeletePrimaryDiagnosis(caseNo, PDId);
                if (rowsAffected > 0)
                {
                    getPatientPrimaryDiagnosis();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No diagnosis found to delete.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid CaseNo or PDId.');", true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred while deleting the diagnosis.');", true);
        }
    }
    protected void lnkDeleteSecondaryDiagnosis_Click(object sender, EventArgs e)
    {
        try
        {
            string caseNo = Session["CaseNumber"] as string ?? Request.QueryString["CaseNumber"];
            LinkButton lnkButton = (LinkButton)sender;
            int pdId;
            bool isNumeric = int.TryParse(lnkButton.CommandArgument, out pdId);
            if (!string.IsNullOrEmpty(caseNo) && isNumeric && pdId > 0)
            {
                int rowsAffected = cpd.DeleteSecondaryDiagnosis(caseNo, pdId);
                if (rowsAffected > 0)
                {
                    getPatientSecondaryDiagnosis();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No diagnosis found to delete.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid CaseNo or PDId.');", true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred while deleting the diagnosis.');", true);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string caseNo = Session["CaseNumber"] as string;
        string cardNo = Session["CardNumber"] as string;
        if (!cbTerms.Checked)
        {
            strMessage = "window.alert('Please confirm that you have validated all documents before making any decisions by checking the box.');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        }
        else
        {
            string selectedValue = ddlActionType.SelectedItem.Value;
            if (!hfDeductedAmount.Value.IsEmpty() && !hfFinalAmount.Value.IsEmpty())
            {
                decimal deductedAmount = Convert.ToDecimal(hfDeductedAmount.Value.ToString());
                decimal finalAmount = Convert.ToDecimal(hfFinalAmount.Value.ToString());
                cpd.InsertDeductionAndUpdateClaimMaster(Convert.ToInt32(Session["UserId"].ToString()), dropDeductionType.SelectedItem.Value, deductedAmount, finalAmount, caseNo, tbDedRemarks.Text);
            }
            if (selectedValue.Equals("0"))
            {
                strMessage = "window.alert('Case action is required.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else
            {
                if (selectedValue.Equals("1"))
                {
                    doAction(Session["claimId"].ToString(), Session["UserId"].ToString(), "", "", selectedValue, "", "", "", tbRejectRemarks.Text.ToString() + "");
                    bool specialCase = tbSpecialCase.Text == "Yes";
                    bool diagnosisSupported = rbDiagnosisSupportedYes.Checked;
                    bool caseManagementSTP = rbCaseManagementYes.Checked;
                    bool evidenceTherapyConducted = rbEvidenceTherapyYes.Checked;
                    bool mandatoryReports = rbMandatoryReportsYes.Checked;
                    string remarks = tbTechRemarks.Text.Trim();
                    if (!cpd.CheckCaseNumberExists(caseNo))
                    {
                        cpd.InsertTechnicalChecklist(caseNo, cardNo, diagnosisSupported, caseManagementSTP, evidenceTherapyConducted, mandatoryReports, remarks);
                    }
                    else
                    {
                        lblMessage.Text = "The case number already exists in the checklist.";
                    }
                }
                else if (selectedValue.Equals("2"))
                {
                    string selectedUserId = ddlUserToAssign.SelectedItem.Value;
                    string selectedUserName = ddlUserToAssign.SelectedItem.Text;
                    if (selectedUserId.Equals("0"))
                    {
                        strMessage = "window.alert('Please select user to assign this case.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        doAction(Session["claimId"].ToString(), Session["UserId"].ToString(), selectedUserId, selectedUserName, selectedValue, "", "", "", tbRejectRemarks.Text.ToString() + "");
                    }
                }
                else if (selectedValue.Equals("4"))
                {

                }
                else if (selectedValue.Equals("5"))
                {
                    string selectedRejectReason = ddlReason.SelectedItem.Value;
                    if (selectedRejectReason.Equals("0"))
                    {
                        strMessage = "window.alert('Please select reject reason.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        doAction(Session["claimId"].ToString(), Session["UserId"].ToString(), "", "", selectedValue, "", "", ddlReason.SelectedItem.Text.ToString(), tbRejectRemarks.Text.ToString() + "");
                    }
                }
            }
        }
    }
    public void doAction(string ClaimId, string UserId, string ForwardedToId, string ForwardedToUser, string ActionId, string ReasonId, string SubReasonId, string RejectReason, string Remarks)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[8];
            p[0] = new SqlParameter("@ClaimId", ClaimId);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@UserId", UserId);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@ForwardedToId", ForwardedToId);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@ActionId", ActionId);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@ReasonId", ReasonId);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@SubReasonId", SubReasonId);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@RejectReason", RejectReason);
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@Remarks", Remarks);
            p[7].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDInsertActions", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ActionId.Equals("1"))
            {
                if (Session["RoleId"].ToString() == "7")
                {
                    strMessage = "window.alert('Claim has been approved by CPD(Insurer). " + caseNo + "');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else if (Session["RoleId"].ToString() == "8")
                {
                    strMessage = "window.alert('Claim has been approved by CPD(Trust). " + caseNo + "');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                BindPatientName();
            }
            else if (ActionId.Equals("2"))
            {
                strMessage = "window.alert('Case Successfully Forwarded To " + ForwardedToUser + "');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                BindPatientName();
            }
            else if (ActionId.Equals("4"))
            {
                strMessage = "window.alert('Query Raised Successfully.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                getClaimQuery(ClaimId);

            }
            else if (ActionId.Equals("5"))
            {
                strMessage = "window.alert('Case Rejected Successfully.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                BindPatientName();
            }
            cbTerms.Checked = false;
            tbRejectRemarks.Text = "";
            pUserRole.Visible = false;
            pReason.Visible = false;
            pSubReason.Visible = false;
            pRemarks.Visible = false;
            //pAddReason.Visible = false;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
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


