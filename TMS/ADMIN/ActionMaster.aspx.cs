using System;
using CareerPath.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Web.Helpers;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using AbuaTMS;
using System.Security.Cryptography;
using System.Web.Services.Description;

public partial class ADMIN_ActionMaster : System.Web.UI.Page
{
    private string strMessage;
    string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
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
                    GetActionDetails();
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
    protected void ClearAll()
    {
        tbActionName.Text = "";
        chkPPD.Checked = false;
        chkCEX.Checked = false;
        chkCPD.Checked = false;
        chkACO.Checked = false;
        chkSHA.Checked = false;
        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (tbActionName.Text == "")
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else if (TextboxValidation.isAlphaNumeric(tbActionName.Text) == false)
            {
                strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

            string actionName = tbActionName.Text.Trim();
            bool ppd = chkPPD.Checked;
            bool cex = chkCEX.Checked;
            bool cpd = chkCPD.Checked;
            bool aco = chkACO.Checked;
            bool sha = chkSHA.Checked;

            bool checkDuplicate = md.CheckDuplicateActionMaster(actionName);
            if (checkDuplicate)
            {
                strMessage = "window.alert('Action is Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
                return;
            }


            bool resultId = md.AddActionMaster(actionName, ppd, cex, cpd, aco, sha);

            if (resultId)
            {
                ClearAll();
                GetActionDetails();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
            else
            {
                strMessage = "window.alert('Failed to Register the Action.');";
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


    protected void btnActiveStatus_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;

            int actionId = Convert.ToInt32(btn.CommandArgument);

            bool isUpdated = md.UpdateActionStatus(actionId);

            if (isUpdated)
            {
                gridActionDetail.DataBind();
                GetActionDetails();
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

    protected void gridActionDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditAction")
        {
            try
            {
                int actionId = Convert.ToInt32(e.CommandArgument);

                DataTable actionDetails = md.GetActionDetailsById(actionId);

                if (actionDetails.Rows.Count > 0)
                {
                    tbActionName.Text = actionDetails.Rows[0]["ActionName"].ToString();
                    chkPPD.Checked = Convert.ToBoolean(actionDetails.Rows[0]["PPD"]);
                    chkCEX.Checked = Convert.ToBoolean(actionDetails.Rows[0]["CEX"]);
                    chkCPD.Checked = Convert.ToBoolean(actionDetails.Rows[0]["CPD"]);
                    chkACO.Checked = Convert.ToBoolean(actionDetails.Rows[0]["ACO"]);
                    chkSHA.Checked = Convert.ToBoolean(actionDetails.Rows[0]["SHA"]);

                    hdActionId.Value = actionId.ToString();

                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Action details not found!');", true);
                }
            }
            catch (Exception ex)
            {
                md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while fetching action details.');", true);

            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(tbActionName.Text))
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else if (!TextboxValidation.isAlphaNumeric(tbActionName.Text))
            {
                strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

            int actionId;
            if (!int.TryParse(hdActionId.Value, out actionId))
            {
                strMessage = "window.alert('Invalid Action ID!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }
            string actionName = tbActionName.Text.Trim();
            bool ppd = chkPPD.Checked;
            bool cex = chkCEX.Checked;
            bool cpd = chkCPD.Checked;
            bool aco = chkACO.Checked;
            bool sha = chkSHA.Checked;

            DataTable currentActionDetails = md.GetActionDetailsById(actionId);
            if (currentActionDetails.Rows.Count > 0)
            {
                var currentData = currentActionDetails.Rows[0];

                if (currentData["ActionName"].ToString() == actionName &&
                    Convert.ToBoolean(currentData["PPD"]) == ppd &&
                    Convert.ToBoolean(currentData["CEX"]) == cex &&
                    Convert.ToBoolean(currentData["CPD"]) == cpd &&
                    Convert.ToBoolean(currentData["ACO"]) == aco &&
                    Convert.ToBoolean(currentData["SHA"]) == sha)
                {
                    strMessage = "window.alert('Please make any changes to update the action.');";
                    ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (currentData["ActionName"].ToString() != actionName)
                {
                    bool Isduplicateentry = md.CheckActionNameDuplicacy(actionId, actionName);
                    if (Isduplicateentry)
                    {
                        strMessage = "window.alert('The ActionName you have entered already exists. Please choose a different name.!');";
                        ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
            }

            bool IsUpdated = md.UpdateActionNew(actionId, actionName, ppd, cex, cpd, aco, sha);

            if (IsUpdated)
            {
                ClearAll();
                GetActionDetails();
                strMessage = "window.alert('Updated Successfully!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);

            }
            else
            {
                strMessage = "window.alert('Failed to Update the action.');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);
            }

            
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }

    }

    protected void gridActionDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridActionDetail.PageIndex = e.NewPageIndex;

        string searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;

        GetActionDetails(searchTerm);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        GetActionDetails(searchTerm);
    }

    protected void GetActionDetails(string searchTerm = "")
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
        dt = md.GetActionDetail();


        if (!string.IsNullOrEmpty(searchTerm))
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = "ActionName LIKE '%" + searchTerm + "%'";
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
            gridActionDetail.DataSource = dt;
            gridActionDetail.DataBind();
        }
        else
        {
            lbRecordCount.Text = "Total No Records: 0";
            gridActionDetail.DataSource = null;
            gridActionDetail.DataBind();
        }
    }


}