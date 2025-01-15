using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using CareerPath.DAL;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Linq;
partial class MEDCO_PreAuth : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    string pageName;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else if (!IsPostBack)
            {
                if (Session["RoleId"].ToString() == "2" && Session["RoleName"].ToString() == "MEDCO")
                {
                    panelStratification.Visible = false;
                    panelImplant.Visible = false;
                    panelAddedDocument.Visible = false;
                    panelDocumentsRequired.Visible = true;
                    hdUserId.Value = Session["UserId"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    getRegisteredPatient();
                    getPrimaryDiagnosis();
                    getSecondaryDiagnosis();
                    divChild.Visible = false;
                    //ShowPreInvestigationDocuments();
                    MultiView1.SetActiveView(viewRegisteredPatient);
                    MultiView2.SetActiveView(View1);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //if (TextboxValidation.isNumeric(tbSearchRegno.Text) == false)
        //{
        //    string strMessage = "window.alert('Invalid Entry!');";
        //    ScriptManager.RegisterStartupScript(btnSearch, btnSearch.GetType(), "AlertMessage", strMessage, true);
        //    return;
        //}
        //gridRegisteredPatient.DataSource = "";
        //gridRegisteredPatient.DataBind();
        //dt.Clear();
        //dt = preAuth.PreAuthCaseSearch(Convert.ToInt32(hdHospitalId.Value), Convert.ToInt32(tbSearchRegno.Text), tbSearchBeneficiaryCardNo.Text, Convert.ToInt32(dropSearchDistrict.SelectedValue), Convert.ToDateTime(tbSearchRegisteredFromDate.Text), Convert.ToDateTime(tbSearchRegisteredToDate.Text));
        //if (dt.Rows.Count > 0)
        //{
        //    gridRegisteredPatient.DataSource = dt;
        //    gridRegisteredPatient.DataBind();
        //}
        //else
        //{
        //    gridRegisteredPatient.DataSource = "";
        //    gridRegisteredPatient.DataBind();
        //}
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbSearchRegno.Text = "";
        tbSearchBeneficiaryCardNo.Text = "";
        tbSearchRegisteredFromDate.Text = "";
        tbSearchRegisteredToDate.Text = "";
        dropSearchDistrict.SelectedIndex = 0;
        dropSearchStateScheme.SelectedIndex = 0;
    }
    protected void getRegisteredPatient()
    {
        gridRegisteredPatient.DataSource = "";
        gridRegisteredPatient.DataBind();
        dt.Clear();
        dt = preAuth.GetRegisteredPatientForPreAuth(Convert.ToInt32(hdHospitalId.Value));
        if (dt.Rows.Count > 0)
        {
            gridRegisteredPatient.DataSource = dt;
            gridRegisteredPatient.DataBind();
        }
        else
        {
            gridRegisteredPatient.DataSource = "";
            gridRegisteredPatient.DataBind();
        }
    }
    protected void lnkRegId_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbGridRegId = (Label)gridRegisteredPatient.Rows[i].FindControl("lbRegId");
            lbRegNo.Text = lbGridRegId.Text;
            Label lbGridCardNo = (Label)gridRegisteredPatient.Rows[i].FindControl("lbPatientCardNo");
            hdAbuaId.Value = lbGridCardNo.Text;
            SqlParameter[] p = new SqlParameter[3];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@CardNumber", lbGridCardNo.Text);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PatientRegId", lbGridRegId.Text);
            p[2].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_GetRegisteredPatientForPreAuthAdmission", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                MultiView1.SetActiveView(viewAdmission);
                if (dt.Rows[0]["CheckId"].ToString() == "1")
                {
                    // hdAbuaId.Value = lbGridAbuaId.Text
                    hdPatientRegId.Value = lbGridRegId.Text;
                    lbName.Text = dt.Rows[0]["PatientName"].ToString();
                    lbGender.Text = dt.Rows[0]["Gender"].ToString();
                    lbCardNumber.Text = dt.Rows[0]["CardNumber"].ToString();
                    lbAge.Text = dt.Rows[0]["Age"].ToString();
                    lbRegDate.Text = dt.Rows[0]["RegDate"].ToString();
                    lbMobileNo.Text = dt.Rows[0]["MobileNumber"].ToString();
                    lbFamilId.Text = dt.Rows[0]["PatientFamilyId"].ToString();
                    if (dt.Rows[0]["IsAadharVerified"].ToString() == "True")
                        lbAadharVerified.Text = "Yes";
                    else
                        lbAadharVerified.Text = "No";
                    if (dt.Rows[0]["IsBiometricVerified"].ToString() == "True")
                        lbBiometricVerified.Text = "Yes";
                    else
                        lbBiometricVerified.Text = "No";
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";
                    base64String = preAuth.DisplayImage(folderName, imageFileName);
                    if (base64String != "")
                        imgPatientPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                    else
                        imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";

                    //Child Details
                    if (dt.Columns.Contains("IsChild") && dt.Rows[0]["IsChild"].ToString() == "True")
                    {
                        lbChildName.Text = dt.Rows[0]["ChildName"].ToString();
                        lbChildDOB.Text = dt.Rows[0]["ChildDOB"].ToString();
                        patientImageBase64 = Convert.ToString(dt.Rows[0]["ChildImageURL"].ToString());
                        imageFileName = hdAbuaId.Value + "_Profile_Image_Child.jpeg";

                        base64String = "";
                        base64String = preAuth.DisplayImage(folderName, imageFileName);

                        if (base64String != "")
                        {
                            imgChildPhoto.ImageUrl = "data:image/jpeg;base64," + base64String;
                            imgChildPhoto.Visible = true;
                        }
                        else
                        {
                            imgChildPhoto.ImageUrl = "~/img/profile.jpeg";
                            imgChildPhoto.Visible = false;
                        }
                    }
                    else
                    {
                        imgChildPhoto.Visible = true;
                        divChild.Visible = false;
                        imgChildPhoto.Visible = false;
                    }

                    getPatientPrimaryDiagnosis();
                    getPatientSecondaryDiagnosis();
                    dt.Clear();
                    dt = preAuth.getPackageMaster();
                    if (dt.Rows.Count > 0)
                    {
                        dropPackageMaster.Items.Clear();
                        dropPackageMaster.DataValueField = "Packageid";
                        dropPackageMaster.DataTextField = "SpecialtiyName";
                        dropPackageMaster.DataSource = dt;
                        dropPackageMaster.DataBind();
                        dropPackageMaster.Items.Insert(0, new ListItem("--SELECT--", "0"));
                    }
                    else
                    {
                        dropPackageMaster.Items.Clear();
                        dropPackageMaster.Items.Insert(0, new ListItem("--SELECT--", "0"));
                    }
                    getAddedProcedure();
                    ShowPreInvestigationDocuments();
                    getPatientPackageTotalAmount();
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Record! Please remove patient and register again!');", true);
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Records missing! Please register the patient again!');", true);
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            MultiView1.SetActiveView(viewRegisteredPatient);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Something Went Wrong! Please Retry.');", true);
        }
    }
    protected void lnkDeletePatient_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbGridRegId = (Label)gridRegisteredPatient.Rows[i].FindControl("lbRegId");
            Label lbGridCardNo = (Label)gridRegisteredPatient.Rows[i].FindControl("lbCardNo");
            // Dim dropUpdate As DropDownList = DirectCast(row.FindControl("dropStatus"), DropDownList)
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@PatientRegId", lbGridRegId.Text);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@CardNumber", lbGridCardNo.Text);
            p[1].DbType = DbType.String;
            SqlHelper.ExecuteNonQuery(con, CommandType.StoredProcedure, "TMS_PreAuthRemovePatient", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            strMessage = "window.alert('Patient removed successfully!');";
            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
            getRegisteredPatient();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            strMessage = "window.alert('Patient already removed! Please reolad the page');";
            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
        }
    }
    protected void lnkBackToList_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewRegisteredPatient);
    }
    protected void showGeneralFindingModal_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthGetPatientGeneralFindings", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows[0]["checkId"].ToString() == "1")
                {
                    if (dt.Rows[0]["Temperature"].ToString() == "False")
                    {
                        rbGTempC.Checked = true;
                        rbGTempF.Checked = false;
                    }
                    else if (dt.Rows[0]["Temperature"].ToString() == "True")
                    {
                        rbGTempF.Checked = true;
                        rbGTempC.Checked = false;
                    }
                    tbGTemp.Text = dt.Rows[0]["TemperatureData"].ToString();
                    tbGPulseRate.Text = dt.Rows[0]["PulseRate"].ToString();
                    tbGBPLArm1.Text = dt.Rows[0]["BPLeftArm"].ToString();
                    tbGBPLArm2.Text = dt.Rows[0]["BPLeftArm1"].ToString();
                    tbGBPRArm1.Text = dt.Rows[0]["BPRightArm"].ToString();
                    tbGBPRArm2.Text = dt.Rows[0]["BPRightArm1"].ToString();
                    tbGHeight.Text = dt.Rows[0]["HeightInCm"].ToString();
                    tbGWeight.Text = dt.Rows[0]["WeightInKg"].ToString();
                    tbGBMI.Text = dt.Rows[0]["BMI"].ToString();

                    if (dt.Rows[0]["Pallor"].ToString() == "False")
                    {
                        rbGPallorYes.Checked = false;
                        rbGPallorNo.Checked = true;
                    }
                    else if (dt.Rows[0]["Pallor"].ToString() == "True")
                    {
                        rbGPallorYes.Checked = true;
                        rbGPallorNo.Checked = false;
                    }

                    if (dt.Rows[0]["Cyanosis"].ToString() == "False")
                    {
                        rbGCyanosisYes.Checked = false;
                        rbGCyanosisNo.Checked = true;
                    }
                    else if (dt.Rows[0]["Cyanosis"].ToString() == "True")
                    {
                        rbGCyanosisYes.Checked = true;
                        rbGCyanosisNo.Checked = false;
                    }

                    if (dt.Rows[0]["ClubbingOfFingers"].ToString() == "False")
                    {
                        rbGClubbingYes.Checked = false;
                        rbGClubbingNo.Checked = true;
                    }
                    else if (dt.Rows[0]["ClubbingOfFingers"].ToString() == "True")
                    {
                        rbGClubbingYes.Checked = true;
                        rbGClubbingNo.Checked = false;
                    }

                    if (dt.Rows[0]["Lymphadenopathy"].ToString() == "False")
                    {
                        rbGLymphaYes.Checked = false;
                        rbGLymphaNo.Checked = true;
                    }
                    else if (dt.Rows[0]["Lymphadenopathy"].ToString() == "True")
                    {
                        rbGLymphaYes.Checked = true;
                        rbGLymphaNo.Checked = false;
                    }

                    if (dt.Rows[0]["OedemaInFeet"].ToString() == "False")
                    {
                        rbGOedemaYes.Checked = false;
                        rbGOedemaNo.Checked = true;
                    }
                    else if (dt.Rows[0]["OedemaInFeet"].ToString() == "True")
                    {
                        rbGOedemaYes.Checked = true;
                        rbGOedemaNo.Checked = false;
                    }

                    if (dt.Rows[0]["Malnutrition"].ToString() == "False")
                    {
                        rbGMalYes.Checked = false;
                        rbGMalNo.Checked = true;
                    }
                    else if (dt.Rows[0]["Malnutrition"].ToString() == "True")
                    {
                        rbGMalYes.Checked = true;
                        rbGMalNo.Checked = false;
                    }

                    if (dt.Rows[0]["Dehydration"].ToString() == "False")
                    {
                        rbGDehydYes.Checked = false;
                        rbGDehydNo.Checked = true;
                    }
                    else if (dt.Rows[0]["Dehydration"].ToString() == "True")
                    {
                        rbGDehydYes.Checked = true;
                        rbGDehydNo.Checked = false;
                    }
                    tbGRespiration.Text = dt.Rows[0]["Respiration"].ToString();
                }
            }
            MultiView2.SetActiveView(View1);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
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
    protected void hideGeneralFindingModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
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
    protected void showPersonalHistoryModal_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthGetPersonalHistory", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows[0]["checkId"].ToString() == "1")
                {
                    dropAppetite.SelectedValue = dt.Rows[0]["Appetite"].ToString();
                    dropDiet.SelectedValue = dt.Rows[0]["Diet"].ToString();
                    dropBowels.SelectedValue = dt.Rows[0]["Bowels"].ToString();
                    dropNutrition.SelectedValue = dt.Rows[0]["Nutrition"].ToString();
                    if (dt.Rows[0]["KnownAllergies"].ToString() == "true")
                        rbAllergiesYes.Checked = true;
                    else
                        rbAllergiesNo.Checked = false;
                    if (dt.Rows[0]["HabitsAddiction"].ToString() == "true")
                        rbHabitsYes.Checked = true;
                    else
                        rbHabitsNo.Checked = false;
                }
            }
            MultiView2.SetActiveView(View2);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
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
    protected void hidePersonalHistoryModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
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
    protected void showFamilyHistoryModal_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthGetPatientFamilyHistory", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows[0]["checkId"].ToString() == "1")
                {
                    cbPEndocrineDiseases.Checked = Convert.ToBoolean(dt.Rows[0]["PEndocrine"].ToString());
                    cbPDiabetes.Checked = Convert.ToBoolean(dt.Rows[0]["PDiabetes"].ToString());
                    cbPHypertension.Checked = Convert.ToBoolean(dt.Rows[0]["PHypertension"].ToString());
                    cbPCAD.Checked = Convert.ToBoolean(dt.Rows[0]["PCAD"].ToString());
                    cbPAsthma.Checked = Convert.ToBoolean(dt.Rows[0]["PAsthma"].ToString());
                    cbPTuberculosis.Checked = Convert.ToBoolean(dt.Rows[0]["PTuberculosis"].ToString());
                    cbPStroke.Checked = Convert.ToBoolean(dt.Rows[0]["PStroke"].ToString());
                    cbPCancers.Checked = Convert.ToBoolean(dt.Rows[0]["PCancers"].ToString());
                    cbPBloodTransfusion.Checked = Convert.ToBoolean(dt.Rows[0]["PBlood"].ToString());
                    cbPSurgeries.Checked = Convert.ToBoolean(dt.Rows[0]["PSurgeries"].ToString());
                    cbPOther.Checked = Convert.ToBoolean(dt.Rows[0]["POther"].ToString());
                    cbPNotApplicable.Checked = Convert.ToBoolean(dt.Rows[0]["PNotApplicable"].ToString());
                    cbFDiabetes.Checked = Convert.ToBoolean(dt.Rows[0]["FDiabetes"].ToString());
                    cbFHypertension.Checked = Convert.ToBoolean(dt.Rows[0]["FHypertension"].ToString());
                    cbFHeartDisease.Checked = Convert.ToBoolean(dt.Rows[0]["FHeartDisease"].ToString());
                    cbFStroke.Checked = Convert.ToBoolean(dt.Rows[0]["FStroke"].ToString());
                    cbFCancers.Checked = Convert.ToBoolean(dt.Rows[0]["FCancers"].ToString());
                    cbFTuberculosis.Checked = Convert.ToBoolean(dt.Rows[0]["FTuber"].ToString());
                    cbFAsthma.Checked = Convert.ToBoolean(dt.Rows[0]["FAsthma"].ToString());
                    cbFAnyOtherHereditary.Checked = Convert.ToBoolean(dt.Rows[0]["FAnyOther"].ToString());
                    cbFPsychiatristIllness.Checked = Convert.ToBoolean(dt.Rows[0]["FPsychiatrist"].ToString());
                    cbFAnyOther.Checked = Convert.ToBoolean(dt.Rows[0]["FOther"].ToString());
                    cbFNotApplicable.Checked = Convert.ToBoolean(dt.Rows[0]["FNotApplicable"].ToString());
                }
            }
            MultiView2.SetActiveView(View3);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
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
    protected void hideFamilyHistoryModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
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
    protected void btnGeneralFinding_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextboxValidation.isDecimal(tbGTemp.Text) == false || TextboxValidation.isNumeric(tbGPulseRate.Text) == false || TextboxValidation.isNumeric(tbGBPLArm1.Text) == false || TextboxValidation.isNumeric(tbGBPLArm2.Text) == false || TextboxValidation.isNumeric(tbGBPRArm1.Text) == false || TextboxValidation.isNumeric(tbGBPRArm2.Text) == false || TextboxValidation.isNumeric(tbGHeight.Text) == false || TextboxValidation.isDecimal(tbGWeight.Text) == false || TextboxValidation.isDecimal(tbGBMI.Text) == false)
            {
                string strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "AlertMessage", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
                return;
            }
            bool Temp = false;
            string TempData = "";
            string PulseRate = "";
            string BPLArm = "";
            string BPLArm1 = "";
            bool Pallor = false;
            bool Cyanosis = false;
            bool Clubbing = false;
            bool Lymph = false;
            bool Oedema = false;
            bool Mal = false;
            bool Dehyd = false;
            string Respiration = "";
            if (rbGTempC.Checked == true | rbGTempF.Checked == true)
            {
                if (tbGTemp.Text != "")
                {
                    TempData = tbGTemp.Text;
                    if (rbGTempC.Checked == true)
                        Temp = false;
                    else
                        Temp = true;
                }
                else
                {
                    strMessage = "window.alert('Please enter temperature!');";
                    ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
                    return;
                }
            }
            else
            {
                strMessage = "window.alert('Please select temperature!');";
                ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
                return;
            }
            if (tbGPulseRate.Text != "")
                PulseRate = tbGPulseRate.Text;
            else
            {
                strMessage = "window.alert('Please enter PulseRate!');";
                ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
                return;
            }
            if (tbGBPLArm1.Text != "" & tbGBPLArm2.Text != "")
            {
                BPLArm = tbGBPLArm1.Text;
                BPLArm1 = tbGBPLArm2.Text;
            }
            else
            {
                strMessage = "window.alert('Please enter BP Left Arm!');";
                ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showGeneralFindingModal", "showGeneralFindingModal();", true);
                return;
            }
            if (rbGPallorYes.Checked == true)
                Pallor = true;
            else
                Pallor = false;
            if (rbGCyanosisYes.Checked == true)
                Cyanosis = true;
            else
                Cyanosis = false;
            if (rbGClubbingYes.Checked == true)
                Clubbing = true;
            else
                Clubbing = false;
            if (rbGLymphaYes.Checked == true)
                Lymph = true;
            else
                Lymph = false;
            if (rbGOedemaYes.Checked == true)
                Oedema = true;
            else
                Oedema = false;
            if (rbGMalYes.Checked == true)
                Mal = true;
            else
                Mal = false;
            if (rbGDehydYes.Checked == true)
                Dehyd = true;
            else
                Dehyd = false;
            SqlParameter[] p = new SqlParameter[21];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@Temperature", Temp.ToString());
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@TemperatureData", TempData.ToString());
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@PulseRate", PulseRate.ToString());
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@BPLeftArm", BPLArm.ToString());
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@BPLeftArm1", BPLArm1.ToString());
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@BPRightArm", tbGBPRArm1.Text);
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@BPRightArm1", tbGBPRArm2.Text);
            p[8].DbType = DbType.String;
            p[9] = new SqlParameter("@HeightInCm", tbGHeight.Text);
            p[9].DbType = DbType.String;
            p[10] = new SqlParameter("@WeightInKg", tbGWeight.Text);
            p[10].DbType = DbType.String;
            p[11] = new SqlParameter("@BMI", tbGBMI.Text);
            p[11].DbType = DbType.String;
            p[12] = new SqlParameter("@Pallor", Pallor.ToString());
            p[12].DbType = DbType.String;
            p[13] = new SqlParameter("@Cyanosis", Cyanosis.ToString());
            p[13].DbType = DbType.String;
            p[14] = new SqlParameter("@ClubbingOfFingers", Clubbing.ToString());
            p[14].DbType = DbType.String;
            p[15] = new SqlParameter("@Lymphadenopathy", Lymph.ToString());
            p[15].DbType = DbType.String;
            p[16] = new SqlParameter("@OedemaInFeet", Oedema.ToString());
            p[16].DbType = DbType.String;
            p[17] = new SqlParameter("@Malnutrition", Mal.ToString());
            p[17].DbType = DbType.String;
            p[18] = new SqlParameter("@Dehydration", Dehyd.ToString());
            p[18].DbType = DbType.String;
            p[19] = new SqlParameter("@Respiration", tbGRespiration.Text);
            p[19].DbType = DbType.String;
            p[20] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[20].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertGeneralFindings", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                {
                    strMessage = "window.alert('Added Successfully!');";
                    ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                {
                    strMessage = "window.alert('Updated Successfully!');";
                    ScriptManager.RegisterStartupScript(btnGeneralFinding, btnGeneralFinding.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
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

    protected void btnSavePersonalHistory_Click(object sender, EventArgs e)
    {
        try
        {
            bool allergies = false;
            bool addiction = false;
            if (rbAllergiesYes.Checked == true)
                allergies = true;
            else
                allergies = false;
            if (rbHabitsYes.Checked == true)
                addiction = true;
            else
                addiction = false;
            SqlParameter[] p = new SqlParameter[9];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@Appetite", dropAppetite.SelectedValue);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@Diet", dropDiet.SelectedValue);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@Bowels", dropBowels.SelectedValue);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@Nutrition", dropNutrition.SelectedValue);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@KnownAllergies", allergies.ToString());
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@HabitsAddiction", addiction.ToString());
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[8].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertPersonalHistory", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                {
                    strMessage = "window.alert('Added Successfully!');";
                    ScriptManager.RegisterStartupScript(btnSavePersonalHistory, btnSavePersonalHistory.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                {
                    strMessage = "window.alert('Updated Successfully!');";
                    ScriptManager.RegisterStartupScript(btnSavePersonalHistory, btnSavePersonalHistory.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
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

    protected void btnSaveFamilyHistory_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[26];
            p[0] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PEndocrine", Convert.ToString(cbPEndocrineDiseases.Checked.ToString()));
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@PDiabetes", Convert.ToString(cbPDiabetes.Checked.ToString()));
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@PHypertension", Convert.ToString(cbPHypertension.Checked.ToString()));
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@PCAD", Convert.ToString(cbPCAD.Checked.ToString()));
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@PAsthma", Convert.ToString(cbPAsthma.Checked.ToString()));
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@PTuberculosis", Convert.ToString(cbPTuberculosis.Checked.ToString()));
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@PStroke", Convert.ToString(cbPStroke.Checked.ToString()));
            p[8].DbType = DbType.String;
            p[9] = new SqlParameter("@PCancers", Convert.ToString(cbPCancers.Checked.ToString()));
            p[9].DbType = DbType.String;
            p[10] = new SqlParameter("@PBlood", Convert.ToString(cbPBloodTransfusion.Checked.ToString()));
            p[10].DbType = DbType.String;
            p[11] = new SqlParameter("@PSurgeries", Convert.ToString(cbPSurgeries.Checked.ToString()));
            p[11].DbType = DbType.String;
            p[12] = new SqlParameter("@POther", Convert.ToString(cbPOther.Checked.ToString()));
            p[12].DbType = DbType.String;
            p[13] = new SqlParameter("@PNotApplicable", Convert.ToString(cbPNotApplicable.Checked.ToString()));
            p[13].DbType = DbType.String;
            p[14] = new SqlParameter("@FDiabetes", Convert.ToString(cbFDiabetes.Checked.ToString()));
            p[14].DbType = DbType.String;
            p[15] = new SqlParameter("@FHypertension", Convert.ToString(cbFHypertension.Checked.ToString()));
            p[15].DbType = DbType.String;
            p[16] = new SqlParameter("@FHeartDisease", Convert.ToString(cbFHeartDisease.Checked.ToString()));
            p[16].DbType = DbType.String;
            p[17] = new SqlParameter("@FStroke", Convert.ToString(cbFStroke.Checked.ToString()));
            p[17].DbType = DbType.String;
            p[18] = new SqlParameter("@FCancers", Convert.ToString(cbFCancers.Checked.ToString()));
            p[18].DbType = DbType.String;
            p[19] = new SqlParameter("@FTuber", Convert.ToString(cbFTuberculosis.Checked.ToString()));
            p[19].DbType = DbType.String;
            p[20] = new SqlParameter("@FAsthma", Convert.ToString(cbFAsthma.Checked.ToString()));
            p[20].DbType = DbType.String;
            p[21] = new SqlParameter("@FAnyOther", Convert.ToString(cbFAnyOtherHereditary.Checked.ToString()));
            p[21].DbType = DbType.String;
            p[22] = new SqlParameter("@FPsychiatrist", Convert.ToString(cbFPsychiatristIllness.Checked.ToString()));
            p[22].DbType = DbType.String;
            p[23] = new SqlParameter("@FOther", Convert.ToString(cbFAnyOther.Checked.ToString()));
            p[23].DbType = DbType.String;
            p[24] = new SqlParameter("@FNotApplicable", Convert.ToString(cbFNotApplicable.Checked.ToString()));
            p[24].DbType = DbType.String;
            p[25] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[25].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertFamilyHistory", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                {
                    strMessage = "window.alert('Added Successfully!');";
                    ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                {
                    strMessage = "window.alert('Updated Successfully!');";
                    ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideGeneralFindingModal", "hideGeneralFindingModal();", true);
                    return;
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

    protected void lnkDeletePrimaryDiagnosis_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbPPDId = (Label)gridPrimaryDiagnosis.Rows[i].FindControl("lbPPDId");
            int rowsAffected = 0;
            rowsAffected = preAuth.DeletePrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbPPDId.Text));
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
            strMessage = "window.alert('Already Deleted!');";
            ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }

    protected void lnkDeleteSecondaryDiagnosis_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbSPDId = (Label)gridSecondaryDiagnosis.Rows[i].FindControl("lbSPDId");
            int rowsAffected = 0;
            rowsAffected = preAuth.DeleteSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbSPDId.Text));
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
            strMessage = "window.alert('Already Deleted!');";
            ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }
    protected void dropPrimaryDiagnosis_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            // divPrimaryDiagnosis.Style("display") = "block"
            // lbPrimaryDiagnosisSelected.Text = dropPrimaryDiagnosis.SelectedItem.Text
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
            ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }
    protected void getPatientPrimaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                gridPrimaryDiagnosis.DataSource = dt;
                gridPrimaryDiagnosis.DataBind();
            }
            else
            {
                gridPrimaryDiagnosis.DataSource = "";
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
    protected void getPrimaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = preAuth.getPrimaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
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
            ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }
    protected void getPatientSecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
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
    protected void getSecondaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = preAuth.getSecondaryDiagnosis(hdAbuaId.Value, hdPatientRegId.Value);
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
    protected void dropPackageMaster_SelectedIndexChanged(object sender, EventArgs e)
    {
        dt.Clear();
        dt = preAuth.getPackageProcedureDetail(Convert.ToInt32(dropPackageMaster.SelectedValue));
        if (dt.Rows.Count > 0)
        {
            dropProcedure.Items.Clear();
            dropProcedure.DataValueField = "ProcedureId";
            dropProcedure.DataTextField = "ProcedureName";
            dropProcedure.DataSource = dt;
            dropProcedure.DataBind();
            dropProcedure.Items.Insert(0, new ListItem("--SELECT--", "0"));
        }
        else
        {
            dropProcedure.Items.Clear();
            dropProcedure.Items.Insert(0, new ListItem("--SELECT--", "0"));
        }
    }
    protected void dropProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = null;
            DataTable dt1 = null;
            SqlParameter[] p = new SqlParameter[5];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@PackageId", dropPackageMaster.SelectedValue);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@ProcedureId", dropProcedure.SelectedValue);
            p[4].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthCheckMultipleProcedure", p);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows[0]["Id"].ToString() == "0")
                {
                    strMessage = "window.alert('Cannot Be Clubbed Together!');";
                    ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                    dropProcedure.SelectedValue = "0";
                    return;
                }
                if (dropPackageMaster.SelectedValue == "28")
                {
                    panelUnspecified.Visible = true;
                }
                else
                {
                    panelUnspecified.Visible = false;
                }
                if (dt.Rows[0]["Id"].ToString() == "1")
                {
                    if (dt.Rows[0]["StratificationId"].ToString() != "0")
                    {
                        panelStratification.Visible = true;
                        dropStratificationType.Items.Clear();
                        dropStratificationOption.Items.Clear();
                        dropStratificationType.DataTextField = "StratificationName";
                        dropStratificationOption.DataValueField = "StratificationId";
                        dropStratificationOption.DataTextField = "StratificationDetail";
                        dropStratificationType.DataSource = dt;
                        dropStratificationType.DataBind();
                        dropStratificationOption.DataSource = dt;
                        dropStratificationOption.DataBind();
                    }
                    else
                    {
                        dropStratificationOption.Items.Clear();
                        dropStratificationOption.Items.Insert(0, new ListItem("--SELECT--", "0"));
                        panelStratification.Visible = false;
                    }
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    dt1 = ds.Tables[1];
                    if (dt1.Rows[0]["Id"].ToString() == "1")
                    {
                        if (dt1.Rows[0]["ImplantId"].ToString() != "0")
                        {
                            panelImplant.Visible = true;
                            dropImplantOption.DataValueField = "ImplantId";
                            dropImplantOption.DataTextField = "ImplantName";
                            dropImplantOption.DataSource = dt1;
                            dropImplantOption.DataBind();
                        }
                        else
                        {
                            dropImplantOption.Items.Clear();
                            dropImplantOption.Items.Insert(0, new ListItem("--SELECT--", "0"));
                            panelImplant.Visible = false;
                        }
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
    protected void btnAddProcedure_Click(object sender, EventArgs e)
    {
        try
        {
            if (dropPackageMaster.SelectedValue != "0")
            {
                if (TextboxValidation.isNumeric(tbImplantCount.Text) == false)
                {
                    string strMessage = "window.alert('Invalid Entry!');";
                    ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "AlertMessage", strMessage, true);
                    return;
                }
                if (dropProcedure.SelectedValue != "0" && tbImplantCount.Text != "" && Convert.ToInt32(tbImplantCount.Text) >= 0)
                {
                    if (dropPackageMaster.SelectedValue == "28")
                    {
                        if (tbUnspecifiedProcedureName.Text == "" || Convert.ToInt32(tbUnspecifiedProcedureAmount.Text) <= 0 || tbUnspecifiedProcedureInvestigation.Text == "")
                        {
                            string strMessage = "window.alert('Invalid Entry!');";
                            ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "AlertMessage", strMessage, true);
                            return;
                        }
                        else if (Convert.ToInt32(tbUnspecifiedProcedureAmount.Text) > 100000)
                        {
                            string strMessage = "window.alert('Amount should be less than or equal to 100000!');";
                            ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "AlertMessage", strMessage, true);
                            return;
                        }
                    }
                    //if (tbInvestigation.Text != "")
                    //{
                    int stratificationId = 0, implantId = 0;
                    if (dropStratificationOption.SelectedValue != "0")
                    {
                        stratificationId = Convert.ToInt32(dropStratificationOption.SelectedValue);
                    }
                    if (dropImplantOption.SelectedValue != "0")
                    {
                        implantId = Convert.ToInt32(dropImplantOption.SelectedValue);
                    }
                    else
                    {
                        implantId = 0;
                        tbImplantCount.Text = "0";
                    }
                    SqlParameter[] p = new SqlParameter[13];
                    p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                    p[0].DbType = DbType.String;
                    p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                    p[1].DbType = DbType.String;
                    p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                    p[2].DbType = DbType.String;
                    p[3] = new SqlParameter("@PackageId", dropPackageMaster.SelectedValue);
                    p[3].DbType = DbType.String;
                    p[4] = new SqlParameter("@ProcedureId", dropProcedure.SelectedValue);
                    p[4].DbType = DbType.String;
                    p[5] = new SqlParameter("@ICHICode", dropICHICode.SelectedValue);
                    p[5].DbType = DbType.String;
                    p[6] = new SqlParameter("@Investigation", "");
                    p[6].DbType = DbType.String;
                    p[7] = new SqlParameter("@StratificationId", stratificationId.ToString());
                    p[7].DbType = DbType.String;
                    p[8] = new SqlParameter("@ImplantId", implantId.ToString());
                    p[8].DbType = DbType.String;
                    p[9] = new SqlParameter("@ImplantCount", tbImplantCount.Text);
                    p[9].DbType = DbType.String;
                    p[10] = new SqlParameter("@UnspecifiedProcedureName", tbUnspecifiedProcedureName.Text);
                    p[10].DbType = DbType.String;
                    p[11] = new SqlParameter("@UnspecifiedProcedureAmount", Convert.ToInt32(tbUnspecifiedProcedureAmount.Text));
                    p[11].DbType = DbType.String;
                    p[12] = new SqlParameter("@UnspecifiedProcedureInvestigation", tbUnspecifiedProcedureInvestigation.Text);
                    p[12].DbType = DbType.String;


                    ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertPatientTreatmentProtocol", p);
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["Id"].ToString() == "0")
                        {
                            strMessage = "window.alert('Package already added!');";
                            ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                        }
                        else if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
                        {
                            lbPackageCost.Text = ds.Tables[0].Rows[0]["ProcedureAmount"].ToString();
                            lbIncentiveAmount.Text = ds.Tables[0].Rows[0]["IncentiveAmount"].ToString();
                            lbTotalPackageCost.Text = ds.Tables[0].Rows[0]["TotalPackageCost"].ToString();
                            lbHospitalIncentivePercentage.Text = ds.Tables[0].Rows[0]["IncentivePercentage"].ToString();
                            getAddedProcedure();
                            ShowPreInvestigationDocuments();
                            panelStratification.Visible = false;
                            panelImplant.Visible = false;
                            panelUnspecified.Visible = false;
                            dropPackageMaster.SelectedValue = "0";
                            dropProcedure.Items.Clear();
                            strMessage = "window.alert('Added successfully!');";
                            ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                        }
                        else
                        {
                            strMessage = "window.alert('Package details missing!');";
                            ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                        }
                    }
                    else
                    {
                        strMessage = "window.alert('Package details missing!');";
                        ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                    }
                    //}
                    //else
                    //{
                    //    strMessage = "window.alert('Please provide investigation remarks!');";
                    //    ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                    //}
                }
                else
                {
                    strMessage = "window.alert('Please select Procedure/enter valid implant count!');";
                    ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
                }
            }
            else
            {
                strMessage = "window.alert('Please select Speciality Type!');";
                ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
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
    protected void getAddedProcedure()
    {
        try
        {
            DataTable dt = null;
            dt = preAuth.getPatientAddedPackage(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                gridAddedpackageProcedure.DataSource = dt;
                gridAddedpackageProcedure.DataBind();
                panelAddedDocument.Visible = true;
            }
            else
            {
                gridAddedpackageProcedure.DataSource = "";
                gridAddedpackageProcedure.DataBind();
                panelAddedDocument.Visible = false;
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
    protected void lnkDeleteProcedure_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbPackageId = (Label)gridAddedpackageProcedure.Rows[i].FindControl("lbPackageId");
            Label lbProcedureId = (Label)gridAddedpackageProcedure.Rows[i].FindControl("lbProcedureId");
            //int rowsAffected = 0;
            //rowsAffected = preAuth.DeleteAddedProcedure(hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbPackageId.Text), Convert.ToInt32(lbProcedureId.Text));
            SqlParameter[] p = new SqlParameter[5];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@PackageId", Convert.ToInt32(lbPackageId.Text));
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@ProcedureId", Convert.ToInt32(lbProcedureId.Text));
            p[4].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthRemovePackage", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                lbPackageCost.Text = ds.Tables[0].Rows[0]["ProcedureAmount"].ToString();
                lbIncentiveAmount.Text = ds.Tables[0].Rows[0]["IncentiveAmount"].ToString();
                lbTotalPackageCost.Text = ds.Tables[0].Rows[0]["TotalPackageCost"].ToString();
                lbHospitalIncentivePercentage.Text = ds.Tables[0].Rows[0]["IncentivePercentage"].ToString();
                getAddedProcedure();
                ShowPreInvestigationDocuments();
                dropPackageMaster.SelectedValue = "0";
                dropProcedure.Items.Clear();
                strMessage = "window.alert('Removed successfully!');";
                ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
            }
            else
            {
                lbPackageCost.Text = "0";
                lbIncentiveAmount.Text = "0";
                lbTotalPackageCost.Text = "0";
                lbHospitalIncentivePercentage.Text = "0";
                getAddedProcedure();
                ShowPreInvestigationDocuments();
                dropPackageMaster.SelectedValue = "0";
                dropProcedure.Items.Clear();
                strMessage = "window.alert('Removed successfully!');";
                ScriptManager.RegisterStartupScript(btnAddProcedure, btnAddProcedure.GetType(), "Error", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            strMessage = "window.alert('Already Deleted!');";
            ScriptManager.RegisterStartupScript(btnSaveFamilyHistory, btnSaveFamilyHistory.GetType(), "Error", strMessage, true);
        }
    }
    protected void getPatientPackageTotalAmount()
    {
        try
        {
            dt = preAuth.getPatientPackageTotalAmount(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
            if (dt.Rows.Count > 0)
            {
                lbPackageCost.Text = dt.Rows[0]["ProcedureAmount"].ToString();
                lbIncentiveAmount.Text = dt.Rows[0]["IncentiveAmount"].ToString();
                lbTotalPackageCost.Text = dt.Rows[0]["TotalPackageCost"].ToString();
                lbHospitalIncentivePercentage.Text = dt.Rows[0]["IncentivePercentage"].ToString();
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
    protected void ShowPreInvestigationDocuments()
    {
        try
        {
            DataTable dtDocumentGroup = new DataTable();
            // TMS_PreAuthInsertDocumentPreInvestigation
            dtDocumentGroup = preAuth.getPreInvestigationDocumentsPackage(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
            if (dtDocumentGroup.Rows.Count > 0)
            {
                GridPackage.DataSource = dtDocumentGroup;
                GridPackage.DataBind();
                panelDocumentsRequired.Visible = true;
            }
            else
            {
                panelDocumentsRequired.Visible = false;
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
    protected void GridPackage_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataTable dtDocument = new DataTable();
                GridView gridInvestigation = (GridView)e.Row.FindControl("gridInvestigation");
                int packageid = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PackageId"));
                int ProcedureId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ProcedureId"));
                dtDocument = preAuth.getPreInvestigationDocumentsProcedure(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value), packageid, ProcedureId);
                gridInvestigation.DataSource = dtDocument;
                gridInvestigation.DataBind();

                foreach (GridViewRow row in gridInvestigation.Rows)
                {
                    Label lbUploadStatus = (Label)row.FindControl("lbUploadStatus");
                    LinkButton btnUploadStatus = (LinkButton)row.FindControl("btnUploadStatus");
                    // Dim dropUpdate As DropDownList = DirectCast(row.FindControl("dropStatus"), DropDownList)
                    // dropUpdate.Text = lbCheckAI.Text
                    // dropUpdate.ForeColor = Drawing.Color.White
                    if (lbUploadStatus.Text == "View Document")
                    {
                        lbUploadStatus.ForeColor = System.Drawing.Color.Green;
                        btnUploadStatus.Enabled = true;
                    }
                    else
                    {
                        lbUploadStatus.ForeColor = System.Drawing.Color.Red;
                        btnUploadStatus.Enabled = false;
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

    protected void btnUploadStatus_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbDocumentName = (Label)row.FindControl("lbPreInvestigationName");
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentViewModal", "showDocumentViewModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnUploadPreInvestigation(object sender, EventArgs e)
    {
        try
        {
            Button btnUpload = (Button)sender;
            string InvestigationId = btnUpload.CommandArgument;
            GridViewRow row = (GridViewRow)btnUpload.NamingContainer;
            // Dim fuImage As FileUpload = CType(row.FindControl("fuImage"), FileUpload)
            Label lbPreInvestigationPackageId = (Label)row.FindControl("lbPreInvestigationPackageId");
            Label lbPreInvestigationProcedureId = (Label)row.FindControl("lbPreInvestigationProcedureId");
            Label lbPreInvestigationId = (Label)row.FindControl("lbPreInvestigationId");
            Label lbPreInvestigationName = (Label)row.FindControl("lbPreInvestigationName");

            hdPackageId.Value = lbPreInvestigationPackageId.Text;
            hdProcedureId.Value = lbPreInvestigationProcedureId.Text;
            hdPreInvestigationId.Value = lbPreInvestigationId.Text;
            // Dim nestedGridViewRow As GridViewRow = CType(btnUpload.NamingContainer, GridViewRow)
            // Dim parentGridViewRow As GridViewRow = CType(nestedGridViewRow.NamingContainer.NamingContainer, GridViewRow)
            // Dim packageId As String = CType(parentGridViewRow.Cells(0).Text, String) ' Assuming PackageID is in the first column
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentUploadModal", "showDocumentUploadModal();", true);
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
    protected void btnUploadPreInvestigationFile_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuImage.HasFile)
            {
                string fileExtension = Path.GetExtension(fuImage.FileName).ToLower();
                int fileSize = fuImage.PostedFile.ContentLength;
                string mimeType = fuImage.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    //if (!IsValidMimeType(mimeType))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid MIME type! Only image files are allowed.')", true);
                    //    return;
                    //}
                    //if (fileSize > 500 * 1024) // 500 KB limit
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File size is too large. Maximum allowed size is 500 kb.')", true);
                    //    return;
                    //}

                    //// Read the file's bytes into a byte array
                    //byte[] fileBytes = new byte[fileSize];
                    //fuImage.PostedFile.InputStream.Read(fileBytes, 0, fileSize);

                    //if (!IsValidFileByBytes(fileBytes, fileExtension))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid file format. Only JPEG files are allowed.')", true);
                    //    return;
                    //}

                    //string randomFolderName = hdAbuaId.Value;
                    //string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                    //string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);
                    //string fileName = hdPackageId.Value + "_" + hdProcedureId.Value + "_" + hdPreInvestigationId.Value + "_" + DateTime.Now.ToShortDateString().ToString();
                    ////if (!Directory.Exists(destinationFolderPath))
                    ////    Directory.CreateDirectory(destinationFolderPath);
                    //string ImagePath = destinationFolderPath + @"\" + fileName.ToString() + ".jpeg";
                    ////fuImage.SaveAs(ImagePath);

                    using (Stream fileStream = fuImage.PostedFile.InputStream)
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

                        string fileName = hdPackageId.Value + "_" + hdProcedureId.Value + "_" + hdPreInvestigationId.Value + "_" + DateTime.Now.ToShortDateString();
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        // Save the file to the specified path
                        File.WriteAllBytes(imagePath, fileBytes);

                        //string base64String = ConvertImageToBase64(fuImage.FileName);
                        //byte[] fileBytes = Convert.FromBase64String(base64String);
                        //if (!Directory.Exists(destinationFolderPath))
                        //    Directory.CreateDirectory(destinationFolderPath);
                        //File.WriteAllBytes(ImagePath, fileBytes);

                        SqlParameter[] p = new SqlParameter[9];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@PackageId", hdPackageId.Value);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@ProcedureId", hdProcedureId.Value);
                        p[4].DbType = DbType.String;
                        p[5] = new SqlParameter("@PreInvestigationId", hdPreInvestigationId.Value);
                        p[5].DbType = DbType.String;
                        p[6] = new SqlParameter("@FolderName", randomFolderName.ToString());
                        p[6].DbType = DbType.String;
                        p[7] = new SqlParameter("@UploadedFileName", fileName.ToString());
                        p[7].DbType = DbType.String;
                        p[8] = new SqlParameter("@FilePath", imagePath.ToString());
                        p[8].DbType = DbType.String;
                        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertDocumentPreInvestigation", p);
                        if (con.State == ConnectionState.Open)
                            con.Close();
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Image uploaded successfully!')", true);
                                ShowPreInvestigationDocuments();
                            }
                            else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Image uploaded successfully!')", true);
                                ShowPreInvestigationDocuments();
                            }
                            else
                            {
                                strMessage = "window.alert('Invalid request!');";
                                ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                        }
                    }
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid File Format! Please upload .jpg/.jpeg/.png')", true);
            }
            else
                // Handle case where no file was selected
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a file to upload.')", true);
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
    static string ConvertImageToBase64(string imagePath)
    {
        try
        {
            // Read the image file into a byte array
            byte[] imageBytes = File.ReadAllBytes(imagePath);

            // Convert byte array to Base64 string
            return Convert.ToBase64String(imageBytes);
        }
        catch (Exception ex)
        {
            //Console.WriteLine($"Error: {ex.Message}");
            return null;
        }
    }
    protected void showDocumentUploadModal_Click(object sender, EventArgs e)
    {
        try
        {
            ShowPreInvestigationDocuments();
            // MultiViewFileUpload.SetActiveView(viewPreInvestigationUpload)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentUploadModal", "showDocumentUploadModal();", true);
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
    protected void hideDocumentUploadModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideDocumentUploadModal", "hideDocumentUploadModal();", true);
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

    protected void btnAddViewAttachment_Click(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientManditoryDocument(hdAbuaId.Value.ToString());

            if (dt.Rows.Count > 0)
            {
                attachmentPanel.Visible = true;
                anamolyPanel.Visible = false;

                // Check and handle the first row (index 0)
                foreach(DataRow dr in dt.Rows) 
                {
                    string DocumentId = dr["DocumentId"].ToString().Trim();
                    string FolderName = dr["FolderName"].ToString().Trim();
                    string UploadedFileName = dr["UploadedFileName"].ToString().Trim();
                    if (DocumentId.Equals("1"))
                    {
                        lbConsentStatus.Text = "Click Here To View";
                        lbConsentFolderName.Text = FolderName;
                        lbConsentUploadedFileName.Text = UploadedFileName;
                        lbConsentStatus.ForeColor = System.Drawing.Color.Green;
                        btnConsentDocument.Enabled = true;
                    }
                    else if (DocumentId.Equals("2"))
                    {
                        lbHealthStatus.Text = "Click Here To View";
                        lbHealthFolderName.Text = FolderName;
                        lbHealthUploadedFileName.Text = UploadedFileName;
                        lbHealthStatus.ForeColor = System.Drawing.Color.Green;
                        btnHealthDocument.Enabled = true;
                    }
                    else if (DocumentId.Equals("3"))
                    {
                        lbPatientPhotoStatus.Text = "Click Here To View";
                        lbPatientPhotoFolderName.Text = FolderName;
                        lbPatientPhotoUploadedFileName.Text = UploadedFileName;
                        lbPatientPhotoStatus.ForeColor = System.Drawing.Color.Green;
                        btnPatientDocument.Enabled = true;
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
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

    protected void btnConsentDocument_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbConsentFolderName.Text;
            string fileName = lbConsentUploadedFileName.Text + ".jpeg";
            string DocumentName = "Consent Document";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentViewModal", "showDocumentViewModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnHealthDocument_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbHealthFolderName.Text;
            string fileName = lbHealthUploadedFileName.Text + ".jpeg";
            string DocumentName = "Health Document";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentViewModal", "showDocumentViewModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnPatientDocument_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbPatientPhotoFolderName.Text;
            string fileName = lbPatientPhotoUploadedFileName.Text + ".jpeg";
            string DocumentName = "Patient Document";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showDocumentViewModal", "showDocumentViewModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void btnAddViewDataAnamoly_Click(object sender, EventArgs e)
    {
        attachmentPanel.Visible = false;
        anamolyPanel.Visible = true;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
    }
    protected void btnUploadConsent_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuConsent.HasFile)
            {
                string fileExtension = Path.GetExtension(fuConsent.FileName).ToLower();
                int fileSize = fuConsent.PostedFile.ContentLength;
                string mimeType = fuConsent.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    //if (!IsValidMimeType(mimeType))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid MIME type! Only image files are allowed.')", true);
                    //    return;
                    //}
                    //if (fileSize > 500 * 1024) // 500 KB limit
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File size is too large. Maximum allowed size is 500 kb.')", true);
                    //    return;
                    //}

                    //// Read the file's bytes into a byte array
                    //byte[] fileBytes = new byte[fileSize];
                    //fuConsent.PostedFile.InputStream.Read(fileBytes, 0, fileSize);

                    //if (!IsValidFileByBytes(fileBytes, fileExtension))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid file format. Only JPEG files are allowed.')", true);
                    //    return;
                    //}
                    using (Stream fileStream = fuConsent.PostedFile.InputStream)
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

                        string fileName = "Consent_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        // Save the file to the specified path
                        File.WriteAllBytes(imagePath, fileBytes);

                        //string randomFolderName = hdAbuaId.Value;
                        //string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                        //string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);
                        //string fileName = "Consent_" + "_" + DateTime.Now.ToShortDateString().ToString();
                        //if (!Directory.Exists(destinationFolderPath))
                        //    Directory.CreateDirectory(destinationFolderPath);
                        //string ImagePath = destinationFolderPath + @"\" + fileName.ToString() + ".jpeg";
                        //fuConsent.SaveAs(ImagePath);

                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 1);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 1);
                        p[4].DbType = DbType.String;
                        p[5] = new SqlParameter("@FolderName", randomFolderName.ToString());
                        p[5].DbType = DbType.String;
                        p[6] = new SqlParameter("@UploadedFileName", fileName.ToString());
                        p[6].DbType = DbType.String;
                        p[7] = new SqlParameter("@FilePath", imagePath.ToString());
                        p[7].DbType = DbType.String;
                        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertDocumentMandatory", p);
                        if (con.State == ConnectionState.Open)
                            con.Close();
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else
                            {
                                strMessage = "window.alert('Invalid request!');";
                                ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                        }
                    }
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid File Format! Please upload .jpg/.jpeg/.png')", true);
            }
            else
                // Handle case where no file was selected
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a file to upload.')", true);
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
    protected void btnUploadHealthCard_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuHealthCard.HasFile)
            {
                string fileExtension = Path.GetExtension(fuHealthCard.FileName).ToLower();
                int fileSize = fuHealthCard.PostedFile.ContentLength;
                string mimeType = fuHealthCard.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    //if (!IsValidMimeType(mimeType))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid MIME type! Only image files are allowed.')", true);
                    //    return;
                    //}
                    //if (fileSize > 500 * 1024) // 500 KB limit
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File size is too large. Maximum allowed size is 500 kb.')", true);
                    //    return;
                    //}

                    //// Read the file's bytes into a byte array
                    //byte[] fileBytes = new byte[fileSize];
                    //fuHealthCard.PostedFile.InputStream.Read(fileBytes, 0, fileSize);

                    //if (!IsValidFileByBytes(fileBytes, fileExtension))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid file format. Only JPEG files are allowed.')", true);
                    //    return;
                    //}
                    using (Stream fileStream = fuHealthCard.PostedFile.InputStream)
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

                        string fileName = "HealthCard_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        // Save the file to the specified path
                        File.WriteAllBytes(imagePath, fileBytes);

                        //string randomFolderName = hdAbuaId.Value;
                        //string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                        //string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);
                        //string fileName = "Consent_" + "_" + DateTime.Now.ToShortDateString().ToString();
                        //if (!Directory.Exists(destinationFolderPath))
                        //    Directory.CreateDirectory(destinationFolderPath);
                        //string ImagePath = destinationFolderPath + @"\" + fileName.ToString() + ".jpeg";
                        //fuPatientPhoto.SaveAs(ImagePath);

                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 1);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 2);
                        p[4].DbType = DbType.String;
                        p[5] = new SqlParameter("@FolderName", randomFolderName.ToString());
                        p[5].DbType = DbType.String;
                        p[6] = new SqlParameter("@UploadedFileName", fileName.ToString());
                        p[6].DbType = DbType.String;
                        p[7] = new SqlParameter("@FilePath", imagePath.ToString());
                        p[7].DbType = DbType.String;
                        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertDocumentMandatory", p);
                        if (con.State == ConnectionState.Open)
                            con.Close();
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else
                            {
                                strMessage = "window.alert('Invalid request!');";
                                ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                        }
                    }
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid File Format! Please upload .jpg/.jpeg/.png')", true);
            }
            else
                // Handle case where no file was selected
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a file to upload.')", true);
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
    protected void btnUploadPatientPhoto_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuPatientPhoto.HasFile)
            {
                string fileExtension = Path.GetExtension(fuPatientPhoto.FileName).ToLower();
                int fileSize = fuPatientPhoto.PostedFile.ContentLength;
                string mimeType = fuPatientPhoto.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    //if (!IsValidMimeType(mimeType))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid MIME type! Only image files are allowed.')", true);
                    //    return;
                    //}
                    //if (fileSize > 500 * 1024) // 500 KB limit
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File size is too large. Maximum allowed size is 500 kb.')", true);
                    //    return;
                    //}

                    //// Read the file's bytes into a byte array
                    //byte[] fileBytes = new byte[fileSize];
                    //fuPatientPhoto.PostedFile.InputStream.Read(fileBytes, 0, fileSize);

                    //if (!IsValidFileByBytes(fileBytes, fileExtension))
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid file format. Only JPEG files are allowed.')", true);
                    //    return;
                    //}
                    using (Stream fileStream = fuPatientPhoto.PostedFile.InputStream)
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

                        string fileName = "PatientPhoto_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        // Save the file to the specified path
                        File.WriteAllBytes(imagePath, fileBytes);

                        //string randomFolderName = hdAbuaId.Value;
                        //string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                        //string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);
                        //string fileName = "Consent_" + "_" + DateTime.Now.ToShortDateString().ToString();
                        //if (!Directory.Exists(destinationFolderPath))
                        //    Directory.CreateDirectory(destinationFolderPath);
                        //string ImagePath = destinationFolderPath + @"\" + fileName.ToString() + ".jpeg";
                        //fuPatientPhoto.SaveAs(ImagePath);

                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 1);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 3);
                        p[4].DbType = DbType.String;
                        p[5] = new SqlParameter("@FolderName", randomFolderName.ToString());
                        p[5].DbType = DbType.String;
                        p[6] = new SqlParameter("@UploadedFileName", fileName.ToString());
                        p[6].DbType = DbType.String;
                        p[7] = new SqlParameter("@FilePath", imagePath.ToString());
                        p[7].DbType = DbType.String;
                        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthInsertDocumentMandatory", p);
                        if (con.State == ConnectionState.Open)
                            con.Close();
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully!')", true);
                            }
                            else
                            {
                                strMessage = "window.alert('Invalid request!');";
                                ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadPreInvestigationFile, btnUploadPreInvestigationFile.GetType(), "Error", strMessage, true);
                        }
                    }
                }
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid File Format! Please upload .jpg/.jpeg/.png')", true);
            }
            else
                // Handle case where no file was selected
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a file to upload.')", true);
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
    private bool IsValidFileExtension(string extension)
    {
        string[] validExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
        return validExtensions.Contains(extension);
    }

    // Validate MIME type (whitelist approach)
    private bool IsValidMimeType(string mimeType)
    {
        string[] validMimeTypes = { "image/jpeg", "image/png", "image/gif" };
        return validMimeTypes.Contains(mimeType);
    }
    private bool IsValidFileByBytes(byte[] fileBytes, string fileExtension)
    {
        if (fileExtension == ".jpeg" || fileExtension == ".jpg")
        {
            // Magic bytes for JPEG files: 0xFF, 0xD8, 0xFF (JPEG file signature)
            byte[] jpegSignature = new byte[] { 0xFF, 0xD8, 0xFF };

            // Check if the file starts with the JPEG signature
            for (int i = 0; i < jpegSignature.Length; i++)
            {
                if (fileBytes[i] != jpegSignature[i])
                {
                    return false; // File is not a valid JPEG
                }
            }
        }
        else if (fileExtension == ".png")
        {
            // Magic bytes for PNG files: 0x89 0x50 0x4E 0x47 0x0D 0x0A 0x1A 0x0A (PNG signature)
            byte[] pngSignature = new byte[] { 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A };

            // Check if the file starts with the PNG signature
            for (int i = 0; i < pngSignature.Length; i++)
            {
                if (fileBytes[i] != pngSignature[i])
                {
                    return false; // File is not a valid PNG
                }
            }
        }
        return true; // Valid JPEG or PNG
    }
    protected void btnSubmitAdmission_Click(object sender, EventArgs e)
    {
        try
        {
            if (GridPackage.Rows.Count > 0)
            {
                if (tbProposedTreatmentDate.Text == "" || tbAdmissionDate.Text == "" || tbRemarks.Text == "")
                {
                    string strMessage = "window.alert('Please fill admission details!');";
                    ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "AlertMessage", strMessage, true);
                    return;
                }
                if (TextboxValidation.isDate(tbProposedTreatmentDate.Text) == false || TextboxValidation.isDate(tbAdmissionDate.Text) == false || TextboxValidation.isAlphaNumericSpecial(tbRemarks.Text) == false)
                {
                    string strMessage = "window.alert('Invalid Entry!');";
                    ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "AlertMessage", strMessage, true);
                    return;
                }
                //dt.Clear();
                //dt = preAuth.checkProcedureDocumentUploadStatus(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value));
                //if (dt.Rows.Count > 0)
                //{
                //    if (Convert.ToInt32(dt.Rows[0]["UploadStatus"].ToString()) > 0)
                //    {
                //        string strMessage = "window.alert('Please upload procedure documents!');";
                //        ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "AlertMessage", strMessage, true);
                //        return;
                //    }
                //}
                dt.Clear();
                dt = preAuth.checkMandatoryDocumentUploadStatus(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value));
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["UploadStatus"].ToString() != "0")
                    {
                        string strMessage = "window.alert('Please upload consent and other mandatory documents!');";
                        ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "AlertMessage", strMessage, true);
                        return;
                    }
                }
                Boolean MedcoLegalCase = false;
                if (rbLegalCaseYes.Checked == true)
                    MedcoLegalCase = true;
                else if (rbLegalCaseNo.Checked == true)
                    MedcoLegalCase = false;
                SqlParameter[] p = new SqlParameter[10];
                p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                p[0].DbType = DbType.String;
                p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                p[1].DbType = DbType.String;
                p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                p[2].DbType = DbType.String;
                p[3] = new SqlParameter("@AdmissionType", dropAdmissionType.SelectedValue);
                p[3].DbType = DbType.String;
                p[4] = new SqlParameter("@ProposedSurgeryDate", tbProposedTreatmentDate.Text);
                p[4].DbType = DbType.String;
                p[5] = new SqlParameter("@AdmissionDate", tbAdmissionDate.Text);
                p[5].DbType = DbType.String;
                p[6] = new SqlParameter("@MedcoLegalCase", MedcoLegalCase.ToString());
                p[6].DbType = DbType.String;
                p[7] = new SqlParameter("@IsPreAuthInitiated", dropActionType.SelectedValue);
                p[7].DbType = DbType.String;
                p[8] = new SqlParameter("@Remarks", tbRemarks.Text);
                p[8].DbType = DbType.String;
                p[9] = new SqlParameter("@UserId", hdUserId.Value);
                p[9].DbType = DbType.String;
                ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PatientInsertAdmissionDetail", p);
                if (con.State == ConnectionState.Open)
                    con.Close();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Id"].ToString() == "0")
                    {
                        strMessage = "window.alert('Wallet Balance is Low! Remaining Balance is: " + ds.Tables[0].Rows[0]["RemainingBalance"].ToString() + "');";
                        ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "Error", strMessage, true);
                    }
                    else if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
                    {
                        panelStratification.Visible = false;
                        panelImplant.Visible = false;
                        getRegisteredPatient();
                        getPrimaryDiagnosis();
                        getSecondaryDiagnosis();
                        //ShowPreInvestigationDocuments();
                        dropProcedure.Items.Clear();
                        tbAdmissionDate.Text = "";
                        tbProposedTreatmentDate.Text = "";
                        lbPackageCost.Text = "";
                        lbIncentiveAmount.Text = "";
                        lbTotalPackageCost.Text = "";
                        lbHospitalIncentivePercentage.Text = "";
                        tbRemarks.Text = "";
                        dropPackageMaster.SelectedValue = "0";
                        dt.Clear();
                        GridPackage.DataSource = dt;
                        GridPackage.DataBind();
                        MultiView1.SetActiveView(viewRegisteredPatient);
                        MultiView2.SetActiveView(View1);
                        string caseNumber = ds.Tables[0].Rows[0]["CaseNumber"].ToString();
                        string strMessage = "window.alert('Admission Successful! Case No.: " + caseNumber.Replace("'", "\\'") + "');";
                        ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "AlertMessage", strMessage, true);
                        //ShowPreInvestigationDocuments();
                    }
                }
                else
                {
                    strMessage = "window.alert('Invalid request!');";
                    ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "Error", strMessage, true);
                }
            }
            else
            {
                strMessage = "window.alert('Add atleast 1 procedure!');";
                ScriptManager.RegisterStartupScript(btnSubmitAdmission, btnSubmitAdmission.GetType(), "Error", strMessage, true);
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
}