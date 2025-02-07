
using CareerPath.DAL;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class SHAHelper
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();

    public DataTable GetShaCases()
    {
        try
        {
            string query = "SELECT t2.ClaimId, t2.AdmissionId, t2.CaseNumber, t2.ClaimNumber, t2.CardNumber, t3.HospitalName, t4.RegDate, t1.DischargeDate, t5.AccountNumber, t5.IFSCCode, t5.TDSExemption, t5.IsTDSApplicable, t5.TDSExemptionPercent, t1.TotalPackageCost AS ClaimInitaiteAmount, t2.InsurerClaimAmountRequested AS InsurerAmount, t2.InsurerClaimAmountApproved AS InsurerApprovedAmount, t2.InsurerClaimAmountDeducted AS InsurerDeductedAmount, t2.TrustClaimAmountRequested AS TrsutAmount, t2.TrustClaimAmountApproved AS TrustApprovedAmount, t2.TrustClaimAmountDeducted AS TrustDeductedAmount FROM TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId LEFT JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId LEFT JOIN TMS_PatientRegistration t4 ON t1.PatientRegId = t4.PatientRegId LEFT JOIN HEM_FinancialDetails t5 ON t3.HospitalId = t5.HospitalId WHERE (t2.ClaimMode = 1 AND t2.ForwardActionInsurer = 2 AND t2.ForwardedByInsurer = 9 AND t2.ForwardedToInsurer = 11 AND t2.IsACOInsurerApproved = 1) OR (t2.ClaimMode = 2 AND t2.ForwardActionTrust = 2 AND t2.ForwardedByTrust = 10 AND t2.ForwardedToTrust = 12 AND t2.IsACOTrustApproved = 1) OR (t2.ClaimMode = 3 AND t2.ForwardActionInsurer = 2 AND t2.ForwardedByInsurer = 9 AND t2.ForwardedToInsurer = 11 AND t2.ForwardActionTrust = 2 AND t2.ForwardedByTrust = 10 AND t2.ForwardedToTrust = 12 AND t2.IsACOInsurerApproved = 1 AND t2.IsACOTrustApproved = 1) AND t1.IsActive = 1 AND t1.IsDeleted = 0";
            if (con.State == ConnectionState.Closed)
                con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            dt.Clear();
            adapter.Fill(dt);
            return dt;
        }
        catch (Exception ex)
        {
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
}


