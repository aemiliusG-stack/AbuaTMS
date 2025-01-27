using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class LoginModule
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataTable dtTemp = new DataTable();
    private DataSet ds = new DataSet();
    public DataTable GetSessionValue(string SessionValue)
    {
        string Query = @"if exists(select SessionValue from TMS_Users where SessionValue=@SessionValue)
	                           Begin
	                           	select 1 as Id
	                           End
	                           else
	                           Begin
	                           	select 0 as Id
	                           End";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@SessionValue", SessionValue);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public void UpdateLoginSession(string Username, string IpAddress, string SessionAuthCode, string SessionValue)
    {
        try
        {
            string Query = @"if exists(select UserId from TMS_Users where UserName = @Username)
	                               BEGIN
		                           update TMS_Users set IpAddress = @IpAddress, SessionAuthCode = @SessionAuthCode, SessionValue = @SessionValue where UserName = @Username
	                               END";
            SqlCommand cmd = new SqlCommand(Query, con);
            cmd.Parameters.AddWithValue("@Username", Username.ToString());
            cmd.Parameters.AddWithValue("@IpAddress", IpAddress.ToString());
            cmd.Parameters.AddWithValue("@SessionAuthCode", SessionAuthCode.ToString());
            cmd.Parameters.AddWithValue("@SessionValue", SessionValue.ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception ex)
        {
        }
    }
    public void UpdateLogoutStatus(string IpAddress)
    {
        try
        {
            string Query = "update TMS_Users set IpAddress = '', IsLogin = 0, SessionAuthCode = '', SessionValue = '' where IpAddress = @IpAddress";
            SqlCommand cmd = new SqlCommand(Query, con);
            cmd.Parameters.AddWithValue("@IpAddress", IpAddress.ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception ex)
        {
        }
    }
    public DataTable getMEDCOCaseCount(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "SELECT COUNT(CASE WHEN CurrentAction = 0 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS PreAuthOrReferCase, COUNT(CASE WHEN CurrentAction = 1 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS CasesForTreatmentDischargeAndCancelPatient FROM TMS_PatientRegistration where HospitalId = @HospitalId;";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getMEDCODashboardData(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "SELECT COUNT(CASE WHEN CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS PatientRegistered_Today, COUNT(CASE WHEN CurrentAction = 1 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS PreAuthInitiated_Today, COUNT(CASE WHEN CurrentAction = 2 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS PatientCancelled_Today, COUNT(CASE WHEN CurrentAction = 3 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS PatientRefered_Today, COUNT(CASE WHEN CurrentAction = 4 AND CAST(RegDate AS DATE) = CAST(GETDATE() AS DATE) THEN PatientRegId END) AS ClaimInitiated_Today, COUNT(CASE WHEN CurrentAction = 0 THEN PatientRegId END) AS PatientRegistered_Overall, COUNT(CASE WHEN CurrentAction = 1 THEN PatientRegId END) AS PreAuthInitiated_Overall, COUNT(CASE WHEN CurrentAction = 2 THEN PatientRegId END) AS PatientCancelled_Overall, COUNT(CASE WHEN CurrentAction = 3 THEN PatientRegId END) AS PatientRefered_Overall, COUNT(CASE WHEN CurrentAction = 4 THEN PatientRegId END) AS ClaimInitiated_Overall FROM TMS_PatientRegistration where HospitalId = @HospitalId;";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
}
