using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_RoleMaster : System.Web.UI.Page
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
                GetRoles();
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

    public void GetRoles()
    {
        try
        {
            dt.Clear();
            dt = md.GetRoles();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridRole.DataSource = dt;
                gridRole.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridRole.DataSource = null;
                gridRole.DataBind();
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


    protected void gridRole_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridRole.PageIndex = e.NewPageIndex;
        GetRoles();
    }

    protected void gridRole_RowDataBound(object sender, GridViewRowEventArgs e)
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
            string RoleName = tbRoleName.Text;
            if (!RoleName.Equals(""))
            {
                md.AddRoles(RoleName);
                tbRoleName.Text = "";
                strMessage = "window.alert('Role Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetRoles();
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
        Label lbRoleId = (Label)row.FindControl("lbRoleId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string RoleId = lbRoleId.Text.ToString();

        if (IsActive.Equals("InActive"))
        {
            md.ToogleRole(RoleId, true);
        }
        else
        {
            md.ToogleRole(RoleId, false);
        }
        strMessage = "window.alert('Role Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetRoles();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbRoleName.Text = "";
        hdRoleId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbRoleId = (Label)row.FindControl("lbRoleId");
        Label lbRoleName = (Label)row.FindControl("lbRoleName");
        hdRoleId.Value = lbRoleId.Text.ToString();
        string RoleName = lbRoleName.Text.ToString();

        tbRoleName.Text = RoleName;
        tbRoleName.Focus();
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdRoleId.Value != null)
            {
                string RoleName = tbRoleName.Text;
                if (!RoleName.Equals(""))
                {
                    md.UpdateRole(hdRoleId.Value, RoleName);
                    tbRoleName.Text = "";
                    hdRoleId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Role Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetRoles();
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