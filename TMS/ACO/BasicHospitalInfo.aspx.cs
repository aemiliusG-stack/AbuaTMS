using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using WebGrease.Css.Ast;

public partial class ACO_BasicHospitalInfo : System.Web.UI.Page
{
    //private string connectionString = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private string sortDirection;
    private string sortExpression = string.Empty;
    ACOHelper aco = new ACOHelper();
    MasterData md = new MasterData();
    string pageName;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdUserId.Value = Session["UserId"].ToString();
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            LoadHospitals();
            LoadHospitalTypes();
            LoadDistricts();
        }
    }

    private void LoadHospitals()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = aco.GetAllHospitalNameList(); // Use the class method to get the hospital list
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlHospitals.DataSource = dt;
                ddlHospitals.DataTextField = "HospitalName";
                ddlHospitals.DataValueField = "HospitalId";
                ddlHospitals.DataBind();
                ddlHospitals.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                ddlHospitals.Items.Clear();
                ddlHospitals.Items.Add(new ListItem("---select---", ""));
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
    private void LoadHospitalTypes()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = aco.GetAllHospitalType(); // Use the class method to get the hospital list
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlTypeS.DataSource = dt;
                ddlTypeS.DataTextField = "Title";
                ddlTypeS.DataValueField = "Id";
                ddlTypeS.DataBind();
                ddlTypeS.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                ddlHospitals.Items.Clear();
                ddlHospitals.Items.Add(new ListItem("---select---", ""));
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
    private void LoadDistricts()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = aco.GetAllDistrictsFromMasterDistrict(); // Use the method from your class
            //dt.Clear();
            if (dt != null && dt.Rows.Count > 0)
            {
                DropDownListDistricts.DataSource = dt;
                DropDownListDistricts.DataTextField = "Title";
                DropDownListDistricts.DataValueField = "Id";
                DropDownListDistricts.DataBind();
                DropDownListDistricts.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
            else
            {
                DropDownListDistricts.Items.Clear();
                DropDownListDistricts.Items.Add(new ListItem("No districts available", string.Empty));
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
        PerformSearch(); // Call the search method on search button click

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex; // Set the new page index
        PerformSearch(); // Re-run the search to fetch the data for the new page
       
    }

    private void PerformSearch()
    {
        try
        {
            // Collect search criteria from controls (e.g., textboxes, dropdowns)
            string hemRefNumber = txtHospitalCode.Text.Trim();  // Adjust control names as needed
            int? hospitalId = null;
            if (!string.IsNullOrEmpty(ddlHospitals.SelectedValue) && ddlHospitals.SelectedValue != "0")
            {
                hospitalId = Convert.ToInt32(ddlHospitals.SelectedValue);
            }

            string hospitalType = ddlTypeS.SelectedIndex == 0 ? null : ddlTypeS.SelectedValue;
            int? districtId = null;
            if (!string.IsNullOrEmpty(DropDownListDistricts.SelectedValue) && DropDownListDistricts.SelectedValue != "0")
            {
                districtId = Convert.ToInt32(DropDownListDistricts.SelectedValue);
            }

            // Call the method from your class to get the search results
            dt = aco.GetHospitalSearchResults(hemRefNumber, hospitalId, hospitalType, districtId);

            // Check if the DataTable has any results
            if (dt != null && dt.Rows.Count > 0)
            {
                // Bind the results to your GridView or other data-bound control
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                // If no results, show a message to the user
                lblError.Visible = true;
                lblError.Text = "No hospitals found matching your criteria.";
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
        try
        {
            txtHospitalCode.Text = string.Empty;
            ddlHospitals.SelectedIndex = 0;
            ddlTypeS.SelectedIndex = 0;
            DropDownListDistricts.SelectedIndex = 0;
            GridView1.DataSource = null;
            GridView1.DataBind();
            lblError.Visible = false;
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
