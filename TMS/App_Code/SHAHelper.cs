
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

    public DataTable GetActionTypes()
    {
        string query = "SELECT [ActionId], [ActionName] FROM [TMS_MasterActionMaster] WHERE [SHA] = 1";
        try
        {
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    dt.Clear();
                    adapter.Fill(dt);
                }
            }
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

    public DataTable GetSHARemarksFromSP(long claimId, long userId)
    {
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand("TMS_SHA_ACORemarks", con))
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
    private DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
    {
        DataTable dt = new DataTable();
        try
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing query: " + ex.Message);
        }
        return dt;
    }

    /// <summary>
    /// Executes a non-query command (e.g., Insert, Update, Delete).
    /// </summary>
    private void ExecuteNonQuery(SqlCommand cmd)
    {
        try
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing command: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    //public DataTable GetSHARemarks(string claimId)
    //{
    //    string query = @"SELECT 
    //                    t2.TotalPackageCost AS TotalClaims,
    //                    t1.TrustClaimAmountApproved AS TrustLiable,
    //                    COALESCE(t5.TotalAmtAfterDeduction, CONVERT(BIGINT, t2.TotalPackageCost)) AS FinalApprovedAmount
    //                FROM TMS_ClaimMaster t1
    //                INNER JOIN TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId
    //                INNER JOIN TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId
    //                LEFT JOIN TMS_ClaimAddDeduction t5 ON t1.CaseNumber = t5.CaseNumber AND t5.IsActive = 1 AND t5.IsDeleted = 0
    //                WHERE t1.ClaimId = @claimId AND t1.IsActive = 1 AND t1.IsDeleted = 0;";

    //    SqlParameter[] parameters = { new SqlParameter("@claimId", claimId) };

    //    // Call ExecuteQuery within the helper class where it is defined
    //    return ExecuteQuery(query, parameters);
    //}


    //public DataTable GetClaimWorkflow(string claimId)
    //{
    //    string query = @"SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, 
    //                           t3.RejectName AS RejectionReason
    //                    FROM TMS_PatientActionHistory t1
    //                    LEFT JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId
    //                    LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId
    //                    WHERE t1.ClaimId = @ClaimId";
    //    SqlParameter[] parameters = { new SqlParameter("@ClaimId", claimId) };
    //    return con.ExecuteQuery(query, parameters);
    //}

   


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



    public DataTable GetNonTechnicalChecklist(long claimId)
    {
        dt.Clear();
        string Query = "SELECT CaseNo, CardNumber, UserId, ClaimId, AddmissionId, IsNameCorrect, IsGenderCorrect, DoesPhotoMatch, AdmissionDateCS, DoesAddDateMatchCS, SurgeryDateCS, DoesSurDateMatchCS, DischargeDateCS, DoesDischDateMatchCS, IsPatientSignVerified, IsReportVerified, IsDateAndNameCorrect, NonTechChecklistRemarks FROM TMS_CEXNonTechChecklist WHERE IsActive = 1 AND ClaimId = claimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", claimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetTechnicalChecklist(long claimId)
    {
        dt.Clear();
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
    INNER JOIN
        TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId
    INNER JOIN
        TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId
    INNER JOIN
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
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetClaimWorkFlow(int claimId)
    {
        DataTable dt = new DataTable();
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t3.RejectName AS RejectionReason " +
                       "FROM TMS_PatientActionHistory t1 " +
                       "LEFT JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId " +
                       "LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId " +
                       "WHERE t1.ClaimId = @claimId";
        using (SqlCommand cmd = new SqlCommand(Query, con))
        {
            cmd.Parameters.AddWithValue("@claimId", claimId);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
        }
        return dt;
    }

    public DataTable GetACORemarks(string claimId)
    {
        string query = "SELECT \r\n    t2.TotalPackageCost AS TotalClaims,\r\n    t1.TrustClaimAmountApproved AS TrustLiable,\r\n    t2.TotalPackageCost AS [Final Approved Amount] -- No deduction logic\r\nFROM \r\n    TMS_ClaimMaster t1\r\nINNER JOIN \r\n    TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId\r\nINNER JOIN \r\n    TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId\r\nWHERE \r\n    t1.ClaimId = @claimId\r\n    AND t1.IsActive = 1\r\n    AND t1.IsDeleted = 0;\r\n";
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
    public DataTable GetSHARemarks(string claimId)
    {
        string query = "SELECT \r\n    t2.TotalPackageCost AS TotalClaims,\r\n    t1.TrustClaimAmountApproved AS TrustLiable,\r\n    t2.TotalPackageCost AS [Final Approved Amount] -- No deduction logic\r\nFROM \r\n    TMS_ClaimMaster t1\r\nINNER JOIN \r\n    TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId\r\nINNER JOIN \r\n    TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId\r\nWHERE \r\n    t1.ClaimId = @claimId\r\n    AND t1.IsActive = 1\r\n    AND t1.IsDeleted = 0;\r\n";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@claimId", claimId);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        dt.Clear();

        // Open the connection, execute the query, and fill the DataTable
        con.Open();
        da.Fill(dt);

        // Close the connection if it's still open
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }

        return dt;
    }
    public void SaveSHARemarksAndDeduction(string caseNo, long userId, long roleId, decimal finalAmount, decimal deductionAmount)
    {
        string storedProcedure = "SHA_InsertDeductionAndUpdateClaimMaster";
        SqlParameter[] parameters = {
        new SqlParameter("@UserId", userId),
        new SqlParameter("@RoleId", roleId),
        new SqlParameter("@totalFinalAmountBySha", finalAmount),
        new SqlParameter("@deductionAmount", deductionAmount),
       
        new SqlParameter("@CaseNo", caseNo),
       // new SqlParameter("@Remarks", remarks)
    };

        // Use a SqlCommand to call the stored procedure
        using (SqlCommand cmd = new SqlCommand(storedProcedure, con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddRange(parameters);

            // Execute the stored procedure
            ExecuteNonQuery(cmd);
        }
    }

    public void InsertDeductionAndUpdateClaimMaster(int userId, int roleId, decimal deductionAmount, decimal totalDeductionAmount, string caseNo, string remarks)
    {
        using (SqlCommand cmd = new SqlCommand("SHA_InsertDeductionAndUpdateClaimMaster", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            // Add input parameters
            cmd.Parameters.AddWithValue("@RoleId", roleId);
            cmd.Parameters.AddWithValue("@UserId", userId);
           
            cmd.Parameters.AddWithValue("@DeductionAmt", deductionAmount);
            cmd.Parameters.AddWithValue("@TotalAmtAfterDeduction", totalDeductionAmount);
            cmd.Parameters.AddWithValue("@CaseNo", caseNo);
            cmd.Parameters.AddWithValue("@Remarks", remarks);

            // Add output parameter
            SqlParameter roleParam = new SqlParameter("@RoleName", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            cmd.Parameters.Add(roleParam);

            try
            {
                // Open the connection
                con.Open();

                // Execute the stored procedure
                cmd.ExecuteNonQuery();

                // Retrieve the output parameter value
                string roleName = (roleParam.Value != DBNull.Value) ? roleParam.Value.ToString() : null;

                // Handle case where role is not recognized or user is inactive
                if (string.IsNullOrEmpty(roleName))
                {
                    throw new Exception("Unrecognized role or user inactive.");
                }
            }
            catch (Exception ex)
            {
                // Throw a custom exception with details
                throw new Exception("Error while inserting deduction and updating claim master: " + ex.Message);
            }
            finally
            {
                // Ensure connection is closed
                if (con.State == ConnectionState.Open)
                { 
                    con.Close();
                }
            }
        }
    }



    //public DataTable GetSHARemarks(string claimId)
    //{
    //    string query = @"SELECT 
    //                    t2.TotalPackageCost AS TotalClaims,
    //                    t1.TrustClaimAmountApproved AS TrustLiable,
    //                    COALESCE(t5.TotalAmtAfterDeduction, CONVERT(BIGINT, t2.TotalPackageCost)) AS FinalApprovedAmount
    //                FROM 
    //                    TMS_ClaimMaster t1
    //                INNER JOIN 
    //                    TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId
    //                INNER JOIN 
    //                    TMS_DischargeDetail t3 ON t1.ClaimId = t3.ClaimId
    //                LEFT JOIN 
    //                    TMS_ClaimAddDeduction t5 ON t1.CaseNumber = t5.CaseNumber 
    //                        AND t5.IsActive = 1 
    //                        AND t5.IsDeleted = 0
    //                WHERE 
    //                    t1.ClaimId = @claimId 
    //                    AND t1.IsActive = 1 
    //                    AND t1.IsDeleted = 0;";

    //    SqlCommand cmd = new SqlCommand(query, con);
    //    cmd.Parameters.AddWithValue("@claimId", claimId);

    //    // Create a new SqlDataAdapter
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    // Clear the existing DataTable (dt) before filling it
    //    dt.Clear();

    //    // Open the connection, execute the query and fill the DataTable
    //    con.Open();
    //    da.Fill(dt);

    //    // Close the connection if it’s still open
    //    if (con.State == ConnectionState.Open)
    //    {
    //        con.Close();
    //    }

    //    return dt;
    //}

    public DataTable GetDeductionTypesForSHA()
    {
        string query = "SELECT DeductionTypeId, DeductionType FROM TMS_MasterDeductionTypeMaster WHERE IsSHA = 1";
        try
        {
            if (con.State == ConnectionState.Closed)
                con.Open();

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    dt.Clear();
                    adapter.Fill(dt);
                }
            }
            return dt;
        }
        catch (Exception ex)
        {
            throw new Exception("Error fetching deduction types: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
    }
    public DataTable GetQueryReason()
    {
        string query = "SELECT ReasonId, ReasonName FROM TMS_MasterQueryReason WHERE IsActive = 1";
        return ExecuteQuery(query);
    }

    public DataTable GetRejectReason()
    {
        string query = "SELECT RejectId, RejectName FROM TMS_MasterRejectReason WHERE IsActive = 1";
        return ExecuteQuery(query);
    }

    public DataTable GetQuerySubReason(string reasonId)
    {
        string query = "SELECT SubReasonId, SubReasonName FROM TMS_MasterQuerySubReason WHERE ReasonId = @ReasonId AND IsActive = 1";
        using (SqlCommand cmd = new SqlCommand(query))
        {
            cmd.Parameters.AddWithValue("@ReasonId", reasonId);
            return ExecuteQuery(cmd);
        }
    }

    private DataTable ExecuteQuery(string query)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString))
        using (SqlCommand cmd = new SqlCommand(query, con))
        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        {
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            return dt;
        }
    }

    private DataTable ExecuteQuery(SqlCommand cmd)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString))
        {
            cmd.Connection = con;
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }
    }

   
    public void SaveDeductionAmount(int userId, int roleId, decimal finalDeductedAmount, decimal totalFinalAmountBySha, string caseNo, string remarks)
    {
        SqlCommand cmd = new SqlCommand("SHA_InsertDeductionAndUpdateClaimMaster", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@RoleId", roleId);
        //cmd.Parameters.AddWithValue("@ACODeductionAmount", acODeductionAmount);
        cmd.Parameters.AddWithValue("@deductionAmount", finalDeductedAmount);
       
        cmd.Parameters.AddWithValue("@totalFinalAmountBySha", totalFinalAmountBySha);
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

    public DataTable GetDeductionData()
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT t2.DeductionType, t1.DeductionAmt, t1.TotalAmtAfterDeduction, t1.Remarks, t3.RoleName FROM TMS_ClaimAddDeduction t1 LEFT JOIN TMS_MasterDeductionTypeMaster t2 ON t1.DeductionType = t2.DeductionTypeId LEFT JOIN TMS_Roles t3 on t1.RoleId = t3.RoleId WHERE t1.IsActive = 1 AND t1.IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
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

}


