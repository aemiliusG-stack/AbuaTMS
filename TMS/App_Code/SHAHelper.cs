
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
            string query = "SELECT t2.ClaimId, t2.ClaimMode, t2.AdmissionId, t2.CaseNumber, t2.ClaimNumber, t2.CardNumber, t3.HospitalName, t4.RegDate, t1.DischargeDate, t5.AccountNumber, t5.IFSCCode, t5.TDSExemption, t5.IsTDSApplicable, ISNULL(t5.TDSExemptionPercent, 0) AS TDSExemptionPercent, t1.TotalPackageCost AS ClaimInitaiteAmount, t2.InsurerClaimAmountRequested AS InsurerAmount, t2.InsurerClaimAmountApproved AS InsurerApprovedAmount, t2.InsurerClaimAmountDeducted AS InsurerDeductedAmount, t2.TrustClaimAmountRequested AS TrsutAmount, t2.TrustClaimAmountApproved AS TrustApprovedAmount, t2.TrustClaimAmountDeducted AS TrustDeductedAmount FROM TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId LEFT JOIN HEM_HospitalDetails t3 ON t1.HospitalId = t3.HospitalId LEFT JOIN TMS_PatientRegistration t4 ON t1.PatientRegId = t4.PatientRegId LEFT JOIN HEM_FinancialDetails t5 ON t3.HospitalId = t5.HospitalId WHERE (t2.ClaimMode = 1 AND t2.ForwardActionInsurer IN(1,2) AND t2.ForwardedByInsurer IN (2,9) AND t2.ForwardedToInsurer = 11 AND t2.IsACOInsurerApproved = 1) OR (t2.ClaimMode = 2 AND t2.ForwardActionTrust IN(1,2) AND t2.ForwardedByTrust IN (2,10) AND t2.ForwardedToTrust = 12 AND t2.IsACOTrustApproved = 1) OR (t2.ClaimMode = 3 AND t2.ForwardActionInsurer IN(1,2) AND t2.ForwardedByInsurer IN (2,9) AND t2.ForwardedToInsurer = 11 AND t2.ForwardActionTrust IN(1,2) AND t2.ForwardedByTrust IN (2,10) AND t2.ForwardedToTrust = 12 AND t2.IsACOInsurerApproved = 1 AND t2.IsACOTrustApproved = 1) AND t1.IsActive = 1 AND t1.IsDeleted = 0";
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

    public DataTable GetClaimsDetails(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT t2.TotalPackageCost AS PreAuthApprovedAmt, t2.AdmissionDate AS PreAuthApprovedDate, t1.CreatedOn AS ClaimSubmittedDate, t1.UpdatedOn AS ClaimUpdatedDate, t2.TotalPackageCost AS ClaimAmount, t1.InsurerClaimAmountRequested AS InsuranceLiableAmt, t1.TrustClaimAmountRequested AS TrustLiableAmt, t2.TotalPackageCost AS BillAmt, t1.Remarks AS ClaimRemarks, t1.ClaimId, t1.QueryRaisedByRoleInsurer, t1.QueryRaisedByRoleTrust, t1.IsCPDInsurerApproved, t1.IsCPDTrustApproved, t1.IsACOInsurerApproved, t1.IsACOTrustApproved FROM TMS_ClaimMaster t1 LEFT JOIN TMS_PatientAdmissionDetail t2 ON t1.AdmissionId = t2.AdmissionId WHERE t1.ClaimId = @ClaimId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
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

    public DataTable GetNonTechnicalChecklist(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT CaseNo, CardNumber, UserId, ClaimId, AddmissionId, IsNameCorrect, IsGenderCorrect, DoesPhotoMatch, AdmissionDateCS, DoesAddDateMatchCS, SurgeryDateCS, DoesSurDateMatchCS, DischargeDateCS, DoesDischDateMatchCS, IsPatientSignVerified, IsReportVerified, IsDateAndNameCorrect, NonTechChecklistRemarks FROM TMS_CEXNonTechChecklist WHERE IsActive = 1 AND ClaimId = @ClaimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetTechnicalChecklist(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT t1.TotalPackageCost, t2.InsurerClaimAmountApproved, t2.TrustClaimAmountApproved, t2.InsurerClaimAmountRequested, t2.TrustClaimAmountRequested, t3.IsSpecialCase, t4.DiagnosisSupportedEvidence, t4.CaseManagementSTP, t4.EvidenceTherapyConducted, t4.MandatoryReports, t4.Remarks FROM TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId LEFT JOIN TMS_DischargeDetail t3 ON t1.DischargeId = t3.DischargeId LEFT JOIN TMS_CPDTechnicalCkecklist t4 ON t1.ClaimId = t4.ClaimId WHERE t1.ClaimId = @ClaimId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetDeductedAmountDetails(string ClaimId, string RoleId)
    {
        dt.Clear();
        string Query = "SELECT TOP 1 DeductionAmt, TotalAmtAfterDeduction, Remarks FROM TMS_ClaimAddDeduction WHERE ClaimId = @ClaimId AND RoleId = @RoleId ORDER BY Id DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        sd.SelectCommand.Parameters.AddWithValue("@RoleId", RoleId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetDeductionTable()
    {
        dt.Clear();
        string Query = "SELECT t2.DeductionType, t1.DeductionAmt, t1.TotalAmtAfterDeduction, t1.Remarks, t3.RoleName FROM TMS_ClaimAddDeduction t1 LEFT JOIN TMS_MasterDeductionTypeMaster t2 ON t1.DeductionType = t2.DeductionTypeId LEFT JOIN TMS_Roles t3 ON t1.RoleId = t3.RoleId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public DataTable GetClaimWorkFlow(string ClaimId)
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT t1.ActionDate, t2.RoleName AS Role, t1.Remarks, t1.ActionTaken AS Action, t1.Amount, ISNULL(t3.RejectName, 'NA') AS RejectedReason FROM TMS_PatientActionHistory t1 LEFT JOIN TMS_Users t2 ON t1.ActionTakenBy = t2.UserId LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @ClaimId AND t1.IsClaimInitiated = 1 AND t1.IsActive = 1";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
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

    public DataTable GetMasterActions()
    {
        try
        {
            DataTable dt = new DataTable();
            string Query = "SELECT ActionId, ActionName from TMS_MasterActionMaster WHERE SHA = 1 AND IsActive = 1";
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


