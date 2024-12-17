using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CareerPath.DAL;

public partial class PPD_PPDCaseDetails : System.Web.UI.Page
{
    private string caseNumber, admissionId, claimId;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    public static PPDHelper ppdHelper = new PPDHelper();
    string pageName, childImageUrl;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            caseNumber = Request.QueryString["CaseNumber"];
            admissionId = Request.QueryString["AdmissionId"];
            claimId = Request.QueryString["ClaimId"];
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                MultiView1.SetActiveView(viewPreauth);
                btnPreauth.CssClass = "btn btn-warning p-3";
                GetPatientDetails();
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

    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewPastHistory);
        btnPastHistory.CssClass = "btn btn-warning p-3";
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewPreauth);
        btnPreauth.CssClass = "btn btn-warning p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
    }

    protected void btnTreatmentDischarge_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewTreatmentDischarge);
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-warning p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
    }

    protected void btnAttachmanet_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewAttachment);
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        lnkPreauthorization.CssClass = "nav-link active nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }

    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkPreauthorization.CssClass = "nav-link active nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "hideModal();", true);
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }

    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewSpecialInvestigation);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkSpecialInvestigation.CssClass = "nav-link active nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        getPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }

    protected void lnkDischarge_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDischarge);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link active nav-attach";
        getPreInvestigationDocuments(hdHospitalId.Value, hdAbuaId.Value, hdPatientRegId.Value);
    }

    protected void btnTransactionDataReferences_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Transaction Data References";
        MultiView3.SetActiveView(viewEnhancement);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkPhoto_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Patient Photo";
        MultiView3.SetActiveView(viewPhoto);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkDocument_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Enhancement Justification";
        MultiView3.SetActiveView(viewJustification);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkChildPhoto_Click(object sender, EventArgs e)
    {
        try
        {
            string childImageBase64 = childImageUrl;
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

    //protected void btnViewAudit_Click(object sender, EventArgs e)
    //{
    //    lbTitle.Text = "Raise Query Audit";
    //    MultiView3.SetActiveView(viewAudit);
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    //}

    public void GetPatientDetails()
    {
        try
        {
            SqlParameter[] p = new SqlParameter[4];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@CaseNumber", caseNumber);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@AdmissionId", admissionId);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@ClaimId", claimId);
            p[3].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PPD_GetCaseSearchDetails", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null)
                {
                    MultiViewMain.SetActiveView(viewContent);
                    DateTime registrationDate = Convert.ToDateTime(dt.Rows[0]["RegDate"].ToString().Trim());
                    DateTime admissionDate = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"].ToString().Trim());
                    Session["AdmissionId"] = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    Session["ClaimId"] = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hdCaseId.Value = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString().Trim();
                    hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    hdHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
                    lbPersonName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                    lbBeneficiaryCardId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                    lbRegistrationNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbCaseNumber.Text = "Case No: " + dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbActualRegistrationDate.Text = registrationDate.ToString("dd-MM-yyyy");
                    lbContactNo.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();
                    lbGender.Text = dt.Rows[0]["Gender"].ToString().Trim() == "" ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                    lbFamilyId.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                    lbIsChild.Text = dt.Rows[0]["IsChild"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbBiometricVerified.Text = dt.Rows[0]["IsBiometricVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbPatientDistrict.Text = dt.Rows[0]["District"].ToString().Trim();
                    lbAge.Text = dt.Rows[0]["Age"].ToString().Trim();
                    tbHospitalName.Text = dt.Rows[0]["HospitalName"].ToString().Trim();
                    tbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();
                    tbHospitalAddress.Text = dt.Rows[0]["HospitalAddress"].ToString().Trim();
                    tbAdmissionDate.Text = admissionDate.ToString("dd-MM-yyyy");
                    tbRemarks.Text = dt.Rows[0]["Remarks"].ToString().Trim();

                    if (dt.Rows[0]["AdmissionType"].ToString().Trim() == "0")
                    {
                        rbPlanned.Checked = true;
                    }
                    else
                    {
                        rbEmergency.Checked = true;
                    }

                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString().Trim());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";

                    base64String = preAuth.DisplayImage(folderName, imageFileName);
                    if (base64String != "")
                    {
                        imgPatient.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                    else
                    {
                        imgPatient.ImageUrl = "~/img/profile.jpg";
                    }

                    if (dt.Rows[0]["IsChild"].ToString().Trim() == "True")
                    {
                        if (dt.Rows[0]["ChildGender"].ToString().Trim().Equals("0"))
                        {
                            lbChildGender.Text = "N/A";
                        }
                        else if (dt.Rows[0]["ChildGender"].ToString().Trim().Equals("1"))
                        {
                            lbChildGender.Text = "Male";
                        }
                        else if (dt.Rows[0]["ChildGender"].ToString().Trim().Equals("2"))
                        {
                            lbChildGender.Text = "Female";
                        }
                        lbChildName.Text = dt.Rows[0]["ChildName"].ToString().Trim();
                        lbChildDob.Text = dt.Rows[0]["ChildDOB"].ToString().Trim();
                        lbFatherName.Text = dt.Rows[0]["ChildFatherName"].ToString().Trim();
                        lbMotherName.Text = dt.Rows[0]["ChildMotherName"].ToString().Trim();
                        childImageUrl = Convert.ToString(dt.Rows[0]["ChildImageURL"].ToString().Trim());
                        string childImageBase64 = Convert.ToString(dt.Rows[0]["ChildImageURL"].ToString().Trim());
                        string childfolderName = hdAbuaId.Value;
                        string childImageFileName = hdAbuaId.Value + "_Profile_Image_Child.jpeg";
                        string childBase64String = "";

                        childBase64String = preAuth.DisplayImage(childfolderName, childImageFileName);
                        if (childBase64String != "")
                        {
                            imgChild.ImageUrl = "data:image/jpeg;base64," + childBase64String;
                        }
                        else
                        {
                            imgChild.ImageUrl = "~/img/profile.jpg";
                        }
                        panelChild.Visible = true;
                        imgChild.Visible = true;
                    }
                    else
                    {
                        panelChild.Visible = false;
                        imgChild.Visible = false;
                    }
                    getPrimaryDiagnosis();
                    getSecondaryDiagnosis();
                    getPatientPrimaryDiagnosis();
                    getPatientSecondaryDiagnosis();
                    getTreatementProtocol();
                    getAdmissionDetails();
                    getWorkFlow(dt.Rows[0]["ClaimId"].ToString().Trim());
                    getPreauthQuery(dt.Rows[0]["ClaimId"].ToString().Trim());
                    getCaseCurrentAction(dt.Rows[0]["ClaimId"].ToString().Trim());
                }
                else
                {
                    MultiViewMain.SetActiveView(viewNoContent);
                }
            }
            else
            {
                MultiViewMain.SetActiveView(viewNoContent);
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
            dt = preAuth.GetPatientPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridPrimaryDiagnosis.DataSource = dt;
                gridPrimaryDiagnosis.DataBind();
                gridPrimaryDiagnosisValues.DataSource = dt;
                gridPrimaryDiagnosisValues.DataBind();
            }
            else
            {
                gridPrimaryDiagnosis.DataSource = null;
                gridPrimaryDiagnosis.DataBind();
                gridPrimaryDiagnosisValues.DataSource = null;
                gridPrimaryDiagnosisValues.DataBind();
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
            dt = preAuth.GetPatientSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridSecondaryDiagnosis.DataSource = dt;
                gridSecondaryDiagnosis.DataBind();
                gridSecondaryDiagnosisValues.DataSource = dt;
                gridSecondaryDiagnosisValues.DataBind();
            }
            else
            {
                gridSecondaryDiagnosis.DataSource = null;
                gridSecondaryDiagnosis.DataBind();
                gridSecondaryDiagnosisValues.DataSource = null;
                gridSecondaryDiagnosisValues.DataBind();
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

    protected void getPrimaryDiagnosis()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = preAuth.getPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
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
                dropPrimaryDiagnosis.Items.Clear();
                dropPrimaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    protected void getSecondaryDiagnosis()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = preAuth.getSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
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
                dropSecondaryDiagnosis.Items.Clear();
                dropSecondaryDiagnosis.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    protected void getTreatementProtocol()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = preAuth.getPatientAddedPackage(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridTreatementProtocol.DataSource = dt;
                gridTreatementProtocol.DataBind();
            }
            else
            {
                gridTreatementProtocol.DataSource = null;
                gridTreatementProtocol.DataBind();
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

    protected void getAdmissionDetails()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetAdmissionDetails(Session["AdmissionId"].ToString());
            if (dt != null && dt.Rows.Count > 0)
            {
                tbPackageCost.Text = dt.Rows[0]["PackageCost"].ToString();
                tbIncentiveCost.Text = dt.Rows[0]["IncentiveAmount"].ToString();
                tbTotalPackageCost.Text = dt.Rows[0]["TotalPackageCost"].ToString();
                tbImplantCost.Text = dt.Rows[0]["ImplantAmount"].ToString();
                lbIncentivePercentage.Text = dt.Rows[0]["IncentivePercentage"].ToString() + " %";
                if (Session["RoleId"].ToString() == "3")
                {
                    lbRoleStatus.Text = "The amount liable by insurance is";
                    tbAmountLiable.Text = dt.Rows[0]["InsurerClaimAmountRequested"].ToString();
                }
                else if (Session["RoleId"].ToString() == "4")
                {
                    lbRoleStatus.Text = "The amount liable by trust is";
                    tbAmountLiable.Text = dt.Rows[0]["TrustClaimAmountRequested"].ToString();
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

    public void getWorkFlow(string ClaimId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetWorkFlow(ClaimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                gridWorkFlow.DataSource = dt;
                gridWorkFlow.DataBind();
            }
            else
            {
                gridWorkFlow.DataSource = null;
                gridWorkFlow.DataBind();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    public void getPreauthQuery(string ClaimId)
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
            MultiView3.SetActiveView(viewPhoto);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected string getRegisteredByText(object registeredBy)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetUserDetails(registeredBy.ToString());
            if (dt != null && dt.Rows.Count > 0)
            {
                return dt.Rows[0]["RoleName"].ToString().Trim();
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
        return "Unknown";
    }

    public void getCaseCurrentAction(string ClaimId)
    {
        try
        {
            DataTable dt = new DataTable();
            string ActionId = null;
            dt = ppdHelper.GetCaseCurrentAction(ClaimId);
            if (dt != null && dt.Rows.Count > 0)
            {
                if (Session["RoleId"].ToString() == "3")
                {
                    ActionId = dt.Rows[0]["ForwardActionInsurer"].ToString().Trim();
                }
                else if (Session["RoleId"].ToString() == "4")
                {
                    ActionId = dt.Rows[0]["ForwardActionTrust"].ToString().Trim();
                }
                switch (ActionId)
                {
                    case "1":
                        tbAction.Text = "Approve";
                        break;
                    case "2":
                        tbAction.Text = "Assigned To";
                        break;
                    case "4":
                        tbAction.Text = "Raise Query";
                        break;
                    case "5":
                        tbAction.Text = "Reject";
                        break;
                    default:
                        break;
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
}