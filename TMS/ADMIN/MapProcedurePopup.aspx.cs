using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AbuaTMS;
using CareerPath.DAL;
using Org.BouncyCastle.Crypto.General;
using System.Web.Helpers;
using System.Security.Cryptography;

public partial class ADMIN_MapProcedurePopup : System.Web.UI.Page
{
    private string strMessage;
    string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private CEX cex = new CEX();
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
                if (Session["RoleId"].ToString() == "1" && Session["RoleName"].ToString() == "ADMIN")
                {
                    getProcedureCode();
                    GetMapPopUpDetails();
                    GetRoles();
                    getPopDescription();
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
    protected void getProcedureCode()
    {
        try
        {
            dt = cex.GetProcedureCode();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddProcedureCode.Items.Clear();
                ddProcedureCode.DataValueField = "ProcedureId";
                ddProcedureCode.DataTextField = "ProcedureCode";
                ddProcedureCode.DataSource = dt;
                ddProcedureCode.DataBind();
                ddProcedureCode.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddProcedureCode.Items.Clear();
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void getPopDescription()
    {
        try
        {
            dt = md.GetPopDescription();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddPopupDescription.Items.Clear();
                ddPopupDescription.DataValueField = "PopUpId";
                ddPopupDescription.DataTextField = "PopUpDescription";
                ddPopupDescription.DataSource = dt;
                ddPopupDescription.DataBind();
                ddPopupDescription.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddPopupDescription.Items.Clear();
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void GetRoles()
    {
        try
        {
            dt.Clear();
            dt = md.GetUserRoles();
            if (dt.Rows.Count > 0)
            {
                dropRoles.Items.Clear();
                dropRoles.DataValueField = "RoleId";
                dropRoles.DataTextField = "RoleName";
                dropRoles.DataSource = dt;
                dropRoles.DataBind();
                dropRoles.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
                dropRoles.Items.Clear();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void ClearAll()
    {
        ddProcedureCode.SelectedIndex = 0;
        ddPopupDescription.SelectedIndex = 0;
        dropRoles.SelectedIndex = 0;
        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void GetMapPopUpDetails(string searchTerm = "")
    {
        if (!IsPostBack && string.IsNullOrEmpty(searchTerm))
        {
            searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;
        }
        else
        {
            ViewState["SearchTerm"] = searchTerm;
        }
        dt.Clear();
        dt = md.GetMapPopUpDetail();
        if (!string.IsNullOrEmpty(searchTerm))
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = "PopUpDescription LIKE '%" + searchTerm + "%' OR ProcedureCode LIKE '%" + searchTerm + "%' OR ProcedureName LIKE '%" + searchTerm + "%'";
            dt = dv.ToTable();

            lbRecordCount.Text = "Total No. of Record Related " + searchTerm + ": " + dt.Rows.Count.ToString();
        }
        else
        {
            lbRecordCount.Text = "Total No. of Records: " + dt.Rows.Count.ToString();
        }

        if (dt.Rows.Count > 0)
        {
            lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
            gridProcedurePopUp.DataSource = dt;
            gridProcedurePopUp.DataBind();
        }
        else
        {
            lbRecordCount.Text = "Total No Records: 0";
            gridProcedurePopUp.DataSource = null;
            gridProcedurePopUp.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddPopupDescription.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (dropRoles.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }


            int popUpId = int.Parse(ddPopupDescription.SelectedValue.Trim()); 
            int procedureId = int.Parse(ddProcedureCode.SelectedValue.Trim());
            int popUpRoleId = int.Parse(dropRoles.SelectedValue.Trim());

            bool checkDuplicate = md.CheckDuplicateMappedPopUp(popUpId, popUpRoleId, procedureId);
            if (checkDuplicate)
            {
                strMessage = "window.alert('This Procedure PopUp is Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
                return;
            }

            bool resultId = md.AddMappedPopUp(popUpId, popUpRoleId, procedureId);

            if (resultId)
            {
                ClearAll();
                GetMapPopUpDetails();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
            else
            {
                strMessage = "window.alert('Failed to Register the MApped PopUp.');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddPopupDescription.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }
            if (dropRoles.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }

            int procedurePopUpId;
            if (!int.TryParse(hdprocedurePopUpIdId.Value, out procedurePopUpId))
            {
                strMessage = "window.alert('Invalid Procedure PopUpId ID!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }

            int popUpId = int.Parse(ddPopupDescription.SelectedValue.Trim());
            int procedureId = int.Parse(ddProcedureCode.SelectedValue.Trim());
            int popUpRoleId = int.Parse(dropRoles.SelectedValue.Trim());

            DataTable currentMappedPopUpDetails = md.GetMappedPopUpDetailsById(procedurePopUpId);

            if (currentMappedPopUpDetails.Rows.Count > 0)
            {
                var currentData = currentMappedPopUpDetails.Rows[0];

                int currentpopupDescription = Convert.ToInt32(currentData["PopUpId"]);
                int currentProcedureId = Convert.ToInt32(currentData["ProcedureId"]);
                int currentroleName = Convert.ToInt32(currentData["PopUpRoleId"]);


                if (currentpopupDescription == popUpId && currentProcedureId == procedureId && currentroleName == popUpRoleId)
                {
                    strMessage = "window.alert('Please make any changes to update the Procedure PopUp.');";
                    ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                    return;
                }
                else
                {
                    bool isDuplicateEntryinProcedurePopUp = md.CheckMappedPopUpDuplicacy(popUpId, procedureId, popUpRoleId, procedurePopUpId);
                    if (isDuplicateEntryinProcedurePopUp)
                    {
                        strMessage = "window.alert('The combination you have entered already exists. Please choose a different combination!');";
                        ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
            }
            bool IsUpdated = md.UpdateMapPopUpNew(procedurePopUpId, popUpId, procedureId, popUpRoleId);

            if (IsUpdated)
            {
                ClearAll();
                GetMapPopUpDetails();
                strMessage = "window.alert('Updated Successfully!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);

            }
            else
            {
                strMessage = "window.alert('Failed to Update the Map PopUp.');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        GetMapPopUpDetails(searchTerm);
    }
    protected void btnActiveStatus_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;

            int procedurePopUpId = Convert.ToInt32(btn.CommandArgument);

            bool isUpdated = md.UpdateMApPopUpStatus(procedurePopUpId);

            if (isUpdated)
            {
                gridProcedurePopUp.DataBind();
                GetMapPopUpDetails();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void gridProcedurePopUp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridProcedurePopUp.PageIndex = e.NewPageIndex;
        string searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;

        GetMapPopUpDetails(searchTerm);
    }

    protected void gridProcedurePopUp_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditMapPopup")
        {
            try
            {
                ddProcedureCode.SelectedIndex = 0;
                ddPopupDescription.SelectedIndex = 0;
                dropRoles.SelectedIndex = 0;
                int procedurePopUpId = Convert.ToInt32(e.CommandArgument);

                DataTable ProcedurePopUpIdDetail = md.GetMappedPopUpDetailsById(procedurePopUpId);

                if (ProcedurePopUpIdDetail.Rows.Count > 0)
                {
                    string popDescription = ProcedurePopUpIdDetail.Rows[0]["PopUpId"].ToString();
                    string procedureCode = ProcedurePopUpIdDetail.Rows[0]["ProcedureId"].ToString();
                    string rolename= ProcedurePopUpIdDetail.Rows[0]["PopUpRoleId"].ToString();
                    if (ddPopupDescription.Items.FindByValue(popDescription) != null)
                    {
                        ddPopupDescription.SelectedValue = ddPopupDescription.Items.FindByValue(popDescription).Value;
                    }

                    if (ddProcedureCode.Items.FindByValue(procedureCode) != null)
                    {
                        ddProcedureCode.SelectedValue = ddProcedureCode.Items.FindByValue(procedureCode).Value;
                    }
                    if (dropRoles.Items.FindByValue(rolename) != null)
                    {
                        dropRoles.SelectedValue = dropRoles.Items.FindByValue(rolename).Value;
                    }

                    hdprocedurePopUpIdId.Value = procedurePopUpId.ToString();

                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mapped PopUp details not found!');", true);
                }
            }
            catch (Exception ex)
            {
                md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while fetching action details.');", true);

            }
        }
    }
}