using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_MapProcedureStratificationMaster : System.Web.UI.Page
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
                GetStratificationDetails();
                GetMapProcedureStratification();
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
            string selectedStratification = dropStratificationCode.SelectedValue;

            if (!selectedProcedure.Equals("0") && !selectedStratification.Equals("0"))
            {
                md.InsertMapProcedureStratification(selectedProcedure, selectedStratification);
                dropProcedureCode.SelectedIndex = 0;
                dropStratificationCode.SelectedIndex = 0;
                strMessage = "window.alert('Map Procedure Stratification Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetMapProcedureStratification();
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
        dropStratificationCode.SelectedIndex = 0;
        hdProcedureStratificationId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedureStratificationId.Value != null)
            {
                string selectedProcedure = dropProcedureCode.SelectedValue;
                string selectedStratificationCode = dropStratificationCode.SelectedValue;
                if (selectedProcedure != null && !selectedProcedure.Equals("0") && selectedStratificationCode != null && !selectedStratificationCode.Equals("0"))
                {
                    md.UpdateMapProcedureStratification(hdProcedureStratificationId.Value, selectedProcedure, selectedStratificationCode);
                    dropProcedureCode.SelectedIndex = 0;
                    dropStratificationCode.SelectedIndex = 0;
                    hdProcedureStratificationId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Mapping Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetMapProcedureStratification();
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

    public void GetStratificationDetails()
    {
        try
        {
            dt.Clear();
            dt = md.GetStratificationDetails();
            if (dt != null && dt.Rows.Count > 0)
            {
                dropStratificationCode.Items.Clear();
                dropStratificationCode.DataValueField = "StratificationId";
                dropStratificationCode.DataTextField = "StratificationCode";
                dropStratificationCode.DataSource = dt;
                dropStratificationCode.DataBind();
                dropStratificationCode.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dropStratificationCode.Items.Clear();
                dropStratificationCode.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetMapProcedureStratification()
    {
        try
        {
            dt.Clear();
            dt = md.GetMapProcedureStratification();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridMapProcedureStratification.DataSource = dt;
                gridMapProcedureStratification.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridMapProcedureStratification.DataSource = null;
                gridMapProcedureStratification.DataBind();
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

    protected void gridMapProcedureStratification_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridMapProcedureStratification.PageIndex = e.NewPageIndex;
        GetMapProcedureStratification();
    }

    protected void gridMapProcedureStratification_RowDataBound(object sender, GridViewRowEventArgs e)
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
            Label lbProcedureStratificationId = (Label)row.FindControl("lbProcedureStratificationId");
            Label lbIsActive = (Label)row.FindControl("lbStatus");
            string IsActive = lbIsActive.Text.ToString();
            string ProcedureStratificationId = lbProcedureStratificationId.Text.ToString();

            if (IsActive.Equals("InActive"))
            {
                md.ToogleMapProcedureStratification(ProcedureStratificationId, true);
            }
            else
            {
                md.ToogleMapProcedureStratification(ProcedureStratificationId, false);
            }
            strMessage = "window.alert('Mapping Status Update Successfully...!!');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            GetMapProcedureStratification();
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
        Label lbProcedureStratificationId = (Label)row.FindControl("lbProcedureStratificationId");
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbStratificationId = (Label)row.FindControl("lbStratificationId");
        hdProcedureStratificationId.Value = lbProcedureStratificationId.Text.ToString();
        string ProcedureId = lbProcedureId.Text.ToString();
        string StratificationId = lbStratificationId.Text.ToString();

        dropProcedureCode.SelectedValue = ProcedureId;
        dropStratificationCode.SelectedValue = StratificationId;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }
}