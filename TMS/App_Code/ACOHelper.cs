using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Collections;
using WebGrease.Activities;
using System.IO;
using iText.IO.Image;
using iText.Kernel.Pdf;
using iText.Layout.Element;
using System.Net;
using iText.Layout;
using System.Web.WebPages;

/// <summary>
/// Summary description for ACOHelper
/// </summary>
public class ACOHelper
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private int rowsAffected;
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private DataTable dtTemp = new DataTable();
    private MasterData md = new MasterData();
    private string base64String = "";
    string pageName;
    public DataTable GetProcedureName(int PackageId)
    {
        dt.Clear();
        string query = "SELECT ProcedureId, ProcedureName FROM TMS_MasterPackageDetail WHERE PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(query, con);
        sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
        con.Open();
        sd.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetSpecialityName()
    {
        dt.Clear();
        try
        {
            string Query = "select PackageId, concat(SpecialityName, ' (', SpecialityCode, ')') as SpecialityName from TMS_MasterPackageMaster where IsActive=1 and IsDeleted=0";
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
    public DataTable GetAdmissionDetails(string CaseNo)
    {
        dt.Clear();
        string Query = "SELECT t1.AdmissionType, t1.AdmissionDate, t1.PackageCost, t1.IncentiveAmount, t1.TotalPackageCost, t2.InsurerClaimAmountRequested, t2.TrustClaimAmountRequested, t1.Remarks FROM TMS_PatientAdmissionDetail t1 INNER JOIN TMS_ClaimMaster t2 ON t1.AdmissionId = T2.AdmissionId WHERE t1.CaseNumber = @CaseNo AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(dt);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return dt;
    }
    public DataTable GetTreatmentDischarge(string ClaimId)
    {
        string Query = "SELECT T4.Title as TypeOfMedicalExpertise, T2.Name as DoctorName, T2.RegistrationNumber as DoctorRegistrationNumber, T5.Title as Qualification, T2.MobileNumber as DoctorContactNumber, T2.Name AS AnaesthetistName, T2.RegistrationNumber AS AnaesthetistRegNo, T2.MobileNumber AS AnaesthetistMobNo, T1.IncisionType, T1.OPPhotosWebexTaken, T1.VideoRecordingDone, T1.SwabCountInstrumentsCount, T1.SuturesLigatures, T1.SpecimenRequired, T1.DrainageCount, T1.BloodLoss, T1.PostOperativeInstructions, T1.PatientCondition, T1.ComplicationsIfAny, T1.TreatmentSurgeryStartDate, T1.SurgeryStartTime, T1.SurgeryEndTime, T1.TreatmentGiven, T1.OperativeFindings, T1.PostOperativePeriod, T1.PostSurgeryInvestigationGiven, T1.StatusAtDischarge, T1.Review, T1.Advice, T1.IsDischarged, T1.DischargeDate, T1.NextFollowUpDate, T1.ConsultAtBlock, T1.FloorNo, T1.RoomNo, T1.IsSpecialCase, T6.SpecialCaseValue, T1.FinalDiagnosis, T1.FinalDiagnosisDesc, T1.ProcedureConsent FROM TMS_DischargeDetail T1 LEFT JOIN HEM_HospitalManPowers T2 ON T1.AnesthetistId = T2.Id  LEFT JOIN HEM_MasterMedicalExpertiseSubTypes T4 ON T1.DoctorTypeId = T4.Id LEFT JOIN HEM_MasterQualifications T5 ON T2.QualificationId = T5.Id LEFT JOIN TMS_SpecialCasevalue T6 ON T1.SpecialCaseValue = T6.SpecialCaseId WHERE T1.ClaimId = @ClaimId AND T1.IsActive = 1 AND T1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetTreatmentProtocol(string CaseNo)
    {
        dt.Clear();
        string Query = "SELECT t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, COUNT(t3.ProcedureName) AS Quantity, CASE WHEN t1.ImplantId IS NULL OR t1.ImplantId = 0 THEN 'NA' ELSE t4.ImplantName END AS ImplantName,CASE WHEN t1.StratificationId IS NULL OR t1.StratificationId = 0 THEN 'NA' ELSE t5.StratificationName END AS StratificationName FROM TMS_PatientTreatmentProtocol t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId LEFT JOIN TMS_MasterImplantMaster t4 on t1.ImplantId= t4.ImplantId LEFT JOIN TMS_MasterStratificationMaster t5 on t5.StratificationId=t1.StratificationId INNER JOIN TMS_PatientAdmissionDetail t6 on t6.PatientRegId = t1.PatientRegId WHERE t6.CaseNumber = @CaseNo GROUP BY t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, t1.ImplantId, t4.ImplantName, t1.StratificationId, t5.StratificationName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(dt);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return dt;
    }
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
    public DataTable GetPatientSecondaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dtTemp.Clear();
        string Query = "SELECT t1.Id, t1.PatientRegId, t3.RoleName, t1.PDId, t2.PrimaryDiagnosisName, t2.ICDValue from TMS_PatientSecondaryDiagnosis t1 LEFT JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId LEFT JOIN TMS_Roles t3 ON t1.RegisteredBy = t3.RoleId WHERE t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetPatientPrimaryDiagnosis(string CardNumber, string PatientRegId)
    {
        dt.Clear();
        string Query = "SELECT t1.Id, t1.PatientRegId, t3.RoleName, t2.PrimaryDiagnosisName, t1.PDId, t2.ICDValue from TMS_PatientPrimaryDiagnosis t1 LEFT JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId LEFT JOIN TMS_Roles t3 ON t1.RegisteredBy = t3.RoleId WHERE t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetActionTypes()
    {
        string query = "SELECT [ActionId], [ActionName] FROM [TMS_MasterActionMaster] WHERE [ACO] = 1";
        try
        {
            DataTable dt = new DataTable();
            // Use the existing connection field
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand command = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    dt.Clear(); // Clear any previous data in the shared DataTable
                    adapter.Fill(dt);
                }
            }

            return dt; // Return the shared DataTable
        }
        catch (Exception ex)
        {
            // Log or handle exception as needed
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public DataTable GetAllDistrictsFromMasterDistrict()
    {
        DataTable dt = new DataTable();
        string query = "SELECT Id,Title FROM HEM_MasterDistricts where IsDeleted=0 and IsActive=1";
        try
        {
            // Use the existing connection field
            if (con.State == ConnectionState.Closed)
                con.Open();
            using (SqlCommand command = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dt);
                }
            }
            return dt; // Return the shared DataTable
        }
        catch (Exception ex)
        {
            // Log or handle exception as needed
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public DataTable GetAllHospitalNameList()
    {
        DataTable dt = new DataTable();
        string query = "select HospitalId,HospitalName from HEM_HospitalDetails where IsDeleted=0 and IsActive=1 ORDER BY HospitalName";
        try
        {
            // Use the existing connection field
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand command = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    dt.Clear(); // Clear any previous data in the shared DataTable
                    adapter.Fill(dt);
                }
            }
            return dt; // Return the shared DataTable
        }
        catch (Exception ex)
        {
            // Log or handle exception as needed
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public DataTable GetAllHospitalType()
    {
        DataTable dt = new DataTable();
        string query = "select DISTINCT Id,Title from HEM_MasterHospitalTypes where IsDeleted=0 and IsActive=1 ORDER BY Title";
        try
        {
            // Use the existing connection field
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand command = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    dt.Clear(); // Clear any previous data in the shared DataTable
                    adapter.Fill(dt);
                }
            }
            return dt; // Return the shared DataTable
        }
        catch (Exception ex)
        {
            // Log or handle exception as needed
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public DataTable GetClaimsDetails(string CaseNo)
    {
        DataTable dt = new DataTable();
        string Query = "select t2.TotalPackageCost as PreAuthApprovedAmt, t2.AdmissionDate as PreAuthApprovedDate, t1.CreatedOn as ClaimSubmittedDate, t1.UpdatedOn as ClaimUpdatedDate, t2.TotalPackageCost as ClaimAmount, t1.InsurerClaimAmountRequested as InsuranceLiableAmt, t1.TrustClaimAmountRequested as TrustLiableAmt, t2.TotalPackageCost as BillAmt, t1.Remarks as ClaimRemarks, t1.ClaimId from TMS_ClaimMaster t1 inner join TMS_PatientAdmissionDetail t2 on t1.AdmissionId = t2.AdmissionId where t1.CaseNumber= @CaseNo and t1.IsActive = 1 and t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetNonTechnicalChecklist(long claimId)
    {
        DataTable dt = new DataTable();
        string Query = "SELECT CaseNo, CardNumber, UserId, ClaimId, AddmissionId, IsNameCorrect, IsGenderCorrect, DoesPhotoMatch, AdmissionDateCS, DoesAddDateMatchCS, SurgeryDateCS, DoesSurDateMatchCS, DischargeDateCS, DoesDischDateMatchCS, IsPatientSignVerified, IsReportVerified, IsDateAndNameCorrect, NonTechChecklistRemarks FROM TMS_CEXNonTechChecklist WHERE IsActive = 1 AND ClaimId = claimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", claimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable GetTechnicalChecklist(long claimId)
    {
        DataTable dt = new DataTable();
        string Query = @" SELECT
        t2.TotalPackageCost AS TotalClaims,
        CASE 
            WHEN t5.CaseNumber IS NOT NULL THEN t5.TotalAmtAfterDeduction
            ELSE CONVERT(BIGINT, t1.InsurerClaimAmountApproved)
        END AS [InsurerClaimAmountApproved],
        t1.TrustClaimAmountApproved,
        t3.IsSpecialCase,
        t4.DiagnosisSupportedEvidence,
        t4.EvidenceTherapyConducted,
        t4.CaseManagementSTP,
        t4.MandatoryReports,
		t4.Remarks
    FROM
        TMS_ClaimMaster t1
    LEFT JOIN
        TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId
    LEFT JOIN
        TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId
    LEFT JOIN
        TMS_CPDTechnicalCkecklist t4 ON t2.CardNumber = t4.CardNumber
    LEFT JOIN
        TMS_ClaimAddDeduction t5 ON t1.ClaimId = t5.ClaimId
        AND t5.IsActive = 1 
        AND t5.IsDeleted = 0
        AND t5.RoleId = 7
    WHERE
        t1.ClaimId = @ClaimId
        AND t1.IsActive = 1
        AND t1.IsDeleted = 0;";

        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", claimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetHospitalSearchResults(string hemRefNumber, int? hospitalId, string hospitalType, int? districtId)
    {
        // Define the SQL query
        string query = @"
        SELECT
            t1.HospitalId,
            t1.HospitalName,
            t1.HospitalType,
            t3.Title AS District,
            NULL AS Status,
            NULL AS PaymentActivity
        FROM HEM_Excel_Hospital t1
        LEFT JOIN HEM_HospitalDetails t2 ON t1.BasicHospitalId = t2.HospitalId
        LEFT JOIN HEM_MasterDistricts t3 ON t2.DistrictID = t3.Id
        WHERE (@HemRefNumber IS NULL OR t1.HemRefNumber = @HemRefNumber)
            AND (@HospitalId IS NULL OR t1.BasicHospitalId = @HospitalId)
            AND (@HospitalType IS NULL OR t1.HospitalType = @HospitalType)
            AND (@DistrictId IS NULL OR t3.Id = @DistrictId)
        ORDER BY HospitalName";

        // Create a DataTable to store the results
        DataTable dt = new DataTable();

        try
        {
            // Create a SqlConnection object
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString))
            {
                // Create the SqlCommand object with the query and connection
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Add parameters to the command
                    cmd.Parameters.AddWithValue("@HemRefNumber", string.IsNullOrEmpty(hemRefNumber) ? (object)DBNull.Value : hemRefNumber);
                    cmd.Parameters.AddWithValue("@HospitalId", hospitalId.HasValue ? (object)hospitalId.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@HospitalType", string.IsNullOrEmpty(hospitalType) ? (object)DBNull.Value : hospitalType);
                    cmd.Parameters.AddWithValue("@DistrictId", districtId.HasValue ? (object)districtId.Value : DBNull.Value);

                    // Open the connection
                    con.Open();

                    // Create a SqlDataAdapter to execute the query and fill the DataTable
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);  // Fill the DataTable with the result set
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Handle exceptions, log them or display an error message
            throw new Exception("An error occurred while fetching hospital details.", ex);
        }

        // Return the DataTable
        return dt;
    }

    public DataTable GetClaimWorkFlow(string claimId)
    {
        DataTable dt = new DataTable();
        string Query = "SELECT t1.ActionDate,\r\nt2.RoleName,\r\nt1.Remarks,\r\nt1.ActionTaken,\r\nt1.Amount,\r\nt3.RejectName AS RejectionReason\r\nFROM TMS_PatientActionHistory t1 \r\nLEFT JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId \r\nLEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @claimId";
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
    //public DataTable GetACORemarks(string claimId)
    //{
    //    string query = "SELECT \r\n    t2.TotalPackageCost as TotalClaims,\r\n    CASE \r\n        WHEN t5.CaseNumber IS NOT NULL THEN t5.TotalAmtAfterDeduction\r\n        ELSE CONVERT(BIGINT, t1.TrustClaimAmountApproved)\r\n    END as TrustLiable,\r\n    CASE\r\n        WHEN t5.CaseNumber IS NOT NULL THEN t5.TotalAmtAfterDeduction\r\n        ELSE CONVERT(BIGINT, t1.InsurerClaimAmountApproved)\r\n    END AS InsurerLiable\r\nFROM \r\n    TMS_ClaimMaster t1\r\nINNER JOIN \r\n    TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId\r\nINNER JOIN \r\n    TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId\r\nLEFT JOIN \r\n    TMS_ClaimAddDeduction t5 ON t1.CaseNumber = t5.CaseNumber AND t5.IsActive = 1 AND t5.IsDeleted = 0 and RoleId in (7,8)\r\nWHERE \r\n    t1.ClaimId = @claimId\r\n    AND t1.IsActive = 1\r\n    AND t1.IsDeleted = 0;";
    //    SqlCommand cmd = new SqlCommand(query, con);
    //    cmd.Parameters.AddWithValue("@claimId", claimId);
    //    con.Open();
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    da.Fill(dt);
    //    if (con.State == ConnectionState.Open)
    //    {
    //        con.Close();
    //    }
    //    return dt;
    //}
    public DataTable GetACORemarksFromSP(long claimId, long userId)
    {
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand("TMS_ACO_ACORemarksUpdated", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            // Add parameters for the stored procedure
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ClaimId", claimId);
            //cmd.Parameters.AddWithValue("@RoleId", roleId);
            try
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt); // Fill the DataTable with the results
                }
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
        return dt;
    }
    public DataTable GetDeductionTypesForACO()
    {
        DataTable dt = new DataTable();
        string query = "SELECT DeductionTypeId, DeductionType FROM TMS_MasterDeductionTypeMaster WHERE IsACO = 1";
        try
        {
            // Use the existing connection field
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand command = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    dt.Clear(); // Clear any previous data in the shared DataTable
                    adapter.Fill(dt);
                }
            }
            return dt; // Return the shared DataTable
        }
        catch (Exception ex)
        {
            // Log or handle exception as needed
            throw new Exception("Error fetching action types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public void SaveDeductionAmount(int userId, int roleId, decimal acODeductionAmount, decimal totalFinalAmountByAco, long claimId, string remarks)
    {
        SqlCommand cmd = new SqlCommand("TMS_ACO_InsertDeductionAndUpdateClaimMaster", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@RoleId", roleId);
        //cmd.Parameters.AddWithValue("@ACODeductionAmount", acODeductionAmount);
        cmd.Parameters.AddWithValue("@deductionAmount", acODeductionAmount);
        //cmd.Parameters.AddWithValue("@DeductionType", deductionType);
        cmd.Parameters.AddWithValue("@totalFinalAmountByAco", totalFinalAmountByAco);
        cmd.Parameters.AddWithValue("@ClaimId", claimId);
        cmd.Parameters.AddWithValue("@Remarks", remarks);

        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception("Error while saving deduction amount: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    public void InsertDeductionAmount(int userId, int roleId, decimal acODeductionAmount, decimal totalFinalAmountByAco, long claimId, string remarks)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        // SQL Insert Query
        cmd.CommandText = @"
        INSERT INTO [dbo].[TMS_ClaimAddDeduction]
           ([ClaimId]
           ,[RoleId]
           ,[UserId]
           ,[DeductionAmt]
           ,[TotalAmtAfterDeduction]
           ,[Remarks]
           ,[IsActive]
           ,[IsDeleted]
           ,[CreatedOn]
           ,[UpdatedOn])
     VALUES
           (@ClaimId
           ,@RoleId
           ,@UserId
           ,@DeductionAmount
           ,@TotalAmtAfterDeduction
           ,@Remarks
           ,@IsActive
           ,@IsDeleted
           ,@CreatedOn
           ,@UpdatedOn);
    ";

        // Add parameters for the insert query
        cmd.Parameters.AddWithValue("@ClaimId", claimId);
        //cmd.Parameters.AddWithValue("@CaseNumber", claimId.ToString()); // Assuming you get CaseNumber from elsewhere or it's derived from ClaimId
        cmd.Parameters.AddWithValue("@RoleId", roleId);
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@DeductionAmount", acODeductionAmount); // The deduction amount
        cmd.Parameters.AddWithValue("@TotalAmtAfterDeduction", totalFinalAmountByAco); // The final amount after deduction
        cmd.Parameters.AddWithValue("@Remarks", remarks); // Remarks from the user
        cmd.Parameters.AddWithValue("@IsActive", true); // Assuming record is active by default
        cmd.Parameters.AddWithValue("@IsDeleted", false); // Assuming the record is not deleted by default
        cmd.Parameters.AddWithValue("@CreatedOn", DateTime.Now); // Current date and time for CreatedOn
        cmd.Parameters.AddWithValue("@UpdatedOn", DateTime.Now); // Current date and time for UpdatedOn

        try
        {
            con.Open();
            cmd.ExecuteNonQuery(); // Execute the insert query
        }
        catch (Exception ex)
        {
            throw new Exception("Error while saving deduction amount: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    public void UpdateDeductionAmount(int userId, int roleId, decimal acODeductionAmount, decimal totalFinalAmountByAco, long claimId, string remarks)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        // SQL Update Query to update only the record with the specific RoleId and ClaimId
        cmd.CommandText = @"
    UPDATE [dbo].[TMS_ClaimAddDeduction]
    SET 
        [UserId] = @UserId,
        [DeductionAmt] = @DeductionAmount, 
        [TotalAmtAfterDeduction] = @TotalAmtAfterDeduction,
        [Remarks] = @Remarks,
        [UpdatedOn] = @UpdatedOn
    WHERE 
        [ClaimId] = @ClaimId 
        AND [RoleId] = @RoleId 
        AND [IsDeleted] = 0; -- Ensuring you are not updating deleted records
    ";

        // Add parameters for the update query
        cmd.Parameters.AddWithValue("@ClaimId", claimId);
        cmd.Parameters.AddWithValue("@RoleId", roleId); // Ensure we are updating for the correct RoleId
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@DeductionAmount", acODeductionAmount); // The deduction amount
        cmd.Parameters.AddWithValue("@TotalAmtAfterDeduction", totalFinalAmountByAco); // The final amount after deduction
        cmd.Parameters.AddWithValue("@Remarks", remarks); // Remarks from the user
        cmd.Parameters.AddWithValue("@UpdatedOn", DateTime.Now); // Current date and time for UpdatedOn

        try
        {
            con.Open();
            cmd.ExecuteNonQuery(); // Execute the update query
        }
        catch (Exception ex)
        {
            throw new Exception("Error while updating deduction amount: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    public void UpdateDeductionAmountInClaimMaster( decimal acODeductionAmount, long claimId)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        // SQL Update Query to update only the record with the specific RoleId and ClaimId
        cmd.CommandText = @"
    update TMS_ClaimMaster set TrustClaimAmountDeducted = @DeductionAmount where ClaimId = @ClaimId 
    ";

        // Add parameters for the update query
        cmd.Parameters.AddWithValue("@ClaimId", claimId);
        //cmd.Parameters.AddWithValue("@RoleId", roleId); 
        //cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@DeductionAmount", acODeductionAmount); 
        cmd.Parameters.AddWithValue("@UpdatedOn", DateTime.Now);
        try
        {
            con.Open();
            cmd.ExecuteNonQuery(); // Execute the update query
        }
        catch (Exception ex)
        {
            throw new Exception("Error while updating deduction amount: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
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
    public DataTable GetRejectReason()
    {
        dt.Clear();
        string Query = "select RejectId, RejectName from TMS_MasterRejectReason where IsActive = 1 and IsDeleted = 0";
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
    public DataTable GetQueryReason()
    {
        dt.Clear();
        string Query = "select ReasonId, ReasonName from TMS_MasterQueryReason where IsActive=1 and IsDeleted = 0";
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
    public DataTable GetPreInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
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
        catch (Exception ex)
        {
            throw new Exception("An error occurred while fetching assigned cases", ex);
        }
        finally
        {
            if (con != null)
            {
                con.Close();

            }
        }
    }
    public DataTable GetPostInvestigationDocuments(string HospitalId, string CardNumber, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT t5.HospitalName, t2.SpecialityCode, t2.SpecialityName, t3.ProcedureCode, t3.ProcedureName, t4.InvestigationCode, t4.InvestigationName, t1.UploadStatus, t6.InvestigationStage, t1.FolderName, t1.UploadedFileName, t1.FilePath, t1.CreatedOn from TMS_PatientDocumentPostInvestigation t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId INNER JOIN TMS_MasterInvestigationMaster t4 on t1.PostInvestigationId = t4.InvestigationId INNER JOIN HEM_HospitalDetails t5 on t1.HospitalId = t5.HospitalId LEFT JOIN TMS_MapProcedureInvestigation t6 ON t6.InvestigationId = t1.PostInvestigationId AND t6.PackageId = t1.PackageId AND t6.ProcedureId = t1.ProcedureId WHERE t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t6.InvestigationStage = 'Post'";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
            sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            con.Open();
            sd.Fill(dt);
            con.Close();
            return dt;
        }
        catch (Exception ex)
        {
            throw new Exception("An error occurred while fetching assigned cases", ex);
        }
        finally
        {
            if (con != null)
            {
                con.Close();

            }
        }
    }
    public DataTable getPrimaryDiagnosis(string CardNo, string PatientRegId)
    {
        dt.Clear();
        try
        {
            string Query = "Select t1.ICDValue,t3.RoleName, t2.PrimaryDiagnosisName from TMS_PatientPrimaryDiagnosis t1 LEFT JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId LEFT JOIN TMS_Roles t3 ON t1.RegisteredBy = t3.RoleId WHERE t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNo);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            con.Open();
            sd.Fill(dt);
            con.Close();
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
    public byte[] CreatePdfWithImagesInMemory(List<string> images)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        MemoryStream ms = new MemoryStream();
        PdfWriter pdfWriter = new PdfWriter(ms);
        PdfDocument pdfDocument = new PdfDocument(pdfWriter);
        Document document = new Document(pdfDocument);
        foreach (string image in images)
        {
            if (image.StartsWith("data:image", StringComparison.OrdinalIgnoreCase))
            {
                string base64String = image.Substring(image.IndexOf(",") + 1);
                byte[] imageBytes = Convert.FromBase64String(base64String);
                ImageData imageData = ImageDataFactory.Create(imageBytes);
                document.Add(new Image(imageData));
            }
            else
            {
                WebClient webClient = new WebClient();
                byte[] imageBytes = webClient.DownloadData(image);
                ImageData imageData = ImageDataFactory.Create(imageBytes);
                document.Add(new Image(imageData));
            }
            if (image != images.Last())
            {
                document.Add(new AreaBreak());
            }
        }
        document.Close();
        return ms.ToArray();
    }
    public string DisplayImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }
    public DataTable GetDischargeDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT t4.DocumentName, t2.HospitalName, t2.Address AS HospitalAddress, t3.PatientName, t1.CardNumber, t1.DocumentFor, t1.FolderName, t1.UploadedFileName, t1.UploadStatus, t1.CreatedOn FROM TMS_PatientMandatoryDocument t1 INNER JOIN HEM_HospitalDetails t2 on t2.HospitalId = t1.HospitalId INNER JOIN TMS_PatientRegistration t3 ON t3.PatientRegId = t1.PatientRegId INNER JOIN TMS_MasterDischargeMandatoryDocument t4 ON t4.DocumentId = t1.DocumentId WHERE t1.DocumentFor = 1 AND t1.PatientRegId = @PatientRegId AND t1.HospitalId = @HospitalId AND t1.IsActive = 1";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            con.Open();
            sd.Fill(dt);
            con.Close();
            return dt;
        }
        catch (Exception ex)
        {
            throw new Exception("An error occurred while fetching assigned cases", ex);
        }
        finally
        {
            if (con != null)
            {
                con.Close();

            }
        }
    }
    public DataTable GetManditoryDocuments(string HospitalId, string PatientRegId)
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT t4.DocumentName, t2.HospitalName, t2.Address AS HospitalAddress, t3.PatientName, t1.CardNumber, t1.DocumentFor, t1.FolderName, t1.UploadedFileName, t1.UploadStatus, t1.CreatedOn FROM TMS_PatientMandatoryDocument t1 INNER JOIN HEM_HospitalDetails t2 on t2.HospitalId = t1.HospitalId INNER JOIN TMS_PatientRegistration t3 ON t3.PatientRegId = t1.PatientRegId INNER JOIN TMS_MasterPreAuthMandatoryDocument t4 ON t4.DocumentId = t1.DocumentId WHERE t1.DocumentFor = 1 AND t1.PatientRegId = @PatientRegId AND t1.HospitalId = @HospitalId AND t1.IsActive = 1";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            con.Open();
            sd.Fill(dt);
            con.Close();
            return dt;
        }
        catch (Exception ex)
        {
            throw new Exception("An error occurred while fetching assigned cases", ex);
        }
        finally
        {
            if (con != null)
            {
                con.Close();

            }
        }
    }
    public DataTable getSecondaryDiagnosis(string CardNo, string PatientRegId)
    {
        dt.Clear();
        try
        {
            string Query = "Select t1.ICDValue,t3.RoleName, t2.PrimaryDiagnosisName from TMS_PatientSecondaryDiagnosis t1 LEFT JOIN TMS_MasterPrimaryDiagnosis t2 ON t1.PDId = t2.PDId LEFT JOIN TMS_Roles t3 ON t1.RegisteredBy = t3.RoleId WHERE t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNo);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            con.Open();
            sd.Fill(dt);
            con.Close();
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
    public bool IfSecondaryDiagnosisPresent(string cardNo, string PatientRegId)
    {
        try
        {
            string query = @"Select COUNT(1) From TMS_PatientSecondaryDiagnosis WHERE CardNumber = @CardNumber AND PatientRegId = @PatientRegId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CardNumber", cardNo);
            cmd.Parameters.AddWithValue("@PatientRegId", PatientRegId);

            con.Open();
            int existingRecords = (int)cmd.ExecuteScalar();
            con.Close();

            return existingRecords > 0;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            return false;
        }
    }
    public DataTable GetQuerySubReason(string ReasonId)
    {
        dt.Clear();
        string Query = "select ReasonId,SubReasonId, SubReasonName from TMS_MasterQuerySubReason where ReasonId= @ReasonId and IsActive=1 and IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ReasonId", ReasonId);
        con.Open();
        sd.Fill(dt);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return dt;
    }
    public DataTable GetExistingDeductionAmount(long claimId, int roleId)
    {
        DataTable dt = new DataTable();
        try
        {
            string query = "SELECT DeductionAmt,TotalAmtAfterDeduction, Remarks FROM TMS_ClaimAddDeduction WHERE ClaimId = @ClaimId AND IsDeleted = 0 AND IsActive = 1 AND RoleId = @RoleId";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ClaimId", claimId);
                cmd.Parameters.AddWithValue("@RoleId", roleId);
                con.Open();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);  // Fill the DataTable with the result set
                }
            }
        }
        catch (SqlException ex)
        {
            // Log or handle the SQL exceptions as needed
            throw new Exception("Database error: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
        return dt; // Return the DataTable
    }
    public DataTable GetExistingDeductionAmountfromClaimMaster(long claimId)
    {
        DataTable dt = new DataTable();
        try
        {
            string query = "SELECT TrustClaimAmountDeducted FROM TMS_ClaimMaster WHERE ClaimId = @ClaimId AND IsCPDTrustApproved = 1 AND IsACOTrustApproved=0 AND IsDeleted = 0 AND IsActive = 1 AND TrustClaimAmountDeducted IS NOT NULL AND TrustClaimAmountDeducted > 0;";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ClaimId", claimId);
                //cmd.Parameters.AddWithValue("@RoleId", roleId);
                con.Open();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);  // Fill the DataTable with the result set
                }
            }
        }
        catch (SqlException ex)
        {
            // Log or handle the SQL exceptions as needed
            throw new Exception("Database error: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
        return dt; // Return the DataTable
    }

    public DataTable GetRecociliationCU_Filter(string caseNumber, string beneficiaryCardNumber, DateTime? regFromDate, DateTime? regToDate, int schemeId, int categoryId, int procedureId)
    {
        // Define base query
        string query = @"
                        SELECT 
    t1.CaseNumber,
    t1.ClaimId,
    t1.ClaimNumber As ClaimNo,
    CONCAT('Erroneous Claim ', t4.ActionName, ' by ', t5.RoleName) as CaseStatus, 
    t3.HospitalName,
    t2.AdmissionDate as RegisteredDate,
    t1.TrustClaimAmountRequested as ClaimInitiatedAmount,
    t1.TrustClaimAmountApproved AS ClaimApprovedAmount,
    NULL AS ErroneousAmount,
    NULL AS ErroneousInitiatedAmount,
    t9.AccountNumber As HospitalAccountNo,
    t9.IFSCCode As HospitalIFSCCode,
    t10.TDSExemptPercentage As TDSPercentage,
    CASE 
        WHEN t10.IsCPDTrustApproved = 1 THEN t10.TrustClaimAmountApproved 
        ELSE NULL 
    END AS CPDApprovedAmountTrust,
    t10.TrustClaimAmountApproved As ApprovedAmountTrust,
    t10.TrustTDSAmount As TDSAmountTrust,
    t10.TrustClaimAmountApproved As FinalAmountTrust
FROM TMS_ClaimMaster t1
Left JOIN TMS_PatientAdmissionDetail t2 ON t1.CaseNumber = t2.CaseNumber
Left JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId
Left JOIN TMS_MasterActionMaster t4 ON t1.ForwardActionTrust = t4.ActionId
Left JOIN TMS_Roles t5 ON t1.ForwardedByTrust = t5.RoleId
Left JOIN TMS_PatientTreatmentProtocol t6 ON t2.PatientRegId = t6.PatientRegId
Left JOIN TMS_MasterPackageMaster t7 ON t6.PackageId = t7.PackageId
Left JOIN TMS_MasterPackageDetail t8 ON t6.ProcedureId = t8.ProcedureId
LEFT JOIN HEM_FinancialDetails t9 ON t1.HospitalId = t9.HospitalId
LEFT JOIN TMS_ClaimMaster t10 ON t1.CaseNumber = t10.CardNumber
WHERE 1 = 1";

        // Dynamically add filters to the query based on provided parameters
        if (!string.IsNullOrEmpty(caseNumber))
            query += " AND t2.CaseNumber = @CaseNumber";
        if (!string.IsNullOrEmpty(beneficiaryCardNumber))
            query += " AND t2.CardNumber = @BeneficiaryCardNumber";
        if (regFromDate.HasValue)
            query += " AND t2.AdmissionDate >= @RegFromDate";
        if (regToDate.HasValue)
            query += " AND t2.AdmissionDate <= @RegToDate";
        if (schemeId > 0)
            query += " AND t7.PackageId = @SchemeId";
        if (categoryId > 0)
            query += " AND t8.CategoryId = @CategoryId";
        if (procedureId > 0)
            query += " AND t8.ProcedureId = @ProcedureId";

        SqlCommand cmd = null;
        SqlDataAdapter sd = null;
        DataTable dt = new DataTable();

        try
        {
            // Prepare command with parameters
            cmd = new SqlCommand(query, con);

            // Add parameters if applicable
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

            // Execute the query and fill the dataset
            sd = new SqlDataAdapter(cmd);
            con.Open();
            sd.Fill(dt);
        }
        catch (SqlException ex)
        {
            // Log or handle the SQL exceptions as needed
            throw new Exception("Database error: " + ex.Message);
        }
        finally
        {
            if (sd != null) sd.Dispose();
            if (cmd != null) cmd.Dispose();
            if (con.State == ConnectionState.Open) con.Close();
        }

        return dt;
    }
    public void DeleteDeductionAmount(int userId, int roleId, long claimId)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        // SQL DELETE Query to remove the deduction for the specific ClaimId and RoleId
        cmd.CommandText = @"
    DELETE FROM [dbo].[TMS_ClaimAddDeduction]
    WHERE [ClaimId] = @ClaimId 
    AND [RoleId] = @RoleId
    AND [IsDeleted] = 0; -- Ensure we are not deleting records that are marked as deleted
    ";

        // Add parameters for the delete query
        cmd.Parameters.AddWithValue("@ClaimId", claimId);
        cmd.Parameters.AddWithValue("@RoleId", roleId); // Ensure we are deleting the record for the correct RoleId

        try
        {
            con.Open();
            cmd.ExecuteNonQuery(); // Execute the delete query
        }
        catch (Exception ex)
        {
            throw new Exception("Error while deleting deduction amount: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    public DataTable GetClaimQuery(string ClaimId)
    {
        DataTable dt = new DataTable();
        string Query = "SELECT t1.QueryId, t1.QueryRaisedDate, t1.QueryRasiedByRole, t1.ClaimId, t2.ReasonName, t3.SubReasonName, ISNULL(t1.PpdQuery, 'NA') AS PpdQuery, ISNULL(t1.CpdQuery, 'NA') AS CpdQuery, ISNULL(t1.AcoQuery, 'NA') AS AcoQuery, ISNULL(t1.ShaQuery, 'NA') AS ShaQuery, t1.IsQueryReplied, ISNULL(t1.QueryReply, 'NA') AS QueryReply, t1.QueryFolderName, t1.QueryUploadedFileName, t1.QueryReplyDate FROM TMS_ClaimQuery t1 LEFT JOIN TMS_MasterQueryReason t2 ON t1.ReasonId = t2.ReasonId LEFT JOIN TMS_MasterQuerySubReason t3 ON t1.SubReasonId = t3.SubReasonId WHERE t1.ClaimId = @ClaimId AND t1.IsClaimInitiated = 1 AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    //Case Search Method start here and
    public DataTable GetCaseStatus(string ClaimId)
    {
        DataTable dt = new DataTable();
        string Query = "SELECT TOP 1 ActionTaken FROM TMS_PatientActionHistory WHERE ClaimId = @ClaimId AND IsActive = 1 ORDER BY ActionId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    public DataTable SearchCase(string CaseNumber, string CardNumber, string ClaimNumber, string FromDate, string ToDate)
    {
        string SubQuery = "";

        if (!CaseNumber.IsEmpty())
        {
            SubQuery += "AND t1.CaseNumber = '" + CaseNumber + "' ";
        }
        if (!CardNumber.IsEmpty())
        {
            SubQuery += "AND t1.CardNumber = '" + CardNumber + "' ";
        }
        if (!ClaimNumber.IsEmpty())
        {
            SubQuery += "AND t1.ClaimNumber = '" + ClaimNumber + "' ";
        }
        if (!FromDate.IsEmpty() && !ToDate.IsEmpty())
        {
            SubQuery += "AND t3.RegDate between '" + FromDate + "' AND '" + ToDate + "' ";
        }

        string Query = "SELECT t1.AdmissionId, t2.ClaimId, t1.HospitalId, t3.PatientName, t1.CardNumber, t1.PatientRegId, t1.CaseNumber, t2.ClaimNumber, t1.AdmissionType, t1.AdmissionDate, t2.Remarks, t3.RegDate, t1.DischargeDate, t3.MobileNumber, t4.HospitalName, CONCAT(t4.Address,', ',t4.City,'-',t4.PinCode) AS HospitalAddress, t4.HospitalParentType, t3.Gender, t3.PatientFamilyId, t3.IsAadharVerified, t3.IsBiometricVerified, t5.Title AS State, t6.Title AS District, t3.IsChild, t3.ChildName, t3.ChildGender, t3.ChildFatherName, t3.ChildMotherName, t3.ChildDOB, t3.Age, t3.ImageURL, t3.ChildImageURL FROM TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId LEFT JOIN TMS_PatientRegistration t3 ON t1.PatientRegId = t3.PatientRegId LEFT JOIN HEM_HospitalDetails t4 ON t1.HospitalId = t4.HospitalId LEFT JOIN HEM_MasterStates t5 ON t3.StateId = t5.Id LEFT JOIN HEM_MasterDistricts t6 ON t3.DistrictId = t6.Id WHERE t1.IsActive = 1 AND t1.IsDeleted = 0 " + SubQuery;
        DataTable dt = new DataTable();
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }
    //end here
}