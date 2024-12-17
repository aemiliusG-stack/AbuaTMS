using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_ProcedureLabelMaster : System.Web.UI.Page
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
                GetProcedureLabel();
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

    public void GetProcedureLabel()
    {
        try
        {
            dt.Clear();
            dt = md.GetProcedureLabel();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridProcedureLabel.DataSource = dt;
                gridProcedureLabel.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridProcedureLabel.DataSource = null;
                gridProcedureLabel.DataBind();
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

    protected void gridProcedureLabel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridProcedureLabel.PageIndex = e.NewPageIndex;
        GetProcedureLabel();
    }

    protected void gridProcedureLabel_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string LabelName = tbLabelName.Text;
            if (!LabelName.Equals(""))
            {
                md.AddProcedureLabel(LabelName);
                tbLabelName.Text = "";
                strMessage = "window.alert('Procedure Label Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetProcedureLabel();
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

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbProcedureLabelId = (Label)row.FindControl("lbProcedureLabelId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string ProcedureLabelId = lbProcedureLabelId.Text.ToString();

        if (IsActive.Equals("InActive"))
        {
            md.ToogleProcedureLabel(ProcedureLabelId, true);
        }
        else
        {
            md.ToogleProcedureLabel(ProcedureLabelId, false);
        }
        strMessage = "window.alert('Procedure Label Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetProcedureLabel();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbLabelName.Text = "";
        hdProcedureLabelId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbProcedureLabelId = (Label)row.FindControl("lbProcedureLabelId");
        Label lbLabelName = (Label)row.FindControl("lbLabelName");
        hdProcedureLabelId.Value = lbProcedureLabelId.Text.ToString();
        string LabelName = lbLabelName.Text.ToString();

        tbLabelName.Text = LabelName;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedureLabelId.Value != null)
            {
                string LabelName = tbLabelName.Text;
                if (!LabelName.Equals(""))
                {
                    md.UpdateProcedureLabel(hdProcedureLabelId.Value, LabelName);
                    tbLabelName.Text = "";
                    hdProcedureLabelId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Procedure Label Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetProcedureLabel();
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

}