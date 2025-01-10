using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Org.BouncyCastle.Crypto.General;
using CareerPath.DAL;
using System.Web.Helpers;
using AbuaTMS;
using System.Security.Cryptography;

public partial class ADMIN_StratificationMaster : System.Web.UI.Page
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
                    GetStratDetails();
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
    protected void GetStratDetails(string searchTerm = "")
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
        dt = md.GetStratDetail();

        if (!string.IsNullOrEmpty(searchTerm))
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = "StratificationName LIKE '%" + searchTerm + "%' OR StratificationCode LIKE '%" + searchTerm + "%' OR StratificationDetail LIKE '%" + searchTerm + "%'";
            dt = dv.ToTable();

            lbRecordCount.Text = "Total No. of Record Related " + searchTerm + ": " + dt.Rows.Count.ToString();
        }
        else
        {
            lbRecordCount.Text = "Total No. of Records: " + dt.Rows.Count.ToString();
        }

        if (dt.Rows.Count > 0)
        {
            gridStratification.DataSource = dt;
            gridStratification.DataBind();
        }
        else
        {
            gridStratification.DataSource = null;
            gridStratification.DataBind();
        }
    }
    protected void ClearAll()
    {
        tbStratCode.Text = "";
        tbStratName.Text = "";
        tbStratAmount.Text = "";
        tbStratDetail.Text = "";
        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void gridStratification_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridStratification.PageIndex = e.NewPageIndex;
        string searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;

        GetStratDetails(searchTerm);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(tbStratCode.Text) || string.IsNullOrWhiteSpace(tbStratName.Text) || string.IsNullOrWhiteSpace(tbStratAmount.Text) || string.IsNullOrWhiteSpace(tbStratDetail.Text))
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else if (!TextboxValidation.isAlphaNumeric(tbStratCode.Text) || !TextboxValidation.isAlphaNumeric(tbStratName.Text))
            {
                strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            string stratCode = tbStratCode.Text.Trim();
            string stratName = tbStratName.Text.Trim();
            string stratDetails = tbStratDetail.Text.Trim();
            string stratAmount = tbStratAmount.Text.Trim();

            bool checkDuplicate = md.CheckDuplicateStratMaster(stratCode);
            if (checkDuplicate)
            {
                strMessage = "window.alert('This Stratification is Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
                return;
            }
            bool resultId = md.AddStratMaster(stratCode, stratName, stratDetails, stratAmount);

            if (resultId)
            {
                ClearAll();
                GetStratDetails();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
            else
            {
                strMessage = "window.alert('Failed to Register the Stratification.');";
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
            if (string.IsNullOrWhiteSpace(tbStratCode.Text) || string.IsNullOrWhiteSpace(tbStratName.Text) || string.IsNullOrWhiteSpace(tbStratAmount.Text) || string.IsNullOrWhiteSpace(tbStratDetail.Text))
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            else if (!TextboxValidation.isAlphaNumeric(tbStratCode.Text) || !TextboxValidation.isAlphaNumeric(tbStratName.Text))
            {
                strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }

            string stratCode = tbStratCode.Text.Trim();
            string stratName = tbStratName.Text.Trim();
            string stratDetails = tbStratDetail.Text.Trim();
            string stratAmount = tbStratAmount.Text.Trim();


            long stratificationId;

            if (!long.TryParse(hdStratId.Value.Trim(), out stratificationId))
            {
                strMessage = "window.alert('Invalid Stratification ID!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            } 



            DataTable CurrentStratDetails = md.GetStratDetailsById(stratificationId);
            if (CurrentStratDetails.Rows.Count > 0)
            {
                var currentData = CurrentStratDetails.Rows[0];

                if (currentData["StratificationCode"].ToString() == stratCode &&
                    currentData["StratificationName"].ToString() == stratName &&
                    currentData["StratificationDetail"].ToString() == stratDetails &&
                    currentData["StratificationAmount"].ToString() == stratAmount)
                {
                    strMessage = "window.alert('Please make any changes to update the Stratification.');";
                    ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                    return;
                }
                else if (currentData["StratificationCode"].ToString() != stratCode)
                {
                    bool Isduplicateentry = md.CheckStratCodeDuplicacy(stratificationId, stratCode);
                    if (Isduplicateentry)
                    {
                        strMessage = "window.alert('The Stratification Code you have entered already exist!');";
                        ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
            }

            bool IsUpdated = md.UpdateStratNew(stratificationId, stratCode, stratName, stratDetails, stratAmount);

            if (IsUpdated)
            {
                ClearAll();
                GetStratDetails();
                strMessage = "window.alert('Updated Successfully!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);

            }
            else
            {
                strMessage = "window.alert('Failed to Update the Strat.');";
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
        GetStratDetails(searchTerm);
    }


    protected void btnActiveStatus_Click(object sender, EventArgs e)
    {
        {
            try
            {
                Button btn = (Button)sender;

                int stratificationId = Convert.ToInt32(btn.CommandArgument);

                bool isUpdated = md.UpdateStratStatus(stratificationId);

                if (isUpdated)
                {
                    gridStratification.DataBind();
                    GetStratDetails();
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

    protected void gridStratification_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditStrat")
        {
            try
            {
                long stratificationId = Convert.ToInt64(e.CommandArgument);

                DataTable StratDetails = md.GetStratDetailsById(stratificationId);

                if (StratDetails.Rows.Count > 0)
                {
                    tbStratCode.Text = StratDetails.Rows[0]["StratificationCode"].ToString();
                    tbStratName.Text = StratDetails.Rows[0]["StratificationName"].ToString();
                    tbStratAmount.Text = StratDetails.Rows[0]["StratificationAmount"].ToString();
                    tbStratDetail.Text = StratDetails.Rows[0]["StratificationDetail"].ToString();

                    hdStratId.Value = stratificationId.ToString();

                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Stratification details not found!');", true);
                }
            }
            catch (Exception ex)
            {
                md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while fetching Stratification details.');", true);

            }
        }
    }
}