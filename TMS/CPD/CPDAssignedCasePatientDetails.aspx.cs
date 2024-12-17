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

public partial class CPD_CPDAssignedCasePatientDetails : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    CPD cpd = new CPD();
    private string caseNo;
    private string claimNo;
    string pageName;
    private string strMessage;
    protected void Page_Load(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            

            string caseNo = Request.QueryString["CaseNo"];
            if (!string.IsNullOrEmpty(caseNo))
            {
                BindPatientName(caseNo);
            }
            else
            {
                lblMessage.Text = "Invalid Case Number.";
            }
            
            //BindGrid_ICDDetails_Preauth();
            //BindGrid_TreatmentProtocol();
            //BindGrid_ICHIDetails();
            //BindGrid_PreauthWorkFlow();
            //BindGrid_PICDDetails_Claims();
            //BindGrid_SICDDetails_Claims();
            //BindTechnicalChecklistData();
            //BindClaimWorkflow();
            ////GetPrimaryDiagnosis(null, null);
            ////GetSecondaryDiagnosis(null, null);
            //getPrimaryDiagnosis();
            //getSecondaryDiagnosis();
            //getPatientPrimaryDiagnosis();
            //getPatientSecondaryDiagnosis();
            //BindPreauthAdmissionDetails();
            //BindClaimsDetails();
            //getNetworkHospitalDetails();
            BindActionType();
            //if (!string.IsNullOrEmpty(caseNo))
            //{
            //    getNetworkHospitalDetails(caseNo);
            //}
        }
    }

    protected void BindGrid_TreatmentProtocol(string caseNo)
    {
        // Use caseNo here
    }

    [System.Web.Services.WebMethod]
    public static void HandleWindowClose()
    {
        var session = HttpContext.Current.Session;
        CPD cpd = new CPD();
        if (session["CaseNumber"] != null)
        {
            int affectedRows = cpd.TransferCase(session["CaseNumber"].ToString());
        }
        HttpContext.Current.Response.Redirect(System.Web.VirtualPathUtility.ToAbsolute("~/Unauthorize.aspx"));
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
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDAssignedCasePatientDetails", parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                lbCaseNoHead.Text = dt.Rows[0]["CaseNumber"].ToString();
                lbName.Text = dt.Rows[0]["PatientName"].ToString();
                lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString();
                lbRegNo.Text = dt.Rows[0]["PatientRegId"].ToString();
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
                BindGrid_ICDDetails_Preauth();
                BindGrid_TreatmentProtocol();
                BindGrid_ICHIDetails();
                BindGrid_PreauthWorkFlow();
                BindGrid_PICDDetails_Claims();
                BindGrid_SICDDetails_Claims();
                BindTechnicalChecklistData();
                BindClaimWorkflow();
                //GetPrimaryDiagnosis(null, null);
                //GetSecondaryDiagnosis(null, null);
                getPrimaryDiagnosis();
                getSecondaryDiagnosis();
                getPatientPrimaryDiagnosis();
                getPatientSecondaryDiagnosis();
                BindPreauthAdmissionDetails();
                BindClaimsDetails();
                getNetworkHospitalDetails();
                BindActionType();
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
    private void BindGrid_PreauthWorkFlow()
    {
        dt.Clear();
        string caseNo = Session["CaseNumber"].ToString();
        dt = cpd.GetClaimWorkFlow(caseNo);
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
            lbTotalAmtInsurance.Text = Convert.ToDecimal(row["InsurerClaimAmountRequested"]).ToString("C");
            lbTotalAmtTrust.Text = Convert.ToDecimal(row["TrustClaimAmountRequested"]).ToString("C");
            tbRemarks.Text = row["Remarks"].ToString();

            bool isPlanned = row["AdmissionType"] != DBNull.Value && Convert.ToInt32(row["AdmissionType"]) == 0;
            RBPlanned.Checked = isPlanned;
            RBEmergency.Checked = !isPlanned;
        }
        else
        {
            lbAdmissionDate_Preauth.Text = "No data found";
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
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
    }

    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
    }

    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
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
        decimal totalClaims = 0;
        decimal deductionAmount = 0;
        decimal totalDeductionAmount = 0;
        string caseNo = Session["CaseNumber"].ToString();
        int parsedUserId;
        int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
        if (!decimal.TryParse(tbAmount.Text, out deductionAmount))
        {
            tbTotalDeductionAmt.Text = "Invalid input for deduction amount";
            return;
        }
        string roleName = "";
        try
        {
            roleName = cpd.GetUserRole(userId);
            if (roleName == "CPD(INSURER)")
            {
                if (!decimal.TryParse(tbInsuranceApprovedAmt.Text, out totalClaims))
                {
                    tbTotalDeductionAmt.Text = "Invalid Insurance Approved Amount input";
                    return;
                }
            }
            else if (roleName == "CPD(TRUST)")
            {
                if (!decimal.TryParse(tbTrustApprovedAmt.Text, out totalClaims))
                {
                    tbTotalDeductionAmt.Text = "Invalid Trust Approved Amount input";
                    return;
                }
            }
            else
            {
                tbTotalDeductionAmt.Text = "Unrecognized role";
                return;
            }
            if (deductionAmount > totalClaims)
            {
                tbTotalDeductionAmt.Text = "Deduction cannot exceed total claims";
                return;
            }
            totalDeductionAmount = totalClaims - deductionAmount;
            tbTotalDeductionAmt.Text = totalDeductionAmount.ToString("C");
            cpd.InsertDeductionAndUpdateClaimMaster(userId, dropDeductionType.SelectedItem.Value, deductionAmount, totalDeductionAmount, caseNo, tbDedRemarks.Text);
            BindTechnicalChecklistData();
        }
        catch (Exception ex)
        {
            tbTotalDeductionAmt.Text = "Error: " + ex.Message;
        }
    }

    private void BindClaimWorkflow()
    {
        dt.Clear();
        dt = cpd.GetClaimWorkFlow(caseNo);
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
    private void BindActionType()
    {
        try
        {
            DataTable dt = cpd.GetActionType();
            ddlActionType.DataSource = dt;
            ddlActionType.DataTextField = "ActionName";
            ddlActionType.DataValueField = "ActionName";
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

        if (ddlActionType.SelectedValue == "Reject")
        {
            pReason.Visible = true;
            pRemarks.Visible = true;
            BindRejectReason();
        }
        else if (ddlActionType.SelectedValue == "Forward")
        {
            pUserRole.Visible = true;
            pUserToAssign.Visible = true;
        }
        else if (ddlActionType.SelectedValue == "Raise Query")
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
            // divPrimaryDiagnosis.Style("display") = "block"
            // lbPrimaryDiagnosisSelected.Text = dropPrimaryDiagnosis.SelectedItem.Text
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
        string selectedAction = ddlActionType.SelectedValue;
        string caseNo = Session["CaseNumber"] as string;
        string cardNo = Session["CardNumber"] as string;

        if (!string.IsNullOrEmpty(caseNo))
        {
            if (selectedAction == "Approved")
            {
                int totalClaims = Convert.ToInt32(tbTotalClaims.Text);
                int insuranceApprovedAmt = Convert.ToInt32(tbInsuranceApprovedAmt.Text);
                int trustApprovedAmt = Convert.ToInt32(tbTrustApprovedAmt.Text);
                bool specialCase = tbSpecialCase.Text == "Yes";
                bool diagnosisSupported = rbDiagnosisSupportedYes.Checked;
                bool caseManagementSTP = rbCaseManagementYes.Checked;
                bool evidenceTherapyConducted = rbEvidenceTherapyYes.Checked;
                bool mandatoryReports = rbMandatoryReportsYes.Checked;
                string remarks = "Document Verified";

                if (!cpd.CheckCaseNumberExists(caseNo))
                {
                    cpd.InsertTechnicalChecklist(caseNo, cardNo, totalClaims, insuranceApprovedAmt, trustApprovedAmt, specialCase, diagnosisSupported, caseManagementSTP, evidenceTherapyConducted, mandatoryReports, remarks);
                    cpd.UpdatePatientAdmissionDetails(caseNo);

                    string script = "alert('Approved Successfully'); window.location.reload();";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", script, true);
                }
                else
                {
                    lblMessage.Text = "The case number already exists in the checklist.";
                }
            }
            else if (selectedAction == "Reject")
            {
                lblMessage.Text = "Claim has been rejected.";
            }
            else if (selectedAction == "SendToMedicalAudit")
            {
                lblMessage.Text = "Claim has been sent to Medical Audit.";
            }
            else if (selectedAction == "Assign")
            {
                lblMessage.Text = "Claim has been assigned.";
            }
            else if (selectedAction == "RaiseQueryToHCO")
            {
                lblMessage.Text = "Query raised to HCO.";
            }
            else
            {
                lblMessage.Text = "Please select a valid action type.";
            }
        }
        else
        {
            lblMessage.Text = "No CaseNo available to update workflow.";
        }
    }

}