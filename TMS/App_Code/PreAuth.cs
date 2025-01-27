using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using AbuaTMS;

public class PreAuth
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dtTemp = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected;
    private string base64String = "";
    public string DisplayImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }
    public bool UploadImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return true;
    }
    public DataTable PreAuthCaseSearch(int HospitalId, int PatientRegId, string CardNumber, int DistrictId, DateTime FromDate, DateTime ToDate)
    {
        dtTemp.Clear();
        string Query = "Select t1.PatientRegId, t1.PatientName, t1.CardNumber, h1.Title, t1.PatientAddress, t1.Gender, t1.Age, FORMAT (t1.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientRegistration t1 INNER JOIN HEM_MasterDistricts h1 ON t1.DistrictId = h1.Id where t1.HospitalId = @HospitalId AND t1.CurrentAction = 0 AND t1.IsReferedBeforePreAuth = 0 AND t1.IsActive = 1 AND t1.IsDeleted = 0 AND (t1.PatientRegId = @PatientRegId OR t1.CardNumber = @CardNumber OR t1.DistrictId = @DistrictId OR t1.RegDate BETWEEN (@FromDate AND @ToDate)) ORDER BY t1.PatientRegId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@DistrictId", DistrictId);
        sd.SelectCommand.Parameters.AddWithValue("@FromDate", FromDate);
        sd.SelectCommand.Parameters.AddWithValue("@ToDate", ToDate);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetRegisteredPatientForPreAuth(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "Select t1.PatientRegId, t1.PatientName, t1.CardNumber, h1.Title, t1.PatientAddress, t1.Gender, t1.Age, FORMAT (t1.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientRegistration t1 INNER JOIN HEM_MasterDistricts h1 ON t1.DistrictId = h1.Id where t1.HospitalId = @HospitalId AND t1.CurrentAction = 0 AND t1.IsReferedBeforePreAuth = 0 AND t1.IsActive = 1 AND t1.IsDeleted = 0 ORDER BY t1.PatientRegId ASC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPrimaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        //AND PDId NOT IN(select PDId from TMS_PatientSecondaryDiagnosis)
        string Query = "select PDId, PrimaryDiagnosisName, ICDValue from TMS_MasterPrimaryDiagnosis where IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getSecondaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        // AND PDId NOT IN(select PDId from TMS_PatientPrimaryDiagnosis)
        string Query = "select PDId, PrimaryDiagnosisName, ICDValue from TMS_MasterPrimaryDiagnosis where IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetPatientPrimaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t1.PatientRegId, t1.RegisteredBy, t2.PrimaryDiagnosisName, t1.PDId, t1.ICDValue from TMS_PatientPrimaryDiagnosis t1 INNER JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId where t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetPatientSecondaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t1.PatientRegId, t1.RegisteredBy, t1.PDId, t2.PrimaryDiagnosisName, t1.ICDValue from TMS_PatientSecondaryDiagnosis t1 INNER JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId where t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public int DeletePrimaryDiagnosis(string CardNumber, string PatientRegId, int PDId)
    {
        string Query = "delete from TMS_PatientPrimaryDiagnosis where CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND PDId = @PDId AND IsActive = 1 AND IsDeleted = 0";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@CardNumber", CardNumber);
        cmd.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public int DeleteSecondaryDiagnosis(string CardNumber, string PatientRegId, int PDId)
    {
        string Query = "delete from TMS_PatientSecondaryDiagnosis where CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND PDId = @PDId AND IsActive = 1 AND IsDeleted = 0";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@CardNumber", CardNumber);
        cmd.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public DataTable getPackageMaster()
    {
        dtTemp.Clear();
        string Query = "Select Packageid, CONCAT(SpecialityCode,' - ', SpecialityName) As SpecialtiyName from TMS_MasterPackageMaster where IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPackageProcedureDetail(int PackageId)
    {
        dtTemp.Clear();
        string Query = "Select ProcedureId, CONCAT(ProcedureCode,' - ', ProcedureName) As ProcedureName from TMS_MasterPackageDetail where PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0 ORDER BY ProcedureName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPreInvestigationDocumentsPackage(int HospitalId, string CardNumber, string PatientRegId)
    {
        DataTable dtDocumentParent = new DataTable();
        string Query = "select DISTINCT t1.PackageId, t1.ProcedureId, t2.SpecialityName from TMS_PatientTreatmentProtocol t1 LEFT JOIN TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        DataSet ds = new DataSet();
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtDocumentParent);
        con.Close();
        return dtDocumentParent;
    }
    public DataTable getPreInvestigationDocumentsProcedure(int HospitalId, string CardNumber, int PatientRegId, int PackageId, int ProcedureId)
    {
        DataTable dtDocumentChild = new DataTable();
        // Dim Query As String = "Select PreInvestigationId, PreInvestigationName from TMS_MasterPackagePreInvestigation where PackageId = @PackageId And ProcedureId = @ProcedureId And IsActive = 1 And IsDeleted = 0"
        string Query = "select t1.PackageId, t1.ProcedureId, t1.PreInvestigationId, t2.InvestigationName, t1.UploadStatus, t1.FolderName, t1.UploadedFileName from TMS_PatientDocumentPreInvestigation t1 LEFT JOIN TMS_MasterInvestigationMaster t2 ON t1.PreInvestigationId = t2.InvestigationId where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.PackageId = @PackageId AND t1.ProcedureId = @ProcedureId AND t1.IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        con.Open();
        sd.Fill(dtDocumentChild);
        con.Close();
        return dtDocumentChild;
    }

    public DataTable getPatientPackageTotalAmount(int HospitalId, string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select DISTINCT HospitalId, CardNumber, PatientRegId, IncentivePercentage, Cast((SUM(iSNULL(ProcedureAmountFinal,0))) as decimal(18,2)) as ProcedureAmount, Cast((SUM(IncentiveAmount)) as decimal(18,2)) as IncentiveAmount, Cast((SUM(IsNUll(TotalPackageCost,0))) as decimal(18,2)) as TotalPackageCost, IncentivePercentage, 0 as checkId from TMS_PatientTreatmentProtocol where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND IsActive = 1 AND IsDeleted = 0 GROUP BY HospitalId, CardNumber,  PatientRegId, IncentivePercentage";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPatientAddedPackage(int HospitalId, string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t1.PatientRegId, t1.PackageId, t1.ProcedureId, t2.SpecialityCode, t2.SpecialityName, t3.ProcedureName, ISNULL(s1.StratificationDetail, 'NA') as StratificationName, ISNULL(l1.ImplantName, 'NA') as ImplantName, t1.ImplantCount, t1.ImplantAmount, t1.ProcedureAmountFinal, t1.PackageCost, t1.TotalPackageCost from TMS_PatientTreatmentProtocol t1 LEFT JOIN TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId LEFT JOIN TMS_MasterPackageDetail t3 ON t1.ProcedureId = t3.ProcedureId LEFT JOIN TMS_MasterStratificationMaster s1 ON t1.StratificationId = s1.StratificationId LEFT JOIN TMS_MasterImplantMaster l1 ON t1.ImplantId = l1.ImplantId where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPatientAddedProcedureForDischarge(int HospitalId, string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t1.PatientRegId, t1.ProcedureId, t2.ProcedureCode, t2.ProcedureName, CONVERT(VARCHAR, TreatmentStartDate, 23) as TreatmentStartDate from TMS_PatientTreatmentProtocol t1 LEFT JOIN TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId where t1.HospitalId = @HospitalId AND t1.PatientRegId = @PatientRegId AND t1.CardNumber = @CardNumber AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public int UpdateTreatmentStartDate(int HospitalId, string CardNumber, string PatientRegId, int ProcedureId, DateTime SurgeryStartDate)
    {
        string Query = "update TMS_PatientTreatmentProtocol SET TreatmentStartDate = @SurgeryStartDate where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND ProcedureId = @ProcedureId AND IsActive = 1 AND IsDeleted = 0;";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@HospitalId", HospitalId);
        cmd.Parameters.AddWithValue("@CardNumber", CardNumber);
        cmd.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@SurgeryStartDate", SurgeryStartDate);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public DataTable checkProcedureDocumentUploadStatus(int HospitalId, string CardNumber, int PatientRegId)
    {
        dtTemp.Clear();
        // Dim Query As String = "Select PreInvestigationId, PreInvestigationName from TMS_MasterPackagePreInvestigation where PackageId = @PackageId And ProcedureId = @ProcedureId And IsActive = 1 And IsDeleted = 0"
        string Query = "select COUNT(PatientPreInvestigationDocumentId) as UploadStatus from TMS_PatientDocumentPreInvestigation where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND UploadStatus = 'Not Uploaded' AND IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable checkMandatoryDocumentUploadStatus(int HospitalId, string CardNumber, int PatientRegId)
    {
        dtTemp.Clear();
        // Dim Query As String = "Select PreInvestigationId, PreInvestigationName from TMS_MasterPackagePreInvestigation where PackageId = @PackageId And ProcedureId = @ProcedureId And IsActive = 1 And IsDeleted = 0"
        string Query = "SELECT CASE WHEN EXISTS (SELECT t1.DocumentId FROM TMS_MasterPreAuthMandatoryDocument t1 LEFT JOIN TMS_PatientMandatoryDocument t2 ON t1.DocumentId = t2.DocumentId AND t2.HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PAtientRegId WHERE t1.IsMandatory = 1 AND t2.UploadStatus IS NULL) THEN 1 ELSE 0 END AS UploadStatus";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetPatientForPreAuthCancellation(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "Select t1.CaseNumber, t1.HospitalId, t1.CardNumber, t1.PatientRegId, t2.PatientName, h1.HospitalName, FORMAT(t2.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_PatientRegistration t2 ON t1.PatientRegId = t2.PatientRegId LEFT JOIN HEM_HospitalDetails h1 ON t1.HospitalId = h1.HospitalId where t1.HospitalId = @HospitalId AND t1.IsPreAuthInitiated = 1 AND t1.IsClaimInitiated = 0 AND t2.IsReferedBeforePreAuth = 0 AND t1.IsActive = 1 AND t1.IsDeleted = 0 ORDER BY t1.PatientRegId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetRegisteredPatientForReferal(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "Select t1.PatientRegId, t1.PatientName, t1.CardNumber, h1.Title, t1.PatientAddress, t1.Gender, t1.Age, FORMAT (t1.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientRegistration t1 INNER JOIN HEM_MasterDistricts h1 ON t1.DistrictId = h1.Id where t1.HospitalId = @HospitalId AND t1.CurrentAction = 0 AND t1.IsReferedBeforePreAuth = 0 AND t1.IsActive = 1 AND t1.IsDeleted = 0 AND t1.PatientRegId NOT IN (select PatientRegId from TMS_PatientTreatmentProtocol where HospitalId = @HospitalId) ORDER BY t1.PatientRegId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable checkPatientToReferBeforePreAuth(int HospitalId, string CardNumber, int PatientRegId, int ReferedHospitalId)
    {
        dtTemp.Clear();
        string Query = "select TreatmentId from TMS_PatientTreatmentProtocol where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        sd.SelectCommand.Parameters.AddWithValue("@ReferedHospitalId", ReferedHospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public int ReferPatientBeforePreAuth(int HospitalId, string CardNumber, int PatientRegId, int ReferedHospitalId)
    {
        dtTemp.Clear();
        string Query = "update TMS_PatientRegistration SET IsReferedBeforePreAuth = 1, ReferedHospitalId = @ReferedHospitalId, IsActive = 0, UpdatedOn = GETDATE() where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId AND IsReferedBeforePreAuth = 0 AND IsActive = 1 AND IsDeleted = 0; update TMS_PatientRegistration SET CurrentAction = 3, UpdatedOn = GETDATE() where HospitalId = @HospitalId AND CardNumber = @CardNumber AND PatientRegId = @PatientRegId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@HospitalId", HospitalId);
        cmd.Parameters.AddWithValue("@CardNumber", CardNumber);
        cmd.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        cmd.Parameters.AddWithValue("@ReferedHospitalId", ReferedHospitalId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    //Discharge
    public DataTable GetPatientForDischarge(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "Select t1.PatientRegId, t1.AdmissionId, t1.AdmissionDate, t1.ClaimId, t1.CaseNumber, t2.ClaimNumber, t3.PatientName, t1.CardNumber, 'PPD Approved' as CaseStatus, h1.HospitalName, FORMAT (t3.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.AdmissionId = t2.AdmissionId AND t1.ClaimId = t2.ClaimId LEFT JOIN TMS_PatientRegistration t3 ON t1.PatientRegId = t3.PatientRegId LEFT JOIN HEM_HospitalDetails h1 ON t1.HospitalId = h1.HospitalId where t1.HospitalId = @HospitalId AND t1.IsClaimInitiated = 0 AND t1.IsDischarged = 0 AND t1.DischargeId = 0 AND ((ClaimMode = 1 AND t2.ForwardedToInsurer = 2 AND IsPPDInsurerApproved = 1) OR (ClaimMode = 2 AND t2.ForwardedToTrust = 2 AND IsPPDTrustApproved = 1) OR (ClaimMode = 3 AND t2.ForwardedToInsurer = 2 AND t2.ForwardedToTrust = 2 AND IsPPDInsurerApproved = 1 AND IsPPDTrustApproved = 1)) AND t3.CurrentAction = 1 AND t3.IsReferedBeforePreAuth = 0 AND t1.IsActive = 1 AND t1.IsDeleted = 0 ORDER BY t1.AdmissionId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetSpecialCaseValue()
    {
        try
        {
            dtTemp.Clear();
            string Query = "Select SpecialCaseId, SpecialCaseValue from TMS_SpecialCaseValue where IsActive = 1 AND IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dtTemp = ds.Tables[0];
            return dtTemp;
        }
        catch (Exception ex)
        {
            return dtTemp;
        }
    }

    public DataTable GetPatientManditoryDocument(string CardNumber)
    {
        dtTemp.Clear();
        string Query = "SELECT DocumentId, DocumentFor, FolderName, UploadedFileName, UploadStatus FROM TMS_PatientMandatoryDocument WHERE CardNumber = @CardNumber AND IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dtTemp = ds.Tables[0];
        return dtTemp;
    }
    public DataTable GetClaimWorkFlow(int ClaimId)
    {
        dtTemp.Clear();
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, IsNULL(t3.RejectName, 'NA') as RejectName FROM TMS_PatientActionHistory t1 LEFT JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @ClaimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dtTemp = ds.Tables[0];
        return dtTemp;
    }
    // Added By Nirmal
    // Preauth Query Reply
    public DataTable GetQueryCases(int HospitalId)
    {
        dtTemp.Clear();
        string Query = "Select t1.PatientRegId, t1.AdmissionId, t1.AdmissionDate, t1.ClaimId, t1.CaseNumber, t2.ClaimNumber, t3.PatientName, t1.CardNumber, 'Query Raised By PPD' as CaseStatus, h1.HospitalName, FORMAT (t3.RegDate, 'dd-MMM-yyyy ') as RegDate from TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.AdmissionId = t2.AdmissionId AND t1.ClaimId = t2.ClaimId LEFT JOIN TMS_PatientRegistration t3 ON t1.PatientRegId = t3.PatientRegId LEFT JOIN HEM_HospitalDetails h1 ON t1.HospitalId = h1.HospitalId where t1.HospitalId = @HospitalId AND t1.IsClaimInitiated = 0 AND t1.IsDischarged = 0 AND t1.IsQueryRaised = 1 AND t1.IsActive = 1 AND t1.IsDeleted = 0 ORDER BY t1.AdmissionId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }

    public void PreAuthReply(string QueryId, string Remarks, string QueryFolderName, string QueryUploadedFileName, string QueryFilePath)
    {
        string Query = "update TMS_ClaimQuery SET QueryFolderName = @QueryFolderName, QueryUploadedFileName = @QueryUploadedFileName, QueryFilePath = @QueryFilePath, IsQueryReplied = 1, QueryReply = @Remarks, QueryReplyDate = GETDATE(), UpdatedOn = GETDATE() WHERE QueryId = @QueryId AND IsActive = 1";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@QueryId", QueryId);
        cmd.Parameters.AddWithValue("@Remarks", Remarks);
        cmd.Parameters.AddWithValue("@QueryFolderName", QueryFolderName);
        cmd.Parameters.AddWithValue("@QueryUploadedFileName", QueryUploadedFileName);
        cmd.Parameters.AddWithValue("@QueryFilePath", QueryFilePath);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

}
