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


public class CPD
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
    public DataTable GetAssignedCases(string userId, string caseNumber, string cardNumber, string fromDate, string toDate)
    {
        SqlCommand cmd = new SqlCommand("TMS_CPDGetAssignedCases", con);
        SqlDataAdapter da = null;
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@CaseNumber", string.IsNullOrEmpty(caseNumber) ? (object)DBNull.Value : caseNumber);
            cmd.Parameters.AddWithValue("@CardNumber", string.IsNullOrEmpty(cardNumber) ? (object)DBNull.Value : cardNumber);
            cmd.Parameters.AddWithValue("@FromDate", string.IsNullOrEmpty(fromDate) ? (object)DBNull.Value : fromDate);
            cmd.Parameters.AddWithValue("@ToDate", string.IsNullOrEmpty(toDate) ? (object)DBNull.Value : toDate);
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        catch (Exception ex)
        {
            throw new Exception("An error occurred while fetching assigned cases: " + ex.Message, ex);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            if (cmd != null)
            {
                cmd.Dispose();
            }
            if (da != null)
            {
                da.Dispose();
            }
        }
        return dt;
    }
    public DataTable GetCPDCounts()
    {
        string query = @"
        SELECT 
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByInsurer = 5 AND ForwardedToInsurer = 7 AND CAST(UpdatedOn AS DATE) = CAST(GETDATE() AS DATE)) AS CPDInsurerToday,
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByInsurer = 5 AND ForwardedToInsurer = 7) AS CPDInsurerOverall,
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByTrust = 6 AND ForwardedToTrust = 8 AND CAST(UpdatedOn AS DATE) = CAST(GETDATE() AS DATE)) AS CPDTrustToday,
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByTrust = 6 AND ForwardedToTrust = 8) AS CPDTrustOverall,
	        (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByInsurer = 7 AND ForwardedToInsurer = 7 AND CAST(UpdatedOn AS DATE) = CAST(GETDATE() AS DATE)) AS CPDInsurerTodayAssigned,
	        (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByInsurer = 7 AND ForwardedToInsurer = 7) AS CPDInsurerOverallAssigned,
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByTrust = 8 AND ForwardedToTrust = 8 AND CAST(UpdatedOn AS DATE) = CAST(GETDATE() AS DATE)) AS CPDTrustTodayAssigned,
            (SELECT COUNT(*) FROM TMS_ClaimMaster WHERE ForwardedByTrust = 8 AND ForwardedToTrust = 8) AS CPDTrustOverallAssigned";

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter sd = new SqlDataAdapter(cmd);

        con.Open();
        sd.Fill(ds);
        con.Close();

        dt = ds.Tables[0];
        return dt;
    }

    //public DataTable GetCaseType()
    //{
    //    string Query = "SELECT Id, Title FROM TMS_CaseType WHERE IsActive = 1";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}
    public DataTable GetHospitalName()
    {
        string Query = "select Id, HospitalName from HEM_HospitalDetails";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetCaseStatus()
    {
        dt.Clear();
        string Query = "select CaseStatusId, ClaimStatusId, CaseStatus from TMS_MasterCaseStatus where IsActive = 1 and IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    //public DataTable GetAdvanceSearch()
    //{
    //    string Query = "select Id, Title from TMS_AdvanceSearchParameter";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}

    public DataTable GetCaseSearchTable(string CaseNo)
    {
        dt.Clear();
        string Query = "select b.CaseNumber, b.ClaimNumber,  a.PatientRegId, a.PatientName, a.MobileNumber as ContactNumber, b.CardNumber as BeneficiaryCardNo, c.HospitalName, a.RegDate as PatientRegistrationDate from TMS_PatientRegistration a join TMS_PatientAdmissionDetail b on a.PatientRegId = b.PatientRegId join HEM_HospitalDetails c on a.HospitalId = c.Id where b.CaseNumber = @CaseNo and a.IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    //public DataTable GetNetworkHospitalDetails(string CaseNo)
    //{
    //    dt.Clear();
    //    string Query = @"select t1.HospitalName, t3.Title, t1.Address from HEM_HospitalDetails t1
    //                         inner join  TMS_PatientAdmissionDetail t2 on t1.HospitalId=t2.HospitalId
    //                         inner join HEM_MasterHospitalTypes t3 on t1.HospitalTypeId= t3.Id
    //                         where t2.CaseNumber= @CaseNo and t2.IsActive=1 and t2.IsDeleted=0";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}
    public DataTable GetNetworkHospitalDetails(string CaseNo)
    {
        dt.Clear(); // Clears any existing data in the DataTable
        string Query = @"SELECT t1.HospitalName, t3.Title, t1.Address 
                     FROM HEM_HospitalDetails t1
                     INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.HospitalId = t2.HospitalId
                     INNER JOIN HEM_MasterHospitalTypes t3 ON t1.HospitalTypeId = t3.Id
                     WHERE t2.CaseNumber = @CaseNo AND t2.IsActive = 1 AND t2.IsDeleted = 0";

        try
        {
            // Initialize SqlDataAdapter with query and connection
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            // Add parameter
            sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);

            // Use DataSet directly with the adapter to fill data
            ds.Clear();
            sd.Fill(ds);

            // Ensure we return a valid DataTable
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            // Log or handle exception here
            throw new Exception("An error occurred while fetching network hospital details.", ex);
        }
        finally
        {
            // Ensure connection is closed even if an exception occurs
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }

        return dt;
    }

    public DataTable GetPICDDetails(string CardNo, int PatientRedgNo)
    {
        string Query = " select t1.PDId, t2.ICDValue as ICDCode, t2.PrimaryDiagnosisName as ICDDescription, t3.RoleName as ActedByRole  from TMS_PatientPrimaryDiagnosis t1 INNER JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId INNER JOIN TMS_Users t3 ON t1.RegisteredBy = t3.UserId WHERE t1.PatientRegId = @PatientRedgNo AND t1.CardNumber = @CardNo";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNo", CardNo);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRedgNo", PatientRedgNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetSICDDetails(string CardNo, int PatientRedgNo)
    {
        string Query = " select t1.PDId, t2.ICDValue as ICDCode, t2.PrimaryDiagnosisName as ICDDescription, t3.RoleName as ActedByRole  from TMS_PatientSecondaryDiagnosis t1 INNER JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId INNER JOIN TMS_Users t3 ON t1.RegisteredBy = t3.UserId WHERE t1.PatientRegId = @PatientRedgNo AND t1.CardNumber = @CardNo";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNo", CardNo);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRedgNo", PatientRedgNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetAdmissionDetails(string CaseNo)
    {
        dt.Clear();
        string Query = "SELECT t1.AdmissionType, t1.AdmissionDate, t1.PackageCost, t1.IncentiveAmount, t1.TotalPackageCost, t2.InsurerClaimAmountRequested, t2.TrustClaimAmountRequested, t1.Remarks FROM TMS_PatientAdmissionDetail t1 INNER JOIN TMS_ClaimMaster t2 ON t1.AdmissionId = T2.AdmissionId WHERE t1.CaseNumber = @CaseNo AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetTreatmentProtocol(string CaseNo)
    {
        string Query = "SELECT t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, COUNT(t3.ProcedureName) AS Quantity, CASE WHEN t1.ImplantId IS NULL OR t1.ImplantId = 0 THEN 'NA' ELSE t4.ImplantName END AS ImplantName,CASE WHEN t1.StratificationId IS NULL OR t1.StratificationId = 0 THEN 'NA' ELSE t5.StratificationName END AS StratificationName FROM TMS_PatientTreatmentProtocol t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId LEFT JOIN TMS_MasterImplantMaster t4 on t1.ImplantId= t4.ImplantId LEFT JOIN TMS_MasterStratificationMaster t5 on t5.StratificationId=t1.StratificationId INNER JOIN TMS_PatientAdmissionDetail t6 on t6.PatientRegId = t1.PatientRegId WHERE t6.CaseNumber = @CaseNo GROUP BY t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, t1.ImplantId, t4.ImplantName, t1.StratificationId, t5.StratificationName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetClaimsDetails(string CaseNo)
    {
        dt.Clear();
        string Query = "select t2.TotalPackageCost as PreAuthApprovedAmt, t2.AdmissionDate as PreAuthApprovedDate, t1.CreatedOn as ClaimSubmittedDate, t1.UpdatedOn as ClaimUpdatedDate, t2.TotalPackageCost as ClaimAmount, t1.InsurerClaimAmountRequested as InsuranceLiableAmt, t1.TrustClaimAmountRequested as TrustLiableAmt, t2.TotalPackageCost as BillAmt, t1.Remarks as ClaimRemarks, t1.ClaimId from TMS_ClaimMaster t1 inner join TMS_PatientAdmissionDetail t2 on t1.AdmissionId = t2.AdmissionId where t1.CaseNumber= @CaseNo and t1.IsActive = 1 and t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    //public DataTable GetICHIDetails()
    //{
    //    string Query = "select ProcedureName, ICHICodeGivenByMedco, ICHICodeGivenByPPD, ICHICodeGivenByPPDInsurer, ICHICodeGivenByCPD, ICHICodeGivenByCPDInsurer, ICHICodeGivenBySAFO, ICHICodeGivenByNAFO from TMS_ICHIDetails";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}
    //public DataTable GetCUPreauthWorkFlow()
    //{
    //    string Query = "select t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t1.RejectionReason from TMS_PatientActionHistory t1 inner join  TMS_Roles t2 on t1.ActionTakenBy = t2.RoleId";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}
    public DataTable GetActionType()
    {
        dt.Clear();
        string Query = "select ActionId, ActionName from TMS_MasterActionMaster where IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetRejectReason()
    {
        dt.Clear();
        string Query = "select RejectId, RejectName from TMS_MasterRejectReason where IsActive = 1 and IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetQueryReason()
    {
        dt.Clear();
        string Query = "select ReasonId, ReasonName from TMS_MasterQueryReason where IsActive=1 and IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetQuerySubReason(string ReasonId)
    {
        dt.Clear();
        string Query = "select ReasonId,SubReasonId, SubReasonName from TMS_MasterQuerySubReason where ReasonId= @ReasonId and IsActive=1 and IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ReasonId", ReasonId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetUsersByRole(string RoleId, string UserId)
    {
        dt.Clear();
        string Query = "SELECT UserId, CONCAT(FullName,' '+ RoleName+' ('+Username+')') AS FullName FROM TMS_Users WHERE RoleId = @RoleId AND UserId != @UserId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@RoleId", RoleId);
        sd.SelectCommand.Parameters.AddWithValue("@UserId", UserId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetTriggerType()
    {
        dt.Clear();
        string Query = "SELECT Id, TriggerType FROM TMS_MasterTriggerType WHERE IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetNonTechnicalChecklist(string CaseNo)
    {
        dt.Clear();
        string Query = "SELECT CaseNo, CardNumber, UserId, ClaimId, AddmissionId, IsNameCorrect, IsGenderCorrect, DoesPhotoMatch, AdmissionDateCS, DoesAddDateMatchCS, SurgeryDateCS, DoesSurDateMatchCS, DischargeDateCS, DoesDischDateMatchCS, IsPatientSignVerified, IsReportVerified, IsDateAndNameCorrect, NonTechChecklistRemarks FROM TMS_CEXNonTechChecklist WHERE IsActive = 1 AND CaseNo = @CaseNo";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetTechnicalChecklist(string CaseNo)
    {
        dt.Clear();
        string Query = "select t2.TotalPackageCost as TotalClaims, t1.InsurerClaimAmountApproved, t1.TrustClaimAmountApproved\r\n, t3.IsSpecialCase from TMS_ClaimMaster t1 inner join TMS_PatientAdmissionDetail t2 on t1.AdmissionId = t2.AdmissionId inner join TMS_DischargeDetail t3 on t1.ClaimId = t3.ClaimId where t1.CaseNumber = @CaseNo and t1.IsActive = 1 and t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    //MIS
    public DataTable GetSpecialityName()
    {
        dt.Clear();
        try
        {
            string Query = "select PackageId, SpecialityName from TMS_MasterPackageMaster where IsActive=1 and IsDeleted=0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
        }
        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return dt;
    }
    public DataTable GetPackageMaster(string PackageId, string ProcedureId)
    {
        dt.Clear();
        string Query = "";

        try
        {
            if (!string.IsNullOrEmpty(PackageId) && !string.IsNullOrEmpty(ProcedureId))
            {
                Query = @"SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation 
                FROM TMS_MasterPackageDetail t1 INNER JOIN TMS_MasterPackageMaster t2  ON t1.PackageId = t2.PackageId WHERE  t2.PackageId = @PackageId AND t1.ProcedureId = @ProcedureId";
            }
            else if (!string.IsNullOrEmpty(PackageId))
            {
                Query = @"SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName,t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation 
                FROM TMS_MasterPackageDetail t1 
                INNER JOIN TMS_MasterPackageMaster t2  ON t1.PackageId = t2.PackageId WHERE  t2.PackageId = @PackageId";
            }
            else
            {
                Query = @"SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation 
                FROM TMS_MasterPackageDetail t1 INNER JOIN TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId";
            }

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);

            if (!string.IsNullOrEmpty(PackageId))
            {
                sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
            }
            if (!string.IsNullOrEmpty(ProcedureId))
            {
                sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
            }
            con.Open();
            sd.Fill(dt);
            con.Close();

        }
        catch (SqlException ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return dt;

    }
    public DataTable GetProcedureName(int PackageId)
    {
        dt.Clear();
        string query = "SELECT ProcedureId, ProcedureName FROM TMS_MasterPackageDetail WHERE PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(query, con);
        sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public string GetUserRole(int userId)
    {
        string roleName = string.Empty;
        SqlCommand cmd = new SqlCommand("SELECT RoleName FROM TMS_Users WHERE UserId = @UserId AND IsActive = 1 AND IsDeleted = 0", con);
        cmd.Parameters.AddWithValue("@UserId", userId);
        try
        {
            con.Open();
            roleName = cmd.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {
            throw new Exception("Error while fetching user role: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return roleName;
    }
    public void InsertDeductionAndUpdateClaimMaster(int userId, string deductionType, decimal deductionAmount, decimal totalDeductionAmount, string caseNo, string remarks)
    {
        SqlCommand cmd = new SqlCommand("TMS_CPDInsertDeductionAndUpdateClaimMaster", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@DeductionType", deductionType);
        cmd.Parameters.AddWithValue("@DeductionAmount", deductionAmount);
        cmd.Parameters.AddWithValue("@TotalDeductionAmount", totalDeductionAmount);
        cmd.Parameters.AddWithValue("@CaseNo", caseNo);
        cmd.Parameters.AddWithValue("@Remarks", remarks);
        SqlParameter roleParam = new SqlParameter("@RoleName", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
        cmd.Parameters.Add(roleParam);
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            string roleName = roleParam.Value.ToString();

            if (string.IsNullOrEmpty(roleName))
            {
                throw new Exception("Unrecognized role or user inactive.");
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error while inserting deduction and updating claim master: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    public DataTable GetClaimWorkFlow(string claimId)
    {
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t1.RejectionReason FROM TMS_PatientActionHistory t1 INNER JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId WHERE t1.ClaimId = @claimId";
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
    public DataTable GetClaimQuery(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT t1.QueryId, t1.QueryRaisedDate, t1.QueryRasiedByRole, t1.ClaimId, t2.ReasonName, t3.SubReasonName, t1.Remarks, t1.IsQueryReplied, t1.QueryReply, t1.QueryReplyDate FROM TMS_ClaimQuery t1 inner join TMS_MasterQueryReason t2 ON t1.ReasonId = t2.ReasonId inner join TMS_MasterQuerySubReason t3 ON t1.SubReasonId = t3.SubReasonId WHERE t1.ClaimId = @ClaimId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public void UpdateWorkflowStatus(string CaseNo)
    {
        try
        {
            string query1 = "UPDATE TMS_RecociliationCaseSearch SET IsActive = 0, IsDeleted = 1 WHERE CaseNo = @caseNo";
            string query2 = "INSERT INTO TMS_CasesToACO (Id, CaseNo, ClaimNo, CaseStatus, ClaimInitiatedAmt, ClaimApprovedAmt, ErroneousAmt, ErroneousInitiatedAmt, PatientRegId, IsActive, IsDeleted, CreatedOn, UpdatedOn) SELECT Id, CaseNo, ClaimNo, CaseStatus, ClaimInitiatedAmt, ClaimApprovedAmt, ErroneousAmt, ErroneousInitiatedAmt, PatientRegId, 1 AS IsActive, IsDeleted, CreatedOn, UpdatedOn FROM  TMS_RecociliationCaseSearch WHERE CaseNo = @CaseNo";
            con.Open();
            using (SqlCommand cmd1 = new SqlCommand(query1, con))
            {
                cmd1.Parameters.AddWithValue("@CaseNo", CaseNo);
                cmd1.ExecuteNonQuery();
            }
            using (SqlCommand cmd2 = new SqlCommand(query2, con))
            {
                cmd2.Parameters.AddWithValue("@CaseNo", CaseNo);
                cmd2.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    public DataTable getPrimaryDiagnosis(string CaseNo)
    {
        dtTemp.Clear();
        string Query = "select PDId, PrimaryDiagnosisName, ICDValue from TMS_MasterPrimaryDiagnosis where IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }

    public DataTable GetPatientPrimaryDiagnosis(string CaseNo)
    {
        dtTemp.Clear();
        string query = "select t1.PatientRegId, t3.PrimaryDiagnosisName, t2.PDId, t2.ICDValue " +
                       "from TMS_PatientAdmissionDetail t1 " +
                       "inner join TMS_PatientPrimaryDiagnosis t2 on t1.CardNumber = t2.CardNumber " +
                       "inner join TMS_MasterPrimaryDiagnosis t3 on t2.PDId = t3.PDId " +
                       "where t1.CaseNumber = @CaseNo AND t2.IsActive = 1 AND t2.IsDeleted = 0";

        SqlDataAdapter sd = new SqlDataAdapter(query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public int DeletePrimaryDiagnosis(string CaseNo, int PDId)
    {
        string Query = "DELETE t1 FROM TMS_PatientPrimaryDiagnosis t1 INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.CardNumber = t2.CardNumber WHERE t2.CaseNumber = @CaseNo AND t1.PDId = @PDId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@CaseNo", CaseNo);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public int DeleteSecondaryDiagnosis(string CaseNo, int PDId)
    {
        string Query = "DELETE t1 FROM TMS_PatientSecondaryDiagnosis t1 INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.CardNumber = t2.CardNumber WHERE t2.CaseNumber = @CaseNo AND t1.PDId = @PDId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@CaseNo", CaseNo);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public DataTable getSecondaryDiagnosis(string CaseNo)
    {
        dtTemp.Clear();
        string Query = "select PDId, PrimaryDiagnosisName, ICDValue from TMS_MasterPrimaryDiagnosis where IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetPatientSecondaryDiagnosis(string CaseNo)
    {
        dtTemp.Clear();
        string query = "select t1.PatientRegId, t3.PrimaryDiagnosisName, t2.PDId, t2.ICDValue from TMS_PatientAdmissionDetail t1 inner join TMS_PatientSecondaryDiagnosis t2 on t1.CardNumber = t2.CardNumber inner join TMS_MasterPrimaryDiagnosis t3 on t2.PDId = t3.PDId where t1.CaseNumber = @CaseNo AND t2.IsActive = 1 AND t2.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public void InsertTechnicalChecklist(string caseNumber, string cardNumber, bool diagnosisSupported, bool caseManagementSTP, bool evidenceTherapyConducted, bool mandatoryReports, string remarks)
    {
        string query = "INSERT INTO TMS_CPDTechnicalCkecklist (CaseNumber, CardNumber, DiagnosisSupportedEvidence, CaseManagementSTP, EvidenceTherapyConducted, MandatoryReports, Remarks, IsActive, IsDeleted, CreatedOn, UpdatedOn) " +
                           "VALUES (@CaseNumber, @CardNumber, @DiagnosisSupportedEvidence, @CaseManagementSTP, @EvidenceTherapyConducted, @MandatoryReports, @Remarks, @IsActive, @IsDeleted, @CreatedOn, @UpdatedOn)";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@CaseNumber", caseNumber);
        cmd.Parameters.AddWithValue("@CardNumber", cardNumber);
        cmd.Parameters.AddWithValue("@DiagnosisSupportedEvidence", diagnosisSupported);
        cmd.Parameters.AddWithValue("@CaseManagementSTP", caseManagementSTP);
        cmd.Parameters.AddWithValue("@EvidenceTherapyConducted", evidenceTherapyConducted);
        cmd.Parameters.AddWithValue("@MandatoryReports", mandatoryReports);
        cmd.Parameters.AddWithValue("@Remarks", remarks);
        cmd.Parameters.AddWithValue("@IsActive", 1);
        cmd.Parameters.AddWithValue("@IsDeleted", 0);
        cmd.Parameters.AddWithValue("@CreatedOn", DateTime.Now);
        cmd.Parameters.AddWithValue("@UpdatedOn", DateTime.Now);

        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        con.Close();
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public bool CheckCaseNumberExists(string caseNumber)
    {
        bool exists = false;
        string query = "SELECT COUNT(1) FROM TMS_CPDTechnicalCkecklist WHERE CaseNumber = @CaseNumber";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@CaseNumber", caseNumber);
        try
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            int count = (int)cmd.ExecuteScalar();
            exists = count > 0;
        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }

        return exists;
    }
    public int TransferCase(string CaseNo)
    {
        string Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = 0 WHERE CaseNumber = @CaseNo AND IsActive = 1 AND IsDeleted = 0";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }
    public DataTable GetRecociliationClaimUpdation()
    {
        string Query = "SELECT t1.CaseNumber, t1.ClaimNumber, CONCAT(t4.ActionName, ' by ', t5.RoleName) as CaseStatus, t3.HospitalName, t2.AdmissionDate, (t1.InsurerClaimAmountRequested+t1.TrustClaimAmountRequested) as ClaimInitiatedAmt, (t1.InsurerClaimAmountApproved + t1.TrustClaimAmountApproved) AS ClaimApprovedAmt FROM TMS_ClaimMaster t1 INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.CaseNumber =t2.CaseNumber INNER JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId INNER JOIN TMS_MasterActionMaster t4 ON t1.ForwardActionInsurer = t4.ActionId INNER JOIN TMS_Roles t5 ON t1.ForwardedByInsurer = t5.RoleId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetRecociliationCU_Filter(string caseNumber, string beneficiaryCardNumber, DateTime? regFromDate, DateTime? regToDate, int schemeId, int categoryId, int procedureId)
    {
        string query = @"SELECT t1.CaseNumber, t1.ClaimNumber, CONCAT(t4.ActionName, ' by ', t5.RoleName) as CaseStatus, 
                     t3.HospitalName, t2.AdmissionDate, 
                     (t1.InsurerClaimAmountRequested + t1.TrustClaimAmountRequested) as ClaimInitiatedAmt,
                     (t1.InsurerClaimAmountApproved + t1.TrustClaimAmountApproved) AS ClaimApprovedAmt
                     FROM TMS_ClaimMaster t1
                     INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.CaseNumber = t2.CaseNumber
                     INNER JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId
                     INNER JOIN TMS_MasterActionMaster t4 ON t1.ForwardActionInsurer = t4.ActionId
                     INNER JOIN TMS_Roles t5 ON t1.ForwardedByInsurer = t5.RoleId
                     INNER JOIN TMS_PatientTreatmentProtocol t6 ON t2.PatientRegId = t6.PatientRegId
                     INNER JOIN TMS_MasterPackageMaster t7 ON t6.PackageId = t7.PackageId
                     INNER JOIN TMS_MasterPackageDetail t8 ON t6.ProcedureId = t8.ProcedureId
                     WHERE 1 = 1";

        if (!string.IsNullOrEmpty(caseNumber))
        {
            query += " AND t2.CaseNumber = @CaseNumber";
        }
        if (!string.IsNullOrEmpty(beneficiaryCardNumber))
        {
            query += " AND t2.CardNumber = @BeneficiaryCardNumber";
        }
        if (regFromDate.HasValue)
        {
            query += " AND t2.AdmissionDate >= @RegFromDate";
        }
        if (regToDate.HasValue)
        {
            query += " AND t2.AdmissionDate <= @RegToDate";
        }
        if (schemeId > 0)
        {
            query += " AND t7.PackageId = @SchemeId";
        }
        if (categoryId > 0)
        {
            query += " AND t8.CategoryId = @CategoryId";
        }
        if (procedureId > 0)
        {
            query += " AND t8.ProcedureId = @ProcedureId";
        }
        SqlCommand cmd = null;
        SqlDataAdapter sd = null;
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        try
        {
            cmd = new SqlCommand(query, con);
            if (!string.IsNullOrEmpty(caseNumber))
                cmd.Parameters.AddWithValue("@CaseNumber", caseNumber);
            if (!string.IsNullOrEmpty(beneficiaryCardNumber))
                cmd.Parameters.AddWithValue("@BeneficiaryCardNumber", beneficiaryCardNumber);
            if (regFromDate.HasValue)
                cmd.Parameters.AddWithValue("@RegFromDate", regFromDate.Value);
            if (regToDate.HasValue)
                cmd.Parameters.AddWithValue("@RegToDate", regToDate.Value);
            if (schemeId > 0)
                cmd.Parameters.AddWithValue("@SchemeId", schemeId);
            if (categoryId > 0)
                cmd.Parameters.AddWithValue("@CategoryId", categoryId);
            if (procedureId > 0)
                cmd.Parameters.AddWithValue("@ProcedureId", procedureId);

            sd = new SqlDataAdapter(cmd);
            con.Open();
            sd.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        finally
        {
            if (sd != null)
            {
                sd.Dispose();
            }
            if (cmd != null)
            {
                cmd.Dispose();
            }
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return dt;
    }

    public void ExecuteStoredProcedure(long claimId, long userId, long forwardedToId, long actionId, string remarks)
    {
        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
            cmd = new SqlCommand("TMS_CPDInsertActions", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@ClaimId", claimId);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ForwardedToId", forwardedToId);
            cmd.Parameters.AddWithValue("@ActionId", actionId);
            cmd.Parameters.AddWithValue("@Remarks", remarks);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing stored procedure: " + ex.Message);
        }
        finally
        {
            if (cmd != null)
            {
                cmd.Dispose();
            }

            if (con != null)
            {
                con.Close();
                con.Dispose();
            }
        }
    }
    //Treatment and Discharge
    public DataTable GetSurgeonDetails(string ClaimId)
    {
        string Query = "SELECT t2.TypeOfMedicalExpertise, t2.DoctorName, t2.DoctorRegistrationNumber, t2.Qualification, t2.DoctorContactNumber FROM TMS_DischargeDetail t1 INNER JOIN HEM_Execl_DoctorRegistration t2 ON t1.DoctorId = t2.Sno WHERE t1.ClaimId = @ClaimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetTreatmentDischarge(string ClaimId)
    {
        string Query = "SELECT T3.TypeOfMedicalExpertise, T3.DoctorName, T3.DoctorRegistrationNumber, T3.Qualification, T3.DoctorContactNumber, T2.Name AS AnaesthetistName, T2.RegistrationNumber AS AnaesthetistRegNo, T2.MobileNumber AS AnaesthetistMobNo, T1.IncisionType, T1.OPPhotosWebexTaken, T1.VideoRecordingDone, T1.SwabCountInstrumentsCount, T1.SuturesLigatures, T1.SpecimenRequired, T1.DrainageCount, T1.BloodLoss, T1.PostOperativeInstructions, T1.PatientCondition, T1.ComplicationsIfAny, T1.TreatmentSurgeryStartDate, T1.SurgeryStartTime, T1.SurgeryEndTime, T1.TreatmentGiven, T1.OperativeFindings, T1.PostOperativePeriod, T1.PostSurgeryInvestigationGiven, T1.StatusAtDischarge, T1.Review, T1.Advice, T1.IsDischarged, T1.DischargeDate, T1.NextFollowUpDate, T1.ConsultAtBlock, T1.FloorNo, T1.RoomNo, T1.IsSpecialCase, T1.FinalDiagnosis, T1.ProcedureConsent FROM TMS_DischargeDetail T1 LEFT JOIN HEM_HospitalManPowers T2 ON T1.AnesthetistId = T2.Id LEFT JOIN HEM_Execl_DoctorRegistration T3 ON T1.DoctorId = T3.Sno WHERE T1.ClaimId = @ClaimId AND T1.IsActive = 1 AND T1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public bool UpdateDischarge(string ClaimId, int DischargeStatus, string Remarks)
    {
        string Query = "UPDATE TMS_DischargeDetail SET IsDischarged = @DischargeStatus, Remarks = @Remarks WHERE ClaimId = @ClaimId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ClaimId", ClaimId);
        cmd.Parameters.AddWithValue("@DischargeStatus", DischargeStatus);
        cmd.Parameters.AddWithValue("@Remarks", Remarks);

        try
        {
            con.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            con.Close();
            return rowsAffected > 0; // Return true if at least one row was updated
        }
        catch (Exception ex)
        {
            con.Close(); // Ensure the connection is closed in case of an error
            throw new Exception("Error updating discharge details: {ex.Message}");
        }
    }

    public byte[] CreatePdfWithImagesInMemory(string[] images)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        MemoryStream ms = new MemoryStream();
        PdfWriter pdfWriter = new PdfWriter(ms);
        PdfDocument pdfDocument = new PdfDocument(pdfWriter);
        Document document = new Document(pdfDocument);

        foreach (string image in images)
        {
            WebClient webClient = new WebClient();
            byte[] imageBytes = webClient.DownloadData(image);
            ImageData imageData = ImageDataFactory.Create(imageBytes);

            // Fully qualify the Image class from iText
            iText.Layout.Element.Image pdfImage = new iText.Layout.Element.Image(imageData);
            document.Add(pdfImage);

            if (image != images.Last())
            {
                document.Add(new AreaBreak());
            }
        }
        document.Close();
        return ms.ToArray();
    }
    public DataTable GetManditoryDocuments(string HospitalId, string PatientRegId)
    {
        dt.Clear();
        string Query = "SELECT t4.DocumentName, t2.HospitalName, t2.Address AS HospitalAddress, t3.PatientName, t1.CardNumber, t1.DocumentFor, t1.FolderName, t1.UploadedFileName, t1.UploadStatus, t1.CreatedOn FROM TMS_PatientMandatoryDocument t1 INNER JOIN HEM_HospitalDetails t2 on t2.HospitalId = t1.HospitalId INNER JOIN TMS_PatientRegistration t3 ON t3.PatientRegId = t1.PatientRegId INNER JOIN TMS_MasterPreAuthMandatoryDocument t4 ON t4.DocumentId = t1.DocumentId WHERE t1.PatientRegId = @PatientRegId AND t1.HospitalId = @HospitalId AND t1.IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetPreInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        dt.Clear();
        string Query = "SELECT t5.HospitalName, t2.SpecialityCode, t2.SpecialityName, t3.ProcedureCode, t3.ProcedureName, t4.InvestigationCode, t4.InvestigationName, t1.UploadStatus, t6.InvestigationStage, t1.FolderName, t1.UploadedFileName, t1.FilePath, t1.CreatedOn from TMS_PatientDocumentPreInvestigation t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId INNER JOIN TMS_MasterInvestigationMaster t4 on t1.PreInvestigationId = t4.InvestigationId INNER JOIN HEM_HospitalDetails t5 on t1.HospitalId = t5.HospitalId LEFT JOIN TMS_MapProcedureInvestigation t6 ON t6.InvestigationId = t1.PreInvestigationId AND t6.PackageId = t1.PackageId AND t6.ProcedureId = t1.ProcedureId WHERE t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t6.InvestigationStage = 'Pre'";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    //public byte[] CreatePdfWithImagesInMemory(List<string> images)
    //{
    //    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
    //    MemoryStream ms = new MemoryStream();
    //    PdfWriter pdfWriter = new PdfWriter(ms);
    //    PdfDocument pdfDocument = new PdfDocument(pdfWriter);
    //    Document document = new Document(pdfDocument);
    //    foreach (string image in images)
    //    {
    //        if (image.StartsWith("data:image", StringComparison.OrdinalIgnoreCase))
    //        {
    //            string base64String = image.Substring(image.IndexOf(",") + 1);
    //            byte[] imageBytes = Convert.FromBase64String(base64String);
    //            ImageData imageData = ImageDataFactory.Create(imageBytes);
    //            document.Add(new Image(imageData));
    //        }
    //        else
    //        {
    //            WebClient webClient = new WebClient();
    //            byte[] imageBytes = webClient.DownloadData(image);
    //            ImageData imageData = ImageDataFactory.Create(imageBytes);
    //            document.Add(new Image(imageData));
    //        }
    //        if (image != images.Last())
    //        {
    //            document.Add(new AreaBreak());
    //        }
    //    }
    //    document.Close();
    //    return ms.ToArray();
    //}

}


