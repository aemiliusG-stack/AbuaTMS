using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;
using System.Web.WebPages;

public partial class ADMIN_ImplantMaster : System.Web.UI.Page
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
                GetImplantMasterData();
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

    public void GetImplantMasterData()
    {
        try
        {
            dt.Clear();
            dt = md.GetImplantMasterData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridImplant.DataSource = dt;
                gridImplant.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridImplant.DataSource = null;
                gridImplant.DataBind();
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

    protected void gridImplant_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridImplant.PageIndex = e.NewPageIndex;
        GetImplantMasterData();
    }

    protected void gridImplant_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void btnAddImplant_Click(object sender, EventArgs e)
    {
        try
        {
            string ImplantCode = tbImplantCode.Text;
            string ImplantName = tbImplantName.Text;
            string ImplantCount = tbImplantCount.Text;
            string ImplantAmount = tbImplantAmount.Text;
            if (!ImplantCode.Equals("") && !ImplantName.Equals("") && !ImplantCount.Equals("") && !ImplantAmount.Equals(""))
            {
                DataTable dt = new DataTable();
                dt = md.CheckExistingImplant(ImplantCode, ImplantName);
                if (dt != null)
                {
                    if (dt.Rows.Count > 0 && dt.Rows[0]["ImplantId"].ToString().Trim() != null)
                    {
                        strMessage = "window.alert('Implant Already Exist...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        md.InsertImplant(ImplantCode, ImplantName, ImplantCount, ImplantAmount);
                        tbImplantCode.Text = "";
                        tbImplantName.Text = "";
                        tbImplantCount.Text = "";
                        tbImplantAmount.Text = "";
                        strMessage = "window.alert('Implant Added Successfully...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        GetImplantMasterData();
                    }
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

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdImplantId.Value != null)
            {
                string ImplantCode = tbImplantCode.Text;
                string ImplantName = tbImplantName.Text;
                string ImplantCount = tbImplantCount.Text;
                string ImplantAmount = tbImplantAmount.Text;
                if (!ImplantCode.Equals("") && !ImplantName.Equals("") && !ImplantCount.Equals("") && !ImplantAmount.Equals(""))
                {
                    DataTable dt = new DataTable();
                    dt = md.CheckExistingImplant(ImplantCode, ImplantName);
                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0 && dt.Rows[0]["ImplantId"].ToString().Trim() != null)
                        {
                            strMessage = "window.alert('Implant Already Exist...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        }
                        else
                        {
                            md.UpdateImplant(hdImplantId.Value, ImplantCode, ImplantName, ImplantCount, ImplantAmount);
                            tbImplantCode.Text = "";
                            tbImplantName.Text = "";
                            tbImplantCount.Text = "";
                            tbImplantAmount.Text = "";
                            hdImplantId.Value = null;
                            btnUpdate.Visible = false;
                            btnAddImplant.Visible = true;
                            strMessage = "window.alert('Implant Updated Successfully...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                            GetImplantMasterData();
                        }
                    }
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string SearchText = tbSearch.Text;
            if (!SearchText.Equals(""))
            {
                dt.Clear();
                dt = md.SearchImplantMasterData(SearchText);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                    gridImplant.DataSource = dt;
                    gridImplant.DataBind();
                }
                else
                {
                    lbRecordCount.Text = "Total No Records: 0";
                    gridImplant.DataSource = null;
                    gridImplant.DataBind();
                }
            }
            else
            {
                GetImplantMasterData();
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
        Label lbImplantId = (Label)row.FindControl("lbImplantId");
        Label lbImplantCode = (Label)row.FindControl("lbImplantCode");
        Label lbImplantName = (Label)row.FindControl("lbImplantName");
        Label lbMaxImplant = (Label)row.FindControl("lbMaxImplant");
        Label lbImplantAmount = (Label)row.FindControl("lbImplantAmount");
        hdImplantId.Value = lbImplantId.Text.ToString();
        string ImplantCode = lbImplantCode.Text.ToString();
        string ImplantName = lbImplantName.Text.ToString();
        string ImplantCount = lbMaxImplant.Text.ToString();
        string ImplantAmuont = lbImplantAmount.Text.ToString();

        tbImplantCode.Text = ImplantCode;
        tbImplantName.Text = ImplantName;
        tbImplantCount.Text = ImplantCount;
        tbImplantAmount.Text = ImplantAmuont;
        btnUpdate.Visible = true;
        btnAddImplant.Visible = false;
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbImplantId = (Label)row.FindControl("lbImplantId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string ImplantId = lbImplantId.Text.ToString();

        if (IsActive.Equals("InActive"))
        {
            md.ToogleImplant(ImplantId, true);
        }
        else
        {
            md.ToogleImplant(ImplantId, false);
        }
        strMessage = "window.alert('Implant Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetImplantMasterData();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbImplantCode.Text = "";
        tbImplantName.Text = "";
        tbImplantCount.Text = "";
        tbImplantAmount.Text = "";
        hdImplantId.Value = null;
        btnUpdate.Visible = false;
        btnAddImplant.Visible = true;
    }
}