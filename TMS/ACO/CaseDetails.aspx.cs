﻿using AbuaTMS;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
                // Call a method to fetch and display details for the given CaseNumber
                LoadPatientDetails(caseNumber);
            }
            else
            {
                // Handle the case where no CaseNumber is provided
                lblError.Text = "No Case Number provided!";
                lblError.Visible = true;
            }
            BindActionTypeDropdown();
            BindICDDetailsGrid();
            BindClaimsDetails();
            BindNonTechnicalChecklist(caseNumber);
            BindTechnicalChecklistData();
            BindClaimWorkflow();
            BindACORemarks();
        }

    }
    //protected void TextBoxFinalApprovedAmount_TextChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        // Retrieve Total Claims amount (assume it's already set in Label8.Text)
    //        decimal totalClaims = Convert.ToDecimal(Label8.Text);
    //        string caseNo = Session["CaseNumber"].ToString();
    //        int parsedUserId;
    //        int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
    //        string roleName = "";
    //        roleName = cpd.GetUserRole(userId);

    //        if (roleName == "ACO(INSURER)")
    //        {
    //            if (!decimal.TryParse(tbInsuranceApprovedAmt.Text, out totalClaims))
    //            {
    //                LabelTotalDeduction.Text = "Invalid Insurance Approved Amount input";
    //                return;
    //            }
    //        }
    //        else if (roleName == "ACO(TRUST)")
    //        {
    //            if (!decimal.TryParse(tbTrustApprovedAmt.Text, out totalClaims))
    //            {
    //                LabelTotalDeduction.Text = "Invalid Trust Approved Amount input";
    //                return;
    //            }
    //        }

    //        // Get the entered Final Approved Amount
    //        decimal finalApprovedAmount = 0;
    //        if (!string.IsNullOrEmpty(TextBoxFinalApprovedAmount.Text))
    //        {
    //            finalApprovedAmount = Convert.ToDecimal(TextBoxFinalApprovedAmount.Text);
    //        }

    //        // Calculate the difference (deduction amount)
    //        decimal deductionAmount = totalClaims - finalApprovedAmount;

    //        // Update the Total Deduction Amount label
    //        LabelTotalDeduction.Text = deductionAmount.ToString("N2");

    //        // Save the deduction amount to the database
    //        string remarks = "ACO Deduction"; // Define remarks
    //        //aco.SaveDeductionAmount(userId, deductionAmount.ToString(), caseNo, TextBoxFinalApprovedAmount.Text);
    //        aco.SaveDeductionAmount(userId, (int)deductionAmount, caseNo, TextBoxFinalApprovedAmount.Text);

    //    }
    //    catch (Exception ex)
    //    {
    //        // Handle exceptions (e.g., invalid input)
    //        LabelTotalDeduction.Text = "Error calculating deduction.";
    //    }
    //}

    private void BindACORemarks()
    {
        dt.Clear();
        string claimId = Session["ClaimId"].ToString();
        if (string.IsNullOrEmpty(claimId))
        {
            lblError.Text = "Claim ID is missing!";
            lblError.Visible = true;
            return;
        }
        dt = aco.GetACORemarks(claimId);
        if (dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            Label8.Text = row["TotalClaims"].ToString();
            Label9.Text = row["Trust Liable"].ToString();
            //Label10.Text = row["Final Approved Amount"].ToString();
            tbFinalAmountByAco.Text = row["Final Approved Amount"].ToString();
        }
        else
        {
            Label8.Text = "N/A";
            Label9.Text = "N/A";
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
        string caseNo = Session["CaseNumber"].ToString();
        //string cardNo = Session["CardNumber"].ToString();

        if (!string.IsNullOrEmpty(caseNo))
        {

            dt = aco.GetTechnicalChecklist(caseNo);
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
    private void BindICDDetailsGrid()
    {
        // Create a DataTable with the same structure as the GridView columns
        DataTable dt = new DataTable();
        dt.Columns.Add("SNo", typeof(string));
        dt.Columns.Add("ICDCode", typeof(string));
        dt.Columns.Add("ICDDescription", typeof(string));
        dt.Columns.Add("ActedByRole", typeof(string));

        // Add rows with "N/A" values
        for (int i = 1; i <= 3; i++) // Create 3 placeholder rows
        {
            DataRow row = dt.NewRow();
            row["SNo"] = "N/A";
            row["ICDCode"] = "N/A";
            row["ICDDescription"] = "N/A";
            row["ActedByRole"] = "N/A";
            dt.Rows.Add(row);
        }

        // Bind the DataTable to the GridView
        gvICDDetails.DataSource = dt;
        gvICDDetails.DataBind();
    }
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
                    using (SqlCommand cmd = new SqlCommand("ACOInsurer_ClaimUpdationDeatilsByCaseNumberUpdated", con))
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
        decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
        decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
        decimal finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;
        lbFinalAmount.Text = finalDeductedAmount.ToString();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
        //Add Deduction method down here
        decimal totalFinalAmountByAco = Convert.ToDecimal(tbFinalAmountByAco.Text.ToString().Trim());
        decimal totalClaimAmount = Convert.ToDecimal(Label8.Text.ToString().Trim());
        decimal finalDeductedAmount = totalClaimAmount - totalFinalAmountByAco;
        lbFinalAmount.Text = finalDeductedAmount.ToString();
        string caseNo = Session["CaseNumber"].ToString();
        int parsedUserId;
        int userId = int.TryParse(Session["UserId"].ToString(), out parsedUserId) ? parsedUserId : 0;
        string roleName = "";
        roleName = cpd.GetUserRole(userId);
        // Save the deduction amount to the database
        //string remarks = "ACO Deduction"; // Define remarks
        string remarks = txtRemarks.Text.Trim(); // Assuming a textbox for remarks exists
        aco.SaveDeductionAmount(userId, (int)finalDeductedAmount, caseNo, remarks);
        long claimId = Convert.ToInt64(Session["ClaimId"]); // Ensure ClaimId is stored in the session
        long actionId = Convert.ToInt64(actionType.SelectedValue);

        // Optional fields
        long? reasonId = null;
        long? subReasonId = null;
        string rejectReason = null;

        //if (actionId == 4) // Raise Query Action
        //{
        //    reasonId = Convert.ToInt64(reasonDropdown.SelectedValue); // Assuming a dropdown for reasons exists
        //    subReasonId = Convert.ToInt64(subReasonDropdown.SelectedValue); // Assuming a dropdown for sub-reasons exists
        //}
        //else if (actionId == 5) // Reject Action
        //{
        //    rejectReason = txtRejectReason.Text.Trim(); // Assuming a textbox for rejection reason exists
        //}

        try
        {
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_InsertActions", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClaimId", claimId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ActionId", actionId);
                cmd.Parameters.AddWithValue("@ReasonId", reasonId ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@SubReasonId", subReasonId ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@RejectReason", string.IsNullOrEmpty(rejectReason) ? (object)DBNull.Value : rejectReason);
                cmd.Parameters.AddWithValue("@Remarks", remarks);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblSuccess.Text = "Action processed successfully!";
            lblSuccess.Visible = true;

        }
        catch (Exception ex)
        {
            lblError.Text = "Error processing action: " + ex.Message;
            lblError.Visible = true;
        }
    }
    protected void ActionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Show/hide the remarks TextBox based on selected value
        if (actionType.SelectedValue == "1") // Assuming "1" is for "Approve"
        {
            txtRemarks.Visible = true; // Show remarks section
        }
        else
        {
            txtRemarks.Visible = false; // Hide remarks section
        }
    }
}
