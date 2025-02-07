using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Org.BouncyCastle.Asn1.X509;

public partial class SHA_SHAClaimUpdation : System.Web.UI.Page
{

    private string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();
    private SHAHelper shaHelper = new SHAHelper();

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
            else
            {
                hdUserId.Value = Session["UserId"].ToString();
                if (!IsPostBack)
                {
                    GetCases();
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

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

    }

    public void GetCases()
    {
        try
        {
            dt.Clear();
            dt = shaHelper.GetShaCases();
            if (dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridCases.DataSource = dt;
                gridCases.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridCases.DataSource = null;
                gridCases.DataBind();
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

    protected void gridCases_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbTdsExemption = (Label)e.Row.FindControl("lbTdsExemption");
            Label lbTdsPercentage = (Label)e.Row.FindControl("lbTdsPercentage");
            Label lbApprovedAmount = (Label)e.Row.FindControl("lbApprovedAmount");
            Label lbApprovedAmountInsurer = (Label)e.Row.FindControl("lbApprovedAmountInsurer");
            Label lbApprovedAmountTrust = (Label)e.Row.FindControl("lbApprovedAmountTrust");
            Label lbTdsAmountInsurer = (Label)e.Row.FindControl("lbTdsAmountInsurer");
            Label lbTdsAmountTrust = (Label)e.Row.FindControl("lbTdsAmountTrust");
            Label lbFinalAmountInsurer = (Label)e.Row.FindControl("lbFinalAmountInsurer");
            Label lbFinalAmountTrust = (Label)e.Row.FindControl("lbFinalAmountTrust");
            Label lbInsurerApprovedAmount = (Label)e.Row.FindControl("lbInsurerApprovedAmount");
            Label lbTrustApprovedAmount = (Label)e.Row.FindControl("lbTrustApprovedAmount");
            string IsActive = lbTdsExemption.Text.ToString();
            if (Session["RoleId"].ToString().Equals("11"))
            {
                lbApprovedAmountInsurer.Visible = true;
                lbApprovedAmountTrust.Visible = false;
            }
            else
            {
                lbApprovedAmountInsurer.Visible = false;
                lbApprovedAmountTrust.Visible = true;
            }
            if (IsActive != null && IsActive.Equals("False"))
            {
                lbTdsExemption.Text = "Yes";
                double tdsPercentage = Convert.ToDouble(lbTdsPercentage.Text.ToString());
                double insurerAmount = Convert.ToDouble(lbInsurerApprovedAmount.Text.ToString());
                double trustAmount = Convert.ToDouble(lbTrustApprovedAmount.Text.ToString());
                if (tdsPercentage > 0.0)
                {
                    double tdsInsurerAmount = (insurerAmount * tdsPercentage) / 100;
                    double tdsTrustAmount = (trustAmount * tdsPercentage) / 100;
                    double insurerFinalAmount = insurerAmount - tdsInsurerAmount;
                    double trustFinalAmount = trustAmount - tdsTrustAmount;
                    lbTdsAmountInsurer.Text = tdsInsurerAmount.ToString();
                    lbTdsAmountTrust.Text = tdsTrustAmount.ToString();
                    lbFinalAmountInsurer.Text = insurerFinalAmount.ToString();
                    lbFinalAmountTrust.Text = trustFinalAmount.ToString();
                }
            }
            else
            {
                lbTdsExemption.Text = "No";
                lbTdsPercentage.Text = "NA";
            }
        }
    }

    protected void gridCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridCases.PageIndex = e.NewPageIndex;
        GetCases();
    }

    protected void lnkCaseNo_Click(object sender, EventArgs e)
    {

    }
}