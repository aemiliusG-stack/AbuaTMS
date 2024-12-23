using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Configuration;
using CareerPath.DAL;
using iText.IO.Image;
using iText.Kernel.Pdf;
using System.IO;
using iText.Layout;
using iText.Layout.Element;
using System.Net;
using System;
using System.Collections.Generic;

public class PPDHelper
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    public DataTable GetAssignedCases(string UserId, string CaseNumber, string CardNumber, string FromDate, string ToDate)
    {
        dt.Clear();
        SqlParameter[] p = new SqlParameter[5];
        p[0] = new SqlParameter("@UserId", UserId);
        p[0].DbType = DbType.String;
        p[1] = new SqlParameter("@CaseNumber", CaseNumber);
        p[1].DbType = DbType.String;
        p[2] = new SqlParameter("@CardNumber", CardNumber);
        p[2].DbType = DbType.String;
        p[3] = new SqlParameter("@FromDate", FromDate);
        p[3].DbType = DbType.String;
        p[4] = new SqlParameter("@ToDate", ToDate);
        p[4].DbType = DbType.String;
        ds = SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "TMS_PPD_GetAssignedCases", p);
        if (con.State == ConnectionState.Open)
            con.Close();
        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            dt = ds.Tables[0];
        }
        return dt;
    }

    public int TransferCase(string ClaimId, string RoleId)
    {
        string Query = "";
        if (RoleId == "3")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        else if (RoleId == "4")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByTrust = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }

    public DataTable GetUserDetails(string UserId)
    {
        dt.Clear();
        string Query = "SELECT t1.RoleName FROM TMS_Users t1 WHERE t1.UserId = @UserId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@UserId", UserId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetAdmissionDetails(string AdmissionId)
    {
        dt.Clear();
        string Query = "SELECT t1.IncentivePercentage, t1.PackageCost, t1.IncentiveAmount, t1.ImplantAmount, t1.TotalPackageCost, t2.InsurerClaimAmountRequested, t2.TrustClaimAmountRequested FROM TMS_PatientAdmissionDetail t1 INNER JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId WHERE t1.AdmissionId = @AdmissionId AND t1.IsActive = 1 AND t1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@AdmissionId", AdmissionId);
        con.Open();
        sd.Fill(dt);
        con.Close();
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

    public DataTable GetWorkFlow(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT t1.ActionDate, CONCAT(t2.FullName,' ',t2.RoleName) AS Role, t1.Remarks, t1.ActionTaken AS Action, t1.Amount, ISNULL(t1.RejectionReason, 'NA') AS RejectionReason FROM TMS_PatientActionHistory t1 inner join TMS_Users t2 ON t1.ActionTakenBy = t2.UserId WHERE t1.ClaimId = @ClaimId AND t1.IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetQueryReasons()
    {
        dt.Clear();
        string Query = "SELECT ReasonId, ReasonName FROM TMS_MasterQueryReason WHERE IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetSubQueryReasons(string ReasonId)
    {
        dt.Clear();
        string Query = "SELECT SubReasonId, ReasonId, SubReasonName FROM TMS_MasterQuerySubReason WHERE ReasonId = @ReasonId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ReasonId", ReasonId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetRejectReasons()
    {
        dt.Clear();
        string Query = "SELECT RejectId, RejectName FROM TMS_MasterRejectReason WHERE IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetPreauthQuery(string ClaimId)
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

    public DataTable GetSpecialityName()
    {
        dt.Clear();
        string Query = "SELECT PackageId, SpecialityName from TMS_MasterPackageMaster WHERE IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetSpecialityBasedProcedure(string PackageId)
    {
        dt.Clear();
        string Query = "SELECT ProcedureId, ProcedureName from TMS_MasterPackageDetail WHERE PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetPackageMaster(string PackageId, string ProcedureId) //, int OffSet, int PageSize
    {
        dt.Clear();
        string Query = "";
        if (PackageId != null && ProcedureId != null)
        {
            Query = "SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation FROM TMS_MasterPackageDetail t1 INNER JOIN TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId WHERE t2.PackageId = @PackageId AND t1.ProcedureId = @ProcedureId";
        }
        else
        {
            Query = "SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation FROM TMS_MasterPackageDetail t1 INNER JOIN TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId";
        }
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        if (PackageId != null && ProcedureId != null)
        {
            sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
            sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        }
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

    public int UpdateCase(string ClaimId, string UserId, string RoleId)
    {
        string Query = "";
        if (RoleId == "3")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = @UserId WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        else if (RoleId == "4")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByTrust = @UserId WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@UserId", UserId);
        cmd.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();
        return rowsAffected;
    }

    public DataTable GetCaseCurrentAction(string ClaimId)
    {
        dt.Clear();
        string Query = "SELECT t1.ForwardActionInsurer, t1.ForwardActionTrust FROM TMS_ClaimMaster t1 WHERE ClaimId = @ClaimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetDashboardData()
    {
        dt.Clear();
        string Query = "SELECT COUNT(CASE WHEN t2.ForwardActionInsurer = 1 AND t2.ForwardedByInsurer = 2 AND t2.ForwardedToInsurer = 3 AND CAST(t1.AdmissionDate AS DATE) = CAST(GETDATE() AS DATE) THEN t1.AdmissionId END) AS PPDInsurerToday, COUNT(CASE WHEN t2.ForwardActionInsurer = 1 AND t2.ForwardedByInsurer = 2 AND t2.ForwardedToInsurer = 3 THEN t1.AdmissionId END) AS PPPDInsurerOverall, COUNT(CASE WHEN t2.ForwardActionTrust = 1 AND t2.ForwardedByTrust = 2 AND t2.ForwardedToTrust = 4 AND CAST(t1.AdmissionDate AS DATE) = CAST(GETDATE() AS DATE) THEN t1.AdmissionId END) AS PPDTrustToday, COUNT(CASE WHEN t2.ForwardActionTrust = 1 AND t2.ForwardedByTrust = 2 AND t2.ForwardedToTrust = 4 THEN t1.AdmissionId END) AS PPPDTrustOverall, COUNT(CASE WHEN t2.ForwardActionInsurer = 2 AND t2.ForwardedByInsurer = 3 AND t2.ForwardedToInsurer = 3 AND CAST(t1.AdmissionDate AS DATE) = CAST(GETDATE() AS DATE) THEN t1.AdmissionId END) AS PPDInsurerAssignedToday, COUNT(CASE WHEN t2.ForwardActionInsurer = 2 AND t2.ForwardedByInsurer = 3 AND t2.ForwardedToInsurer = 3 THEN t1.AdmissionId END) AS PPPDInsurerAssignedOverall, COUNT(CASE WHEN t2.ForwardActionTrust = 2 AND t2.ForwardedByTrust = 4 AND t2.ForwardedToTrust = 4 AND CAST(t1.AdmissionDate AS DATE) = CAST(GETDATE() AS DATE) THEN t1.AdmissionId END) AS PPDTrustAssignedToday, COUNT(CASE WHEN t2.ForwardActionTrust = 2 AND t2.ForwardedByTrust = 4 AND t2.ForwardedToTrust = 4 THEN t1.AdmissionId END) AS PPPDTrustAssignedOverall,COUNT(CASE WHEN CAST(t1.AdmissionDate AS DATE) = CAST(GETDATE() AS DATE) THEN t1.AdmissionId END) AS PreauthCountToday, COUNT(t1.AdmissionId) AS PreauthCountOverall FROM TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_ClaimMaster t2 ON t1.ClaimId = t2.ClaimId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetSurgeonDetails(string DischargeId)
    {
        dt.Clear();
        string Query;
        SqlDataAdapter sd;
        Query = "SELECT DoctorId FROM TMS_DischargeDetail WHERE DischargeId = @DischargeId";
        sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DischargeId", DischargeId);
        con.Open();
        sd.Fill(dt);
        con.Close();

        string DoctorId = dt.Rows[0]["DoctorId"].ToString().Trim();
        Query = "SELECT DISTINCT t1.Id, t1.Name, t1.RegistrationNumber, t2.Title AS Qualification, t1.MobileNumber, t3.Title AS DoctorType FROM HEM_HospitalManPowers t1 LEFT JOIN HEM_MasterQualifications t2 ON t1.QualificationId = t2.Id LEFT JOIN HEM_MasterMedicalExpertiseSubTypes t3 ON t1.MedicalSubExpertiseId = t3.Id WHERE t1.Id = @DoctorId";
        dt.Clear();
        sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DoctorId", DoctorId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetAnesthetistDetails(string DischargeId)
    {
        dt.Clear();
        string Query;
        SqlDataAdapter sd;
        Query = "SELECT AnesthetistId FROM TMS_DischargeDetail WHERE DischargeId = @DischargeId";
        sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DischargeId", DischargeId);
        con.Open();
        sd.Fill(dt);
        con.Close();

        DataTable dtSurgeon = dt;
        string AnesthetistId = dtSurgeon.Rows[0]["AnesthetistId"].ToString().Trim();
        Query = "SELECT DISTINCT t1.Id, t1.Name, t1.RegistrationNumber, t2.Title AS Qualification, t1.MobileNumber FROM HEM_HospitalManPowers t1 LEFT JOIN HEM_MasterQualifications t2 ON t1.QualificationId = t2.Id WHERE t1.Id = @AnesthetistId";
        dt.Clear();
        sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@AnesthetistId", AnesthetistId);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    public DataTable GetOtherDischargeDetails(string DischargeId)
    {
        string Query = "SELECT t1.IncisionType, t1.OPPhotosWebexTaken, t1.VideoRecordingDone, t1.SwabCountInstrumentsCount, t1.SuturesLigatures, t1.SpecimenRequired, t1.DrainageCount, t1.BloodLoss, t1.PostOperativeInstructions, t1.PatientCondition, t1.ComplicationsIfAny, t1.TreatmentSurgeryStartDate, t1.SurgeryStartTime, t1.SurgeryEndTime, t1.TreatmentGiven, t1.OperativeFindings, t1.PostOperativePeriod, t1.PostSurgeryInvestigationGiven, t1.StatusAtDischarge, t1.Review, t1.Advice, t1.DischargeDate, t1.NextFollowUpDate, t1.ConsultAtBlock, t1.FloorNo, t1.RoomNo, t1.IsSpecialCase, t1.SpecialCaseValue, t1.FinalDiagnosis, t1.FinalDiagnosisDesc, t1.ProcedureConsent FROM TMS_DischargeDetail t1 WHERE t1.DischargeId = @DischargeId";
        dt.Clear();
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DischargeId", DischargeId);
        con.Open();
        sd.Fill(dt);
        con.Close();
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

}