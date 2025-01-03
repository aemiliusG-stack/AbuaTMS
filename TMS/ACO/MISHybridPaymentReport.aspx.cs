using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ACO_MISHybridPaymentReport : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

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
        tbRegisteredFromDate.Text = string.Empty;
        //toDate.SelectedIndex = 0;
        ddlScheme.SelectedIndex = 0;
        DropDownListPatientState.SelectedIndex = 0;
        lblError.Visible = false;
    }
}