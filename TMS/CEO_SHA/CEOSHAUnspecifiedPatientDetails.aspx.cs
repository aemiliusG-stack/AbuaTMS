using AbuaTMS;
using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;
using System.Configuration;

public partial class CEO_SHA_CEOSHAUnspecifiedPatientDetails : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    MasterData md = new MasterData();
    string pageName;
    CEOSHA ceosha = new CEOSHA();
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
            if (Request.QueryString["CaseNo"] != null)
            {
                string caseNo = Request.QueryString["CaseNo"].ToString();
                lbCaseNo.Text = caseNo; 
                BindPatientDetails(caseNo);
            }
        }

    }
    protected void btnSECC_Click(object sender, EventArgs e)
    {

    }
    public void BindPatientDetails(string caseNo)
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@CaseNo", caseNo);
            p[0].DbType = DbType.String;

            DataSet ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CEOSHAUnspecifiedPatientDetails", p);
            if (con.State == ConnectionState.Open)
                con.Close();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                if (dt != null)
                {
                    
                    DateTime registrationDate = Convert.ToDateTime(dt.Rows[0]["RegDate"].ToString().Trim());
                    DateTime admissionDate = Convert.ToDateTime(dt.Rows[0]["AdmissionDate"].ToString().Trim());
                    Session["AdmissionId"] = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    hfAdmissionId.Value = dt.Rows[0]["AdmissionId"].ToString().Trim();
                    Session["ClaimId"] = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hfClaimId.Value = dt.Rows[0]["ClaimId"].ToString().Trim();
                    hdAbuaId.Value = dt.Rows[0]["CardNumber"].ToString().Trim();
                    hdPatientRegId.Value = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    hdHospitalId.Value = dt.Rows[0]["HospitalId"].ToString().Trim();
                    lbName.Text = dt.Rows[0]["PatientName"].ToString().Trim();
                    lbBeneficiaryId.Text = dt.Rows[0]["CardNumber"].ToString().Trim();
                    string cardNo = dt.Rows[0]["CardNumber"].ToString();
                    Session["CardNumber"] = cardNo;
                    lbRegistrationNo.Text = dt.Rows[0]["PatientRegId"].ToString().Trim();
                    lbCaseNo.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbCaseNumber.Text = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    hfCaseNumber.Value = dt.Rows[0]["CaseNumber"].ToString().Trim();
                    lbCaseStatus.Text = dt.Rows[0]["CaseStatus"].ToString().Trim();
                    lbActualRegDate.Text = registrationDate.ToString("dd-MM-yyyy");
                    lbContact.Text = dt.Rows[0]["MobileNumber"].ToString().Trim();
                    lbHospitalAddress.Text = dt.Rows[0]["HospitalAddress"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();
                    lbGender.Text = string.IsNullOrEmpty(dt.Rows[0]["Gender"].ToString().Trim()) ? "N/A" : dt.Rows[0]["Gender"].ToString().Trim();
                    lbFamilyId.Text = dt.Rows[0]["PatientFamilyId"].ToString().Trim();
                    lbAadharVerified.Text = dt.Rows[0]["IsAadharVerified"].ToString().Trim() == "False" ? "No" : "Yes";
                    lbPatientDistrict.Text = dt.Rows[0]["District"].ToString().Trim();
                    lbAge.Text = dt.Rows[0]["Age"].ToString().Trim();
                    lbHospitalName.Text = dt.Rows[0]["HospitalName"].ToString().Trim();
                    lbHospitalType.Text = dt.Rows[0]["HospitalType"].ToString().Trim();

                    //MultiViewMain.ActiveViewIndex = 0;
                    string patientImageBase64 = Convert.ToString(dt.Rows[0]["ImageURL"].ToString());
                    string folderName = hdAbuaId.Value;
                    string imageFileName = hdAbuaId.Value + "_Profile_Image.jpeg";
                    string base64String = "";

                    base64String = ceosha.DisplayImage(folderName, imageFileName);
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
                    displayPatientAdmissionImage();
                    BindGrid_TreatmentProtocol();
                    BindAdmissionDetails();
                    BindGrid_WorkFlow();
                    BindActionType();
                    BindRejectReason();
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
    public void displayPatientAdmissionImage()
    {
        try
        {
            dt.Clear();
            dt = ceosha.GetManditoryDocument(hdAbuaId.Value.ToString());
            if (dt.Rows.Count > 0)
            {
                string DocumentId = dt.Rows[0]["DocumentId"].ToString().Trim();
                string FolderName = dt.Rows[0]["FolderName"].ToString().Trim();
                string UploadedFileName = dt.Rows[0]["UploadedFileName"].ToString().Trim() + ".jpeg";
                string base64Image = ceosha.DisplayImage(FolderName, UploadedFileName);
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

    private void BindGrid_TreatmentProtocol()
    {
        dt = ceosha.GetTreatmentProtocol(hfCaseNumber.Value);

        gvTreatmentProtocol.DataSource = dt;
        gvTreatmentProtocol.DataBind();
        if (dt == null || dt.Rows.Count == 0)
        {
            gvTreatmentProtocol.EmptyDataText = "No Treatment Protocol found.";
            gvTreatmentProtocol.DataBind();
        }
    }
    private void BindAdmissionDetails()
    {
        DataTable dt = ceosha.GetAdmissionDetails(hfCaseNumber.Value);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];

            lbAdmissionDate.Text = Convert.ToDateTime(row["AdmissionDate"]).ToString("dd/MM/yyyy");
            lbPackageCost.Text = Convert.ToDecimal(row["PackageCost"]).ToString("C");
            lbHospitalIncentive.Text = "110%";
            lbIncentiveAmount.Text = Convert.ToDecimal(row["IncentiveAmount"]).ToString("C");
            lbTotalPackageCost.Text = Convert.ToDecimal(row["TotalPackageCost"]).ToString("C");
            bool isPlanned = row["AdmissionType"] != DBNull.Value && Convert.ToInt32(row["AdmissionType"]) == 0;
            rbAdmissionTypePlanned.Checked = isPlanned;
            rbAdmissionTypeEmergency.Checked = !isPlanned;

            PanelTotLiableInsurance.Visible = false;
            PanelTotLiableTrust.Visible = false;

            if (row["ClaimMode"] != DBNull.Value)
            {
                string claimMode = row["ClaimMode"].ToString();

                if (claimMode == "1") 
                {
                    PanelTotLiableInsurance.Visible = true;
                    PanelTotLiableInsuranceIs.Visible = true;
                    lbTotalLiableAmountByInsurer.Text = Convert.ToDecimal(row["InsurerClaimAmountRequested"]).ToString("C");
                }
                else if (claimMode == "2") 
                {
                    PanelTotLiableTrust.Visible = true;
                    PanelTotLiableTrustIs.Visible = true;
                    lbTotalLiableAmountByTrust.Text = Convert.ToDecimal(row["TrustClaimAmountRequested"]).ToString("C");
                }
                else if (claimMode == "3") 
                {
                    PanelTotLiableInsurance.Visible = true;
                    PanelTotLiableInsuranceIs.Visible = true;
                    PanelTotLiableTrust.Visible = true;
                    PanelTotLiableTrustIs.Visible = true;
                    lbTotalLiableAmountByInsurer.Text = Convert.ToDecimal(row["InsurerClaimAmountRequested"]).ToString("C");
                    lbTotalLiableAmountByTrust.Text = Convert.ToDecimal(row["TrustClaimAmountRequested"]).ToString("C");
                }
            }
        }
        else
        {
            lbAdmissionDate.Text = "No data found";
        }
    }
    private void BindGrid_WorkFlow()
    {
        dt.Clear();
        dt = ceosha.GetClaimWorkFlow(Convert.ToInt32(hfClaimId.Value));
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
    private void BindActionType()
    {
        try
        {
            DataTable dt = ceosha.GetActionType();
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
        else if (ddlActionType.SelectedValue == "13")
        {
            pReason.Visible = true;
            pSubReason.Visible = true;
            pRemarks.Visible = true;
            pTriggerType.Visible = false;
            BindQueryReason();

        }
        else if (ddlActionType.SelectedValue == "15")
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
    private void BindRejectReason()
    {
        try
        {
            DataTable dt = ceosha.GetRejectReason();
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
            DataTable dt = ceosha.GetQueryReason();
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
                dt = ceosha.GetQuerySubReason(ReasonId.ToString());

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
    
   

}