using CareerPath.DAL;
using System;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Web.Helpers;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private LoginModule lm = new LoginModule();
    private MasterData md = new MasterData();
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (!IsPostBack)
            {
                FillCapctha();
                //SaltedHashing();
                tbUsername.Text = "";
                tbPassword.Text = "";
                txt_Captcha.Text = "";
            }
            tbUsername.Text = tbUsername.Text.ToString().ToUpper();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        FillCapctha();
    }
    public void SendMsg(string mobileno, string sms)
    {
    }
    private void FillCapctha()
    {
        try
        {
            //Random random = new Random();
            //string captchaCode = random.Next(1000, 9999).ToString(); // Generate a 4-digit random number
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            char[] code = new char[6];

            for (int i = 0; i < 6; i++)
            {
                code[i] = chars[random.Next(chars.Length)];
            }
            string captchaCode = new string(code);
            Session["captcha"] = captchaCode; // Store in session
        }
        catch (Exception ex)
        {
            md.InsertErrorLog("", "Login", ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Default.aspx", false);
            return;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlParameter[] p = new SqlParameter[1];
        p[0] = new SqlParameter("@Username", tbUsername.Text);
        p[0].DbType = DbType.String;
        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CheckUsername", p);
        if (con.State == ConnectionState.Open)
            con.Close();
        DataTable dtLoginData = new DataTable();

        if (ds.Tables[0].Rows.Count > 0)
        {
            dtLoginData = ds.Tables[0];
            string userPassword = "";
            userPassword = ds.Tables[0].Rows[0]["UserPassword"] + hdRndNum.Value;
            userPassword = Crypto.SHA256(userPassword.ToString());
            if (userPassword.ToString().ToUpper() == tbPassword.Text.ToUpper())
            {
                //string strIPAddress;
                //string strHostName;
                //strHostName = System.Net.Dns.GetHostName();
                //strIPAddress = System.Net.Dns.GetHostByName(strHostName).AddressList[0].ToString();
                //lm.UpdateLoginSession(tbUsername.Text, strIPAddress.ToString(), _encryptedString.ToString(), Request.Cookies["ASP.NET_SessionId"].Value);

                Session["UserId"] = dtLoginData.Rows[0]["UserId"].ToString();
                Session["Username"] = dtLoginData.Rows[0]["Username"].ToString();
                Session["HospitalId"] = dtLoginData.Rows[0]["HospitalId"].ToString();
                Session["RoleId"] = dtLoginData.Rows[0]["RoleId"].ToString();
                Session["RoleName"] = dtLoginData.Rows[0]["RoleName"].ToString();
                if ((dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "ADMIN"))
                    Response.Redirect("ADMIN/AdminHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "MEDCO")
                    Response.Redirect("MEDCO/MedcoHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "PPD(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "PPD(TRUST)")
                    Response.Redirect("PPD/PPDHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CEX(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CEX(TRUST)")
                    Response.Redirect("CEX/CEXHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CPD(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CPD(TRUST)")
                    Response.Redirect("CPD/CPDHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "ACO(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "ACO(TRUST)")
                    Response.Redirect("ACO/ACOHome.aspx", false);
                else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "SHA(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "SHA(TRUST)")
                    Response.Redirect("SHA/Dashboard.aspx", false);
                else
                    Response.Redirect("Default.aspx");
            }
        }
    }
}