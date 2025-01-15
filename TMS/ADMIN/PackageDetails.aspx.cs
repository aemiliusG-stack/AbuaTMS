using AbuaTMS;
using Org.BouncyCastle.Pqc.Crypto.Lms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class ADMIN_PackageDetails : System.Web.UI.Page
{
    private string strMessage, pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();
    CPD cpd = new CPD();

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
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                GetPackageDetailsMasterData();
                getSpecialityName();
                getClubbingRemarks();
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
    protected void getSpecialityName()
    {
        try
        {
            dt = cpd.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddSpecialityName.Items.Clear();
                ddSpecialityName.DataValueField = "PackageId";
                ddSpecialityName.DataTextField = "SpecialityName";
                ddSpecialityName.DataSource = dt;
                ddSpecialityName.DataBind();
                ddSpecialityName.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddSpecialityName.Items.Clear();
                ddSpecialityName.Items.Insert(0, new ListItem("--No Speciality Name Available--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void getClubbingRemarks()
    {
        try
        {
            dt = md.GetClubbingRemarks();

            ddClubbingRemarks.Items.Clear();

            if (dt != null && dt.Rows.Count > 0)
            {
                ddClubbingRemarks.DataValueField = "ClubbingId";
                ddClubbingRemarks.DataTextField = "ClubbingRemarks";
                ddClubbingRemarks.DataSource = dt;
                ddClubbingRemarks.DataBind();
                ddClubbingRemarks.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddClubbingRemarks.Items.Insert(0, new ListItem("--No Remarks Found--", "0"));
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    public void GetPackageDetailsMasterData(string searchTerm = "")
    {
        try
        {
            dt.Clear();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                dt = md.GetPackageDetailsSerachData(searchTerm);
            }
            else
            {
                dt = md.GetPackageDetailsMasterData();
            }
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridMasterPackage.DataSource = dt;
                gridMasterPackage.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridMasterPackage.DataSource = null;
                gridMasterPackage.DataBind();
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
    protected void gridMasterPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridMasterPackage.PageIndex = e.NewPageIndex;
        string searchTerm = txtSearch.Text.Trim();
        GetPackageDetailsMasterData(searchTerm);
    }

    protected void gridPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridMasterPackage.PageIndex = e.NewPageIndex;
        GetPackageDetailsMasterData();
    }
    protected void gridPackage_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            bool? isActive = DataBinder.Eval(e.Row.DataItem, "IsActive") as bool?;
            Button btnStatus = (Button)e.Row.FindControl("btnStatus");

            if (btnStatus != null)
            {
                if (!isActive.HasValue || !isActive.Value)
                {
                    btnStatus.Text = "Inactive";
                    btnStatus.CssClass = "btn btn-warning btn-sm rounded-pill";
                }
                else
                {
                    btnStatus.Text = "Active";
                    btnStatus.CssClass = "btn btn-success btn-sm rounded-pill";
                }
            }
        }
    }
    protected void btnAddProcedure_Click(object sender, EventArgs e)
    {
        try
        {
            string PackageId = ddSpecialityName.SelectedValue;
            string ProcedureCode = tbProcedureCode.Text;
            string ProcedureName = tbProcedureName.Text;
            string ProcedureAmount = tbProcedureAmount.Text;
            int IsMultipleProcedure = ddIsMultipleProcedure.Text.ToLower() == "yes" ? 1 : 0;
            int IsLevelApplied = ddIsLevelApplied.Text.ToLower() == "yes" ? 1 : 0;
            int IsAutoApproved = ddIsAutoApproved.Text.ToLower() == "yes" ? 1 : 0;
            int IsStratificationRequired = ddIsStratificationRequired.Text.ToLower() == "yes" ? 1 : 0;
            int IsImplantRequired = ddIsImplantRequired.Text.ToLower() == "yes" ? 1 : 0;
            int IsSpecialCondition = ddIsSpecialCondition.Text.ToLower() == "yes" ? 1 : 0;
            int IsEnhancementApplicable = ddIsEnhancementApplicable.Text.ToLower() == "yes" ? 1 : 0;
            int IsMedicalSurgical = ddIsMedicalSurgical.Text.ToLower() == "yes" ? 1 : 0;
            int IsDayCare = ddIsDayCare.Text.ToLower() == "yes" ? 1 : 0;
            int IsCycleBased = ddIsCycleBased.Text.ToLower() == "yes" ? 1 : 0;
            int IsSittingProcedure = ddIsSittingProcedure.Text.ToLower() == "yes" ? 1 : 0;
            string ProcedureType = tbProcedureType.Text;
            string Reservance = tbReservance.Text;
            string MaxStratification = tbMaxStratification.Text;
            string MaxImplant = tbMaxImplant.Text;
            int ReservationPublicHospital = ddReservationPublicHospital.Text.ToLower() == "yes" ? 1 : 0;
            int ReservationTertiaryHospital = ddReservationTertiaryHospital.Text.ToLower() == "yes" ? 1 : 0;
            string LevelOfCare = tbLevelOfCare.Text;
            string LOS = tbLOS.Text;
            string PreInvestigation = tbPreInvestigation.Text;
            string PostInvestigation = tbPostInvestigation.Text;
            string ProcedureLabel = tbProcedureLabel.Text;
            int SpecialConditionPopUp = ddSpecialConditionPopUp.Text.ToLower() == "yes" ? 1 : 0;
            int SpecialConditionRule = ddSpecialConditionRule.Text.ToLower() == "yes" ? 1 : 0;
            string ClubbingId = ddClubbingRemarks.SelectedValue;
            string ClubbingRemarks = string.Empty;
            string NoOfCycle = tbNoOfCycle.Text;
            string CycleBasedRemarks = tbCycleBasedRemarks.Text;
            string SittingNoOfDays = tbSittingNoOfDays.Text;
            string SittingProcedureRemarks = tbSittingProcedureRemarks.Text;
            if (ddClubbingRemarks.Items.FindByValue(ClubbingId) != null)
            {
                ClubbingRemarks = ddClubbingRemarks.SelectedItem.Text;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "window.alert('Invalid Clubbing Remarks selected.');", true);
                return;
            }
            if (md.CheckPackageDetailsExists(PackageId, ProcedureCode))
            {
                strMessage = "window.alert('This package and procedure combination already exists.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "DuplicateAlert", strMessage, true);
                return; 
            }
            if (!PackageId.Equals("") && !ProcedureCode.Equals("") && !ProcedureName.Equals("") && !ProcedureAmount.Equals("") && !ProcedureType.Equals("") && !Reservance.Equals("") && !MaxStratification.Equals("") && !MaxImplant.Equals("") && !ProcedureCode.Equals("") && !LevelOfCare.Equals("") && !LOS.Equals("") && !PreInvestigation.Equals("") && !PostInvestigation.Equals("") && !ProcedureLabel.Equals("") && !ClubbingId.Equals("") && !ClubbingRemarks.Equals("") && !NoOfCycle.Equals("") && !CycleBasedRemarks.Equals("") && !SittingNoOfDays.Equals("") && !SittingProcedureRemarks.Equals(""))
            {
                md.InsertPackageDetailsMaster(PackageId, ProcedureCode, ProcedureName, ProcedureAmount, IsMultipleProcedure.ToString(), IsLevelApplied.ToString(), IsAutoApproved.ToString(), ProcedureType, Reservance, IsStratificationRequired.ToString(), MaxStratification, IsImplantRequired.ToString(), MaxImplant, IsSpecialCondition.ToString(), ReservationPublicHospital.ToString(), ReservationTertiaryHospital.ToString(), LevelOfCare, LOS, PreInvestigation, PostInvestigation, ProcedureLabel, SpecialConditionPopUp.ToString(), SpecialConditionRule.ToString(), IsEnhancementApplicable.ToString(), IsMedicalSurgical.ToString(),
                  IsDayCare.ToString(), ClubbingId, ClubbingRemarks, IsCycleBased.ToString(), NoOfCycle, CycleBasedRemarks, IsSittingProcedure.ToString(), SittingNoOfDays, SittingProcedureRemarks);
                strMessage = "window.alert('Procedure Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                ResetFields();
                GetPackageDetailsMasterData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "window.alert('Please fill all required fields.');", true);
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
    private void ResetFields()
    {
        tbProcedureCode.Text = "";
        tbProcedureName.Text = "";
        tbProcedureAmount.Text = "";
        ddIsMultipleProcedure.SelectedIndex = 0;
        ddIsLevelApplied.SelectedIndex = 0;
        ddIsAutoApproved.SelectedIndex = 0;
        tbProcedureType.Text = "";
        tbReservance.Text = "";
        ddIsStratificationRequired.SelectedIndex = 0;
        tbMaxStratification.Text = "";
        ddIsImplantRequired.SelectedIndex = 0;
        tbMaxImplant.Text = "";
        ddIsSpecialCondition.Text = "";
        ddReservationPublicHospital.SelectedIndex = 0;
        ddReservationTertiaryHospital.SelectedIndex = 0;
        tbLevelOfCare.Text = "";
        tbLOS.Text = "";
        tbPreInvestigation.Text = "";
        tbPostInvestigation.Text = "";
        tbProcedureLabel.Text = "";
        ddSpecialConditionPopUp.SelectedIndex = 0;
        ddSpecialConditionRule.SelectedIndex = 0;
        ddIsEnhancementApplicable.SelectedIndex = 0;
        ddIsMedicalSurgical.SelectedIndex = 0;
        ddIsDayCare.SelectedIndex = 0;
        ddClubbingRemarks.SelectedIndex = 0;
        ddIsCycleBased.SelectedIndex = 0;
        tbNoOfCycle.Text = "";
        tbCycleBasedRemarks.Text = "";
        ddIsSittingProcedure.SelectedIndex = 0;
        tbSittingNoOfDays.Text = "";
        tbSittingProcedureRemarks.Text = "";
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedureId.Value != null)
            {
                string PackageId = ddSpecialityName.SelectedValue;
                string ProcedureCode = tbProcedureCode.Text;
                string ProcedureName = tbProcedureName.Text;
                string ProcedureAmount = tbProcedureAmount.Text;
                string IsMultipleProcedure = ddIsMultipleProcedure.Text.ToLower() == "yes" ? "1" : "0";
                string IsLevelApplied = ddIsLevelApplied.Text.ToLower() == "yes" ? "1" : "0";
                string IsAutoApproved = ddIsAutoApproved.Text.ToLower() == "yes" ? "1" : "0";
                string IsStratificationRequired = ddIsStratificationRequired.Text.ToLower() == "yes" ? "1" : "0";
                string IsImplantRequired = ddIsImplantRequired.Text.ToLower() == "yes" ? "1" : "0";
                string IsSpecialCondition = ddIsSpecialCondition.Text.ToLower() == "yes" ? "1" : "0";
                string IsEnhancementApplicable = ddIsEnhancementApplicable.Text.ToLower() == "yes" ? "1" : "0";
                string IsMedicalSurgical = ddIsMedicalSurgical.Text.ToLower() == "yes" ? "1" : "0";
                string IsDayCare = ddIsDayCare.Text.ToLower() == "yes" ? "1" : "0";
                string IsCycleBased = ddIsCycleBased.Text.ToLower() == "yes" ? "1" : "0";
                string IsSittingProcedure = ddIsSittingProcedure.Text.ToLower() == "yes" ? "1" : "0";
                string ProcedureType = tbProcedureType.Text;
                string Reservance = tbReservance.Text;
                string MaxStratification = tbMaxStratification.Text;
                string MaxImplant = tbMaxImplant.Text;
                string ReservationPublicHospital = ddReservationPublicHospital.Text.ToLower() == "yes" ? "1" : "0";
                string ReservationTertiaryHospital = ddReservationPublicHospital.Text.ToLower() == "yes" ? "1" : "0";
                string LevelOfCare = tbLevelOfCare.Text;
                string LOS = tbLOS.Text;
                string PreInvestigation = tbPreInvestigation.Text;
                string PostInvestigation = tbPostInvestigation.Text;
                string ProcedureLabel = tbProcedureLabel.Text;
                string SpecialConditionPopUp = ddSpecialConditionPopUp.Text.ToLower() == "yes" ? "1" : "0";
                string SpecialConditionRule = ddSpecialConditionRule.Text.ToLower() == "yes" ? "1" : "0";
                string ClubbingId = ddClubbingRemarks.SelectedValue;
                string ClubbingRemarks = string.Empty;
                string NoOfCycle = tbNoOfCycle.Text;
                string CycleBasedRemarks = tbCycleBasedRemarks.Text;
                string SittingNoOfDays = tbSittingNoOfDays.Text;
                string SittingProcedureRemarks = tbSittingProcedureRemarks.Text;
                if (ddClubbingRemarks.Items.FindByValue(ClubbingId) != null)
                {
                    ClubbingRemarks = ddClubbingRemarks.SelectedItem.Text;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "window.alert('Invalid Clubbing Remarks selected.');", true);
                    return;
                }
                if (!md.CheckPackageDetailsExists(PackageId, ProcedureCode))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "DuplicateAlert", "window.alert('Duplicate entry found for the given Speciality Name and Procedure Code.');", true);
                    return;
                }
                if (!PackageId.Equals("") && !ProcedureCode.Equals("") && !ProcedureName.Equals("") && !ProcedureAmount.Equals("") && !IsMultipleProcedure.Equals("") && !IsLevelApplied.Equals("") && !IsAutoApproved.Equals("") && !ProcedureType.Equals("") && !Reservance.Equals("") && !IsStratificationRequired.Equals("") && !MaxStratification.Equals("") && !IsImplantRequired.Equals("") && !MaxImplant.Equals("") && !IsSpecialCondition.Equals("") && !ReservationPublicHospital.Equals("") && !ReservationTertiaryHospital.Equals("") && !LevelOfCare.Equals("") && !LOS.Equals("") && !PreInvestigation.Equals("") && !PostInvestigation.Equals("") && !ProcedureLabel.Equals("") && !SpecialConditionPopUp.Equals("") && !SpecialConditionRule.Equals("") && !IsEnhancementApplicable.Equals("") && !IsMedicalSurgical.Equals("") && !IsDayCare.Equals("") && !ClubbingId.Equals("") && !ClubbingRemarks.Equals("") && !IsCycleBased.Equals("") && !NoOfCycle.Equals("") && !CycleBasedRemarks.Equals("") && !IsSittingProcedure.Equals("") && !SittingNoOfDays.Equals("") && !SittingProcedureRemarks.Equals(""))
                {
                    md.UpdatePackageDetailsMaster(hdProcedureId.Value, PackageId, ProcedureCode, ProcedureName, ProcedureAmount, IsMultipleProcedure, IsLevelApplied, IsAutoApproved, ProcedureType, Reservance, IsStratificationRequired, MaxStratification, IsImplantRequired, MaxImplant, IsSpecialCondition, ReservationPublicHospital, ReservationTertiaryHospital, LevelOfCare, LOS, PreInvestigation, PostInvestigation, ProcedureLabel, SpecialConditionPopUp, SpecialConditionRule, IsEnhancementApplicable, IsMedicalSurgical, IsDayCare, ClubbingId, ClubbingRemarks, IsCycleBased, NoOfCycle, CycleBasedRemarks, IsSittingProcedure, SittingNoOfDays, SittingProcedureRemarks);
                    ResetFields();
                    strMessage = "window.alert('Procedure Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    btnUpdate.Visible = false;
                    GetPackageDetailsMasterData();
                    btnAddProcedure.Visible = true;
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

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        // Ensure the sender is a Button and cast it accordingly
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;

        // Find and retrieve values from labels
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbPackageId = (Label)row.FindControl("lbPackageId");
        Label lbProcedureCode = (Label)row.FindControl("lbProcedureCode");
        Label lbProcedureName = (Label)row.FindControl("lbProcedureName");
        Label lbProcedureAmount = (Label)row.FindControl("lbProcedureAmount");
        Label lbIsMultipleProcedure = (Label)row.FindControl("lbIsMultipleProcedure");
        Label lbIsLevelApplied = (Label)row.FindControl("lbIsLevelApplied");
        Label lbIsAutoApproved = (Label)row.FindControl("lbIsAutoApproved");
        Label lbProcedureType = (Label)row.FindControl("lbProcedureType");
        Label lbReservance = (Label)row.FindControl("lbReservance");
        Label lbIsStratificationRequired = (Label)row.FindControl("lbIsStratificationRequired");
        Label lbMaxStratification = (Label)row.FindControl("lbMaxStratification");
        Label lbIsImplantRequired = (Label)row.FindControl("lbIsImplantRequired");
        Label lbMaxImplant = (Label)row.FindControl("lbMaxImplant");
        Label lbIIsSpecialCondition = (Label)row.FindControl("lbIIsSpecialCondition");
        Label lbReservationPublicHospital = (Label)row.FindControl("lbReservationPublicHospital");
        Label lbReservationTertiaryHospital = (Label)row.FindControl("lbReservationTertiaryHospital");
        Label lbLevelOfCare = (Label)row.FindControl("lbLevelOfCare");
        Label lbLOS = (Label)row.FindControl("lbLOS");
        Label lbPreInvestigation = (Label)row.FindControl("lbPreInvestigation");
        Label lbPostInvestigation = (Label)row.FindControl("lbPostInvestigation");
        Label lbProcedureLabel = (Label)row.FindControl("lbProcedureLabel");
        Label lbSpecialConditionPopUp = (Label)row.FindControl("lbSpecialConditionPopUp");
        Label lbSpecialConditionRule = (Label)row.FindControl("lbSpecialConditionRule");
        Label lbIsEnhancementApplicable = (Label)row.FindControl("lbIsEnhancementApplicable");
        Label lbIsMedicalSurgical = (Label)row.FindControl("lbIsMedicalSurgical");
        Label lbIsDayCare = (Label)row.FindControl("lbIsDayCare");
        Label lbClubbingId = (Label)row.FindControl("lbClubbingId");
        Label lbIsCycleBased = (Label)row.FindControl("lbIsCycleBased");
        Label lbNoOfCycle = (Label)row.FindControl("lbNoOfCycle");
        Label lbCycleBasedRemarks = (Label)row.FindControl("lbCycleBasedRemarks");
        Label lbIsSittingProcedure = (Label)row.FindControl("lbIsSittingProcedure");
        Label lbSittingNoOfDays = (Label)row.FindControl("lbSittingNoOfDays");
        Label lbSittingProcedureRemarks = (Label)row.FindControl("lbSittingProcedureRemarks");

        // Assign values to form fields (make sure to trim the strings for safety)
        hdProcedureId.Value = lbProcedureId.Text;
        ddSpecialityName.SelectedValue = lbPackageId.Text;
        tbProcedureCode.Text = lbProcedureCode.Text;
        tbProcedureName.Text = lbProcedureName.Text;
        tbProcedureAmount.Text = lbProcedureAmount.Text;
        ddIsMultipleProcedure.SelectedValue = lbIsMultipleProcedure.Text == "True" ? "Yes" : "No";
        ddIsLevelApplied.SelectedValue = lbIsLevelApplied.Text == "True" ? "Yes" : "No";
        ddIsAutoApproved.SelectedValue = lbIsAutoApproved.Text == "True" ? "Yes" : "No";
        tbProcedureType.Text = lbProcedureType.Text;
        tbReservance.Text = lbReservance.Text;
        ddIsStratificationRequired.SelectedValue = lbIsStratificationRequired.Text == "True" ? "Yes" : "No";
        tbMaxStratification.Text = lbMaxStratification.Text;
        ddIsImplantRequired.SelectedValue = lbIsImplantRequired.Text == "True" ? "Yes" : "No";
        tbMaxImplant.Text = lbMaxImplant.Text;
        ddIsSpecialCondition.Text = lbIIsSpecialCondition.Text == "True" ? "Yes" : "No";
        ddReservationPublicHospital.SelectedValue = lbReservationPublicHospital.Text == "True" ? "Yes" : "No";
        ddReservationTertiaryHospital.SelectedValue = lbReservationTertiaryHospital.Text == "True" ? "Yes" : "No";
        tbLevelOfCare.Text = lbLevelOfCare.Text;
        tbLOS.Text = lbLOS.Text;
        tbPreInvestigation.Text = lbPreInvestigation.Text;
        tbPostInvestigation.Text = lbPostInvestigation.Text;
        tbProcedureLabel.Text = lbProcedureLabel.Text;
        ddSpecialConditionPopUp.SelectedValue = lbSpecialConditionPopUp.Text == "True" ? "Yes" : "No";
        ddSpecialConditionRule.SelectedValue = lbSpecialConditionRule.Text == "True" ? "Yes" : "No";
        ddIsEnhancementApplicable.SelectedValue = lbIsEnhancementApplicable.Text == "True" ? "Yes" : "No";
        ddIsMedicalSurgical.SelectedValue = lbIsMedicalSurgical.Text == "True" ? "Yes" : "No";
        ddIsDayCare.SelectedValue = lbIsDayCare.Text == "True" ? "Yes" : "No";
        ddClubbingRemarks.SelectedValue = lbClubbingId.Text;
        ddIsCycleBased.SelectedValue = lbIsCycleBased.Text == "True" ? "Yes" : "No";
        tbNoOfCycle.Text = lbNoOfCycle.Text;
        tbCycleBasedRemarks.Text = lbCycleBasedRemarks.Text;
        ddIsSittingProcedure.SelectedValue = lbIsSittingProcedure.Text == "True" ? "Yes" : "No";
        tbSittingNoOfDays.Text = lbSittingNoOfDays.Text;
        tbSittingProcedureRemarks.Text = lbSittingProcedureRemarks.Text;

        // Show update button and hide add button
        btnUpdate.Visible = true;
        btnAddProcedure.Visible = false;
    }

    protected void btnStatus_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        string ProcedureId = lbProcedureId.Text;
        bool isActive = btn.Text == "Active";

        // Toggle status
        md.StatusMasterPackage(ProcedureId, !isActive);

        strMessage = "window.alert('Procedure Status Updated Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetPackageDetailsMasterData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        GetPackageDetailsMasterData(searchTerm);
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddSpecialityName.SelectedIndex = 0;
        tbProcedureCode.Text = "";
        tbProcedureName.Text = "";
        tbProcedureAmount.Text = "";
        ddIsMultipleProcedure.SelectedIndex = 0;
        ddIsLevelApplied.SelectedIndex = 0;
        ddIsAutoApproved.SelectedIndex = 0;
        tbProcedureType.Text = "";
        tbReservance.Text = "";
        ddIsStratificationRequired.SelectedIndex = 0;
        tbMaxStratification.Text = "";
        ddIsImplantRequired.SelectedIndex = 0;
        ddIsSpecialCondition.SelectedIndex = 0;
        tbMaxImplant.Text = "";
        ddIsSpecialCondition.Text = "";
        ddReservationPublicHospital.SelectedIndex = 0;
        ddReservationTertiaryHospital.SelectedIndex = 0;
        tbLevelOfCare.Text = "";
        tbLOS.Text = "";
        tbPreInvestigation.Text = "";
        tbPostInvestigation.Text = "";
        tbProcedureLabel.Text = "";
        ddSpecialConditionPopUp.SelectedIndex = 0;
        ddSpecialConditionRule.SelectedIndex = 0;
        ddIsEnhancementApplicable.SelectedIndex = 0;
        ddIsMedicalSurgical.SelectedIndex = 0;
        ddIsDayCare.SelectedIndex = 0;
        ddClubbingRemarks.SelectedIndex = 0;
        ddIsCycleBased.SelectedIndex = 0;
        tbNoOfCycle.Text = "";
        tbCycleBasedRemarks.Text = "";
        ddIsSittingProcedure.SelectedIndex = 0;
        tbSittingNoOfDays.Text = "";
        tbSittingProcedureRemarks.Text = "";
        hdProcedureId.Value = null;
        btnUpdate.Visible = false;
        btnAddProcedure.Visible = true;

    }

}
