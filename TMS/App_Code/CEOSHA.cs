using System;
using System.IO;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Configuration;
using iText.IO.Image;
using iText.Kernel.Pdf;
using iText.Layout.Element;
using System.Net;
using iText.Layout;


public class CEOSHA
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected;
    private string base64String = "";
    private DataTable dtTemp = new DataTable();
    public string DisplayImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }
    public DataTable GetRecociliationClaimUpdation()
    {
        string Query = "SELECT t1.CaseNumber, t1.ClaimNumber, CONCAT(t4.ActionName, ' by ', t5.RoleName) as CaseStatus, t3.HospitalName, t2.AdmissionDate, t2.TotalPackageCost as ClaimInitiatedAmt, (t1.InsurerClaimAmountApproved + t1.TrustClaimAmountApproved) AS ClaimApprovedAmt FROM TMS_ClaimMaster t1 LEFT JOIN TMS_PatientAdmissionDetail t2 ON t1.CaseNumber =t2.CaseNumber LEFT JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId LEFT JOIN TMS_MasterActionMaster t4 ON t1.ForwardActionInsurer = t4.ActionId LEFT JOIN TMS_Roles t5 ON t1.ForwardedByInsurer = t5.RoleId LEFT JOIN  TMS_PatientTreatmentProtocol t6 ON  t2.PatientRegId = t6.PatientRegId WHERE t6.PackageId = 28";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return dt;
    }
    public DataTable GetTreatmentProtocol(string CaseNo)
    {
        string Query = "SELECT t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, COUNT(t3.ProcedureName) AS Quantity, CASE WHEN t1.ImplantId IS NULL OR t1.ImplantId = 0 THEN 'NA' ELSE t4.ImplantName END AS ImplantName,CASE WHEN t1.StratificationId IS NULL OR t1.StratificationId = 0 THEN 'NA' ELSE t5.StratificationName END AS StratificationName FROM TMS_PatientTreatmentProtocol t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId LEFT JOIN TMS_MasterImplantMaster t4 on t1.ImplantId= t4.ImplantId LEFT JOIN TMS_MasterStratificationMaster t5 on t5.StratificationId=t1.StratificationId INNER JOIN TMS_PatientAdmissionDetail t6 on t6.PatientRegId = t1.PatientRegId WHERE t6.CaseNumber = @CaseNo GROUP BY t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, t1.ImplantId, t4.ImplantName, t1.StratificationId, t5.StratificationName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetAdmissionDetails(string CaseNo)
    {
        dt.Clear();
        string Query = "SELECT t2.ClaimMode,  t1.AdmissionType, t1.AdmissionDate, t1.PackageCost, t1.IncentiveAmount, t1.TotalPackageCost, t2.InsurerClaimAmountRequested, t2.TrustClaimAmountRequested, t1.Remarks FROM TMS_PatientAdmissionDetail t1 INNER JOIN TMS_ClaimMaster t2 ON t1.AdmissionId = T2.AdmissionId WHERE t1.CaseNumber = @CaseNo AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetClaimWorkFlow(int claimId)
    {
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t3.RejectName AS RejectionReason FROM TMS_PatientActionHistory t1 LEFT JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @claimId";
        //DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@claimId", claimId);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return dt;
    }
}