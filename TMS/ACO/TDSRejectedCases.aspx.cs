using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class ACO_TDSRejectedCases : System.Web.UI.Page
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
        lblError.Visible = false; // Hide error label at the beginning of the method

        try
        {

        }
        catch (Exception ex)
        {
            // Display error message in case of an exception
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
        ddlHospitals.SelectedIndex = 0;
        tbRegisteredFromDate.Text = "";
        TextBox1.Text = "";
        lblError.Visible = false;
    }
}