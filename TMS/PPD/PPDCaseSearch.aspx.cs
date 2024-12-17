using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using CareerPath.DAL;
using System.Web.WebPages;

public partial class PPD_PPDCaseSearch : System.Web.UI.Page
{
    private string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
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
                GetPatients();
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

    protected void gridCaseSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridCaseSearch.PageIndex = e.NewPageIndex;
        GetPatients();
    }

    protected void gridCaseSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbDischargeDate = (Label)e.Row.FindControl("lbDischargeDate");
            string DischargeDate = lbDischargeDate.Text.ToString();
            if (DischargeDate.IsEmpty())
            {
                lbDischargeDate.Text = "Under Treatement";
            }
        }
    }

    public void GetPatients()
    {
        try
        {
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UserId", hdUserId.Value);
            p[0].DbType = DbType.String;
            DataSet ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PPD_CaseSearch", p);
            if (con.State == ConnectionState.Open)
                con.Close();
            if (ds.Tables.Count > 0)
            {
                DataTable dt = new DataTable();
                dt = ds.Tables[0];
                if (dt != null && dt.Rows.Count > 0)
                {
                    lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                    gridCaseSearch.DataSource = dt;
                    gridCaseSearch.DataBind();
                }
                else
                {
                    lbRecordCount.Text = "Total No Records: 0";
                    gridCaseSearch.DataSource = null;
                    gridCaseSearch.DataBind();
                    panelNoData.Visible = true;
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


    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbAdmissionId = (Label)row.FindControl("lbAdmissionId");
        Label lbClaimId = (Label)row.FindControl("lbClaimId");
        LinkButton lnkCaseNo = (LinkButton)row.FindControl("lnkCaseNo");
        string CaseNumber = lnkCaseNo.Text.ToString();
        string AdmissionId = lbAdmissionId.Text.ToString();
        Response.Redirect("PPDCaseDetails.aspx?CaseNumber=" + CaseNumber + "&AdmissionId=" + AdmissionId + "&ClaimId=" + lbClaimId.Text.ToString(), false);
    }
}