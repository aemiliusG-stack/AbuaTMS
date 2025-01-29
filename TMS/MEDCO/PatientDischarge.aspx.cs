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
using AbuaTMS;
using System.Text;
using Org.BouncyCastle.Asn1.Pkcs;
using System.Collections.Generic;

public partial class MEDCO_PatientDischarge : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private string strMessage;
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PreAuth preAuth = new PreAuth();
    private Discharge dis = new Discharge();
    private static CEX cex = new CEX();
    public static PPDHelper ppdHelper = new PPDHelper();
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
            hdAdmissionDate.Value = dt.Rows[0]["AdmissionDate"].ToString();
            string minDate = DateTime.Parse(hdAdmissionDate.Value).AddDays(1).ToString("yyyy-MM-dd");
            string maxDate = DateTime.Parse(hdAdmissionDate.Value).AddDays(5).ToString("yyyy-MM-dd");
            t3tbEnhancementFromDate.Attributes["min"] = minDate;
            t3tbEnhancementToDate.Attributes["min"] = minDate;
            t3tbEnhancementToDate.Attributes["max"] = maxDate;
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
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-primary p-3";
    }

    //*****Past History Display*****//
    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPasthistory);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-warning p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
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
            checkForEnhancement();
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


    //*****Enhancement Work*****//
    protected void checkForEnhancement()
    {
        dt.Clear();
        dt = dis.checkIsEnhancementApplicable(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value));
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["checkId"].ToString() == "1")
            {
                btnRequestEnhancement.Visible = true;
            }
            else
            {
                btnRequestEnhancement.Visible = false;
            }
        }
        else
        {
            btnRequestEnhancement.Visible = false;
        }
    }

    protected void btnRequestEnhancement_Click(object sender, EventArgs e)
    {
        StringBuilder procedureIdBuilder = new StringBuilder();

        foreach (GridViewRow row in t3gridAddedpackageProcedure.Rows)
        {
            Label lbProcedureId = row.FindControl("lbProcedureId") as Label;
            if (lbProcedureId != null)
            {
                procedureIdBuilder.Append(lbProcedureId.Text).Append(", ");
            }
        }
        string procedureIdFinal = procedureIdBuilder.ToString().TrimEnd(',', ' ');
        if (!string.IsNullOrEmpty(procedureIdFinal))
        {
            dt.Clear();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@ProcedureId", procedureIdFinal.ToString());
            p[0].DbType = DbType.String;

            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_GetStratificationForMultipleProcedure", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                //dt = dis.GetStratificationForEnhancement(procedureIdFinal.ToString());
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    t3DropEnhancementStratification.Items.Clear();
                    t3DropEnhancementStratification.DataValueField = "StratificationId";
                    t3DropEnhancementStratification.DataTextField = "StratificationDetail";
                    t3DropEnhancementStratification.DataSource = dt;
                    t3DropEnhancementStratification.DataBind();
                    t3DropEnhancementStratification.Items.Insert(0, new ListItem("--SELECT--", "0"));
                }
            }
        }
        MultiView3.SetActiveView(viewEnhancement);
    }
    protected void t3tbEnhancementFromDate_TextChanged(object sender, EventArgs e)
    {
        if (DateTime.Parse(t3tbEnhancementFromDate.Text) < DateTime.Parse(hdAdmissionDate.Value))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enhancement from date should be less than admission date!');", true);
            t3tbEnhancementFromDate.Text = "";
            t3tbEnhancementToDate.Text = "";
        }
    }
    protected void t3tbEnhancementToDate_TextChanged(object sender, EventArgs e)
    {
        DateTime fromDate;
        DateTime toDate;

        if (DateTime.TryParse(t3tbEnhancementFromDate.Text, out fromDate) &&
            DateTime.TryParse(t3tbEnhancementToDate.Text, out toDate))
        {
            TimeSpan difference = toDate - fromDate;
            t3lbEnhancementNoOfDays.Text = (difference.Days + 1).ToString();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Date!');", true);
            t3tbEnhancementFromDate.Text = "";
            t3tbEnhancementToDate.Text = "";
        }
    }
    protected void btnInitiateEnhancement_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[9];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@Cardnumber", hdAbuaId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@EnhancementFrom", t3tbEnhancementFromDate.Text);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@EnhancementTo", t3tbEnhancementToDate.Text);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@StratificationId", t3DropEnhancementStratification.SelectedValue);
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@Remarks", t3EnhancementRemarks.Text);
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@UserId", hdUserId.Value);
            p[8].DbType = DbType.String;

            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InsertPatientEnhancementDetail", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
                {
                    GetPatientForDischarge();
                    MultiView1.SetActiveView(viewPatientList);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enhancement Raised Successfully!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Request!');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enhancement already in progess!');", true);
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
    protected void btnChangeWard_Click(object sender, EventArgs e)
    {
        MultiView3.SetActiveView(viewChangeWard);
    }
    protected void btnInitiateChangeOfWard_Click(object sender, EventArgs e)
    {

    }

    protected void btnModifyPackage_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[7];
            p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@Cardnumber", hdAbuaId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@ClaimId", hdClaimId.Value);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@Remarks", tbModifyPackageRemarks.Text);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@UserId", hdUserId.Value);
            p[6].DbType = DbType.String;

            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PreAuthModifyPackage", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Id"].ToString() == "1")
                {
                    GetPatientForDischarge();
                    MultiView1.SetActiveView(viewPatientList);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Successful! Please modify package through Initiate Pre-Auth');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Request!');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Request!');", true);
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
            getAddedProcedureForDischarge();
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
    protected void getAddedProcedureForDischarge()
    {
        DataTable dt = null;
        dt = preAuth.getPatientAddedProcedureForDischarge(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value);
        if (dt.Rows.Count > 0)
        {
            t4gridAddedProcedure.DataSource = dt;
            t4gridAddedProcedure.DataBind();
        }
        else
        {
            t4gridAddedProcedure.DataSource = "";
            t4gridAddedProcedure.DataBind();
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
    protected void btnSaveSurgeryDate_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in t4gridAddedProcedure.Rows)
        {
            Label lbProcedureId = row.FindControl("lbProcedureId") as Label;
            TextBox tbSurgeryDateTime = row.FindControl("tbSurgeryDateTime") as TextBox;

            if (lbProcedureId != null && tbSurgeryDateTime.Text != null && tbSurgeryDateTime.Text != "")
            {
                string procedureId = lbProcedureId.Text;
                string surgeryDate = tbSurgeryDateTime.Text;
                int res = preAuth.UpdateTreatmentStartDate(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, hdPatientRegId.Value, Convert.ToInt32(lbProcedureId.Text), Convert.ToDateTime(surgeryDate.ToString()));
                if (res != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Update Successfully!');", true);
                }
            }
        }
    }
    protected void btnAttachments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAttachment);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-warning p-3";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
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
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
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
    protected void btnAttachment_Click(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientManditoryDocument(hdAbuaId.Value.ToString());

            if (dt.Rows.Count > 0)
            {
                // Check and handle the first row (index 0)
                foreach (DataRow dr in dt.Rows)
                {
                    string DocumentId = dr["DocumentId"].ToString().Trim();
                    string FolderName = dr["FolderName"].ToString().Trim();
                    string UploadedFileName = dr["UploadedFileName"].ToString().Trim();
                    if (DocumentId.Equals("4"))
                    {
                        lbDischargeSummaryStatus.Text = "Click Here To View";
                        lbDischargeFolderName.Text = FolderName;
                        lbDischargeUploadedFileName.Text = UploadedFileName;
                        lbDischargeSummaryStatus.ForeColor = System.Drawing.Color.Green;
                        btnDischargeSummary.Enabled = true;
                    }
                    else if (DocumentId.Equals("5"))
                    {
                        lbOperationDocumentStatus.Text = "Click Here To View";
                        lbOperationDocumentFolderName.Text = FolderName;
                        lbOperationDocumentUploadedFileName.Text = UploadedFileName;
                        lbOperationDocumentStatus.ForeColor = System.Drawing.Color.Green;
                        btnOperationDocument.Enabled = true;
                    }
                    else if (DocumentId.Equals("6"))
                    {
                        lbDischargePhotoStatus.Text = "Click Here To View";
                        lbDischargePhotoFolderName.Text = FolderName;
                        lbDischargePhotoUploadedFileName.Text = UploadedFileName;
                        lbDischargePhotoStatus.ForeColor = System.Drawing.Color.Green;
                        btnDischargePhoto.Enabled = true;
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
    protected void btnUploadDischargeSummary_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuDischargeSummary.HasFile)
            {
                string fileExtension = Path.GetExtension(fuDischargeSummary.FileName).ToLower();
                int fileSize = fuDischargeSummary.PostedFile.ContentLength;
                string mimeType = fuDischargeSummary.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuDischargeSummary.PostedFile.InputStream)
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

                        string fileName = "DischargeSummary_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        File.WriteAllBytes(imagePath, fileBytes);
                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 2);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 4);
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
                                ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                        }
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
    protected void btnUploadOperationDocument_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuOperationDocument.HasFile)
            {
                string fileExtension = Path.GetExtension(fuOperationDocument.FileName).ToLower();
                int fileSize = fuOperationDocument.PostedFile.ContentLength;
                string mimeType = fuOperationDocument.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuOperationDocument.PostedFile.InputStream)
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

                        string fileName = "OperationDocument_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        File.WriteAllBytes(imagePath, fileBytes);
                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 2);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 5);
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
                                ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                        }
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
    protected void btnUploadAfterDischargePhoto_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuDischargePhoto.HasFile)
            {
                string fileExtension = Path.GetExtension(fuDischargePhoto.FileName).ToLower();
                int fileSize = fuDischargePhoto.PostedFile.ContentLength;
                string mimeType = fuDischargePhoto.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuDischargePhoto.PostedFile.InputStream)
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

                        string fileName = "DischargePhoto_" + "_" + hdAbuaId.Value;
                        string imagePath = Path.Combine(destinationFolderPath, fileName + ".jpeg");

                        File.WriteAllBytes(imagePath, fileBytes);
                        SqlParameter[] p = new SqlParameter[8];
                        p[0] = new SqlParameter("@HospitalId", hdHospitalId.Value);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@CardNumber", hdAbuaId.Value);
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@DocumentFor", 2);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@DocumentId", 6);
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
                                ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDischargeSummary, btnUploadDischargeSummary.GetType(), "Error", strMessage, true);
                        }
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
    protected void lnkBackToList_Click(object sender, EventArgs e)
    {
        btnRequestEnhancement.Visible = false;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
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
    protected void btnDischargeSummary_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbDischargeFolderName.Text;
            string fileName = lbDischargeUploadedFileName.Text + ".jpeg";
            string DocumentName = "Discharge Summary";
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
    protected void btnOperationDocument_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbOperationDocumentFolderName.Text;
            string fileName = lbOperationDocumentUploadedFileName.Text + ".jpeg";
            string DocumentName = "Operation Document";
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
    protected void btnDischargePhoto_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbDischargePhotoFolderName.Text;
            string fileName = lbDischargeUploadedFileName.Text + ".jpeg";
            string DocumentName = "After Discharge Photo";
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
}