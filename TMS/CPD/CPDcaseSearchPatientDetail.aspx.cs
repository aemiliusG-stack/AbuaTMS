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
using CareerPath.DAL;

public partial class CPD_CPDcaseSearchPatientDetail : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    CPD cpd = new CPD();
    DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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
                ClearLabels();
            }
        }
    }

    private void BindPatientName(string caseNo)
    {
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
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDCaseSearchPatientDetails", parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                mvCPDTabs.SetActiveView(ViewClaims);
                btnAttachments.CssClass = "btn btn-primary ";
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
                BindGrid_PICDDetails_Claims();
                getNetworkHospitalDetails(caseNo);
                BindClaimsDetails();
                BindTechnicalChecklistData();
                BindGrid_ICDDetails_Preauth();
                BindGrid_TreatmentProtocol();
                BindGrid_ICHIDetails();
                BindPreauthAdmissionDetails();
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
        dt.Clear();
        dt = cpd.GetAdmissionDetails(caseNo);
        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["AdmissionDate"] != DBNull.Value)
            {
                lbAdmissionDate_Preauth.Text = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"]).ToString("dd/MM/yyyy");
            }
            else
            {
                lbAdmissionDate_Preauth.Text = "";
            }
            if (dt.Rows[0]["PackageCost"] != DBNull.Value)
            {
                lbPackageCost.Text = Convert.ToDecimal(dt.Rows[0]["PackageCost"]).ToString("C");
            }
            else
            {
                lbPackageCost.Text = "";
            }
            if (dt.Rows[0]["IncentiveAmount"] != DBNull.Value)
            {
                lbHospitalIncentive.Text = "110%";
            }
            else
            {
                lbHospitalIncentive.Text = "";
            }
            if (dt.Rows[0]["IncentiveAmount"] != DBNull.Value)
            {
                lbIncentiveAmount.Text = Convert.ToDecimal(dt.Rows[0]["IncentiveAmount"]).ToString("C");
            }
            else
            {
                lbIncentiveAmount.Text = "";
            }
            if (dt.Rows[0]["TotalPackageCost"] != DBNull.Value)
            {
                lbTotalPackageCost.Text = Convert.ToDecimal(dt.Rows[0]["TotalPackageCost"]).ToString("C");
            }
            else
            {
                lbTotalPackageCost.Text = "";
            }
        }
        else
        {
            lbAdmissionDate_Preauth.Text = "";
            lbPackageCost.Text = "";
            lbHospitalIncentive.Text = "";
            lbIncentiveAmount.Text = "";
            lbTotalPackageCost.Text = "";
        }
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
    //        if (con != null && con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //    }
    //}

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
    //        if (con != null && con.State == ConnectionState.Open)
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
    //        if (con != null && con.State == ConnectionState.Open)
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
        btnCaseSheet.CssClass = "btn btn-primary ";
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
    }



    private void getNetworkHospitalDetails(string caseNo)
    {
        DataTable dt = cpd.GetNetworkHospitalDetails(caseNo);
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
                    lbInsuranceLiableAmt.Text = Convert.ToDecimal(row["InsuranceLiableAmt"]).ToString("C");
                    lbTrustLiableAmt.Text = Convert.ToDecimal(row["TrustLiableAmt"]).ToString("C");
                    lbBillAmt.Text = Convert.ToDecimal(row["BillAmt"]).ToString("C");
                    lbFinalErupiAmt.Text = "0";
                    lbRemark.Text = row["ClaimRemarks"].ToString();
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
        if (!string.IsNullOrEmpty(caseNo))
        {
            dt = cpd.GetTechnicalChecklist(caseNo);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                tbTotalClaims.Text = row["TotalClaims"].ToString();
                tbInsuranceApprovedAmt.Text = row["InsurerClaimAmountApproved"].ToString();
                tbTrustApprovedAmt.Text = row["TrustClaimAmountApproved"].ToString();
                //if (row["IsSpecialCase"] != DBNull.Value)
                //{
                //    bool isSpecialCase = Convert.ToBoolean(row["IsSpecialCase"]);
                //    tbSpecialCase.Text = isSpecialCase ? "Yes" : "No";
                //}
                //else
                //{
                //    tbSpecialCase.Text = string.Empty;
                //}
            }
        }
    }
    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {

    }

    protected void lnkDischarge_Click(object sender, EventArgs e)
    {

    }

    protected void lnkDeath_Click(object sender, EventArgs e)
    {

    }

    protected void lnkClaim_Click(object sender, EventArgs e)
    {

    }

    protected void lnkGeneralInvestigation_Click(object sender, EventArgs e)
    {

    }

    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {

    }

    protected void lnkFraudDocuments_Click(object sender, EventArgs e)
    {

    }

    protected void lnkAuditDocuments_Click(object sender, EventArgs e)
    {

    }
}