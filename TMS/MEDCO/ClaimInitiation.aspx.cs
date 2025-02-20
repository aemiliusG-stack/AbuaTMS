using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using CareerPath.DAL;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web;
using iText.IO.Image;
public partial class MEDCO_ClaimInitiation : System.Web.UI.Page
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
    private SHAHelper shaHelper = new SHAHelper();
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
                    GetPatientForClaimInitiation();
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
    protected void GetPatientForClaimInitiation()
    {
        gridPatientForDischarge.DataSource = "";
        gridPatientForDischarge.DataBind();
        dt.Clear();
        dt = preAuth.GetPatientForClaimInitiation(Convert.ToInt32(hdHospitalId.Value));
        if (dt.Rows.Count > 0)
        {
            hdAdmissionDate.Value = dt.Rows[0]["AdmissionDate"].ToString();
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
                if (dt.Rows[0]["IsDischarged"].ToString().Trim().Equals("True"))
                {
                    hdDischargeId.Value = dt.Rows[0]["DischargeId"].ToString().Trim();
                }

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
        btnClaim.CssClass = "btn btn-primary p-3";
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
        btnClaim.CssClass = "btn btn-primary p-3";
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
            btnTreatment.CssClass = "btn btn-primary p-3";
            btnAttachments.CssClass = "btn btn-primary p-3";
            btnClaim.CssClass = "btn btn-primary p-3";
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
        dt = preAuth.GetWorkFlow(Convert.ToInt32(hdClaimId.Value));
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
            gridSurgeryTreatementDate.DataSource = dt;
            t3gridAddedpackageProcedure.DataBind();
            gridSurgeryTreatementDate.DataBind();
        }
        else
        {
            t3gridAddedpackageProcedure.DataSource = "";
            t3gridAddedpackageProcedure.DataBind();
            gridSurgeryTreatementDate.DataSource = "";
            gridSurgeryTreatementDate.DataBind();
        }
    }
    protected void btnTreatment_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.SetActiveView(viewTreatmentDischarge);
            btnInitialAssessment.CssClass = "btn btn-primary p-3";
            btnPastHistory.CssClass = "btn btn-primary p-3";
            btnPreAutoriztion.CssClass = "btn btn-primary p-3";
            btnTreatment.CssClass = "btn btn-warning p-3";
            btnAttachments.CssClass = "btn btn-primary p-3";
            btnClaim.CssClass = "btn btn-primary p-3";
            if (!hdDischargeId.Value.ToString().Equals(""))
            {
                getSurgeonDetails(hdDischargeId.Value.ToString());
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
        MultiView2.SetActiveView(viewAttachment);
        btnInitialAssessment.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnPreAutoriztion.CssClass = "btn btn-primary p-3";
        btnTreatment.CssClass = "btn btn-primary p-3";
        btnAttachments.CssClass = "btn btn-warning p-3";
        btnClaim.CssClass = "btn btn-primary p-3";
        getManditoryDocuments(hdHospitalId.Value, hdPatientRegId.Value);
    }
    protected void btnAttachment_Click(object sender, EventArgs e)
    {
        getDischargeDocument();
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
        MultiView2.ActiveViewIndex = -1;
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
            string fileName = lbDischargePhotoUploadedFileName.Text + ".jpeg";
            string DocumentName = "After Discharge Photo";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
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
                dtDocument = preAuth.getPostInvestigationDocumentsProcedure(Convert.ToInt32(hdHospitalId.Value), hdAbuaId.Value, Convert.ToInt32(hdPatientRegId.Value), packageid, ProcedureId);
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
            Label lbDocumentName = (Label)row.FindControl("lbPostInvestigationName");
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void btnUploadPostInvestigation(object sender, EventArgs e)
    {
        try
        {
            Button btnUpload = (Button)sender;
            string InvestigationId = btnUpload.CommandArgument;
            GridViewRow row = (GridViewRow)btnUpload.NamingContainer;
            // Dim fuImage As FileUpload = CType(row.FindControl("fuImage"), FileUpload)
            Label lbPostInvestigationPackageId = (Label)row.FindControl("lbPostInvestigationPackageId");
            Label lbPostInvestigationProcedureId = (Label)row.FindControl("lbPostInvestigationProcedureId");
            Label lbPostInvestigationId = (Label)row.FindControl("lbPostInvestigationId");
            Label lbPostInvestigationName = (Label)row.FindControl("lbPostInvestigationName");

            hdPackageId.Value = lbPostInvestigationPackageId.Text;
            hdProcedureId.Value = lbPostInvestigationProcedureId.Text;
            hdPostInvestigationId.Value = lbPostInvestigationId.Text;
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
    protected void btnDischarge_Click(object sender, EventArgs e)
    {
        getDischargeDocument();
    }
    protected void btnOther_Click(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = preAuth.GetPatientManditoryDocument(hdAbuaId.Value.ToString());
            hdCount.Value = "0";

            if (dt.Rows.Count > 0)
            {
                // Check and handle the first row (index 0)
                foreach (DataRow dr in dt.Rows)
                {
                    string DocumentId = dr["DocumentId"].ToString().Trim();
                    string FolderName = dr["FolderName"].ToString().Trim();
                    string UploadedFileName = dr["UploadedFileName"].ToString().Trim();
                    if (DocumentId.Equals("7"))
                    {
                        lbDocumentOneStatus.Text = "Click Here To View";
                        lbDocumentOneFolderName.Text = FolderName;
                        lbDocumentOneUploadedFileName.Text = UploadedFileName;
                        lbDocumentOneStatus.ForeColor = System.Drawing.Color.Green;
                        btnDocumentOne.Enabled = true;
                        panelOne.Visible = true;
                        hdCount.Value = Convert.ToString(Convert.ToInt32(hdCount.Value) + 1);
                    }
                    else if (DocumentId.Equals("8"))
                    {
                        lbDocumentTwoStatus.Text = "Click Here To View";
                        lbDocumentTwoFolderName.Text = FolderName;
                        lbDocumentTwoUploadedFileName.Text = UploadedFileName;
                        lbDocumentTwoStatus.ForeColor = System.Drawing.Color.Green;
                        btnDocumentTwo.Enabled = true;
                        panelTwo.Visible = true;
                        hdCount.Value = Convert.ToString(Convert.ToInt32(hdCount.Value) + 1);
                    }
                    else if (DocumentId.Equals("9"))
                    {
                        lbDocumentThreeStatus.Text = "Click Here To View";
                        lbDocumentThreeFolderName.Text = FolderName;
                        lbDocumentThreeUploadedFileName.Text = UploadedFileName;
                        lbDocumentThreeStatus.ForeColor = System.Drawing.Color.Green;
                        btnDocumentThree.Enabled = true;
                        panelThree.Visible = true;
                        hdCount.Value = Convert.ToString(Convert.ToInt32(hdCount.Value) + 1);
                    }
                }
            }
            multiViewDischarge.SetActiveView(viewMultipleDocument);
            btnDischarge.CssClass = "nav-link nav-attach";
            btnOther.CssClass = "nav-link active nav-attach ml-2";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
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
    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        hdCount.Value = Convert.ToString(Convert.ToInt32(hdCount.Value) + 1);
        int count = Convert.ToInt32(hdCount.Value);
        if (count < 4)
        {
            if (count == 1)
            {
                panelOne.Visible = true;
                panelTwo.Visible = false;
                panelThree.Visible = false;
            }
            else if (count == 2)
            {
                panelOne.Visible = true;
                panelTwo.Visible = true;
                panelThree.Visible = false;
            }
            else if (count == 3)
            {
                panelOne.Visible = true;
                panelTwo.Visible = true;
                panelThree.Visible = true;
            }
        }
        multiViewDischarge.SetActiveView(viewMultipleDocument);
        btnDischarge.CssClass = "nav-link nav-attach";
        btnOther.CssClass = "nav-link active nav-attach ml-2";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
    }
    protected void btnUploadDocumentOne_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuDocumentOne.HasFile)
            {
                string fileExtension = Path.GetExtension(fuDocumentOne.FileName).ToLower();
                int fileSize = fuDocumentOne.PostedFile.ContentLength;
                string mimeType = fuDocumentOne.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuDocumentOne.PostedFile.InputStream)
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

                        string fileName = "DocumentOne_" + "_" + hdAbuaId.Value;
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
                        p[4] = new SqlParameter("@DocumentId", 7);
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
                                ScriptManager.RegisterStartupScript(btnUploadDocumentOne, btnUploadDocumentOne.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDocumentOne, btnUploadDocumentOne.GetType(), "Error", strMessage, true);
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
    protected void btnDocumentOne_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbDocumentOneFolderName.Text;
            string fileName = lbDocumentOneUploadedFileName.Text + ".jpeg";
            string DocumentName = "Document One";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void btnUploadDocumentTwo_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuDocumentTwo.HasFile)
            {
                string fileExtension = Path.GetExtension(fuDocumentTwo.FileName).ToLower();
                int fileSize = fuDocumentTwo.PostedFile.ContentLength;
                string mimeType = fuDocumentTwo.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuDocumentTwo.PostedFile.InputStream)
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

                        string fileName = "DocumentTwo_" + "_" + hdAbuaId.Value;
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
                        p[4] = new SqlParameter("@DocumentId", 8);
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
                                ScriptManager.RegisterStartupScript(btnUploadDocumentTwo, btnUploadDocumentTwo.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDocumentTwo, btnUploadDocumentTwo.GetType(), "Error", strMessage, true);
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
    protected void btnDocumentTwo_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbDocumentTwoFolderName.Text;
            string fileName = lbDocumentTwoUploadedFileName.Text + ".jpeg";
            string DocumentName = "Document Two";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void btnUploadDocumentThree_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuDocumentThree.HasFile)
            {
                string fileExtension = Path.GetExtension(fuDocumentThree.FileName).ToLower();
                int fileSize = fuDocumentThree.PostedFile.ContentLength;
                string mimeType = fuDocumentThree.PostedFile.ContentType;
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    using (Stream fileStream = fuDocumentThree.PostedFile.InputStream)
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

                        string fileName = "DocumentThree_" + "_" + hdAbuaId.Value;
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
                        p[4] = new SqlParameter("@DocumentId", 9);
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
                                ScriptManager.RegisterStartupScript(btnUploadDocumentThree, btnUploadDocumentThree.GetType(), "Error", strMessage, true);
                            }
                        }
                        else
                        {
                            strMessage = "window.alert('Invalid request!');";
                            ScriptManager.RegisterStartupScript(btnUploadDocumentThree, btnUploadDocumentThree.GetType(), "Error", strMessage, true);
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
    protected void btnDocumentThree_Click(object sender, EventArgs e)
    {
        try
        {
            string folderName = lbDocumentThreeFolderName.Text;
            string fileName = lbDocumentThreeUploadedFileName.Text + ".jpeg";
            string DocumentName = "Document Three";
            string base64Image = "";
            base64Image = preAuth.DisplayImage(folderName, fileName);
            if (base64Image != "")
            {
                imgChildView.ImageUrl = "data:image/jpeg;base64," + base64Image;
            }
            lbTitle.Text = DocumentName;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showContentModal", "showContentModal();", true);
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    public void getDischargeDocument()
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
            }
            multiViewDischarge.SetActiveView(viewDischargeDocument);
            btnDischarge.CssClass = "nav-link active nav-attach";
            btnOther.CssClass = "nav-link nav-attach ml-2";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showAttachmentAnamolyModal", "showAttachmentAnamolyModal();", true);
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

    public void getSurgeonDetails(string DischargeId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetSurgeonDetails(DischargeId);
            if (dt != null && dt.Rows.Count > 0)
            {
                tbDoctorType.Text = dt.Rows[0]["DoctorType"].ToString();
                tbDoctorName.Text = dt.Rows[0]["Name"].ToString();
                tbRegistrationNo.Text = dt.Rows[0]["RegistrationNumber"].ToString();
                tbQualification.Text = dt.Rows[0]["Qualification"].ToString();
                tbContact.Text = dt.Rows[0]["MobileNumber"].ToString();
                getAnesthetistDetails(DischargeId);
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

    public void getAnesthetistDetails(string DischargeId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetAnesthetistDetails(DischargeId);
            if (dt != null && dt.Rows.Count > 0)
            {
                tbAnesthetistName.Text = dt.Rows[0]["Name"].ToString();
                tbAnesthetistRegNo.Text = dt.Rows[0]["RegistrationNumber"].ToString();
                tbAnesthetistContact.Text = dt.Rows[0]["MobileNumber"].ToString();
                getOtherDischargeDetails(DischargeId);
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

    public void getOtherDischargeDetails(string DischargeId)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ppdHelper.GetOtherDischargeDetails(DischargeId);
            if (dt != null && dt.Rows.Count > 0)
            {
                tbIncisionType.Text = dt.Rows[0]["IncisionType"].ToString();
                if (dt.Rows[0]["OPPhotosWebexTaken"].ToString().Equals("True"))
                {
                    rbPhotoWebYes.Checked = true;
                    rbPhotoWebNo.Checked = false;
                }
                else
                {
                    rbPhotoWebYes.Checked = false;
                    rbPhotoWebNo.Checked = true;
                }
                if (dt.Rows[0]["VideoRecordingDone"].ToString().Equals("True"))
                {
                    rbVideoYes.Checked = true;
                    rbVideoNo.Checked = false;
                }
                else
                {
                    rbVideoYes.Checked = false;
                    rbVideoNo.Checked = true;
                }
                tbSwabCount.Text = dt.Rows[0]["SwabCountInstrumentsCount"].ToString();
                tbSutures.Text = dt.Rows[0]["SuturesLigatures"].ToString();
                if (dt.Rows[0]["SpecimenRequired"].ToString().Equals("True"))
                {
                    rbSpecimenYes.Checked = true;
                    rbSpecimenNo.Checked = false;
                }
                else
                {
                    rbSpecimenYes.Checked = false;
                    rbSpecimenNo.Checked = true;
                }
                tbDrainageCount.Text = dt.Rows[0]["DrainageCount"].ToString();
                tbBloodLoss.Text = dt.Rows[0]["BloodLoss"].ToString();
                tbPostOperative.Text = dt.Rows[0]["PostOperativeInstructions"].ToString();
                tbPatientCondition.Text = dt.Rows[0]["PatientCondition"].ToString();
                if (dt.Rows[0]["ComplicationsIfAny"].ToString().Equals("True"))
                {
                    rbComplicationYes.Checked = true;
                    rbComplicationNo.Checked = false;
                }
                else
                {
                    rbComplicationYes.Checked = false;
                    rbComplicationNo.Checked = true;
                }
                tbTreatementDate.Text = dt.Rows[0]["TreatmentSurgeryStartDate"].ToString();
                tbSurgeryStartTime.Text = dt.Rows[0]["SurgeryStartTime"].ToString();
                tbSurgeryEndTime.Text = dt.Rows[0]["SurgeryEndTime"].ToString();
                tbTreatementGiven.Text = dt.Rows[0]["TreatmentGiven"].ToString();
                tbOperativeFinding.Text = dt.Rows[0]["OperativeFindings"].ToString();
                tbPostOperativePeriod.Text = dt.Rows[0]["PostOperativePeriod"].ToString();
                tbPostSurgeryGiven.Text = dt.Rows[0]["PostSurgeryInvestigationGiven"].ToString();
                tbStatusAtDischarge.Text = dt.Rows[0]["StatusAtDischarge"].ToString();
                tbReview.Text = dt.Rows[0]["Review"].ToString();
                tbAdvice.Text = dt.Rows[0]["Advice"].ToString();
                tbDischargeDate.Text = dt.Rows[0]["DischargeDate"].ToString();
                tbNextFollowDate.Text = dt.Rows[0]["NextFollowUpDate"].ToString();
                tbConsultAtBlock.Text = dt.Rows[0]["ConsultAtBlock"].ToString();
                tbFloor.Text = dt.Rows[0]["FloorNo"].ToString();
                tbRoomNo.Text = dt.Rows[0]["RoomNo"].ToString();
                tbSpecialCaseValue.Text = dt.Rows[0]["SpecialCaseValue"].ToString();
                tbFinalDiagnosisDescription.Text = dt.Rows[0]["FinalDiagnosisDesc"].ToString();
                if (dt.Rows[0]["IsDischarged"].ToString().Equals("True"))
                {
                    rbDischarge.Checked = true;
                    rbDeath.Checked = false;
                }
                else
                {
                    rbDischarge.Checked = false;
                    rbDeath.Checked = true;
                }
                if (dt.Rows[0]["IsSpecialCase"].ToString().Equals("True"))
                {
                    tbIsSpecialCase.Text = "Yes";
                }
                else
                {
                    tbIsSpecialCase.Text = "No";
                }
                if (dt.Rows[0]["FinalDiagnosis"].ToString().Equals("1"))
                {
                    tbFinalDiagnosis.Text = "Other";
                }
                if (dt.Rows[0]["ProcedureConsent"].ToString().Equals("True"))
                {
                    rbProcedureConsentYes.Checked = true;
                    rbProcedureConsentNo.Checked = false;
                }
                else
                {
                    rbProcedureConsentYes.Checked = false;
                    rbProcedureConsentNo.Checked = true;
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

    protected void btnClaim_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.SetActiveView(viewClaim);
            btnInitialAssessment.CssClass = "btn btn-primary p-3";
            btnPastHistory.CssClass = "btn btn-primary p-3";
            btnPreAutoriztion.CssClass = "btn btn-primary p-3";
            btnTreatment.CssClass = "btn btn-primary p-3";
            btnAttachments.CssClass = "btn btn-primary p-3";
            btnClaim.CssClass = "btn btn-warning p-3";
            getClaimDetails();
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

    protected void getClaimDetails()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = shaHelper.GetClaimsDetails(hdClaimId.Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                lbPreauthApprovedAmount.Text = Convert.ToDecimal(dt.Rows[0]["PreAuthApprovedAmt"]).ToString();
                lbPreauthDate.Text = Convert.ToDateTime(dt.Rows[0]["PreAuthApprovedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                lbClaimSubmittedDate.Text = Convert.ToDateTime(dt.Rows[0]["ClaimSubmittedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                lbClaimUpdatedDate.Text = Convert.ToDateTime(dt.Rows[0]["ClaimUpdatedDate"]).ToString("dd/MM/yyyy hh:mm tt");
                lbPenaltyAmount.Text = "NA";
                lbClaimAmount.Text = Convert.ToDecimal(dt.Rows[0]["ClaimAmount"]).ToString();
                lbInsuranceLiableAmount.Text = Convert.ToDecimal(dt.Rows[0]["InsuranceLiableAmt"]).ToString();
                lbTrustLiableAmount.Text = Convert.ToDecimal(dt.Rows[0]["TrustLiableAmt"]).ToString();
                lbBillAmount.Text = Convert.ToDecimal(dt.Rows[0]["BillAmt"]).ToString();
                tbClaimRemarks.Text = dt.Rows[0]["ClaimRemarks"].ToString();
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

    protected void btnInitiateClaim_Click(object sender, EventArgs e)
    {
        try
        {
            if (!cbTerms.Checked)
            {
                strMessage = "window.alert('Please confirm that you have validated all documents before making any decisions by checking the box.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            }
            else
            {
                if (dlAction.SelectedItem.Value.Equals("0"))
                {
                    strMessage = "window.alert('Action type is required.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else
                {
                    InitiateClaim();
                }
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    public void InitiateClaim()
    {
        try
        {
            SqlParameter[] p = new SqlParameter[7];
            p[0] = new SqlParameter("@AdmissionId", hdAdmissionId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@ClaimId", hdClaimId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@UserId", hdUserId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@Amount", lbClaimAmount.Text.ToString());
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@PatientRegId", hdPatientRegId.Value);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@CardNumber", hdAbuaId.Value);
            p[6].DbType = DbType.String;
            SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InitiateClaim", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            strMessage = "window.alert('Claim Initiated.');";
            strMessage += "window.location='ClaimInitiation.aspx';";
            ScriptManager.RegisterStartupScript(btnUploadDocumentThree, btnUploadDocumentThree.GetType(), "Error", strMessage, true);
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