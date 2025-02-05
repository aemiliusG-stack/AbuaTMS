using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Collections;
using WebGrease.Activities;

/// <summary>
/// Summary description for ACOHelper
/// </summary>
public class ACOHelper
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected;
    private MasterData md = new MasterData();
    private string base64String = "";
    string pageName;
    public DataTable GetActionTypes()
    {
        string query = "SELECT [ActionId], [ActionName] FROM [TMS_MasterActionMaster] WHERE [ACO] = 1";
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
        string Query = "SELECT\r\n    t2.TotalPackageCost AS TotalClaims,\r\n    CASE \r\n        WHEN t5.CaseNumber IS NOT NULL THEN t5.TotalAmtAfterDeduction\r\n        ELSE CONVERT(BIGINT, t1.InsurerClaimAmountApproved)\r\n    END AS [InsurerClaimAmountApproved],\r\n    t1.TrustClaimAmountApproved,\r\n    t3.IsSpecialCase,\r\n    t4.DiagnosisSupportedEvidence,\r\n    t4.EvidenceTherapyConducted,\r\n    t4.CaseManagementSTP,\r\n    t4.MandatoryReports\r\nFROM\r\n    TMS_ClaimMaster t1\r\nINNER JOIN\r\n    TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId\r\nINNER JOIN\r\n    TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId\r\nINNER JOIN\r\n    TMS_CPDTechnicalCkecklist t4 ON t2.CardNumber = t4.CardNumber\r\nLEFT JOIN\r\n    TMS_ClaimAddDeduction t5 ON t1.CaseNumber = t5.CaseNumber\r\n    AND t5.IsActive = 1 \r\n    AND t5.IsDeleted = 0\r\n\tAND t5.RoleId=7\r\nWHERE\r\n    t1.CaseNumber = @CaseNo\r\n    AND t1.IsActive = 1\r\n    AND t1.IsDeleted = 0;";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    //public DataTable GetTechnicalChecklist(string CaseNo)
    //{
    //    dt.Clear();
    //    string Query = @"
    //    SELECT 
    //        CASE 
    //            WHEN t5.Id IS NOT NULL THEN t5.TotalAmtAfterDeduction
    //            ELSE t2.TotalPackageCost
    //        END AS TotalClaims,
    //        t1.InsurerClaimAmountApproved,
    //        t1.TrustClaimAmountApproved,
    //        t3.IsSpecialCase,
    //        t4.DiagnosisSupportedEvidence,
    //        t4.EvidenceTherapyConducted,
    //        t4.CaseManagementSTP,
    //        t4.MandatoryReports
    //    FROM
    //        TMS_ClaimMaster t1
    //    INNER JOIN 
    //        TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId 
    //    INNER JOIN 
    //        TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId 
    //    INNER JOIN 
    //        TMS_CPDTechnicalCkecklist t4 ON t2.CardNumber = t4.CardNumber
    //    LEFT JOIN 
    //        TMS_ClaimAddDeduction t5 ON t1.CaseNumber = t5.CaseNumber 
    //        AND t5.IsActive = 1 
    //        AND t5.IsDeleted = 0
    //    WHERE 
    //        t1.CaseNumber = @CaseNo 
    //        AND t1.IsActive = 1 
    //        AND t1.IsDeleted = 0";

    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}
    public DataTable GetClaimWorkFlow(string claimId)
    {
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
        using (SqlCommand cmd = new SqlCommand("TMS_ACO_ACORemarks", con))
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
    public void SaveDeductionAmount(int userId, int roleId, decimal acODeductionAmount, decimal totalFinalAmountByAco, string caseNo, string remarks, string deductionType)
    {
        SqlCommand cmd = new SqlCommand("TMS_ACO_InsertDeductionAndUpdateClaimMaster", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@RoleId", roleId);
        //cmd.Parameters.AddWithValue("@ACODeductionAmount", acODeductionAmount);
        cmd.Parameters.AddWithValue("@deductionAmount", acODeductionAmount);
        cmd.Parameters.AddWithValue("@DeductionType", deductionType);
        cmd.Parameters.AddWithValue("@totalFinalAmountByAco", totalFinalAmountByAco);
        cmd.Parameters.AddWithValue("@CaseNo", caseNo);
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
}