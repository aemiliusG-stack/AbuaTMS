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

public partial class ADMIN_MapProcedureFollowup : System.Web.UI.Page
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
                    getProcedureFollowUpCode();
                    GetMapProcedureFollowUpDetails();
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
    protected void getProcedureFollowUpCode()
    {
        try
        {
            dt = cex.GetProcedureCode();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddProcedureFollowUpCode.Items.Clear();
                ddProcedureFollowUpCode.DataValueField = "ProcedureId";
                ddProcedureFollowUpCode.DataTextField = "ProcedureCode";
                ddProcedureFollowUpCode.DataSource = dt;
                ddProcedureFollowUpCode.DataBind();
                ddProcedureFollowUpCode.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddProcedureFollowUpCode.Items.Clear();
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void GetMapProcedureFollowUpDetails(string searchTerm = "")
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
        dt = md.GetProceduireFollowUpDetail();
        if (!string.IsNullOrEmpty(searchTerm))
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = "ProcedureCode LIKE '%" + searchTerm + "%'";
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
            gridProcedureFollowUp.DataSource = dt;
            gridProcedureFollowUp.DataBind();
        }
        else
        {
            lbRecordCount.Text = "Total No Records: 0";
            gridProcedureFollowUp.DataSource = null;
            gridProcedureFollowUp.DataBind();
        }
    }

    protected void ClearAll()
    {
        ddProcedureFollowUpCode.SelectedIndex = 0;
        ddProcedureCode.SelectedIndex = 0;
        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddProcedureFollowUpCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

            string followUpId = ddProcedureFollowUpCode.SelectedValue;
            string procedureId = ddProcedureCode.SelectedValue;

            bool checkDuplicate = md.CheckDuplicateFollowup(procedureId, followUpId);
            if (checkDuplicate)
            {
                strMessage = "window.alert('This FollowUp is Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
                return;
            }

            bool resultId = md.AddMapFollowUp(procedureId, followUpId);

            if (resultId)
            {
                ClearAll();
                GetMapProcedureFollowUpDetails();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
            else
            {
                strMessage = "window.alert('Failed to Register the FollowUp.');";
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
            if (ddProcedureFollowUpCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

            int ProcedureFollowId;
            if (!int.TryParse(hdProcedureFolUpId.Value, out ProcedureFollowId))
            {
                strMessage = "window.alert('Invalid FollowUp ID!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }

            int followUpId = int.Parse(ddProcedureFollowUpCode.SelectedValue.Trim()); 
            int procedureId = int.Parse(ddProcedureCode.SelectedValue.Trim());

            DataTable currentFollowupDetails = md.GetFollowDetailsById(ProcedureFollowId);

            if (currentFollowupDetails.Rows.Count > 0)
            {
                var currentData = currentFollowupDetails.Rows[0];

                int currentfollowUpId = Convert.ToInt32(currentData["FollowUpId"]);
                int currentProcedureId = Convert.ToInt32(currentData["ProcedureId"]);

                if (currentfollowUpId == followUpId && currentProcedureId == procedureId)
                {
                    strMessage = "window.alert('Please make any changes to update the action.');";
                    ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                    return;
                }
                else
                {
                    bool isDuplicateEntryinAddon = md.CheckFollowUpDuplicacy(ProcedureFollowId, followUpId, procedureId);
                    if (isDuplicateEntryinAddon)
                    {
                        strMessage = "window.alert('The combination you have entered already exists. Please choose a different combination!');";
                        ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
            }
            bool IsUpdated = md.UpdateProcedureFollowUpNew(ProcedureFollowId, followUpId, procedureId);

            if (IsUpdated)
            {
                ClearAll();
                GetMapProcedureFollowUpDetails();
                strMessage = "window.alert('Updated Successfully!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);

            }
            else
            {
                strMessage = "window.alert('Failed to Update the FollowUp.');";
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
        GetMapProcedureFollowUpDetails(searchTerm);
    }

    protected void gridProcedureFollowUp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridProcedureFollowUp.PageIndex = e.NewPageIndex;
        string searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;

        GetMapProcedureFollowUpDetails(searchTerm);
    }

    protected void gridProcedureFollowUp_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditFollowUp")
        {
            try
            {
                ddProcedureFollowUpCode.SelectedIndex = 0;
                ddProcedureCode.SelectedIndex = 0;
                int procedureFollowId = Convert.ToInt32(e.CommandArgument);

                DataTable ProcedureFollowUpDetail = md.GetFollowDetailsById(procedureFollowId);

                if (ProcedureFollowUpDetail.Rows.Count > 0)
                {
                    string followUpCode = ProcedureFollowUpDetail.Rows[0]["ProcedureFollowUpCode"].ToString();
                    string procedureCode = ProcedureFollowUpDetail.Rows[0]["ProcedureCode"].ToString();
                    if (ddProcedureFollowUpCode.Items.FindByText(followUpCode) != null)
                    {
                        ddProcedureFollowUpCode.SelectedValue = ddProcedureFollowUpCode.Items.FindByText(followUpCode).Value;
                    }

                    if (ddProcedureCode.Items.FindByText(procedureCode) != null)
                    {
                        ddProcedureCode.SelectedValue = ddProcedureCode.Items.FindByText(procedureCode).Value;
                    }

                    hdProcedureFolUpId.Value = procedureFollowId.ToString();

                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('AddOn details not found!');", true);
                }
            }
            catch (Exception ex)
            {
                md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while fetching action details.');", true);

            }
        }
    }
    protected void btnActiveStatus_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;

            int procedureFollowId = Convert.ToInt32(btn.CommandArgument);

            bool isUpdated = md.UpdateMapProcedureFollowUpStatus(procedureFollowId);

            if (isUpdated)
            {
                gridProcedureFollowUp.DataBind();
                GetMapProcedureFollowUpDetails();
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
}