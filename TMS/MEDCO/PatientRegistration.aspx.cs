using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using CareerPath.DAL;
using Newtonsoft.Json;
using System.Net.Http;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.Security;
using System.Web;
using WebGrease.Css.Ast;
using System.Net;

partial class MEDCO_PatientRegistration : System.Web.UI.Page
{
    private string strMessage;
    string pageName = "";
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private string ImageUrlFinal = "";
    private readonly HttpClient _httpClient = new HttpClient();
    private readonly string _connectionString = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
    // Private ReadOnly _baseUrl As String = "https://massyapi.deosoft.in/api/Pds/abua-card-details?BenID="
    private readonly string _baseUrl = "https://mmassy-bisuat.jharkhand.gov.in:81/api/Pds/abua-card-details?BenID=";
    private readonly string _apiKey = "YtZjI4Yy00MGRhLWJmMjItNjQ5M";  // Replace this with your actual key
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
                    string minDate = DateTime.Now.AddDays(-5).ToString("yyyy-MM-dd");
                    string maxDate = DateTime.Now.AddDays(0).ToString("yyyy-MM-dd");
                    tbRegDate.Attributes["min"] = minDate;
                    tbRegDate.Attributes["max"] = maxDate;
                    divMobileBelongsTo.Visible = false;
                    MultiView1.SetActiveView(viewRetrieve);
                    hdUserId.Value = Session["UserId"].ToString();
                    hdUserName.Value = Session["Username"].ToString();
                    hdHospitalId.Value = Session["HospitalId"].ToString();
                    tbMitraId.Text = Session["Username"].ToString();
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

