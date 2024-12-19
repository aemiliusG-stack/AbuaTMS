using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_MapProcedureNonRelated : System.Web.UI.Page
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
                GetMapProcedureNonRelatedData();
                getPrimaryProcedureCode();
                getProcedureCode();
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
    protected void getPrimaryProcedureCode()
    {
        try
        {
            dt = md.GetProcedureCode();

            ddPrimaryProcedureCode.Items.Clear();

            if (dt != null && dt.Rows.Count > 0)
            {
                ddPrimaryProcedureCode.DataValueField = "ProcedureId";
                ddPrimaryProcedureCode.DataTextField = "ProcedureCode";
                ddPrimaryProcedureCode.DataSource = dt;
                ddPrimaryProcedureCode.DataBind();
                ddPrimaryProcedureCode.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddPrimaryProcedureCode.Items.Insert(0, new ListItem("--No Remarks Found--", "0"));
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void getProcedureCode()
    {
        try
        {
            dt = md.GetProcedureCode();

            ddProcedureCode.Items.Clear();

            if (dt != null && dt.Rows.Count > 0)
            {
                ddProcedureCode.DataValueField = "ProcedureId";
                ddProcedureCode.DataTextField = "ProcedureCode";
                ddProcedureCode.DataSource = dt;
                ddProcedureCode.DataBind();
                ddProcedureCode.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddProcedureCode.Items.Insert(0, new ListItem("--No Remarks Found--", "0"));
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    public void GetMapProcedureNonRelatedData()
    {
        try
        {
            dt.Clear();
            dt = md.GetMapProcedureNonRelatedData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridProcedureNonRelated.DataSource = dt;
                gridProcedureNonRelated.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridProcedureNonRelated.DataSource = null;
                gridProcedureNonRelated.DataBind();
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


    protected void gridProcedureNonRelated_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridProcedureNonRelated.PageIndex = e.NewPageIndex;
        GetMapProcedureNonRelatedData();
    }

    //protected void gridProcedureNonRelated_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        bool? isActive = DataBinder.Eval(e.Row.DataItem, "IsActive") as bool?;
    //        Label lbStatus = (Label)e.Row.FindControl("lbStatus");
    //        if (!isActive.HasValue || !isActive.Value)
    //        {
    //            lbStatus.Text = "InActive";
    //            lbStatus.CssClass = "btn btn-warning btn-sm rounded-pill";
    //        }
    //        else
    //        {
    //            lbStatus.Text = "Active";
    //            lbStatus.CssClass = "btn btn-success btn-sm rounded-pill";
    //        }
    //    }
    //}
    protected void gridProcedureNonRelated_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void btnAddProcedureNonRelated_Click(object sender, EventArgs e)
    {
        try
        {
            string PrimaryProcedureCode = ddPrimaryProcedureCode.Text;
            string ProcedureCode = ddProcedureCode.Text;
            string Remarks = tbRemarks.Text;

            if (!PrimaryProcedureCode.Equals("") && !ProcedureCode.Equals("") && !Remarks.Equals(""))
            {
                md.InsertMapProcedureNonRelated(PrimaryProcedureCode, ProcedureCode, Remarks);
                ddPrimaryProcedureCode.SelectedIndex = 0;
                ddProcedureCode.SelectedIndex = 0;
                tbRemarks.Text = "";

                strMessage = "window.alert('Procedure Non Related Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetMapProcedureNonRelatedData();
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
            if (hdProcedureNonRelatedId.Value != null)
            {

                string PrimaryProcedureCode = ddPrimaryProcedureCode.Text;
                string ProcedureCode = ddProcedureCode.Text;
                string Remarks = tbRemarks.Text;
                if (!PrimaryProcedureCode.Equals("") && !ProcedureCode.Equals("") && !Remarks.Equals(""))
                {
                    md.UpdateMapProcedureNonRelated(hdProcedureNonRelatedId.Value, PrimaryProcedureCode, ProcedureCode, Remarks);
                    ddPrimaryProcedureCode.SelectedIndex = 0;
                    ddProcedureCode.SelectedIndex = 0;
                    tbRemarks.Text = "";
                    strMessage = "window.alert('Procedure Non Related Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    btnUpdate.Visible = false;
                    GetMapProcedureNonRelatedData();
                    btnAddProcedureNonRelated.Visible = true;

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
        Label lbProcedureNonRelatedId = (Label)row.FindControl("lbProcedureNonRelatedId");
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbNonRelatedId = (Label)row.FindControl("lbNonRelatedId");
        Label lbRemarks = (Label)row.FindControl("lbRemarks");

        hdProcedureNonRelatedId.Value = lbProcedureNonRelatedId.Text.ToString();
        string ProcedureId = lbProcedureId.Text.ToString();
        string NonRelatedId = lbNonRelatedId.Text.ToString();
        string Remarks = lbRemarks.Text.ToString();
        ddPrimaryProcedureCode.Text = ProcedureId;
        ddProcedureCode.Text = NonRelatedId;
        tbRemarks.Text = Remarks;

        btnUpdate.Visible = true;
        btnAddProcedureNonRelated.Visible = false;
    }
    protected void btnStatus_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbProcedureNonRelatedId = (Label)row.FindControl("lbProcedureNonRelatedId");
        string ProcedureNonRelatedId = lbProcedureNonRelatedId.Text;
        bool isActive = btn.Text == "Active";

        md.StatusMapProcedureNonRelated(ProcedureNonRelatedId, !isActive);

        strMessage = "window.alert('Status Updated Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetMapProcedureNonRelatedData();
    }
    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    LinkButton btn = (LinkButton)sender;
    //    GridViewRow row = (GridViewRow)btn.NamingContainer;
    //    Label lbProcedureNonRelatedId = (Label)row.FindControl("lbProcedureNonRelatedId");
    //    Label lbIsActive = (Label)row.FindControl("lbStatus");
    //    string IsActive = lbIsActive.Text.ToString();
    //    string PopUpId = lbProcedureNonRelatedId.Text.ToString();

    //    if (IsActive.Equals("InActive"))
    //    {
    //        md.StatusMapProcedureNonRelated(PopUpId, true);
    //    }
    //    else
    //    {
    //        md.StatusMapProcedureNonRelated(PopUpId, false);
    //    }
    //    strMessage = "window.alert('POP UP Status Update Successfully...!!');";
    //    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
    //    GetMapProcedureNonRelatedData();
    //}

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddPrimaryProcedureCode.SelectedIndex = 0;
        ddProcedureCode.SelectedIndex = 0;
        tbRemarks.Text = "";
        hdProcedureNonRelatedId.Value = null;
        btnUpdate.Visible = false;
        btnAddProcedureNonRelated.Visible = true;

    }
}