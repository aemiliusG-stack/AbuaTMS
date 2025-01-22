﻿using AbuaTMS;
using CareerPath.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Css.Ast;

public partial class CPD_CPDAssignedCases : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    DataTable dt = new DataTable();
    CPD cpd = new CPD();
    string pageName;
    private MasterData md = new MasterData();
    string CurrentDate = DateTime.Now.ToString("yyyy-MM-dd");

    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                SearchAssignedCases("", "", "", CurrentDate);
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

        if (!IsPostBack)
        {
          getSpecialityName();
        }
    }
    protected void getSpecialityName()
    {
        try
        {
            dt = cpd.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddCategory.Items.Clear();
                ddCategory.DataValueField = "PackageId";
                ddCategory.DataTextField = "SpecialityName";
                ddCategory.DataSource = dt;
                ddCategory.DataBind();
                ddCategory.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddCategory.Items.Clear();
                ddCategory.Items.Insert(0, new ListItem("--No Speciality Name Available--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }
    protected void ddCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int packageId;
            if (int.TryParse(ddCategory.SelectedValue, out packageId))
            {
                dt = cpd.GetProcedureName(packageId);
                if (dt.Rows.Count > 0)
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.DataValueField = "ProcedureId";
                    ddProcedureName.DataTextField = "ProcedureName";
                    ddProcedureName.DataSource = dt;
                    ddProcedureName.DataBind();
                    ddProcedureName.Items.Insert(0, new ListItem("--SELECT--", "0"));
                }
                else
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.Items.Insert(0, new ListItem("--No Procedure Available--", "0"));
                }
            }
            else
            {
                ddProcedureName.Items.Clear();
                ddProcedureName.Items.Insert(0, new ListItem("--SELECT SPECIALITY FIRST--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    protected void btnCPDReset_Click(object sender, EventArgs e)
    {
        tbCaseNumber.Text = string.Empty;
        tbBeneficiaryCardNumber.Text = string.Empty;
        tbFromDate.Text = string.Empty;
        tbToDate.Text = string.Empty;
        SearchAssignedCases("", "", "", CurrentDate);
    }
    protected void btnCPDSearch_Click(object sender, EventArgs e)
    {
        SearchAssignedCases(tbCaseNumber.Text.ToString(), tbBeneficiaryCardNumber.Text.ToString(), tbFromDate.Text.ToString(), tbToDate.Text.ToString());

    }
    public void SearchAssignedCases(string CaseNumber, string CardNumber, string FromDate, string ToDate)
    {
        try
        {
            dt.Clear();
            dt = cpd.GetAssignedCases(hdUserId.Value, CaseNumber, CardNumber, FromDate, ToDate);
            if (dt.Rows.Count > 0)
            {
                gridAssignedCases.DataSource = dt;
                gridAssignedCases.DataBind();
            }
            else
            {
                gridAssignedCases.DataSource = "";
                gridAssignedCases.DataBind();
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

        // Get the values from the row
        string caseNumber = lnkCaseNo.Text.ToString();
        string admissionId = lbAdmissionId.Text.ToString();
        string claimId = lbClaimId.Text.ToString();

        // Store the values in the session
        Session["CaseNumber"] = caseNumber;
        Session["AdmissionId"] = admissionId;
        Session["ClaimId"] = claimId;

        // Redirect without query string parameters
        Response.Redirect("CPDAssignedCasePatientDetails.aspx", false);
    }


}