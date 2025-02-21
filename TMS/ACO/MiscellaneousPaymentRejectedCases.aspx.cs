using AbuaTMS;
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

public partial class ACO_MiscellaneousPaymentRejectedCases : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            // Handle and display any errors
            lblError.Text = "An error occurred: " + ex.Message;
            lblError.Visible = true;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        //txtHospitalCode.Text = string.Empty;
        //ddlHospitals.SelectedIndex = 0;
        //ddlTypeS.SelectedIndex = 0;
        //DropDownListDistricts.SelectedIndex = 0;
        //GridView1.DataSource = null;
        //GridView1.DataBind();
        //lblError.Visible = false;
    }
}