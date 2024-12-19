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

    public void GetMasterPopupMasterData()
    {
        try
        {
            dt.Clear();
            dt = md.GetMasterPopupMasterData();
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
        GetMasterPopupMasterData();
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
            string PopUpDescription = tbPopUpDescription.Text;
            if (!PopUpDescription.Equals(""))
            {
                md.InsertMasterPopup(PopUpDescription);
                tbPopUpDescription.Text = "";
                strMessage = "window.alert('POP UP Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdPopUpId.Value != null)
            {
               
                string PopUpDescription = tbPopUpDescription.Text;
                if (!PopUpDescription.Equals(""))
                {
                    md.UpdateMasterPopup(hdPopUpId.Value, PopUpDescription);
                    tbPopUpDescription.Text = "";
                    strMessage = "window.alert('POP UP Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPopUpId = (Label)row.FindControl("lbPopUpId");
        Label lbPopUpDescription = (Label)row.FindControl("lbPopUpDescription");
        hdPopUpId.Value = lbPopUpId.Text.ToString();
        string PopUpDescription = lbPopUpDescription.Text.ToString();
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

        // Toggle status
        md.StatusMasterPopup(popupId, !isActive);

        strMessage = "window.alert('POP UP Status Updated Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetMasterPopupMasterData();
    }


    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbPopUpDescription.Text = "";
        hdPopUpId.Value = null;
        btnUpdate.Visible = false;
        btnAddPopUp.Visible = true;
    }
}