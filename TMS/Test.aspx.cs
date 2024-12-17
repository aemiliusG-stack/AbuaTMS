using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Test : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = con.ToString();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //DataTable dtTemp = new DataTable();
        //dtTemp.Clear();
        //string Query = "select TOP 1 Username from TMS_Users";
        //SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        //con.Open();
        //sd.Fill(dtTemp);
        //con.Close();
        //TextBox1.Text = dtTemp.Rows[0][0].ToString();
        Session["Test"] = TextBox1.Text;
        if (Session["Test"].ToString() == "Rv")
        {
            Response.Redirect("TestNew.aspx");
        }
        else
        {
            Label1.Text = "Invlid Request";
        }
    }
}