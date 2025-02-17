using System;
using System.Drawing;
using System.Web.UI;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class TestNew : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private LoginModule lm = new LoginModule();
    private MasterData md = new MasterData();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMessage.Text = Session["Test"].ToString();
            GenerateCaptcha();
        }
    }

    private void GenerateCaptcha()
    {
        Random random = new Random();
        string captchaCode = random.Next(1000, 9999).ToString(); // Generate a 4-digit random number
        Session["CaptchaCode"] = captchaCode; // Store in session
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string enteredCode = "";
        string storedCode = "";
        try
        {
            enteredCode = txtCaptcha.Text.Trim();
            storedCode = Session["Test"].ToString();
        }
        catch (Exception ex)
        {
            md.InsertErrorLog("1", "Default", ex.Message, ex.StackTrace, ex.GetType().ToString());
            return;
        }
        if (enteredCode == storedCode)
        {
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Captcha verified successfully!";
        }
        else
        {
            lblMessage.ForeColor = Color.Red;
            lblMessage.Text = "Incorrect captcha. Please try again.";
            GenerateCaptcha(); // Generate a new captcha on failure
        }
    }
}