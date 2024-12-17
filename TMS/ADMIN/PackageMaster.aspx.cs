using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class ADMIN_PackageMaster : System.Web.UI.Page
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
                GetPackageMaster();
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

    protected void gridPackageMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridPackageMaster.PageIndex = e.NewPageIndex;
        GetPackageMaster();
    }

    protected void gridPackageMaster_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPackageId = (Label)row.FindControl("lbPackageId");
        Label lbSpecialityCode = (Label)row.FindControl("lbSpecialityCode");
        Label lbSpecialityName = (Label)row.FindControl("lbSpecialityName");
        hdPackageId.Value = lbPackageId.Text.ToString();
        string SpecialityCode = lbSpecialityCode.Text.ToString();
        string SpecialityName = lbSpecialityName.Text.ToString();

        tbSpecialityCode.Text = SpecialityCode;
        tbSpecialityName.Text = SpecialityName;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPackageId = (Label)row.FindControl("lbPackageId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string PackageId = lbPackageId.Text.ToString();

        if (IsActive.Equals("InActive"))
        {
            md.TooglePackageMaster(PackageId, true);
        }
        else
        {
            md.TooglePackageMaster(PackageId, false);
        }
        strMessage = "window.alert('Package Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetPackageMaster();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string SpecialityCode = tbSpecialityCode.Text;
            string SpecialityName = tbSpecialityName.Text;
            if (!SpecialityCode.Equals("") && !SpecialityName.Equals(""))
            {
                md.AddPackage(SpecialityCode, SpecialityName);
                tbSpecialityCode.Text = "";
                tbSpecialityName.Text = "";
                strMessage = "window.alert('Package Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetPackageMaster();
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
            if (hdPackageId.Value != null)
            {
                string SpecialityCode = tbSpecialityCode.Text;
                string SpecialityName = tbSpecialityName.Text;
                if (!SpecialityCode.Equals("") && !SpecialityName.Equals(""))
                {
                    md.UpdatePackageMaster(hdPackageId.Value, SpecialityCode, SpecialityName);
                    tbSpecialityCode.Text = "";
                    tbSpecialityName.Text = "";
                    hdPackageId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Package Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetPackageMaster();
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbSpecialityCode.Text = "";
        tbSpecialityName.Text = "";
        hdPackageId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    public void GetPackageMaster()
    {
        try
        {
            dt.Clear();
            dt = md.GetPackageMaster();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridPackageMaster.DataSource = dt;
                gridPackageMaster.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridPackageMaster.DataSource = null;
                gridPackageMaster.DataBind();
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