using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.Security;
using System.Web;
using CareerPath.DAL;
using iText.IO.Image;
using System.IO;

public partial class MEDCO_PatientDischarge : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    private Discharge dis = new Discharge();
    private TextboxValidation validateTB = new TextboxValidation();
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
                    hdUserId.Value = Session["UserId"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    GetPatientForDischarge();
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
    protected void GetPatientForDischarge()
    {
        gridPatientForDischarge.DataSource = "";
        gridPatientForDischarge.DataBind();
        dt.Clear();
        dt = preAuth.GetPatientForDischarge(Convert.ToInt32(hdHospitalId.Value));
        if (dt.Rows.Count > 0)
        {
            gridPatientForDischarge.DataSource = dt;
            gridPatientForDischarge.DataBind();
        }
    }
    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        try
        {
            int i;
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            i = row.RowIndex;
            Label lbGridPatientRegId = (Label)gridPatientForDischarge.Rows[i].FindControl("lbPatientRegId");
            Label lbGridAdmissionId = (Label)gridPatientForDischarge.Rows[i].FindControl("lbAdmissionId");
            Label lbClaimId = (Label)gridPatientForDischarge.Rows[i].FindControl("lbClaimId");
            Label lbGridCardNo = (Label)gridPatientForDischarge.Rows[i].FindControl("lbCardNo");
            //Label lbGridCardNo = (Label)gridPatientForDischarge.Rows[i].FindControl("lbPatientCardNo");
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
    protected void btnInitialAssessment_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewInitialAssessment);
        btnInitialAssessment.CssClass = "btn btn-warning p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
    }
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPasthistory);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-warning p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
    }
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
            btnTreatment.CssClass = "btn btn-primary p-3";
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

    protected void btnRequestEnhancement_Click(object sender, EventArgs e)
    {
        MultiView3.SetActiveView(viewEnhancement);
    }

    protected void btnInitiateEnhancement_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[8];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@ClaimId", hdClaimId.Value);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@StratificationId", hdHospitalId.Value);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@FromDate", hdHospitalId.Value);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@ToDate", hdAdmissionId.Value);
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@Remarks", hdAdmissionId.Value);
            p[7].DbType = DbType.String;

            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InsertPatientDischargeDetails", p);
            if (con.State == ConnectionState.Open)
                con.Close();
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

    protected void btnChangeWard_Click(object sender, EventArgs e)
    {
        MultiView3.SetActiveView(viewChangeWard);
    }
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
    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        try
        {
            dt = dis.getDoctorType();
            if (dt.Rows.Count > 0)
            {
                dropDroctorType.Items.Clear();
                dropDroctorType.DataValueField = "Id";
                dropDroctorType.DataTextField = "Title";
                dropDroctorType.DataSource = dt;
                dropDroctorType.DataBind();
                dropDroctorType.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropDroctorType.Items.Insert(0, new ListItem("--SELECT--", "0"));
                dropDroctorType.Items.Clear();
            }

            dt = dis.getAnesthetistList();
            if (dt.Rows.Count > 0)
            {
                dropAnesName.Items.Clear();
                dropAnesName.DataValueField = "Id";
                dropAnesName.DataTextField = "Name";
                dropAnesName.DataSource = dt;
                dropAnesName.DataBind();
                dropAnesName.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropAnesName.Items.Insert(0, new ListItem("--SELECT--", "0"));
                dropAnesName.Items.Clear();
            }
            MultiView2.SetActiveView(viewTreatmentDischarge);
            btnInitialAssessment.CssClass = "btn btn-primary p-3";
            btnPastHistory.CssClass = "btn btn-primary p-3";
            btnPreAutoriztion.CssClass = "btn btn-primary p-3";
            btnTreatment.CssClass = "btn btn-warning p-3";
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
    protected void dropDroctorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt = dis.getDoctorList(Convert.ToInt32(dropDroctorType.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                dropDoctorId.Items.Clear();
                dropDoctorId.DataValueField = "Id";
                dropDoctorId.DataTextField = "Name";
                dropDoctorId.DataSource = dt;
                dropDoctorId.DataBind();
                dropDoctorId.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropDoctorId.Items.Insert(0, new ListItem("--SELECT--", "0"));
                dropDoctorId.Items.Clear();
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
    protected void dropDoctorId_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt = dis.getDoctorDetailByDoctorId(Convert.ToInt32(dropDoctorId.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                lbSurgeonRegNo.Text = dt.Rows[0]["RegistrationNumber"].ToString();
                lbSurgeonQualification.Text = dt.Rows[0]["Qualification"].ToString();
                lbSurgeonContactNo.Text = dt.Rows[0]["MobileNumber"].ToString();
            }
            else
            {
                lbSurgeonRegNo.Text = "";
                lbSurgeonQualification.Text = "";
                lbSurgeonContactNo.Text = "";
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
    protected void dropAnesName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt = dis.getDoctorDetailByDoctorId(Convert.ToInt32(dropAnesName.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                lbAnesRegNo.Text = dt.Rows[0]["RegistrationNumber"].ToString();
                lbAnesContactNo.Text = dt.Rows[0]["MobileNumber"].ToString();
                lbAnesthesiaType.Text = "NA";
            }
            else
            {
                lbSurgeonRegNo.Text = "";
                lbSurgeonQualification.Text = "";
                lbSurgeonContactNo.Text = "";
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
    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAttachments);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-warning p-3";
    }
    protected void rbDischarge_CheckedChanged(object sender, EventArgs e)
    {
        panelDischarge.Visible = true;
        dropIsSpecialCase.SelectedValue = "0";
        dropSpecialCaseValue.SelectedValue = "0";
        dropIsSpecialCase.Enabled = true;
        dropSpecialCaseValue.Enabled = true;
    }
    protected void rbDeath_CheckedChanged(object sender, EventArgs e)
    {
        panelDischarge.Visible = true;
        dropIsSpecialCase.SelectedValue = "1";
        dropSpecialCaseValue.SelectedIndex = dropSpecialCaseValue.Items.IndexOf(dropSpecialCaseValue.Items.FindByText("Death"));
        dropIsSpecialCase.Enabled = false;
        dropSpecialCaseValue.Enabled = false;
    }
    protected void dropIsSpecialCase_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(dropIsSpecialCase.SelectedValue) == 1)
            {
                getSpecialCaseValue();
                dropSpecialCaseValue.SelectedValue = "0";
                divSpecialCaseValue.Visible = true;
            }
            else
            {
                divSpecialCaseValue.Visible = false;
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void dropFinalDiagnosis_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(dropFinalDiagnosis.SelectedValue) > 0)
            {
                getSpecialCaseValue();
                divFinalDiagnosisDesc.Visible = true;
            }
            else
            {
                divFinalDiagnosisDesc.Visible = false;
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void getSpecialCaseValue()
    {
        if (Convert.ToInt32(dropIsSpecialCase.SelectedValue) == 1)
        {

            dt.Clear();
            dt = preAuth.GetSpecialCaseValue();
            if (dt.Rows.Count > 0)
            {
                dropSpecialCaseValue.Items.Clear();
                dropSpecialCaseValue.DataValueField = "SpecialCaseId";
                dropSpecialCaseValue.DataTextField = "SpecialCaseValue";
                dropSpecialCaseValue.DataSource = dt;
                dropSpecialCaseValue.DataBind();
                dropSpecialCaseValue.Items.Insert(0, new ListItem("--SELECT--", "0"));
                divSpecialCaseValue.Visible = true;
            }
            else
            {
                dropSpecialCaseValue.Items.Clear();
                divSpecialCaseValue.Visible = false;
            }
        }
        else
        {
            divSpecialCaseValue.Visible = false;
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (cbDeclaration.Checked)
            {
                bool dischargeType = false, ProcedureConsent = false, OPPhotosWebex = false, VideoRecording = false, SpecimenRequired = false, ComplicationsIfAny = false;
                SqlParameter[] p = new SqlParameter[40];
                p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                p[0].DbType = DbType.String;
                p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                p[1].DbType = DbType.String;
                p[2] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
                p[2].DbType = DbType.String;
                p[3] = new SqlParameter("@ClaimId", hdClaimId.Value);
                p[3].DbType = DbType.String;
                p[4] = new SqlParameter("@DischargeById", hdUserId.Value);
                p[4].DbType = DbType.String;
                p[5] = new SqlParameter("@DischargeType", dischargeType.ToString());
                p[5].DbType = DbType.String;
                p[6] = new SqlParameter("@DischargeDate", tbDischargeDate.Text);
                p[6].DbType = DbType.String;
                p[7] = new SqlParameter("@NextFollowUpDate", tbNextFollowUpDate.Text);
                p[7].DbType = DbType.String;
                p[8] = new SqlParameter("@ConsultAtBlock", tbConsultAtBlockName.Text);
                p[8].DbType = DbType.String;
                p[9] = new SqlParameter("@FloorNo", tbFloor.Text);
                p[9].DbType = DbType.String;
                p[10] = new SqlParameter("@RoomNo", tbRoomNo.Text);
                p[10].DbType = DbType.String;
                p[11] = new SqlParameter("@IsSpecialCase", dropIsSpecialCase.SelectedValue);
                p[11].DbType = DbType.String;
                p[12] = new SqlParameter("@SpecialCaseValue", dropSpecialCaseValue.SelectedValue);
                p[12].DbType = DbType.String;
                p[13] = new SqlParameter("@FinalDiagnosis", dropFinalDiagnosis.SelectedValue);
                p[13].DbType = DbType.String;
                p[14] = new SqlParameter("@FinalDiagnosisDesc", tbFinalDiagnosisDesc.Text);
                p[14].DbType = DbType.String;
                p[15] = new SqlParameter("@ProcedureConsent", ProcedureConsent.ToString());
                p[15].DbType = DbType.String;
                p[16] = new SqlParameter("@DoctorTypeId", dropDroctorType.SelectedValue);
                p[16].DbType = DbType.String;
                p[17] = new SqlParameter("@DoctorId", dropDoctorId.SelectedValue);
                p[17].DbType = DbType.String;
                p[18] = new SqlParameter("@AnesthetistId", dropAnesName.SelectedValue);
                p[18].DbType = DbType.String;
                p[19] = new SqlParameter("@IncisionType", tbIncisionType.Text);
                p[19].DbType = DbType.String;
                p[20] = new SqlParameter("@OPPhotosWebexTaken", OPPhotosWebex.ToString());
                p[20].DbType = DbType.String;
                p[21] = new SqlParameter("@VideoRecordingDone", VideoRecording.ToString());
                p[21].DbType = DbType.String;
                p[22] = new SqlParameter("@SwabCountInstrumentsCount", tbSwabCount.Text);
                p[22].DbType = DbType.String;
                p[23] = new SqlParameter("@SuturesLigatures", tbSutures.Text);
                p[23].DbType = DbType.String;
                p[24] = new SqlParameter("@SpecimenRequired", SpecimenRequired.ToString());
                p[24].DbType = DbType.String;
                p[25] = new SqlParameter("@DrainageCount", tbDrainageCount.Text);
                p[25].DbType = DbType.String;
                p[26] = new SqlParameter("@BloodLoss", tbBloodLoss.Text);
                p[26].DbType = DbType.String;
                p[27] = new SqlParameter("@PostOperativeInstructions", tbPostOperativeInstructions.Text);
                p[27].DbType = DbType.String;
                p[28] = new SqlParameter("@PatientCondition", tbPatientCondition.Text);
                p[28].DbType = DbType.String;
                p[29] = new SqlParameter("@ComplicationsIfAny", ComplicationsIfAny.ToString());
                p[29].DbType = DbType.String;
                p[30] = new SqlParameter("@TreatmentSurgeryStartDate", tbTreatmentSurgeryDate.Text);
                p[30].DbType = DbType.String;
                p[31] = new SqlParameter("@SurgeryStartTime", tbSurgeryStartTime.Text);
                p[31].DbType = DbType.String;
                p[32] = new SqlParameter("@SurgeryEndTime", tbSurgeryEndTime.Text);
                p[32].DbType = DbType.String;
                p[33] = new SqlParameter("@TreatmentGiven", tbTreatmentGiven.Text);
                p[33].DbType = DbType.String;
                p[34] = new SqlParameter("@OperativeFindings", tbOperativeFindings.Text);
                p[34].DbType = DbType.String;
                p[35] = new SqlParameter("@PostOperativePeriod", tbPostOperativePeriod.Text);
                p[35].DbType = DbType.String;
                p[36] = new SqlParameter("@PostSurgeryInvestigationGiven", tbPostSurgeryTherapy.Text);
                p[36].DbType = DbType.String;
                p[37] = new SqlParameter("@StatusAtDischarge", tbStatusDischarge.Text);
                p[37].DbType = DbType.String;
                p[38] = new SqlParameter("@Review", tbReview.Text);
                p[38].DbType = DbType.String;
                p[39] = new SqlParameter("@Advice", tbAdvice.Text);
                p[39].DbType = DbType.String;
                ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InsertPatientDischargeDetails", p);
                if (con.State == ConnectionState.Open)
                    con.Close();
                if (ds != null)
                {
                    if (ds.Tables[0].Rows[0]["ClaimNumber"].ToString() == "0")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Already Discharged!');", true);
                    }
                    else
                    {
                        MultiView1.SetActiveView(viewPatientList);
                        GetPatientForDischarge();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Claim Initiated! " + ds.Tables[0].Rows[0]["ClaimNumber"].ToString() + "');", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please check declaration!');", true);
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
    protected void btnAttachment_Click(object sender, EventArgs e)
    {

    }
}