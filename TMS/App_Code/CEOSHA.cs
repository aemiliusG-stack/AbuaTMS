using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;


public class CEOSHA
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected;
    private string base64String = "";
    private DataTable dtTemp = new DataTable();
    public DataTable GetRecociliationClaimUpdation()
    {
        string Query = "SELECT t1.CaseNumber, t1.ClaimNumber, CONCAT(t4.ActionName, ' by ', t5.RoleName) as CaseStatus, t3.HospitalName, t2.AdmissionDate, (t1.InsurerClaimAmountRequested+t1.TrustClaimAmountRequested) as ClaimInitiatedAmt, (t1.InsurerClaimAmountApproved + t1.TrustClaimAmountApproved) AS ClaimApprovedAmt FROM TMS_ClaimMaster t1 INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.CaseNumber =t2.CaseNumber INNER JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId INNER JOIN TMS_MasterActionMaster t4 ON t1.ForwardActionInsurer = t4.ActionId INNER JOIN TMS_Roles t5 ON t1.ForwardedByInsurer = t5.RoleId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        dt = ds.Tables[0];
        return dt;
    }
}