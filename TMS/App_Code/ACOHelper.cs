using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Collections;

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
        string Query = "select t2.TotalPackageCost as TotalClaims, t1.InsurerClaimAmountApproved, t1.TrustClaimAmountApproved\r\n, t3.IsSpecialCase from TMS_ClaimMaster t1 inner join TMS_PatientAdmissionDetail t2 on t1.AdmissionId = t2.AdmissionId inner join TMS_DischargeDetail t3 on t1.ClaimId = t3.ClaimId where t1.CaseNumber = @CaseNo and t1.IsActive = 1 and t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
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
    public DataTable GetACORemarks(string claimId)
    {
        string query = "SELECT \r\nt2.TotalPackageCost AS TotalClaims,\r\nISNULL(CONVERT(VARCHAR, t1.TrustClaimAmountApproved), 'NA') AS [Trust Liable]," +
            "\r\nt2.TotalPackageCost AS [Final Approved Amount]\r\nFROM \r\n    TMS_ClaimMaster t1 \r\nINNER JOIN TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId\r\n" +
            "INNER JOIN TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId\r\nWHERE \r\nt1.ClaimId = @claimId\r\nAND t1.IsActive = 1 \r\nAND t1.IsDeleted = 0;";
        SqlCommand cmd = new SqlCommand(query, con);
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
    public void SaveDeductionAmount(int userId, int acODeductionAmount, string caseNo, string remarks)
    {
        SqlCommand cmd = new SqlCommand("ACO_InsertDeductionAndUpdateClaimMaster", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@ACODeductionAmount", acODeductionAmount);
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