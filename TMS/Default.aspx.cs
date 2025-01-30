using System;
using System.Data;
using System.Data.SqlClient;
using CareerPath.DAL;
using System.Web;
using System.Web.Helpers;
using System.Configuration;
using System.Web.UI;


partial class _Default : System.Web.UI.Page
{
    private string strMessage;
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
            md.InsertErrorLog("", "Default", ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Default.aspx", false);
            return;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextboxValidation.isAlphaNumeric(tbUsername.Text) == false || TextboxValidation.IsPassword(tbPassword.Text) == false || TextboxValidation.isAlphaNumeric(txt_Captcha.Text) == false)
            {
                string strMessage = "window.alert('Invalid Entry!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "AlertMessage", strMessage, true);
                return;
            }
            //AntiForgery.Validate();

            if (Session["captcha"].ToString().Trim() != txt_Captcha.Text.Trim())
            {
                strMessage = "window.alert('Invalid Captcha!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                txt_Captcha.Text = string.Empty;
                FillCapctha();
                return;
            }
            string sessionValue = Request.Cookies["ASP.NET_SessionId"].Value;
            dt.Clear();
            dt = lm.GetSessionValue(sessionValue.ToString());
            if (dt.Rows[0]["Id"].ToString() != "0")
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else
            {
            }
            //Checking user exists or not
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
                bool blnActive = Convert.ToBoolean(ds.Tables[0].Rows[0]["Isactive"]);
                bool blnLogin = Convert.ToBoolean(ds.Tables[0].Rows[0]["IsLogin"]);
                if (blnActive == false)
                {
                    strMessage = "window.alert('User is InActive!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    FillCapctha();
                    return;
                }
                if (blnLogin == true)
                {
                    strMessage = "window.alert('User is Logged in, Please LogOut First, Thankyou.!');";
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    FillCapctha();
                    return;
                }
                string userPassword = "";
                userPassword = ds.Tables[0].Rows[0]["UserPassword"] + hdRndNum.Value;
                userPassword = Crypto.SHA256(userPassword.ToString());
                if (userPassword.ToString().ToUpper() == tbPassword.Text.ToUpper())
                {
                    string strIPAddress;
                    string strHostName;
                    strHostName = System.Net.Dns.GetHostName();
                    strIPAddress = System.Net.Dns.GetHostByName(strHostName).AddressList[0].ToString();
                    if (strIPAddress == null)
                        strIPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    SqlParameter[] pIp = new SqlParameter[1];
                    pIp[0] = new SqlParameter("@IpAddress", strIPAddress.ToString());
                    pIp[0].DbType = DbType.String;
                    ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_CheckIpAddress", pIp);
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    if (ds.Tables[0].Rows[0][0].ToString() == "1")
                    //    {
                    //        strMessage = "window.alert('You are blocked for some security reasons!');";
                    //        ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                    //        return;
                    //    }
                    //}

                    strHostName = System.Net.Dns.GetHostName();
                    strIPAddress = System.Net.Dns.GetHostByName(strHostName).AddressList[0].ToString();
                    Guid guid = new Guid();
                    guid = System.Guid.NewGuid();
                    string UserId = guid.ToString();
                    string _browserInfo = Request.Browser.Browser + Request.Browser.Version + Request.UserAgent + "~" + Request.ServerVariables["REMOTE_ADDR"];
                    string _sessionValue = _browserInfo + "^" + strIPAddress.ToString();
                    byte[] _encodeAsBytes = System.Text.ASCIIEncoding.ASCII.GetBytes(_sessionValue);
                    string _encryptedString = System.Convert.ToBase64String(_encodeAsBytes);

                    lm.UpdateLoginSession(tbUsername.Text, strIPAddress.ToString(), _encryptedString.ToString(), Request.Cookies["ASP.NET_SessionId"].Value);

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
<<<<<<< Updated upstream
                    else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "ACS")
                        Response.Redirect("ACS/ACSHome.aspx", false);
=======
                    else if (dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CEO_SHA(INSURER)" || dtLoginData.Rows[0]["RoleName"].ToString().ToUpper() == "CEO_SHA(TRUST)")
                        Response.Redirect("CEO_SHA/CEOSHAHome.aspx", false);
>>>>>>> Stashed changes
                    else
                        Response.Redirect("Default.aspx");
                }
                else
                {
                    strMessage = "window.alert('Incorrect Password!');";
                    FillCapctha();
                    ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                }
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog("", "Default", ex.Message, ex.StackTrace, ex.GetType().ToString());
            ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", ex.ToString(), true);
            FillCapctha();
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();
            Response.AppendHeader("Cache-Control", "no-store");
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            Response.Cookies.Add(new HttpCookie("__AntiXsrfToken", ""));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Redirect("~/Default.aspx", false);
            return;
        }
    }
}
