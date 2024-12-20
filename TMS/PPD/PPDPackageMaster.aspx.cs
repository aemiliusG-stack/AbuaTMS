using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CareerPath.DAL;

public partial class PPD_PPDPackageMaster : System.Web.UI.Page
{
    private string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private PPDHelper ppdHelper = new PPDHelper();

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
                GetSpecialityName();
                GetPackageMaster(null, null, false);
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

    protected void dlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedValue = dlSpeciality.SelectedItem.Value;
        GetSpecialityBasedProcedure(selectedValue);
    }

    public void GetSpecialityName()
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                dlSpeciality.Items.Clear();
                dlSpeciality.DataValueField = "PackageId";
                dlSpeciality.DataTextField = "SpecialityName";
                dlSpeciality.DataSource = dt;
                dlSpeciality.DataBind();
                dlSpeciality.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dlSpeciality.Items.Clear();
                dlSpeciality.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetSpecialityBasedProcedure(string PackageId)
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetSpecialityBasedProcedure(PackageId);
            if (dt != null && dt.Rows.Count > 0)
            {
                dlProcedureName.Items.Clear();
                dlProcedureName.DataValueField = "ProcedureId";
                dlProcedureName.DataTextField = "ProcedureName";
                dlProcedureName.DataSource = dt;
                dlProcedureName.DataBind();
                dlProcedureName.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                dlProcedureName.Items.Clear();
                dlProcedureName.Items.Insert(0, new ListItem("--SELECT--", "0"));
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

    public void GetPackageMaster(string PackageId, string ProcedureId, bool isClicked)
    {
        try
        {
            dt.Clear();
            dt = ppdHelper.GetPackageMaster(PackageId, ProcedureId);
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridPackageMaster.DataSource = dt;
                gridPackageMaster.DataBind();
                panelNoData.Visible = false;
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridPackageMaster.DataSource = null;
                gridPackageMaster.DataBind();
                panelNoData.Visible = true;
                if (isClicked)
                {
                    string strMessage = "window.alert('No records found for the given search criteria.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
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

    protected void gridPackageMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridPackageMaster.PageIndex = e.NewPageIndex;
        GetPackageMaster(null, null, false);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string selectedSpeciality = dlSpeciality.SelectedItem.Value;
        string selectedProcedure = dlProcedureName.SelectedItem.Value;
        GetPackageMaster(selectedSpeciality, selectedProcedure, true);
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        dlSpeciality.SelectedIndex = 0;
        dlProcedureName.SelectedIndex = 0;
        GetPackageMaster(null, null, false);
    }
}