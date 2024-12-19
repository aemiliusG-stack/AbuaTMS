using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class ACO_ClaimsUpdateforFraudulentOrPartialAmountCases : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {

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
        tbRegisteredFromDate.Text = "";
        TextBox1.Text = "";
        lblError.Visible = false;
    }
}