    protected void GetStates()
    {
        try
        {
            dt.Clear();
            dt = md.GetState();
            if (dt.Rows.Count > 0)
            {
                dropState.Items.Clear();
                dropState.DataValueField = "Id";
                dropState.DataTextField = "Title";
                dropState.DataSource = dt;
                dropState.DataBind();
                dropState.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropState.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected async void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextboxValidation.isAlphaNumeric(tbIdNumber.Text) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Entry')", true);
                return;
            }
            tbCommAddress.Text = "";
            dropDistrict.Items.Clear();
            dropBlock.Items.Clear();
            dropVillage.Items.Clear();
            tbPinCode.Text = "";
            tbRegDate.Text = "";
            dropMobileBelongsTo.SelectedValue = "0";
            SqlParameter[] p1 = new SqlParameter[1];
            p1[0] = new SqlParameter("@IdNumber", tbIdNumber.Text);
            p1[0].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_GetBISPatientDetail", p1);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["checkId"].ToString() == "0")
                {
                    string benId = tbIdNumber.Text;
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls13;

                    HttpClientHandler handler = new HttpClientHandler
                    {
                        ServerCertificateCustomValidationCallback = (message, cert, chain, sslPolicyErrors) =>
                        {
                            // Log or inspect errors for debugging
                            Console.WriteLine(sslPolicyErrors);
                            // Ignore certificate validation errors (only for testing)
                            return true;
                        }
                    };
                    HttpClient _httpClient = new HttpClient(handler);
                    // Setup the request with headers
                    var request = new HttpRequestMessage(HttpMethod.Get, _baseUrl + benId);
                    request.Headers.Add("accept", "*/*");
                    request.Headers.Add("Key", _apiKey);

                    // Send the request and get the response
                    var response = await _httpClient.SendAsync(request);

                    // Ensure the request was successful
                    response.EnsureSuccessStatusCode();

                    // Deserialize the response
                    var responseData = await response.Content.ReadAsStringAsync();
                    var abuaCardDetails = JsonConvert.DeserializeObject<AbuaCardDetailsResponse>(responseData);

                    // Handle the response and update the UI
                    if (abuaCardDetails == null || abuaCardDetails.Data == null)
                    {
                        MultiView1.SetActiveView(viewRetrieve);
                        string strMessage = "window.alert('Invalid Abua Id! Please contact BIS team.');";
                        ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    }
                    else
                    {
                        lbAbuaId.Text = abuaCardDetails.Data.AbuA_Id;
                        lbName.Text = abuaCardDetails.Data.Name;
                        lbGender.Text = abuaCardDetails.Data.Gender;
                        lbMobileNo.Text = abuaCardDetails.Data.Mobile_Number;
                        lbYOB.Text = abuaCardDetails.Data.Year_of_Birth.ToString();
                        lbAge.Text = abuaCardDetails.Data.Age.ToString();
                        lbAddress.Text = abuaCardDetails.Data.Address;
                        lbState.Text = abuaCardDetails.Data.State_Name;
                        lbDistrict.Text = abuaCardDetails.Data.District_Name;
                        lbPinCode.Text = abuaCardDetails.Data.PinCode;
                        hdFamilyId.Value = abuaCardDetails.Data.Family_Id;
                        string patientImageBase64 = "";
                        patientImageBase64 = abuaCardDetails.Data.Photo;
                        // patientImageBase64 = patientImageBase64.Replace("data:image/png;base64,", "")
                        if (!string.IsNullOrEmpty(patientImageBase64))
                            imgPatientPhoto.ImageUrl = patientImageBase64;
                        else
                            imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";

                        GetStates();
                        MultiView1.SetActiveView(viewDetails);
                        hdAbuaId.Value = abuaCardDetails.Data.AbuA_Id;
                        SqlParameter[] p = new SqlParameter[17];
                        p[0] = new SqlParameter("@PatientFamilyId", abuaCardDetails.Data.Family_Id);
                        p[0].DbType = DbType.String;
                        p[1] = new SqlParameter("@RationCardNo", "");
                        p[1].DbType = DbType.String;
                        p[2] = new SqlParameter("@CardType", 1);
                        p[2].DbType = DbType.String;
                        p[3] = new SqlParameter("@CardNumber", abuaCardDetails.Data.AbuA_Id);
                        p[3].DbType = DbType.String;
                        p[4] = new SqlParameter("@PatientName", abuaCardDetails.Data.Name);
                        p[4].DbType = DbType.String;
                        p[5] = new SqlParameter("@Gender", abuaCardDetails.Data.Gender);
                        p[5].DbType = DbType.String;
                        p[6] = new SqlParameter("@YOB", abuaCardDetails.Data.Year_of_Birth.ToString());
                        p[6].DbType = DbType.String;
                        p[7] = new SqlParameter("@Age", abuaCardDetails.Data.Age.ToString());
                        p[7].DbType = DbType.String;
                        p[8] = new SqlParameter("@MobileNumber", abuaCardDetails.Data.Mobile_Number);
                        p[8].DbType = DbType.String;
                        p[9] = new SqlParameter("@PatientAddress", abuaCardDetails.Data.Address);
                        p[9].DbType = DbType.String;
                        p[10] = new SqlParameter("@StateCode", abuaCardDetails.Data.State_Code);
                        p[10].DbType = DbType.String;
                        p[11] = new SqlParameter("@StateName", abuaCardDetails.Data.State_Name);
                        p[11].DbType = DbType.String;
                        p[12] = new SqlParameter("@DistrictCode", abuaCardDetails.Data.District_Code);
                        p[12].DbType = DbType.String;
                        p[13] = new SqlParameter("@DistrictName", abuaCardDetails.Data.District_Name);
                        p[13].DbType = DbType.String;
                        //p[14] = new SqlParameter("@PinCode", abuaCardDetails.Data.PinCode ?? DBNull.Value);
                        p[14] = new SqlParameter("@PinCode", abuaCardDetails.Data.PinCode == null ? "" : abuaCardDetails.Data.PinCode);
                        p[14].DbType = DbType.String;
                        p[15] = new SqlParameter("@PatientImage", patientImageBase64.ToString());
                        p[15].DbType = DbType.String;
                        p[16] = new SqlParameter("@RegisteredBy", hdUserId.Value);
                        p[16].DbType = DbType.String;

                        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InsertBISBeneficiaryDetail", p);
                        if (con.State == ConnectionState.Open)
                            con.Close();
                    }
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "1")
                {
                    string HospitalName = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                    strMessage = "window.alert('Patient already taking treatment in " + HospitalName + "');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "2")
                {
                    string HospitalName = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                    strMessage = "window.alert('Patient already taking treatment in " + HospitalName + "');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (ds.Tables[0].Rows[0]["checkId"].ToString() == "3")
                {
                    dt = ds.Tables[0];
                    MultiView1.SetActiveView(viewDetails);
                    lbAbuaId.Text = dt.Rows[0]["CardNumber"].ToString();
                    lbName.Text = dt.Rows[0]["PatientName"].ToString();
                    lbGender.Text = dt.Rows[0]["Gender"].ToString();
                    lbMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
                    lbYOB.Text = dt.Rows[0]["YOB"].ToString();
                    lbAge.Text = dt.Rows[0]["Age"].ToString();
                    lbAddress.Text = dt.Rows[0]["PatientAddress"].ToString();
                    lbState.Text = dt.Rows[0]["StateName"].ToString();
                    lbDistrict.Text = dt.Rows[0]["DistrictName"].ToString();
                    lbPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["PatientImage"].ToString());
                    if (!string.IsNullOrEmpty(patientImageBase64))
                        imgPatientPhoto.ImageUrl = patientImageBase64;
                    else
                        imgPatientPhoto.ImageUrl = "~/img/profile.jpeg";
                    if (cbIsChild.Checked == true)
                        childDetailPanel.Visible = true;
                    else
                        childDetailPanel.Visible = false;
                    hdFamilyId.Value = dt.Rows[0]["FamilyId"].ToString();
                    GetStates();
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            MultiView1.SetActiveView(viewRetrieve);
            strMessage = "window.alert('Invalid AbuaId! Please Contact BIS Team!');";
            ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
            return;
        }
    }

    protected void dropMobileBelongsTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (dropMobileBelongsTo.SelectedValue == "1")
                divMobileBelongsTo.Visible = false;
            else if (dropMobileBelongsTo.SelectedValue == "2")
                divMobileBelongsTo.Visible = true;
            else if (dropMobileBelongsTo.SelectedValue == "3")
                divMobileBelongsTo.Visible = true;
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void cbIfAddressSame_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (cbIfAddressSame.Checked == true)
            {
                tbCommAddress.Text = lbAddress.Text;
                tbCommMobileNo.Text = lbMobileNo.Text;
                tbPinCode.Text = lbPinCode.Text;
            }
            else
            {
                tbCommAddress.Text = "";
                tbCommMobileNo.Text = "";
                tbPinCode.Text = "";
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void dropState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = md.GetDistrictStateWise(Convert.ToInt32(dropState.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                dropDistrict.Items.Clear();
                dropDistrict.DataValueField = "Id";
                dropDistrict.DataTextField = "Title";
                dropDistrict.DataSource = dt;
                dropDistrict.DataBind();
                dropDistrict.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropDistrict.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void dropDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = md.GetBlockDistrictWise(Convert.ToInt32(dropDistrict.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                dropBlock.Items.Clear();
                dropBlock.DataValueField = "Id";
                dropBlock.DataTextField = "Title";
                dropBlock.DataSource = dt;
                dropBlock.DataBind();
                dropBlock.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropBlock.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void dropBlock_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            dt = md.GetVillageBlockWise(Convert.ToInt32(dropDistrict.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                dropVillage.Items.Clear();
                dropVillage.DataValueField = "Id";
                dropVillage.DataTextField = "Title";
                dropVillage.DataSource = dt;
                dropVillage.DataBind();
                dropVillage.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropVillage.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void btnVerifyRegister_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.SetActiveView(View1);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void btnHideModal_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "hideModal();", true);
            MultiView1.SetActiveView(viewRetrieve);
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextboxValidation.isAlphaNumeric(tbCommAddress.Text) == false || TextboxValidation.isNumeric(tbPinCode.Text) == false || TextboxValidation.IsValidMobileNumber(tbCommMobileNo.Text) == false || TextboxValidation.isNumeric(tbCommMobileNo.Text) == false || TextboxValidation.isDate(tbRegDate.Text) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Entry')", true);
                return;
            }
            if (dropState.SelectedValue != "0")
            {
                if (dropDistrict.SelectedValue != "0")
                {
                    if (dropMobileBelongsTo.SelectedValue != "0")
                    {
                        if (dropMobileBelongsTo.SelectedValue == "1")
                            goto RegisterPatient;
                        else if (dropMobileBelongsTo.SelectedValue == "2" | dropMobileBelongsTo.SelectedValue == "3")
                        {
                            if (dropRelation.SelectedValue != "0")
                                goto RegisterPatient;
                            else
                            {
                                strMessage = "window.alert('Please Select Relation!');";
                                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                                return;
                            }
                        }
                    }
                    else
                    {
                        strMessage = "window.alert('Please Select Mobile Belongs To!');";
                        ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
                else
                {
                    strMessage = "window.alert('Please Select District!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    return;
                }
            }
            else
            {
                strMessage = "window.alert('Please Select State!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

RegisterPatient:
            ;
            int isChild = 0;
            string fileName = "";
            int IsChildImage = 2;
            string fileNameChild = "";
            if (cbIsChild.Checked == true)
                isChild = 1;
            else
                isChild = 0;
            string imageUrl = imgPatientPhoto.ImageUrl;
            if (imageUrl != "")
            {
                imageUrl = imageUrl.Replace("data:image/jpeg;base64,", "");
                byte[] fileBytes = Convert.FromBase64String(imageUrl);
                fileName = tbIdNumber.Text + "_Profile_Image.jpeg";
                string randomFolderName = tbIdNumber.Text;

                string baseFolderPath = ConfigurationManager.AppSettings["RemoteImagePath"];
                string destinationFolderPath = Path.Combine(baseFolderPath, randomFolderName);
                if (!Directory.Exists(destinationFolderPath))
                    Directory.CreateDirectory(destinationFolderPath);
                string ImagePath = destinationFolderPath + @"\" + fileName;
                File.WriteAllBytes(ImagePath, fileBytes);
            }

            if (fuChildPhoto.HasFile)
            {
                string fileExtension = Path.GetExtension(fuChildPhoto.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    string randomFolderNameChild = tbIdNumber.Text;
                    fileNameChild = tbIdNumber.Text + "_Profile_Image_Child.jpeg";

                    string baseFolderPathChild = ConfigurationManager.AppSettings["RemoteImagePath"];
                    string destinationFolderPathChild = Path.Combine(baseFolderPathChild, randomFolderNameChild);

                    if (!Directory.Exists(destinationFolderPathChild))
                        Directory.CreateDirectory(destinationFolderPathChild);
                    string ImagePath = destinationFolderPathChild + @"\" + fileNameChild.ToString();
                    fuChildPhoto.SaveAs(ImagePath);
                    IsChildImage = 0;
                }
            }
            else if (fuRationCard.HasFile)
            {
                string fileExtension = Path.GetExtension(fuRationCard.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    string randomFolderNameChild = tbIdNumber.Text;
                    fileNameChild = tbIdNumber.Text + "_Profile_Image_Child.jpeg";

                    string baseFolderPathChild = ConfigurationManager.AppSettings["RemoteImagePath"];
                    string destinationFolderPathChild = Path.Combine(baseFolderPathChild, randomFolderNameChild);

                    if (!Directory.Exists(destinationFolderPathChild))
                        Directory.CreateDirectory(destinationFolderPathChild);
                    string ImagePath = destinationFolderPathChild + @"\" + fileNameChild.ToString();
                    fuRationCard.SaveAs(ImagePath);
                    IsChildImage = 1;
                }
            }



            SqlParameter[] p = new SqlParameter[34];
            p[0] = new SqlParameter("@PatientFamilyId", hdFamilyId.Value);
            p[0].DbType = DbType.String;
            p[1] = new SqlParameter("@RegisteredBy", hdUserId.Value);
            p[1].DbType = DbType.String;
            p[2] = new SqlParameter("@HospitalId", hdHospitalId.Value);
            p[2].DbType = DbType.String;
            p[3] = new SqlParameter("@PatientRationCardNumber", "");
            p[3].DbType = DbType.String;
            p[4] = new SqlParameter("@CardTypeId", dropIdType.SelectedValue);
            p[4].DbType = DbType.String;
            p[5] = new SqlParameter("@CardNumber", tbIdNumber.Text);
            p[5].DbType = DbType.String;
            p[6] = new SqlParameter("@IsChild", isChild.ToString());
            p[6].DbType = DbType.String;
            p[7] = new SqlParameter("@SchemeId", dropScheme.SelectedValue);
            p[7].DbType = DbType.String;
            p[8] = new SqlParameter("@ImageURL", fileName.ToString());
            p[8].DbType = DbType.String;
            p[9] = new SqlParameter("@ChildBeneficiaryRelation", dropBeneficiaryRelation.SelectedValue);
            p[9].DbType = DbType.String;
            p[10] = new SqlParameter("@ChildDOB", tbDob.Text);
            p[10].DbType = DbType.String;
            p[11] = new SqlParameter("@ChildName", tbChildName.Text);
            p[11].DbType = DbType.String;
            p[12] = new SqlParameter("@ChildGender", dropChildGender.SelectedValue);
            p[12].DbType = DbType.String;
            p[13] = new SqlParameter("@ChildFatherName", tbFatherName.Text);
            p[13].DbType = DbType.String;
            p[14] = new SqlParameter("@ChildMotherName", tbMotherName.Text);
            p[14].DbType = DbType.String;
            p[15] = new SqlParameter("@IsChildImage", IsChildImage);
            p[15].DbType = DbType.String;
            p[16] = new SqlParameter("@ChildImageURL", fileNameChild);
            p[16].DbType = DbType.String;
            p[17] = new SqlParameter("@PatientName", lbName.Text);
            p[17].DbType = DbType.String;
            p[18] = new SqlParameter("@Gender", lbGender.Text);
            p[18].DbType = DbType.String;
            p[19] = new SqlParameter("@YOB", lbYOB.Text);
            p[19].DbType = DbType.String;
            p[20] = new SqlParameter("@Age", lbAge.Text);
            p[20].DbType = DbType.String;
            p[21] = new SqlParameter("@PatientAddress", tbCommAddress.Text);
            p[21].DbType = DbType.String;
            p[22] = new SqlParameter("@StateId", dropState.SelectedValue);
            p[22].DbType = DbType.String;
            p[23] = new SqlParameter("@DistrictId", dropDistrict.SelectedValue);
            p[23].DbType = DbType.String;
            p[24] = new SqlParameter("@BlockId", dropBlock.SelectedValue);
            p[24].DbType = DbType.String;
            p[25] = new SqlParameter("@VillageId", dropVillage.SelectedValue);
            p[25].DbType = DbType.String;
            p[26] = new SqlParameter("@PinCode", tbPinCode.Text);
            p[26].DbType = DbType.String;
            p[27] = new SqlParameter("@MobileBelongsToId", dropMobileBelongsTo.SelectedValue);
            p[27].DbType = DbType.String;
            p[28] = new SqlParameter("@PatientRelation", dropRelation.SelectedValue);
            p[28].DbType = DbType.String;
            p[29] = new SqlParameter("@MobileNumber", tbCommMobileNo.Text);
            p[29].DbType = DbType.String;
            p[30] = new SqlParameter("@RegDate", tbRegDate.Text);
            p[30].DbType = DbType.String;
            p[31] = new SqlParameter("@AbuaMitraId", 1);
            p[31].DbType = DbType.String;
            p[32] = new SqlParameter("@IsAadharVerified", 1);
            p[32].DbType = DbType.String;
            p[33] = new SqlParameter("@IsBiometricVerified", 1);
            p[33].DbType = DbType.String;
            ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_InsertPatientRegistration", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            tbIdNumber.Text = "";
            MultiView1.SetActiveView(viewRetrieve);
            strMessage = "window.alert('Registered Successfully!');";
            ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
            cbIfAddressSame.Checked = false;
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
}

public class AbuaCardDetailsResponse
{
    public string Status { get; set; }
    public string Message { get; set; }
    public AbuaCardData Data { get; set; }
}

public class AbuaCardData
{
    public string Name { get; set; }
    public string AbuA_Id { get; set; }
    public string Family_Id { get; set; }
    public string Gender { get; set; }
    public int Year_of_Birth { get; set; }
    public int Age { get; set; }
    public string Mobile_Number { get; set; }
    public string Address { get; set; }
    public string State_Code { get; set; }
    public string State_Name { get; set; }
    public string District_Code { get; set; }
    public string District_Name { get; set; }
    public string Photo { get; set; }
    public string PinCode { get; set; }
}
