using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_PrimaryDiagnosisMaster : System.Web.UI.Page
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
                GetPrimaryDiagnosis();
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

    public void GetPrimaryDiagnosis()
    {
        try
        {
            dt.Clear();
            dt = md.GetPrimaryDiagnosis();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridPrimaryDiagnosis.DataSource = dt;
                gridPrimaryDiagnosis.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridPrimaryDiagnosis.DataSource = null;
                gridPrimaryDiagnosis.DataBind();
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

    protected void gridPrimaryDiagnosis_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridPrimaryDiagnosis.PageIndex = e.NewPageIndex;
        GetPrimaryDiagnosis();
    }

    protected void gridPrimaryDiagnosis_RowDataBound(object sender, GridViewRowEventArgs e)
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
            string DiagnosisName = tbDiagnosisName.Text;
            string IcdValue = tbIcdValue.Text;
            if (!DiagnosisName.Equals("") && !IcdValue.Equals(""))
            {
                md.AddPrimaryDiagnosis(DiagnosisName, IcdValue);
                tbDiagnosisName.Text = "";
                tbIcdValue.Text = "";
                strMessage = "window.alert('Primary Diagnosis Added Successfully...!!');";
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                GetPrimaryDiagnosis();
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
        Label lbPDId = (Label)row.FindControl("lbPDId");
        Label lbIsActive = (Label)row.FindControl("lbStatus");
        string IsActive = lbIsActive.Text.ToString();
        string PDId = lbPDId.Text.ToString();

        if (IsActive.Equals("InActive"))
        {
            md.TooglePrimaryDiagnosis(PDId, true);
        }
        else
        {
            md.TooglePrimaryDiagnosis(PDId, false);
        }
        strMessage = "window.alert('Primary Diagnosis Status Update Successfully...!!');";
        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
        GetPrimaryDiagnosis();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbDiagnosisName.Text = "";
        tbIcdValue.Text = "";
        hdPDId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbPDId = (Label)row.FindControl("lbPDId");
        Label lbPrimaryDiagnosisName = (Label)row.FindControl("lbPrimaryDiagnosisName");
        Label lbICDValue = (Label)row.FindControl("lbICDValue");
        hdPDId.Value = lbPDId.Text.ToString();
        string IcdValue = lbICDValue.Text.ToString();
        string DiagnosisName = lbPrimaryDiagnosisName.Text.ToString();

        tbDiagnosisName.Text = DiagnosisName;
        tbIcdValue.Text = IcdValue;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdPDId.Value != null)
            {
                string DiagnosisName = tbDiagnosisName.Text;
                string IcdValue = tbIcdValue.Text;
                if (!DiagnosisName.Equals("") && !IcdValue.Equals(""))
                {
                    md.UpdatePrimaryDiagnosis(hdPDId.Value, DiagnosisName, IcdValue);
                    tbDiagnosisName.Text = "";
                    tbIcdValue.Text = "";
                    hdPDId.Value = null;
                    btnUpdate.Visible = false;
                    btnAdd.Visible = true;
                    strMessage = "window.alert('Primary Diagnosis Updated Successfully...!!');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    GetPrimaryDiagnosis();
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