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

public partial class ADMIN_MapProcedureAddOnPrimaryMaster : System.Web.UI.Page
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
                GetProcedureDetails();
                GetProcedureAddOnPrimaryMasterData();
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string Remarks = tbRemarks.Text.ToString();
            string selectedProcedure = dropProcedureCode.SelectedValue;
            string selectedAddOnProcedure = dropProcedureCodeAddOn.SelectedValue;

            if (!selectedProcedure.Equals("0") && !selectedAddOnProcedure.Equals("0") && !Remarks.IsEmpty())
            {
                md.InsertMapProcedureAddOnPrimary(selectedProcedure, selectedAddOnProcedure, Remarks);
                tbRemarks.Text = "";
                dropProcedureCode.SelectedIndex = 0;
                dropProcedureCodeAddOn.SelectedIndex = 0;
                strMessage = "window.alert('Map Procedure Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetProcedureAddOnPrimaryMasterData();
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbRemarks.Text = "";
        dropProcedureCode.SelectedIndex = 0;
        dropProcedureCodeAddOn.SelectedIndex = 0;
        hdProcedurePrimaryId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedurePrimaryId.Value != null)
            {
                string Remarks = tbRemarks.Text.ToString();
                string selectedProcedure = dropProcedureCode.SelectedValue;
                string selectedAddOnProcedure = dropProcedureCodeAddOn.SelectedValue;
                if (!Remarks.Equals("") && selectedProcedure != null && !selectedProcedure.Equals("0") && selectedAddOnProcedure != null && !selectedAddOnProcedure.Equals("0"))
                {
                    md.UpdateMapProcedureAddOnPrimary(hdProcedurePrimaryId.Value, selectedProcedure, selectedAddOnProcedure, Remarks);
                    tbRemarks.Text = "";
                    dropProcedureCode.SelectedIndex = 0;
                    dropProcedureCodeAddOn.SelectedIndex = 0;
                    hdProcedurePrimaryId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Mapping Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetProcedureAddOnPrimaryMasterData();
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

    public void GetProcedureDetails()
    {
        try
        {
            dt.Clear();
            dt = md.GetProcedureDetails();
            if (dt != null && dt.Rows.Count > 0)
            {
                dropProcedureCode.Items.Clear();
                dropProcedureCode.DataValueField = "ProcedureId";
                dropProcedureCode.DataTextField = "ProcedureCode";
                dropProcedureCode.DataSource = dt;
                dropProcedureCode.DataBind();
                dropProcedureCode.Items.Insert(0, new ListItem("--SELECT--", "0"));

                dropProcedureCodeAddOn.Items.Clear();
                dropProcedureCodeAddOn.DataValueField = "ProcedureId";
                dropProcedureCodeAddOn.DataTextField = "ProcedureCode";
                dropProcedureCodeAddOn.DataSource = dt;
                dropProcedureCodeAddOn.DataBind();
                dropProcedureCodeAddOn.Items.Insert(0, new ListItem("--SELECT--", "0"));

            }
            else
            {
                dropProcedureCode.Items.Clear();
                dropProcedureCode.Items.Insert(0, new ListItem("--SELECT--", "0"));

                dropProcedureCodeAddOn.Items.Clear();
                dropProcedureCodeAddOn.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetProcedureAddOnPrimaryMasterData()
    {
        try
        {
            dt.Clear();
            dt = md.GetProcedureAddOnPrimaryMasterData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridAddOnPrimary.DataSource = dt;
                gridAddOnPrimary.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridAddOnPrimary.DataSource = null;
                gridAddOnPrimary.DataBind();
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


    protected void gridAddOnPrimary_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridAddOnPrimary.PageIndex = e.NewPageIndex;
        GetProcedureAddOnPrimaryMasterData();
    }

    protected void gridManditoryDocument_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbStatus = (Label)e.Row.FindControl("lbStatus");
            LinkButton btnDelete = (LinkButton)e.Row.FindControl("btnDelete");
            string IsActive = lbStatus.Text.ToString();
            if (IsActive != null && IsActive.Equals("False"))
            {
                lbStatus.Text = "InActive";
                lbStatus.CssClass = "btn btn-danger btn-sm rounded-pill";
            }
            else
            {
                lbStatus.Text = "Active";
                lbStatus.CssClass = "btn btn-success btn-sm rounded-pill";
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbProcedurePrimaryId = (Label)row.FindControl("lbProcedurePrimaryId");
            Label lbIsActive = (Label)row.FindControl("lbStatus");
            string IsActive = lbIsActive.Text.ToString();
            string ProcedurePrimaryId = lbProcedurePrimaryId.Text.ToString();

            if (IsActive.Equals("InActive"))
            {
                md.ToogleMapProcedureAddOnPrimary(ProcedurePrimaryId, true);
            }
            else
            {
                md.ToogleMapProcedureAddOnPrimary(ProcedurePrimaryId, false);
            }
            strMessage = "window.alert('Mapping Status Update Successfully...!!');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            GetProcedureAddOnPrimaryMasterData();
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
        Label lbProcedurePrimaryId = (Label)row.FindControl("lbProcedurePrimaryId");
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbAddOnPrimaryId = (Label)row.FindControl("lbAddOnPrimaryId");
        Label lbRemarks = (Label)row.FindControl("lbRemarks");
        hdProcedurePrimaryId.Value = lbProcedurePrimaryId.Text.ToString();
        string ProcedureId = lbProcedureId.Text.ToString();
        string AddOnPrimaryId = lbAddOnPrimaryId.Text.ToString();
        string Remarks = lbRemarks.Text.ToString();

        dropProcedureCode.SelectedValue = lbProcedureId.Text.ToString();
        dropProcedureCodeAddOn.SelectedValue = lbAddOnPrimaryId.Text.ToString();
        tbRemarks.Text = Remarks;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

}