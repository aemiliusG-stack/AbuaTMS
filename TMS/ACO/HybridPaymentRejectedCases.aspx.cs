using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AbuaTMS;
using WebGrease.Css.Ast;

public partial class ACO_HybridPaymentRejectedCases : System.Web.UI.Page
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
            //BindGridView();
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
        BindGridView();
    }
    private void BindGridView()
    {
        try
        {
            var hospitalId = string.IsNullOrEmpty(ddlHospitals.SelectedValue) ? DBNull.Value : (object)ddlHospitals.SelectedValue;
            using (SqlCommand cmd = new SqlCommand("TMS_ACO_GetHospitalPaymentRejectedCases", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BasicHospitalId", hospitalId);
                cmd.Parameters.AddWithValue("@RejectedFromDate", string.IsNullOrEmpty(tbRegisteredFromDate.Text) ? (object)DBNull.Value : DateTime.Parse(tbRegisteredFromDate.Text));
                cmd.Parameters.AddWithValue("@RejectedToDate", string.IsNullOrEmpty(TextBox1.Text) ? (object)DBNull.Value : DateTime.Parse(TextBox1.Text));
                cmd.Parameters.AddWithValue("@Scheme", ddlScheme.SelectedValue);
                con.Open();
                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }

                if (dt.Rows.Count == 0)
                {
                    lblError.Text = "No records found.";
                    lblError.Visible = true;
                    panelNoData.Visible = true;
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }
                else
                {
                    panelNoData.Visible = false;
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "An error occurred: " + ex.Message;
            lblError.Visible = true;
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // Change the page index to the selected page
        GridView1.PageIndex = e.NewPageIndex;

        // Rebind the data to reflect the new page
        BindGridView(); // This is the method to bind data to GridView (if you don't have it, create one)
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddlHospitals.SelectedIndex = 0;
        tbRegisteredFromDate.Text = "";
        TextBox1.Text = "";
        DropDownListDistricts.SelectedIndex = 0;
        ddlScheme.SelectedIndex = 0;
        lblError.Visible = false;
        //rptClaimCases.DataSource = null;
        //rptClaimCases.DataBind();
    }
}