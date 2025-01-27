using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;

public partial class MEDCO_PreAuthQueryReply : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    private Discharge dis = new Discharge();
    public static PPDHelper ppdHelper = new PPDHelper();
    private TextboxValidation validateTB = new TextboxValidation();
    string pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else if (!IsPostBack)
            {
                if (Session["RoleId"].ToString() == "2" && Session["RoleName"].ToString() == "MEDCO")
                {
                    hdUserId.Value = Session["UserId"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    GetCasesForQueryReply();
                    MultiView1.SetActiveView(viewPatientList);
                }
                else
                {
                    Response.Redirect("~/Unauthorize.aspx", false);
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
    protected void GetCasesForQueryReply()
    {
        gridQueryCases.DataSource = "";
        gridQueryCases.DataBind();
        dt.Clear();
        dt = preAuth.GetQueryCases(Convert.ToInt32(hdHospitalId.Value));
        if (dt.Rows.Count > 0)
        {
            hdAdmissionDate.Value = dt.Rows[0]["AdmissionDate"].ToString();
            string minDate = DateTime.Parse(hdAdmissionDate.Value).AddDays(1).ToString("yyyy-MM-dd");
            string maxDate = DateTime.Parse(hdAdmissionDate.Value).AddDays(5).ToString("yyyy-MM-dd");
            gridQueryCases.DataSource = dt;
            gridQueryCases.DataBind();
        }
    }
    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbGridPatientRegId = (Label)gridQueryCases.Rows[i].FindControl("lbPatientRegId");
            Label lbGridAdmissionId = (Label)gridQueryCases.Rows[i].FindControl("lbAdmissionId");
            Label lbClaimId = (Label)gridQueryCases.Rows[i].FindControl("lbClaimId");
            Label lbGridCardNo = (Label)gridQueryCases.Rows[i].FindControl("lbCardNo");
            hdPatientRegId.Value = lbGridPatientRegId.Text;
            hdAdmissionId.Value = lbGridAdmissionId.Text;
            hdClaimId.Value = lbClaimId.Text;
            hdAbuaId.Value = lbGridCardNo.Text;

            dt = dis.getSinglePatientDetails(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value));
            if (dt.Rows.Count > 0)
            {
                lbPersonName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                lbBeneficiaryCardId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                lbFamilyId.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                lbRegistrationNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                lbDisplayCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                lbActualRegistrationDate.Text = dt.Rows[0]["RegDate"].ToString();
                lbContactNo.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();
                lbGender.Text = dt.Rows[0]["Gender"].ToString().Trim() == "" ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                lbAge.Text = dt.Rows[0]["Age"].ToString().Trim();
                lbIsChild.Text = dt.Rows[0]["IsNewBornBaby"].ToString();
                lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString();
                lbBiometricVerified.Text = dt.Rows[0]["IsBiometricVerified"].ToString();
                lbPatientDistrict.Text = dt.Rows[0]["District"].ToString();

                string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                string folderName = hdAbuaId.Value;
                string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                string base64String = "";

                string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
                string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
                if (File.Exists(imageUrl))
                {
                    base64String = preAuth.DisplayImage(folderName, imageFileName);
                    if (base64String != "")
                        imgPatient.ImageUrl = "data:image/jpeg;base64," + base64String;
                    else
                        imgPatient.ImageUrl = "~/img/profile.jpeg";
                }


                patientImageBase64 = Convert.ToString(dt.Rows[0]["ChildImageURL"].ToString());
                imageFileName = hdAbuaId.Value + "_Profile_Image_Child.jpeg";
                imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
                if (File.Exists(imageUrl))
                {
                    base64String = "";
                    base64String = preAuth.DisplayImage(folderName, imageFileName);

                    if (base64String != "")
                    {
                        imgChild.ImageUrl = "data:image/jpeg;base64," + base64String;
                        imgChild.Visible = true;
                    }
                    else
                    {
                        imgChild.ImageUrl = "~/img/profile.jpeg";
                        imgChild.Visible = false;
                    }
                }
                BindClaimWorkflow(lbClaimId.Text);
            }
            MultiView1.SetActiveView(viewDischarge);
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            MultiView1.SetActiveView(viewPatientList);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Something Went Wrong! Please Retry.');", true);
        }
    }

    //*****Initial Assesement Display*****//
    protected void btnInitialAssessment_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewInitialAssessment);
        btnInitialAssessment.CssClass = "btn btn-warning p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
    }

    //*****Past History Display*****//
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPasthistory);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-warning p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
    }

    //*****PreAuth Display*****//
    protected void btnPreAutoriztion_Click(object sender, EventArgs e)
    {
        try
        {
            dt = md.GetHospitalDetail(Convert.ToInt32(hdHospitalId.Value));
            if (dt.Rows.Count > 0)
            {
                t3lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString();
                t3lbHospitalName.Text = dt.Rows[0]["HospitalName"].ToString();
                t3lbHospitalAddress.Text = dt.Rows[0]["Address"].ToString();
            }
            dt.Clear();
            dt = dis.getPatientTotalPackageCost(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value));
            if (dt.Rows.Count > 0)
            {
                var admissionType = dt.Rows[0]["AdmissionType"];
                if (admissionType != DBNull.Value)
                {
                    string admissionTypeValue = Convert.ToString(admissionType);
                    if (admissionTypeValue == "0" || admissionTypeValue == "1")
                    {
                        t3dropAdmissionType.SelectedValue = admissionTypeValue;
                    }
                    else
                    {
                        t3dropAdmissionType.SelectedValue = "0";
                    }
                }
                else
                {
                    t3dropAdmissionType.SelectedValue = "0";
                }
                t3lbAdmissionDate.Text = dt.Rows[0]["AdmissionDate"].ToString();
                t3lbPackageCost.Text = dt.Rows[0]["PackageCost"].ToString();
                t3lbIncentiveAmount.Text = dt.Rows[0]["IncentiveAmount"].ToString();
                t3lbTotalPackageCost.Text = dt.Rows[0]["TotalPackageCost"].ToString();
                t3lbHospitalIncentive.Text = dt.Rows[0]["IncentivePercentage"].ToString();
            }
            getAddedProcedure();
            MultiView2.SetActiveView(viewPreAuth);
            btnInitialAssessment.CssClass = "btn btn-primary p-3";
            btnPastHistory.CssClass = "btn btn-primary p-3";
            btnPreAutoriztion.CssClass = "btn btn-warning p-3";
            btnAttachments.CssClass = "btn btn-primary p-3";
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

    //*****Display Work Flow*****//
    private void BindClaimWorkflow(string claimIds)
    {
        dt.Clear();
        string claimId = claimIds.ToString();
        dt = preAuth.GetClaimWorkFlow(Convert.ToInt32(hdClaimId.Value));
        if (dt != null && dt.Rows.Count > 0)
        {
            gridWorkFlow.DataSource = dt;
            gridWorkFlow.DataBind();
        }
        else
        {
            gridWorkFlow.DataSource = null;
            gridWorkFlow.EmptyDataText = "No record found.";
            gridWorkFlow.DataBind();
        }
        BindPreauthQuery(hdClaimId.Value.ToString());
    }

    //*****Discharge Work*****//
    protected void getAddedProcedure()
    {
        DataTable dt = null;
        dt = preAuth.getPatientAddedPackage(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
        if (dt.Rows.Count > 0)
        {
            t3gridAddedpackageProcedure.DataSource = dt;
            t3gridAddedpackageProcedure.DataBind();
        }
        else
        {
            t3gridAddedpackageProcedure.DataSource = "";
            t3gridAddedpackageProcedure.DataBind();
        }
    }
    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAttachment);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-warning p-3";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }
    protected void lnkBackToList_Click(object sender, EventArgs e)
    {
        MultiView2.ActiveViewIndex = -1;
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
        MultiView1.SetActiveView(viewPatientList);
    }
    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {
        MultiView4.SetActiveView(viewPreauthorization);
        btnAttachments.CssClass = "btn btn-warning p-3";
        lnkPreauthorization.CssClass = "nav-link active nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "hideModal();", true);
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }
    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {
        MultiView4.SetActiveView(viewSpecialInvestigation);
        btnAttachments.CssClass = "btn btn-warning p-3";
        lnkSpecialInvestigation.CssClass = "nav-link active nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
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
            Label lbInvestigationStage = (Label)e.Row.FindControl("lbInvestigationStage");
            lbInvestigationStage.Text = "Pre Investigation";
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

    public void BindPreauthQuery(string ClaimId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetPreauthQuery(ClaimId);
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
            LinkButton lnkQueryStatus = (LinkButton)e.Row.FindControl("lnkQueryStatus");
            LinkButton lnkAttachment = (LinkButton)e.Row.FindControl("lnkAttachment");
            Label lbMedcoReply = (Label)e.Row.FindControl("lbMedcoReply");
            TextBox tbMedcoReply = (TextBox)e.Row.FindControl("tbMedcoReply");
            Label lbQueryStatus = (Label)e.Row.FindControl("lbQueryStatus");
            Label lbIsQueryReplied = (Label)e.Row.FindControl("lbIsQueryReplied");
            string IsQueryReplied = lbIsQueryReplied.Text.ToString();
            if (IsQueryReplied != null && !IsQueryReplied.Equals("0"))
            {
                lnkAttachment.CssClass = "btn btn-secondary btn-sm rounded-pill text-white";
                lbQueryStatus.Text = "Query Replied";
                lnkQueryStatus.Enabled = true;
                lnkAttachment.Enabled = false;
                lbMedcoReply.Visible = true;
                tbMedcoReply.Visible = false;
                lbQueryStatus.CssClass = "text-success";
            }
            else
            {
                lnkAttachment.CssClass = "btn btn-primary btn-sm rounded-pill text-white";
                lbQueryStatus.Text = "Query Pending";
                lnkQueryStatus.Enabled = false;
                lnkAttachment.Enabled = true;
                lbMedcoReply.Visible = false;
                tbMedcoReply.Visible = true;
                lbQueryStatus.CssClass = "text-warning";
            }
        }
    }

    protected void lnkQueryStatus_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
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
            MultiView5.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void lnkAttachment_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbQueryId = (Label)row.FindControl("lbQueryId");
            Label lbQueryRasiedByRole = (Label)row.FindControl("lbQueryRasiedByRole");
            TextBox tbMedcoReply = (TextBox)row.FindControl("tbMedcoReply");
            hdQueryId.Value = lbQueryId.Text.ToString();
            hdMedcoReply.Value = tbMedcoReply.Text.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentUploadModal", "showDocumentUploadModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnUploadQueryImage_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuQueryImage.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQueryImage.FileName).ToLower();
                int fileSize = fuQueryImage.PostedFile.ContentLength;
                string mimeType = fuQueryImage.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuQueryImage.PostedFile.InputStream)
                    {
                        byte[] fileBytes = new byte[fileStream.Length];
                        fileStream.Read(fileBytes, 0, fileBytes.Length);

                        // Convert file content to Base64 string
                        string base64String = Convert.ToBase64String(fileBytes);

                        // Further processing with base64String if needed
                        string randomFolderName = hdAbuaId.Value;
                        string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                        string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);

                        if (!Directory.Exists(destinationFolderPath))
                            Directory.CreateDirectory(destinationFolderPath);

                        string fileName = "PreauthQuery_" + "_" + hdQueryId.Value + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        File.WriteAllBytes(imagePath, fileBytes);
                        preAuth.PreAuthReply(hdQueryId.Value, hdMedcoReply.Value, randomFolderName.ToString(), fileName.ToString(), imagePath.ToString());
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                        BindPreauthQuery(hdClaimId.Value.ToString());
                    }
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid File Format! Please upload .jpg/.jpeg/.png')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a file to upload.')", true);
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hdAdmissionId.Value.IsEmpty())
            {
                SqlParameter[] p = new SqlParameter[4];
                p[0] = new SqlParameter("@ClaimId", hdClaimId.Value);
                p[0].DbType = DbType.String;
                p[1] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
                p[1].DbType = DbType.String;
                p[2] = new SqlParameter("@RoleId", Session["RoleId"].ToString());
                p[2].DbType = DbType.String;
                p[3] = new SqlParameter("@Remarks", "");
                p[3].DbType = DbType.String;

                ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_QueryReply", p);
                if (con.State == ConnectionState.Open)
                    con.Close();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
                    {
                        GetCasesForQueryReply();
                        MultiView1.SetActiveView(viewPatientList);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Query Replied Successfully!');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please provide query reply!');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Request!');", true);
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
        }

    }

    protected void btnDownloadPdf_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dtSpecialDocument = new DataTable();
            DataTable dtManditoryDocument = new DataTable();
            List<string> images = new List<string>();
            dtSpecialDocument = ppdHelper.GetPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
            dtManditoryDocument = ppdHelper.GetManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value); ;
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
}