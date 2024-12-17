using System;
using System.Drawing;

public partial class TestNew : System.Web.UI.Page
{
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
        string enteredCode = txtCaptcha.Text.Trim();
        string storedCode = Session["CaptchaCode"].ToString();

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