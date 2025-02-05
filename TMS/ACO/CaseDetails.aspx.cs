using AbuaTMS;
using CareerPath.DAL;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Reflection.Emit;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class ACO_CaseDetails : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private PreAuth preAuth = new PreAuth();
    CPD cpd = new CPD();
    MasterData md = new MasterData();
    ACOHelper aco = new ACOHelper();
    string pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        else if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            // Get the CaseNumber from the query string
            string caseNumber = Request.QueryString["CaseNumber"];
            if (!string.IsNullOrEmpty(caseNumber))
            {
                Session["CaseNumber"] = caseNumber;
                hdRoleId.Value = Session["RoleId"].ToString();
                // Call a method to fetch and display details for the given CaseNumber
                LoadPatientDetails(caseNumber);
            }
            else
            {
                // Handle the case where no CaseNumber is provided
                lblError.Text = "No Case Number provided!";
                lblError.Visible = true;
            }
            getPatientPrimaryDiagnosis();
            getPatientSecondaryDiagnosis();
            //getPatientPrimaryDiagnosis();
            //getPatientSecondaryDiagnosis();
            BindActionTypeDropdown();
            //BindICDDetailsGrid();
            BindClaimsDetails();
            BindNonTechnicalChecklist(caseNumber);
            BindTechnicalChecklistData();
            BindClaimWorkflow();
            BindACORemarks();
            BindDeductionTypes();
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

    private void BindDeductionTypes()
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

    private void BindACORemarks()
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
    private void BindClaimWorkflow()
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
    private void BindTechnicalChecklistData()
    {
        dt.Clear();
        int parsedUserId;
        int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
        string caseNo = Session["CaseNumber"].ToString();
        //string cardNo = Session["CardNumber"].ToString();

        if (!string.IsNullOrEmpty(caseNo))
        {

            dt = aco.GetTechnicalChecklist(caseNo);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                tbTotalClaims.Text = row["TotalClaims"].ToString();
                if (hdRoleId.Value == "9")
                {
                    plTechfinalAmountInusure.Visible = true;
                    plTechfinalAmountTrust.Visible = false;
                    lbTechfinalAmountInusure.Text = row["InsurerClaimAmountApproved"].ToString();
                }
                else if (hdRoleId.Value == "10")
                {
                    plTechfinalAmountInusure.Visible = false;
                    plTechfinalAmountTrust.Visible = true;
                    lbTechfinalAmountTrust.Text = row["TrustClaimAmountApproved"].ToString();
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


                rbDiagnosisSupportedYes.Checked = Convert.ToBoolean(row["DiagnosisSupportedEvidence"]);
                rbCaseManagementYes.Checked = Convert.ToBoolean(row["CaseManagementSTP"]);
                rbEvidenceTherapyYes.Checked = Convert.ToBoolean(row["EvidenceTherapyConducted"]);
                rbMandatoryReportsYes.Checked = Convert.ToBoolean(row["MandatoryReports"]);

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
    public void BindNonTechnicalChecklist(string caseNo)
    {
        try
        {
            DataTable dtNonTechChecklist = aco.GetNonTechnicalChecklist(caseNo);

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
    private void BindActionTypeDropdown()
    {
        ACOHelper helper = new ACOHelper();
        DataTable actionTypes = helper.GetActionTypes();

        if (actionTypes != null && actionTypes.Rows.Count > 0)
        {
            actionType.DataSource = actionTypes;
            actionType.DataTextField = "ActionName"; // Display ActionName in the dropdown
            actionType.DataValueField = "ActionId";  // Use ActionId as the value
            actionType.DataBind();
        }

        // Add the default "Select Action Type" option
        actionType.Items.Insert(0, new ListItem("-- Select Action Type --", ""));
    }

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
                                string imageFileName = lbBeneficiaryId.Text + "_Profile_Image.jpeg";
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


    protected void btnAddDeduction_Click(object sender, EventArgs e)
    {
        if (hdRoleId.Value == "9")
        {
            decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
            //decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
            decimal totalClaimAmount = Convert.ToDecimal(lbpnlInsuranceAmount.Text.ToString().Trim());
            decimal finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;
            lbFinalAmount.Text = finalDeductedAmount.ToString();

        }
        else if (hdRoleId.Value == "10")
        {
            decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
            //decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
            decimal totalClaimAmount = Convert.ToDecimal(lbpnlTrustAmount.Text.ToString().Trim());
            decimal finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;
            lbFinalAmount.Text = finalDeductedAmount.ToString();
        }
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
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
        string deductionType = dropDeductionTypeACO.SelectedItem.Value;
        string remarks = txtRemarks.Text.Trim(); // Assuming a textbox for remarks exists
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
            aco.SaveDeductionAmount(userId, Convert.ToInt32(Session["RoleId"].ToString()), finalDeductedAmount, totalFinalAmountByAco, caseNo, remarks, deductionType);
        }
        // Save the deduction amount to the database
        long claimId = Convert.ToInt64(Session["ClaimId"]); // Ensure ClaimId is stored in the session
        long actionId = Convert.ToInt64(actionType.SelectedValue);
        string selectedQueryReasonId = ddlReason.SelectedValue;
        string selectedSubQueryReasonId =ddlSubReason.SelectedValue;
        switch (actionId)
        {
            case 2: // Approve
                DoAction(claimId, userId, actionId, " ", "", "", remarks,(int) totalFinalAmountByAco);
                Response.Redirect("~/ACO/ClaimUpdation.aspx");
                break;
            case 5: // Raise Query
                //long reasonId = Convert.ToInt64(reasonDropdown.SelectedValue);
                //long subReasonId = Convert.ToInt64(subReasonDropdown.SelectedValue);
                DoAction(claimId, userId, actionId, selectedQueryReasonId, selectedSubQueryReasonId, null, remarks,0);
                Response.Redirect("~/ACO/ClaimUpdation.aspx");
                break;
            case 6: // Reject
                string rejectReasonId = ddlReason.SelectedItem.Value;
                DoAction(claimId, userId, actionId, "", "", rejectReasonId, remarks,0);
                Response.Redirect("~/ACO/ClaimUpdation.aspx");
                break;
            default:
                lblError.Text = "Invalid action selected.";
                lblError.Visible = true;
                break;
        }
    }
    protected void DoAction(long claimId, long userId, long actionId, string queryReasonId, string querySubReasonId, string rejectReasonId, string remarks,int? totalFinalAmountByAco)
    {
        try
        {
            //reasonId = (long?)(selectedReason ?? (object)DBNull.Value) ?? 0;
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_InsertActions", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClaimId", claimId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ActionId", actionId);
                cmd.Parameters.AddWithValue("@ReasonId", queryReasonId ?? (object)DBNull.Value);
                //cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ??  (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@SubReasonId", querySubReasonId ?? "");
                cmd.Parameters.AddWithValue("@RejectReasonId", rejectReasonId ?? "");
                cmd.Parameters.AddWithValue("@Remarks", remarks ?? "");
                //cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco ?? "");
                // Only add the Amount parameter when actionId is 1 (Approve)
                if (totalFinalAmountByAco.HasValue)
                {
                    cmd.Parameters.AddWithValue("@Amount", totalFinalAmountByAco.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Amount", 0); // Or omit this parameter entirely if you prefer
                }
                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblSuccess.Text = "Action processed successfully!";
            lblSuccess.Visible = true;
            //Response.Redirect("~/ACO/ClaimUpdation.aspx");
        }
        catch (Exception ex)
        {
            lblError.Text = "Error processing action: " + ex.Message;
            lblError.Visible = true;
        }
        finally
        {
            con.Close();
        }
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
    protected void ActionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        pReason.Visible = false;
        //pRemarks.Visible = false;
        pSubReason.Visible = false;
        // Show/hide the remarks TextBox based on selected value
        if (actionType.SelectedValue == "2") // Assuming "1" is for "Approve"
        {
            txtRemarks.Visible = true; // Show remarks section
        }
        else if (actionType.SelectedValue == "6")
        {
            pReason.Visible = true;
            //pRemarks.Visible = true;
            txtRemarks.Visible = true;
            BindRejectReason();
        }
        else if (actionType.SelectedValue == "5")
        {
            pReason.Visible = true;
            pSubReason.Visible = true;
            //pRemarks.Visible = true;
            txtRemarks.Visible = true;
            BindQueryReason();
            BindQuerySubReason("1");

        }
        else
        {
            txtRemarks.Visible = false; // Hide remarks section
            pReason.Visible = false;
            pSubReason.Visible = false;
        }
    }
    protected void ddlReason_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedValue = ddlReason.SelectedItem.Value;
        BindQuerySubReason(selectedValue);
    }
    protected void lnkClaimTab_Click(object sender, EventArgs e)
    {
        // Set all panels to visible
        //pnlICDDetails.Visible = true;
        pnlClaimDetails.Visible=true;
        pnlNonTechnicalChecklist.Visible = true;
        pnlTechnicalChecklist.Visible = true;
        pnlACORemarks.Visible = true;
        pnlAddDeduction.Visible = true;
        pnlWorkflow.Visible = true;
        pnlActionType.Visible = true;

        // Optionally, set focus to the first section (e.g., ICD Details)
        //pnlICDDetails.Focus();
    }

}
