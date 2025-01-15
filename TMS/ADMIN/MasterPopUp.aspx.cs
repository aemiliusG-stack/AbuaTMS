using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;

public partial class ADMIN_MasterPopUp : System.Web.UI.Page
{
    private string strMessage, pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
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
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                GetMasterPopupMasterData();
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
    public void GetMasterPopupMasterData(string searchTerm = "")
    {
        try
        {
            dt.Clear();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                dt = md.GetMasterPopupSerachData(searchTerm); 
            }
            else
            {
                dt = md.GetMasterPopupMasterData(); 
            }
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridPopUp.DataSource = dt;
                gridPopUp.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridPopUp.DataSource = null;
                gridPopUp.DataBind();
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
    protected void gridPopUp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridPopUp.PageIndex = e.NewPageIndex;

        string searchTerm = txtSearch.Text.Trim(); 
        GetMasterPopupMasterData(searchTerm); 
    }
    protected void gridPopUp_RowDataBound(object sender, GridViewRowEventArgs e)
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
    protected void btnAddPopUp_Click(object sender, EventArgs e)
    {
        try
        {
            string PopUpDescription = tbPopUpDescription.Text.Trim(); 
            if (!string.IsNullOrEmpty(PopUpDescription))  
            {
                bool popupExists = md.CheckPopUpExists(PopUpDescription);
                if (popupExists)
                {
                    strMessage = "window.alert('The Pop Up Description already exists. Please provide a different description.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                }
                else
                {
                    md.InsertMasterPopup(PopUpDescription);
                    tbPopUpDescription.Text = ""; 
                    strMessage = "window.alert('POP UP Added Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);  
                    GetMasterPopupMasterData(); 
                }
            }
            else
            {
                strMessage = "window.alert('Please provide a valid PopUp Description.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(hdPopUpId.Value))
            {
                string popUpDescription = tbPopUpDescription.Text.Trim();
                if (!string.IsNullOrEmpty(popUpDescription))
                {
                    // Check if the popup description already exists
                    if (md.CheckPopUpExists(popUpDescription))
                    {
                        strMessage = "window.alert('Duplicate PopUp Description. Please enter a unique value.');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "DuplicateAlert", strMessage, true);
                        return; // Stop further execution
                    }

                    // Update the popup description
                    md.UpdateMasterPopup(hdPopUpId.Value, popUpDescription);
                    tbPopUpDescription.Text = "";

                    strMessage = "window.alert('POP UP Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert", strMessage, true);

                    btnUpdate.Visible = false;
                    GetMasterPopupMasterData();
                    btnAddPopUp.Visible = true;
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
        Button btn = (Button)sender; 
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPopUpId = (Label)row.FindControl("lbPopUpId");
        Label lbPopUpDescription = (Label)row.FindControl("lbPopUpDescription");
        hdPopUpId.Value = lbPopUpId.Text;
        string PopUpDescription = lbPopUpDescription.Text;
        tbPopUpDescription.Text = PopUpDescription;
        btnUpdate.Visible = true;
        btnAddPopUp.Visible = false;
    }
    protected void btnStatus_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPopUpId = (Label)row.FindControl("lbPopUpId");
        string popupId = lbPopUpId.Text;
        bool isActive = btn.Text == "Active";
        md.StatusMasterPopup(popupId, !isActive);

        strMessage = "window.alert('POP UP Status Updated Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetMasterPopupMasterData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        GetMasterPopupMasterData(searchTerm);
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbPopUpDescription.Text = "";
        hdPopUpId.Value = null;
        btnUpdate.Visible = false;
        btnAddPopUp.Visible = true;
    }
}