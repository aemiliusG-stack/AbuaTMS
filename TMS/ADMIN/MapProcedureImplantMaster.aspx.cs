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

public partial class ADMIN_MapProcedureImplantMaster : System.Web.UI.Page
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
                GetImplantDetails();
                GetMapProcedureImplant();
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
            string selectedProcedure = dropProcedureCode.SelectedValue;
            string selectedImplant = dropImplantCode.SelectedValue;

            if (!selectedProcedure.Equals("0") && !selectedImplant.Equals("0"))
            {
                md.InsertMapProcedureImplant(selectedProcedure, selectedImplant);
                dropProcedureCode.SelectedIndex = 0;
                dropImplantCode.SelectedIndex = 0;
                strMessage = "window.alert('Map Procedure Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetMapProcedureImplant();
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
        dropProcedureCode.SelectedIndex = 0;
        dropImplantCode.SelectedIndex = 0;
        hdProcedureImplantId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedureImplantId.Value != null)
            {
                string selectedProcedure = dropProcedureCode.SelectedValue;
                string selectedImplantCode = dropImplantCode.SelectedValue;
                if (selectedProcedure != null && !selectedProcedure.Equals("0") && selectedImplantCode != null && !selectedImplantCode.Equals("0"))
                {
                    md.UpdateMapProcedureImplant(hdProcedureImplantId.Value, selectedProcedure, selectedImplantCode);
                    dropProcedureCode.SelectedIndex = 0;
                    dropImplantCode.SelectedIndex = 0;
                    hdProcedureImplantId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Mapping Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetMapProcedureImplant();
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
            }
            else
            {
                dropProcedureCode.Items.Clear();
                dropProcedureCode.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetImplantDetails()
    {
        try
        {
            dt.Clear();
            dt = md.GetImplantDetails();
            if (dt != null && dt.Rows.Count > 0)
            {
                dropImplantCode.Items.Clear();
                dropImplantCode.DataValueField = "ImplantId";
                dropImplantCode.DataTextField = "ImplantCode";
                dropImplantCode.DataSource = dt;
                dropImplantCode.DataBind();
                dropImplantCode.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropImplantCode.Items.Clear();
                dropImplantCode.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetMapProcedureImplant()
    {
        try
        {
            dt.Clear();
            dt = md.GetMapProcedureImplant();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridMapProcedureImplant.DataSource = dt;
                gridMapProcedureImplant.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridMapProcedureImplant.DataSource = null;
                gridMapProcedureImplant.DataBind();
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

    protected void gridMapProcedureImplant_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridMapProcedureImplant.PageIndex = e.NewPageIndex;
        GetMapProcedureImplant();
    }

    protected void gridMapProcedureImplant_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbStatus = (Label)e.Row.FindControl("lbStatus");
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
            Label lbProcedureImplantId = (Label)row.FindControl("lbProcedureImplantId");
            Label lbIsActive = (Label)row.FindControl("lbStatus");
            string IsActive = lbIsActive.Text.ToString();
            string ProcedureImplantId = lbProcedureImplantId.Text.ToString();

            if (IsActive.Equals("InActive"))
            {
                md.ToogleMapProcedureImplant(ProcedureImplantId, true);
            }
            else
            {
                md.ToogleMapProcedureImplant(ProcedureImplantId, false);
            }
            strMessage = "window.alert('Mapping Status Update Successfully...!!');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            GetMapProcedureImplant();
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
        Label lbProcedureImplantId = (Label)row.FindControl("lbProcedureImplantId");
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbImplantId = (Label)row.FindControl("lbImplantId");
        hdProcedureImplantId.Value = lbProcedureImplantId.Text.ToString();
        string ProcedureId = lbProcedureId.Text.ToString();
        string ImplantId = lbImplantId.Text.ToString();

        dropProcedureCode.SelectedValue = ProcedureId;
        dropImplantCode.SelectedValue = ImplantId;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

}