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

public partial class ADMIN_MapProcedureSpecialRuleMaster : System.Web.UI.Page
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
                GetProcedureRuleMasterData();
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
            string RuleDescription = tbRuleDescription.Text.ToString();
            string SelectedData = dropProcedureCode.SelectedValue;
            if (!SelectedData.Equals("0") && !RuleDescription.IsEmpty())
            {
                DataTable dt = new DataTable();
                dt = md.CheckExistingMapProcedureSpecialRule(SelectedData);
                if (dt != null)
                {
                    if (dt.Rows.Count > 0 && dt.Rows[0]["ProcedureSpecialId"].ToString().Trim() != null)
                    {
                        strMessage = "window.alert('Duplicate Mapping Found...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        md.InsertProcedureSpecialRule(SelectedData, RuleDescription);
                        tbRuleDescription.Text = "";
                        dropProcedureCode.SelectedIndex = 0;
                        strMessage = "window.alert('Rule Added Successfully...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        GetProcedureRuleMasterData();
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbRuleDescription.Text = "";
        dropProcedureCode.SelectedIndex = 0;
        hdProcedureSpecialId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdProcedureSpecialId.Value != null)
            {
                string RuleDescription = tbRuleDescription.Text;
                string SelectedData = dropProcedureCode.SelectedValue;
                if (!RuleDescription.Equals("") && SelectedData != null)
                {
                    DataTable dt = new DataTable();
                    dt = md.CheckExistingMapProcedureSpecialRule(SelectedData);
                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0 && dt.Rows[0]["ProcedureSpecialId"].ToString().Trim() != null)
                        {
                            strMessage = "window.alert('Duplicate Mapping Found...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        }
                        else
                        {
                            md.UpdateProcedureRule(hdProcedureSpecialId.Value, SelectedData, RuleDescription);
                            tbRuleDescription.Text = "";
                            hdProcedureSpecialId.Value = null;
                            dropProcedureCode.SelectedIndex = 0;
                            btnUpdate.Visible = false;
                            btnAdd.Visible = true;
                            strMessage = "window.alert('Procedure Rule Updated Successfully...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                            GetProcedureRuleMasterData();
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

    protected void gridSpecialRule_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridSpecialRule.PageIndex = e.NewPageIndex;
        GetProcedureRuleMasterData();
    }

    protected void gridSpecialRule_RowDataBound(object sender, GridViewRowEventArgs e)
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

    public void GetProcedureRuleMasterData()
    {
        try
        {
            dt.Clear();
            dt = md.GetProcedureRuleMasterData();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridSpecialRule.DataSource = dt;
                gridSpecialRule.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridSpecialRule.DataSource = null;
                gridSpecialRule.DataBind();
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
                dt = md.SearchProcedureRuleMasterData(SearchText);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                    gridSpecialRule.DataSource = dt;
                    gridSpecialRule.DataBind();
                }
                else
                {
                    lbRecordCount.Text = "Total No Records: 0";
                    gridSpecialRule.DataSource = null;
                    gridSpecialRule.DataBind();
                }
            }
            else
            {
                GetProcedureRuleMasterData();
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
        Label lbProcedureSpecialId = (Label)row.FindControl("lbProcedureSpecialId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string ProcedureSpecialId = lbProcedureSpecialId.Text.ToString();
        if (IsActive.Equals("InActive"))
        {
            md.ToogleProcedureRule(ProcedureSpecialId, true);
        }
        else
        {
            md.ToogleProcedureRule(ProcedureSpecialId, false);
        }
        strMessage = "window.alert('Rule Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetProcedureRuleMasterData();
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbProcedureSpecialId = (Label)row.FindControl("lbProcedureSpecialId");
        Label lbProcedureId = (Label)row.FindControl("lbProcedureId");
        Label lbProcedureCode = (Label)row.FindControl("lbProcedureCode");
        Label lbRuleDescription = (Label)row.FindControl("lbRuleDescription");
        hdProcedureSpecialId.Value = lbProcedureSpecialId.Text.ToString();
        string ProcedureCode = lbProcedureCode.Text.ToString();
        string RuleDescription = lbRuleDescription.Text.ToString();

        dropProcedureCode.SelectedValue = lbProcedureId.Text.ToString();
        tbRuleDescription.Text = lbRuleDescription.Text.ToString();
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }
}