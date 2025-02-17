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

public partial class CPD_CPDClaimUpdation : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    CPD cpd = new CPD();
    public static PPDHelper ppdHelper = new PPDHelper();
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
                        btnQuestionnaire.CssClass = "btn btn-primary";
                        dt = ds.Tables[0];
                        string claimId = dt.Rows[0]["ClaimId"].ToString();
                        Session["ClaimId"] = claimId;
                        hfClaimId.Value = claimId;
                        lbCaseNoHead.Text = dt.Rows[0]["CaseNumber"].ToString();
                        lbName.Text = dt.Rows[0]["PatientName"].ToString();
                        lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString();
                        hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString();
                        hfHospitalId.Value = dt.Rows[0]["HospitalId"].ToString();
                        string cardNo = dt.Rows[0]["CardNumber"].ToString();
                        Session["CardNumber"] = cardNo;
                        lbRegNo.Text = dt.Rows[0]["PatientRegId"].ToString();
                        hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString();
                        string patientRedgNo = dt.Rows[0]["PatientRegId"].ToString();
                        Session["PatientRegId"] = patientRedgNo;
                        hfCaseNumber.Value = dt.Rows[0]["CaseNumber"].ToString();
                        lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString();
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
                        hfHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
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
                        if (cpd.IsPatientSecondaryDiagnosisExists(hdAbuaId.Value, hdPatientRegId.Value))
                        {
                            pPreauthSD.Visible = true;
                        }
                        else
                        {
                            pPreauthSD.Visible = false;
                        }
                        if (cpd.IsPatientSecondaryDiagnosisExists(hdAbuaId.Value, hdPatientRegId.Value))
                        {
                            pClaimsSD.Visible = true;
                        }
                        else
                        {
                            pClaimsSD.Visible = false;
                        }
                        if (cpd.IsClaimQueryExists(hfClaimId.Value))
                        {
                            pClaimQuery.Visible = true;
                        }
                        else
                        {
                            pClaimQuery.Visible = false;
                        }
                        if (cpd.IsPreauthUtilizationExists(hfAdmissionId.Value))
                        {
                            pPreauthUtilization.Visible = true;
                        }
                        else
                        {
                            pPreauthUtilization.Visible = false;
                        }
                        bool IsOncologyCase = cpd.IsOncologyCase(hfCaseNumber.Value);
                        if (IsOncologyCase)
                        {
                            btnOncology.Visible = true;
                            btnOncology.CssClass = "btn btn-primary";
                        }
                        if (cpd.IsPreauthQueryExists(hfClaimId.Value))
                        {
                            pPreauthQuery.Visible = true;
                        }
                        else
                        {
                            pPreauthQuery.Visible = false;
                        }
                        displayPatientAdmissionImage();
                        BindGrid_TreatmentProtocol();
                        BindGrid_ICHIDetails();
                        BindGrid_PreauthWorkFlow();
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
                        BindNonTechnicalChecklist();
                        getTreatmentDischarge();
                        BindGrid_TreatmentSurgeryDate();
                        BindDeductionType();
                        gvQuestionnaire.DataSource = CreateQuestionnaireData();
                        gvQuestionnaire.DataBind();
                        BindPreauthUtilizationData();
                        getClaimQuery(hfClaimId.Value);
                    }
                    else
                    {
                        MultiViewMain.SetActiveView(viewNoDataPending);
                        lbNodataPending.Text = "There Is No Pending Case Right Now";
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
        dt.Clear();
        dt = cpd.GetNetworkHospitalDetails(hfCaseNumber.Value);
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
    private void BindGrid_TreatmentProtocol()
    {
        dt = cpd.GetTreatmentProtocol(hfCaseNumber.Value);

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
        dt = cpd.GetPreauthWorkFlow(hfClaimId.Value);
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
        DataTable dt = cpd.GetAdmissionDetails(hfCaseNumber.Value);

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
    public void getPreauthQuery()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetPreauthQuery(hfClaimId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridPreauthQueryRejectionReason.DataSource = dt;
                gridPreauthQueryRejectionReason.DataBind();
            }
            else
            {
                gridPreauthQueryRejectionReason.DataSource = null;
                gridPreauthQueryRejectionReason.DataBind();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void gridPreauthQueryRejectionReason_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnViewaudit = (Button)e.Row.FindControl("btnViewaudit");
            Label lbIsQueryReplied = (Label)e.Row.FindControl("lbIsQueryReplied");
            string IsQueryReplied = lbIsQueryReplied.Text.ToString();
            if (IsQueryReplied != null && !IsQueryReplied.Equals("0"))
            {
                btnViewaudit.Text = "View Audit";
                btnViewaudit.Enabled = true;
                btnViewaudit.CssClass = "btn btn-primary btn-sm rounded-pill";
            }
            else
            {
                btnViewaudit.Text = "Query Pending";
                btnViewaudit.Enabled = false;
                btnViewaudit.CssClass = "btn btn-warning btn-sm rounded-pill";
            }
        }
    }

    protected void btnViewAudit_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbMainReason = (Label)row.FindControl("lbMainReason");
            Label lbSubReason = (Label)row.FindControl("lbSubReason");
            Label lbFolderName = (Label)row.FindControl("lbQueryFolderName");
            Label lbFileName = (Label)row.FindControl("lbQueryUploadedFileName");
            string folderName = lbFolderName.Text;
            string fileName = lbFileName.Text + ".jpeg";
            string DocumentName = lbMainReason.Text.ToString() + " (" + lbSubReason.Text.ToString() + ")";
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

    //protected void btnTransactionDataReferences_Click(object sender, EventArgs e)
    //{
    //    lbTitle.Text = "Transaction Data References";
    //    //MultiView3.SetActiveView(viewEnhancement);
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    //}
    protected void btnTransactionDataReferences_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetEnhancementDetails(hfAdmissionId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridTransactionDataReferences.DataSource = dt;
                gridTransactionDataReferences.DataBind();
                lbTitle.Text = "Transaction Data References";
                MultiView3.SetActiveView(viewEnhancement);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
            }
            else
            {
                gridTransactionDataReferences.DataSource = null;
                gridTransactionDataReferences.DataBind();
                strMessage = "window.alert('There is no enhancement available at the moment.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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
    protected void gridTransactionDataReferences_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbEnhancementStatus = (Label)e.Row.FindControl("lbEnhancementStatus");
            Label lbEnhancementApprovedDate = (Label)e.Row.FindControl("lbEnhancementApprovedDate");
            Label lbEnhancementRejectedDate = (Label)e.Row.FindControl("lbEnhancementRejectedDate");
            Label lbPatientFolderName = (Label)e.Row.FindControl("lbPatientFolderName");
            Label lbJustificationFolderName = (Label)e.Row.FindControl("lbJustificationFolderName");
            LinkButton lnkPhoto = (LinkButton)e.Row.FindControl("lnkPhoto");
            LinkButton lnkDocument = (LinkButton)e.Row.FindControl("lnkDocument");
            string EnhancementStatus = lbEnhancementStatus.Text.ToString();
            string ApprovedDate = lbEnhancementApprovedDate.Text.ToString();
            string RejectedDate = lbEnhancementRejectedDate.Text.ToString();
            string PatientFolderName = lbPatientFolderName.Text.ToString();
            string JustificationFolderName = lbJustificationFolderName.Text.ToString();
            if (EnhancementStatus != null)
            {
                if (EnhancementStatus.Equals("1"))
                {
                    lbEnhancementStatus.Text = "Pending";
                    lbEnhancementApprovedDate.Text = "NA";
                    lbEnhancementApprovedDate.Visible = true;
                }
                else if (EnhancementStatus.Equals("2"))
                {
                    lbEnhancementStatus.Text = "Approved";
                    lbEnhancementApprovedDate.Text = ApprovedDate;
                    lbEnhancementApprovedDate.Visible = true;
                }
                else if (EnhancementStatus.Equals("3"))
                {
                    lbEnhancementStatus.Text = "Query Raised";
                    lbEnhancementApprovedDate.Text = "NA";
                    lbEnhancementApprovedDate.Visible = true;
                }
                else if (EnhancementStatus.Equals("4"))
                {
                    lbEnhancementStatus.Text = "Reject";
                    lbEnhancementRejectedDate.Text = RejectedDate;
                    lbEnhancementRejectedDate.Visible = true;
                }
            }
            if (PatientFolderName.Equals("NA"))
            {
                lnkPhoto.Enabled = false;
                lnkPhoto.CssClass = "text-danger";
            }
            if (JustificationFolderName.Equals("NA"))
            {
                lnkDocument.Enabled = false;
                lnkDocument.CssClass = "text-danger";
            }
        }
    }
    protected void lnkPhoto_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbPatientFolderName = (Label)row.FindControl("lbPatientFolderName");
            Label lbPatientUploadedFileName = (Label)row.FindControl("lbPatientUploadedFileName");
            string PatientFolderName = lbPatientFolderName.Text.ToString();
            string PatientUploadedFileName = lbPatientUploadedFileName.Text.ToString() + ".jpeg";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(PatientFolderName, PatientUploadedFileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = "Patient Photo";
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void lnkDocument_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbJustificationFolderName = (Label)row.FindControl("lbJustificationFolderName");
            Label lbJustificationUploadedFileName = (Label)row.FindControl("lbJustificationUploadedFileName");
            string JustificationFolderName = lbJustificationFolderName.Text.ToString();
            string JustificationUploadedFileName = lbJustificationUploadedFileName.Text.ToString() + ".jpeg";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(JustificationFolderName, JustificationUploadedFileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = "Enhancement Justification";
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }

    }

    protected void lnkChildPhoto_Click(object sender, EventArgs e)
    {
        try
        {
            string childfolderName = hdAbuaId.Value;
            string childImageFileName = hdAbuaId.Value + "_Profile_Image_Child.jpeg";
            string childBase64String = "";

            childBase64String = preAuth.DisplayImage(childfolderName, childImageFileName);
            if (childBase64String != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + childBase64String;
            }
            lbTitle.Text = "Child Photo/ Document";
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
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
        btnQuestionnaire.CssClass = "btn btn-primary";

    }

    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewTreatmentDischarge);
        btnAttachments.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-warning";
        btnClaims.CssClass = "btn btn-primary";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }
    protected void btnClaims_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewClaims);
        btnAttachments.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-warning";
        btnQuestionnaire.CssClass = "btn btn-primary";

    }
    protected void btnOncology_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewOncology);
        btnOncology.Visible = true;
        btnOncology.CssClass = "btn btn-warning";
        btnPastHistory.CssClass = "btn btn-primary";
        btnPreauth.CssClass = "btn btn-primary";
        btnTreatment.CssClass = "btn btn-primary";
        btnClaims.CssClass = "btn btn-primary";
        btnAttachments.CssClass = "btn btn-primary";
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

    }
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

    //Claims Updation Tab
    public void BindClaimsDetails()
    {
        try
        {
            if (!string.IsNullOrEmpty(hfCaseNumber.Value))
            {
                DataTable dtClaimsDetails = cpd.GetClaimsDetails(hfCaseNumber.Value);

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
    //private void BindGrid_PICDDetails_Claims()
    //{
    //    string cardNo = Session["CardNumber"] as string;
    //    int patientRedgNo = Session["PatientRegId"] != null ? Convert.ToInt32(Session["PatientRegId"]) : 0;

    //    dt.Clear();
    //    dt = cpd.GetPICDDetails(cardNo, patientRedgNo);

    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        gvPICDDetails_Claim.DataSource = dt;
    //        gvPICDDetails_Claim.DataBind();
    //    }
    //    else
    //    {
    //        gvPICDDetails_Claim.DataSource = null;
    //        gvPICDDetails_Claim.EmptyDataText = "No ICD details found.";
    //        gvPICDDetails_Claim.DataBind();
    //    }
    //}
    //private void BindGrid_SICDDetails_Claims()
    //{
    //    string cardNo = Session["CardNumber"] as string;
    //    int patientRedgNo = Session["PatientRegId"] != null ? Convert.ToInt32(Session["PatientRegId"]) : 0;

    //    dt.Clear();
    //    dt = cpd.GetSICDDetails(cardNo, patientRedgNo);

    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        gvSICDDetails_Claim.DataSource = dt;
    //        gvSICDDetails_Claim.DataBind();
    //    }
    //    else
    //    {
    //        gvSICDDetails_Claim.DataSource = null;
    //        gvSICDDetails_Claim.EmptyDataText = "No ICD details found.";
    //        gvSICDDetails_Claim.DataBind();
    //    }
    //}
    public void BindNonTechnicalChecklist()
    {
        try
        {
            DataTable dtNonTechChecklist = cpd.GetNonTechnicalChecklist(hfCaseNumber.Value);

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
        if (!string.IsNullOrEmpty(hfClaimId.Value))
        {
            dt = cpd.GetTechnicalChecklist(hfClaimId.Value);
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
                if (row["ClaimMode"] != DBNull.Value)
                {
                    int claimMode = Convert.ToInt32(row["ClaimMode"]);

                    if (claimMode == 1)
                    {
                        pInsuranceApprovedAmt.Visible = true;
                        pTrustApprovedAmt.Visible = false;
                    }
                    else if (claimMode == 2)
                    {
                        pInsuranceApprovedAmt.Visible = false;
                        pTrustApprovedAmt.Visible = true;
                    }
                    else if (claimMode == 3)
                    {
                        pInsuranceApprovedAmt.Visible = true;
                        pTrustApprovedAmt.Visible = true;
                    }
                }
            }
        }
    }
    private void BindDeductionType()
    {
        try
        {
            DataTable dt = cpd.GetDeductionType();
            dropDeductionType.DataSource = dt;
            dropDeductionType.DataTextField = "DeductionType";
            dropDeductionType.DataValueField = "DeductionTypeId";
            dropDeductionType.DataBind();
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
        dropDeductionType.Items.Insert(0, new ListItem("--Select--", ""));
    }
    protected void AddDeduction_Click(object sender, EventArgs e)
    {
        hdUserId.Value = Session["UserId"].ToString();
        hdRoleId.Value = Session["RoleId"].ToString();
        try
        {
            decimal totalClaims = 0, deductionAmount = 0, totalDeductionAmount = 0;
            string roleName = cpd.GetUserRole(Convert.ToInt32(Session["UserId"].ToString()));

            if (!decimal.TryParse(tbAmount.Text, out deductionAmount) || deductionAmount < 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid deduction amount. It must be a positive number.');", true);
                return;
            }
            if (roleName == "CPD(INSURER)")
            {
                totalClaims = Convert.ToDecimal(hfInsurerApprovedAmount.Value);
            }
            else if (roleName == "CPD(TRUST)")
            {
                totalClaims = Convert.ToDecimal(hfTrustApprovedAmount.Value);
            }
            else
            {
                return; // Exit if the role is unknown
            }

            // Ensure at least 1 rupee is left after deduction
            if (deductionAmount >= totalClaims)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deduction cannot exceed total claim amount.');", true);
                return;
            }

            totalDeductionAmount = totalClaims - deductionAmount;

            tbTotalDeductedAmt.Text = deductionAmount.ToString();
            tbFinalAmt.Text = totalClaims.ToString();
            tbFinalAmtAfterDeduction.Text = totalDeductionAmount.ToString();

            hfDeductedAmount.Value = deductionAmount.ToString();
            hfFinalAmount.Value = totalDeductionAmount.ToString();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred. Please try again.');", true);
        }
    }

    protected void ResetDeduction_Click(object sender, EventArgs e)
    {
        dropDeductionType.ClearSelection();
        dropDeductionType.SelectedIndex = 0;
        tbAmount.Text = "";
        tbDedRemarks.Text = "";
        tbTotalDeductedAmt.Text = "";
        tbFinalAmt.Text = "";
        tbFinalAmtAfterDeduction.Text = "";
    }
    private void BindClaimWorkflow()
    {
        dt.Clear();
        dt = cpd.GetClaimWorkFlow(hfClaimId.Value);
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
    public void BindPreauthUtilizationData()
    {
        DataTable dt = cpd.GetPreauthUtilization(hfAdmissionId.Value);

        if (dt != null && dt.Rows.Count > 0)
        {
            //decimal totalNoOfDays = 0;
            //decimal totalAmount = 0;

            int preauthNoOfDays = 0;
            decimal preauthAmount = 0;

            int enhanceNoOfDays = 0;
            decimal enhanceAmount = 0;

            foreach (DataRow row in dt.Rows)
            {
                DateTime preauthFrom = Convert.ToDateTime(row["PreauthDate"]);
                DateTime preauthTo = Convert.ToDateTime(row["PreauthDate"]);

                int preauthNoOfDaysForRecord = (preauthTo - preauthFrom).Days + 1;  // Add 1 to include both start and end dates

                decimal preauthWardRentPerDay = Convert.ToDecimal(row["PrauthWardRent"]);
                decimal preauthAmountForRecord = preauthWardRentPerDay * preauthNoOfDaysForRecord;

                preauthNoOfDays += preauthNoOfDaysForRecord;
                preauthAmount += preauthAmountForRecord;

                lbActionTypePreauth.Text = "Preauth";
                lbPreauthFromDate.Text = preauthFrom.ToString("dd-MM-yyyy");
                lbPreauthToDate.Text = preauthTo.ToString("dd-MM-yyyy");
                lbPreauthWardType.Text = row["PreauthWardType"].ToString();
                lbPreauthWardRent.Text = preauthWardRentPerDay.ToString();
                lbPreauthNoOfDays.Text = preauthNoOfDaysForRecord.ToString();
                lbPreauthAmount.Text = preauthAmountForRecord.ToString("C");

                DateTime enhancementFrom = Convert.ToDateTime(row["EnhancementFrom"]);
                DateTime enhancementTo = Convert.ToDateTime(row["EnhancementTo"]);

                int enhanceNoOfDaysForRecord = (enhancementTo - enhancementFrom).Days + 1;

                decimal enhanceWardRentPerDay = Convert.ToDecimal(row["EnhanceWardRent"]);
                decimal enhanceAmountForRecord = enhanceWardRentPerDay * enhanceNoOfDaysForRecord;

                enhanceNoOfDays += enhanceNoOfDaysForRecord;
                enhanceAmount += enhanceAmountForRecord;

                lbActionTypeEnhance.Text = "Enhancement";
                lbEnhanceFromDate.Text = enhancementFrom.ToString("dd-MM-yyyy");
                lbEnhanceToDate.Text = enhancementTo.ToString("dd-MM-yyyy");
                lbEnhanceWardType.Text = row["EnhanceWardType"].ToString();
                lbEnhanceWardRent.Text = enhanceWardRentPerDay.ToString();
                lbEnhanceNoOfDays.Text = enhanceNoOfDaysForRecord.ToString();
                lbEnhanceAmount.Text = enhanceAmountForRecord.ToString("C");
            }

            tbSumActualDay.Text = (preauthNoOfDays + enhanceNoOfDays).ToString();
            tbSumTotalAmt.Text = (preauthAmount + enhanceAmount).ToString("C");

            pPreauthUtilization.Visible = true;
        }
        else
        {
            pPreauthUtilization.Visible = false;
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
                gvClaimQuery.DataSource = dt;
                gvClaimQuery.DataBind();
            }
            else
            {
                gvClaimQuery.DataSource = null;
                gvClaimQuery.DataBind();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
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

    protected void ddlReason_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();

            int ReasonId = 0;

            if (int.TryParse(ddlReason.SelectedValue, out ReasonId) && ReasonId > 0)
            {
                dt = cpd.GetQuerySubReason(ReasonId.ToString());

                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlSubReason.Items.Clear();
                    ddlSubReason.DataValueField = "SubReasonId";
                    ddlSubReason.DataTextField = "SubReasonName";
                    ddlSubReason.DataSource = dt;
                    ddlSubReason.DataBind();
                    ddlSubReason.Items.Insert(0, new ListItem("--Select--", "0"));
                }
                else
                {
                    ddlSubReason.Items.Clear();
                    ddlSubReason.Items.Insert(0, new ListItem("--No Sub Reason Available--", "0"));
                }
            }
            else
            {
                ddlSubReason.Items.Clear();
                ddlSubReason.Items.Insert(0, new ListItem("--Select Reason First--", "0"));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
            Response.Redirect("~/Unauthorize.aspx", false);
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

    protected void ddlActionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        pUserRole.Visible = false;
        pReason.Visible = false;
        pRemarks.Visible = false;
        pSubReason.Visible = false;
        pUserRole.Visible = false;
        pUserToAssign.Visible = false;
        if (ddlActionType.SelectedValue == "2")
        {
            pRemarks.Visible = true;
            pTriggerType.Visible = false;
            BindRejectReason();
        }
        else if (ddlActionType.SelectedValue == "6")
        {
            pReason.Visible = true;
            pRemarks.Visible = true;
            BindRejectReason();
        }
        else if (ddlActionType.SelectedValue == "3")
        {
            pUserRole.Visible = true;
            pUserToAssign.Visible = true;
            getForwardUsers();
        }
        else if (ddlActionType.SelectedValue == "4")
        {
            pTriggerType.Visible = true;
            BindTriggerType();
        }
        else if (ddlActionType.SelectedValue == "5")
        {
            pReason.Visible = true;
            pSubReason.Visible = true;
            pRemarks.Visible = true;
            pTriggerType.Visible = false;
            BindQueryReason();
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
            dt.Clear();
            dt = cpd.getPrimaryDiagnosis(hfCaseNumber.Value);
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

            dt = cpd.getSecondaryDiagnosis(hfCaseNumber.Value);
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
            DataTable dt = new DataTable();
            dt = cpd.GetPatientPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridPrimaryDiagnosis.DataSource = dt;
                gridPrimaryDiagnosis.DataBind();
                gvPICDDetails_Claim.DataSource = dt;
                gvPICDDetails_Claim.DataBind();
                gvPreauthPD.DataSource = dt;
                gvPreauthPD.DataBind();
            }
            else
            {
                gridPrimaryDiagnosis.DataSource = null;
                gridPrimaryDiagnosis.DataBind();
                gvPICDDetails_Claim.DataSource = null;
                gvPICDDetails_Claim.DataBind();
                gvPreauthPD.DataSource = null;
                gvPreauthPD.DataBind();
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
                gridSecondaryDiagnosis.DataSource = dt;
                gridSecondaryDiagnosis.DataBind();
                gvSICDDetails_Claim.DataSource = dt;
                gvSICDDetails_Claim.DataBind();
                gvPraauthSD.DataSource = dt;
                gvPraauthSD.DataBind();
                pClaimsSD.Visible = true;
            }
            else
            {
                gridSecondaryDiagnosis.DataSource = null;
                gridSecondaryDiagnosis.DataBind();
                gvSICDDetails_Claim.DataSource = null;
                gvSICDDetails_Claim.DataBind();
                gvPraauthSD.DataSource = null;
                gvPraauthSD.DataBind();
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

    protected void lnkDeletePrimaryDiagnosis_Click(object sender, EventArgs e)
    {
        try
        {
            int PatientSDId;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            PatientSDId = row.RowIndex;
            Label lbPatientPDId = (Label)row.FindControl("lbPatientPDId");
            int rowsAffected = 0;
            rowsAffected = cpd.DeletePrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbPatientPDId.Text));
            getPatientPrimaryDiagnosis();
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
            int PatientSDId;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            PatientSDId = row.RowIndex;
            Label lbPatientSDId = (Label)row.FindControl("lbPatientSDId");
            int rowsAffected = 0;
            rowsAffected = cpd.DeleteSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbPatientSDId.Text));
            getPatientSecondaryDiagnosis();


        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred while deleting the diagnosis.');", true);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string selectedReason = ddlReason.SelectedItem.Value;
        string selectedSubReason = ddlSubReason.SelectedItem.Value;
        if (!cbTerms.Checked)
        {
            strMessage = "window.alert('Please confirm that you have validated all documents before making any decisions by checking the box.');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        }
        else
        {

            string selectedValue = ddlActionType.SelectedItem.Value;

            if (selectedValue.Equals("0"))
            {
                strMessage = "window.alert('Case action is required.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else
            {
                if (selectedValue.Equals("2"))
                {
                    if (!rbDiagnosisSupportedYes.Checked && !rbDiagnosisSupportedNo.Checked)
                    {
                        strMessage = "window.alert('Please select Diagnosis Supported Yes or No.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }

                    if (!rbCaseManagementYes.Checked && !rbCaseManagementNo.Checked)
                    {
                        strMessage = "window.alert('Please select Case Management Yes or No.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }

                    if (!rbEvidenceTherapyYes.Checked && !rbEvidenceTherapyNo.Checked)
                    {
                        strMessage = "window.alert('Please select Evidence Therapy Conducted Yes or No.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }

                    if (!rbMandatoryReportsYes.Checked && !rbMandatoryReportsNo.Checked)
                    {
                        strMessage = "window.alert('Please select Mandatory Reports Yes or No.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }
                    if (string.IsNullOrEmpty(tbTechRemarks.Text))
                    {
                        strMessage = "window.alert('Please fill the Remarks.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }
                    if (string.IsNullOrEmpty(tbRejectRemarks.Text))
                    {
                        strMessage = "window.alert('Please fill the Remarks.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        return;
                    }
                    if (!hfDeductedAmount.Value.IsEmpty() && !hfFinalAmount.Value.IsEmpty())
                    {
                        int deductionType;
                        decimal deductedAmount = Convert.ToDecimal(hfDeductedAmount.Value.ToString());
                        decimal finalAmount = Convert.ToDecimal(hfFinalAmount.Value.ToString());
                        int.TryParse(dropDeductionType.SelectedValue, out deductionType);
                        cpd.InsertDeductionAndUpdateClaimMaster(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["RoleId"].ToString()), deductionType, deductedAmount, finalAmount, hfCaseNumber.Value, tbDedRemarks.Text, Convert.ToInt32(hfClaimId.Value));

                    }
                    //string result = cpd.ExecuteTDSCalculation(Convert.ToInt32(hfClaimId.Value));
                    //lblMessage.Text = result;

                    doAction(Session["claimId"].ToString(), Session["UserId"].ToString(), "", "", selectedValue, "", "", "", tbRejectRemarks.Text.ToString() + "");
                    bool specialCase = tbSpecialCase.Text == "Yes";
                    bool diagnosisSupported = rbDiagnosisSupportedYes.Checked;
                    bool caseManagementSTP = rbCaseManagementYes.Checked;
                    bool evidenceTherapyConducted = rbEvidenceTherapyYes.Checked;
                    bool mandatoryReports = rbMandatoryReportsYes.Checked;
                    string remarks = tbTechRemarks.Text.Trim();
                    if (!cpd.CheckCaseNumberExists(hfCaseNumber.Value))
                    {
                        cpd.InsertTechnicalChecklist(Convert.ToInt32(hfClaimId.Value), hfCaseNumber.Value, hdAbuaId.Value, diagnosisSupported, caseManagementSTP, evidenceTherapyConducted, mandatoryReports, remarks);
                    }
                    else
                    {
                        lblMessage.Text = "The case number already exists in the checklist.";
                    }
                }
                else if (selectedValue.Equals("3"))
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
                else if (selectedValue.Equals("5"))
                {

                    if (selectedReason.Equals("0"))
                    {
                        strMessage = "window.alert('Please select query reason.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        if (selectedSubReason.Equals("0"))
                        {
                            strMessage = "window.alert('Please select query sub reason.');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        }
                        else
                        {
                            doAction(Session["ClaimId"].ToString(), Session["UserId"].ToString(), "", "", selectedValue, selectedReason, selectedSubReason, "", tbRejectRemarks.Text.ToString() + "");
                        }
                    }
                }
                else if (selectedValue.Equals("6"))
                {
                    string selectedRejectReason = ddlReason.SelectedItem.Value;
                    if (selectedRejectReason.Equals("0"))
                    {
                        strMessage = "window.alert('Please select reject reason.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        doAction(Session["claimId"].ToString(), Session["UserId"].ToString(), "", "", selectedValue, "", "", ddlReason.SelectedItem.Value.ToString(), tbRejectRemarks.Text.ToString() + "");
                    }
                }
            }
        }
    }
    public void doAction(string ClaimId, string UserId, string ForwardedToId, string ForwardedToUser, string ActionId, string ReasonId, string SubReasonId, string RejectReasonId, string Remarks)
    {
        try
        {
            string finalAmount = !string.IsNullOrEmpty(tbFinalAmtAfterDeduction.Text)
                                         ? tbFinalAmtAfterDeduction.Text
                                         : tbInsuranceApprovedAmt.Text;
            SqlParameter[] p = new SqlParameter[9];
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
            p[6] = new SqlParameter("@RejectReasonId", RejectReasonId);
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@Remarks", Remarks);
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@Amount", finalAmount);
            p[8].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CPDInsertActions", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ActionId.Equals("2"))
            {
                if (Session["RoleId"].ToString() == "7")
                {
                    strMessage = "window.alert('Claim has been approved by CPD(Insurer). " + hfCaseNumber.Value + "');window.location.reload();";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else if (Session["RoleId"].ToString() == "8")
                {
                    strMessage = "window.alert('Claim has been approved by CPD(Trust). " + hfCaseNumber.Value + "');window.location.reload();";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                BindPatientName();
            }
            else if (ActionId.Equals("3"))
            {
                strMessage = "window.alert('Case Successfully Forwarded To " + ForwardedToUser + "');window.location.reload();";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                BindPatientName();
            }
            else if (ActionId.Equals("5"))
            {
                strMessage = "window.alert('Query Raised Successfully.');window.location.reload();";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                //getClaimQuery(ClaimId);
                BindPatientName();

            }
            else if (ActionId.Equals("6"))
            {
                strMessage = "window.alert('Case Rejected Successfully.');window.location.reload();";
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
    //Treatment and Discharge tab
    private void getTreatmentDischarge()
    {
        string claimId = Session["ClaimId"] as string;
        dt.Clear();
        dt = cpd.GetTreatmentDischarge(claimId);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];

            // String values with DBNull and whitespace handling
            lbDoctorType.Text = GetStringValue(row["TypeOfMedicalExpertise"]);
            lbDoctorName.Text = GetStringValue(row["DoctorName"]);
            lbDocRegnNo.Text = GetStringValue(row["DoctorRegistrationNumber"]);
            lbDocQualification.Text = GetStringValue(row["Qualification"]);
            lbDocContactNo.Text = GetStringValue(row["DoctorContactNumber"]);
            lbAnaesthetistName.Text = GetStringValue(row["AnaesthetistName"]);
            lbAnaesthetistRegNo.Text = GetStringValue(row["AnaesthetistRegNo"]);
            lbAnaesthetistContactNo.Text = GetStringValue(row["AnaesthetistMobNo"]);
            lbIncisionType.Text = GetStringValue(row["IncisionType"]);
            lbSwabCounts.Text = GetStringValue(row["SwabCountInstrumentsCount"]);
            lbSurutes.Text = GetStringValue(row["SuturesLigatures"]);
            lbDranageCount.Text = GetStringValue(row["DrainageCount"]);
            lbBloodLoss.Text = GetStringValue(row["BloodLoss"]);
            lbOperativeInstructions.Text = GetStringValue(row["PostOperativeInstructions"]);
            lbPatientCondition.Text = GetStringValue(row["PatientCondition"]);
            tbTreatmentGiven.Text = GetStringValue(row["TreatmentGiven"]);
            tbOperativeFindings.Text = GetStringValue(row["OperativeFindings"]);
            tbPostOperativePeriod.Text = GetStringValue(row["PostOperativePeriod"]);
            tbSpecialInvestigationGiven.Text = GetStringValue(row["PostSurgeryInvestigationGiven"]);
            tbStatusAtDischarge.Text = GetStringValue(row["StatusAtDischarge"]);
            tbReview.Text = GetStringValue(row["Review"]);
            tbAdvice.Text = GetStringValue(row["Advice"]);
            lbConsultBlockName.Text = GetStringValue(row["ConsultAtBlock"]);
            lbFloor.Text = GetStringValue(row["FloorNo"]);
            lbRoomNo.Text = GetStringValue(row["RoomNo"]);
            lbFinalDiagnosis.Text = GetStringValue(row["FinalDiagnosis"]);

            rbOPPhotoYes.Checked = GetBooleanValue(row["OPPhotosWebexTaken"]);
            rbOPPhotoNo.Checked = !GetBooleanValue(row["OPPhotosWebexTaken"]);
            rbVedioRecDoneYes.Checked = GetBooleanValue(row["VideoRecordingDone"]);
            rbVedioRecDoneNo.Checked = !GetBooleanValue(row["VideoRecordingDone"]);
            rbSpecimenRemoveYes.Checked = GetBooleanValue(row["SpecimenRequired"]);
            rbSpecimenRemoveNo.Checked = !GetBooleanValue(row["SpecimenRequired"]);
            rbComplicationsYes.Checked = GetBooleanValue(row["ComplicationsIfAny"]);
            rbComplicationsNo.Checked = !GetBooleanValue(row["ComplicationsIfAny"]);
            rbDischarge.Checked = GetBooleanValue(row["IsDischarged"]);
            rbDeath.Checked = !GetBooleanValue(row["IsDischarged"]);
            rbConsentYes.Checked = GetBooleanValue(row["ProcedureConsent"]);
            rbConsentNo.Checked = !GetBooleanValue(row["ProcedureConsent"]);
            rbIsSpecialCaseYes.Checked = GetBooleanValue(row["IsSpecialCase"]);
            rbIsSpecialCaseNo.Checked = !GetBooleanValue(row["IsSpecialCase"]);

            if (rbIsSpecialCaseYes.Checked)
            {
                pnlSpecialCaseValue.Visible = true;
                lbSpecialCaseValue.Text = GetStringValue(row["SpecialCaseValue"]);
            }

            // Date values handling
            lbTraetmentDate.Text = GetDateValue(row["TreatmentSurgeryStartDate"]);
            lbDischargeDate.Text = GetDateValue(row["DischargeDate"]);
            lbNextFollowUp.Text = GetDateValue(row["NextFollowUpDate"]);

            // Time values handling
            tbSurgeryStartTime.Text = GetTimeValue(row["SurgeryStartTime"]);
            tbSurgeryEndTime.Text = GetTimeValue(row["SurgeryEndTime"]);
        }
    }

    private string GetStringValue(object value)
    {
        return (value == null || value == DBNull.Value || string.IsNullOrWhiteSpace(value.ToString())) ? "NA" : value.ToString();
    }

    private bool GetBooleanValue(object value)
    {
        return (value != DBNull.Value) && Convert.ToBoolean(value);
    }

    private string GetDateValue(object value)
    {
        return (value == null || value == DBNull.Value || string.IsNullOrWhiteSpace(value.ToString())) ? "NA" : Convert.ToDateTime(value).ToString("dd/MM/yyyy");
    }

    private string GetTimeValue(object value)
    {
        return (value == null || value == DBNull.Value || string.IsNullOrWhiteSpace(value.ToString())) ? "NA" : TimeSpan.Parse(value.ToString()).ToString(@"hh\:mm");
    }

    protected void BindGrid_TreatmentSurgeryDate()
    {
        try
        {
            dt.Clear();
            dt = cpd.getTreatmentSurgeryDate(hfHospitalId.Value, hdPatientRegId.Value, hdAbuaId.Value);
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
        lnkDischarge.CssClass = "btn btn-primary";
        lnkPostInvestigation.CssClass = "btn btn-primary";
        getManditoryDocuments(hfHospitalId.Value, hdPatientRegId.Value);
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
        lnkDischarge.CssClass = "btn btn-primary";
        lnkPostInvestigation.CssClass = "btn btn-primary";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "hideModal();", true);
        getManditoryDocuments(hfHospitalId.Value, hdPatientRegId.Value);
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
        lnkDischarge.CssClass = "btn btn-primary";
        lnkPostInvestigation.CssClass = "btn btn-primary";
        getPreInvestigationDocuments(hfHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }
    protected void lnkDischarge_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewDischarge);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-warning";
        lnkPostInvestigation.CssClass = "btn btn-primary";
        getDischargeDocuments(hfHospitalId.Value, hdPatientRegId.Value);
    }

    protected void lnkPostInvestigation_Click(object sender, EventArgs e)
    {
        mvCPDTabs.SetActiveView(ViewAttachment);
        MultiView2.SetActiveView(viewPostInvestigation);
        btnAttachments.CssClass = "btn btn-warning ";
        btnPreauth.CssClass = "btn btn-primary ";
        btnPastHistory.CssClass = "btn btn-primary ";
        btnTreatment.CssClass = "btn btn-primary ";
        btnClaims.CssClass = "btn btn-primary ";
        lnkSpecialInvestigation.CssClass = "btn btn-primary";
        lnkPreauthorization.CssClass = "btn btn-primary";
        lnkDischarge.CssClass = "btn btn-primary";
        lnkPostInvestigation.CssClass = "btn btn-warning";
        getPostInvestigationDocuments(hfHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
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
    public void getDischargeDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = cpd.GetDischargeDocuments(HospitalId, PatientRegId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridDischargeDocument.DataSource = dt;
                gridDischargeDocument.DataBind();
            }
            else
            {
                gridDischargeDocument.DataSource = null;
                gridDischargeDocument.DataBind();
                panelNoDischrage.Visible = true;
            }
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
            mvCPDTabs.SetActiveView(ViewAttachment);
            MultiView2.SetActiveView(viewDischarge);
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
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
            dt = cpd.GetPostInvestigationDocuments(HospitalId, CardNumber, PatientRegId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridPostInvestigation.DataSource = dt;
                gridPostInvestigation.DataBind();
            }
            else
            {
                gridPostInvestigation.DataSource = null;
                gridPostInvestigation.DataBind();
                panelNoPostInvestigation.Visible = true;
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void gridPostInvestigation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var uploadedFileName = DataBinder.Eval(e.Row.DataItem, "UploadedFileName") as string;
            Button btnViewPostDocument = (Button)e.Row.FindControl("btnViewPostDocument");
            Label lbPostInvestigationStage = (Label)e.Row.FindControl("lbPostInvestigationStage");
            lbPostInvestigationStage.Text = "Post Investigation";
            if (string.IsNullOrEmpty(uploadedFileName))
            {
                btnViewPostDocument.Text = "No Document";
                btnViewPostDocument.CssClass = "btn btn-warning btn-sm rounded-pill";
                btnViewPostDocument.Enabled = false;
            }
            else
            {
                btnViewPostDocument.Text = "View Document";
                btnViewPostDocument.CssClass = "btn btn-success btn-sm rounded-pill";
                btnViewPostDocument.Enabled = true;
            }
        }
    }

    protected void btnViewPostDocument_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbPostPackageName = (Label)row.FindControl("lbPostPackageName");
            Label lbPostInvestigationName = (Label)row.FindControl("lbPostInvestigationName");
            Label lbPostFolderName = (Label)row.FindControl("lbPostFolderName");
            Label lbPostFileName = (Label)row.FindControl("lbPostFileName");
            string folderName = lbPostFolderName.Text;
            string fileName = lbPostFileName.Text + ".jpeg";
            string packageName = lbPostPackageName.Text;
            string investigationName = lbPostInvestigationName.Text;
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = packageName + " / " + investigationName;
            mvCPDTabs.SetActiveView(ViewAttachment);
            MultiView2.SetActiveView(viewPostInvestigation);
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
            DataTable dtPostDocument = new DataTable();
            List<string> images = new List<string>();
            dtSpecialDocument = ppdHelper.GetPreInvestigationDocuments(hfHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
            dtManditoryDocument = ppdHelper.GetManditoryDocuments(hfHospitalId.Value, hdPatientRegId.Value);
            dtDischargeDocument = ppdHelper.GetDischargeDocuments(hfHospitalId.Value, hdPatientRegId.Value);
            dtPostDocument = ppdHelper.GetPostInvestigationDocuments(hfHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
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
            if (dtPostDocument != null && dtPostDocument.Rows.Count > 0)
            {
                foreach (DataRow row in dtPostDocument.Rows)
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
                byte[] pdfBytes = ppdHelper.CreatePdfWithImagesInMemory(images);
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

    protected void gvClaimQuery_RowDataBound(object sender, GridViewRowEventArgs e)
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


