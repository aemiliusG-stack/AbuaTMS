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

    public int TransferCase(string ClaimId, string RoleName)
    {
        string Query = "";
        if (RoleName.ToUpper() == "PPD(INSURER)")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        else if (RoleName.ToUpper() == "PPD(TRUST)")
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
            Query = "SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation FROM TMS_MasterPackageDetail t1 inner join TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId WHERE t2.PackageId = @PackageId AND t1.ProcedureId = @ProcedureId";
        }
        else
        {
            Query = "SELECT t2.PackageId, t2.SpecialityCode, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.PreInvestigation, t1.PostInvestigation FROM TMS_MasterPackageDetail t1 inner join TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId";
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
        string Query = "select t5.HospitalName, t2.SpecialityCode, t2.SpecialityName, t3.ProcedureCode, t3.ProcedureName, t4.InvestigationCode, t4.InvestigationName, t1.UploadStatus, t6.InvestigationStage, t1.FolderName, t1.UploadedFileName, t1.FilePath, t1.CreatedOn from TMS_PatientDocumentPreInvestigation t1 inner join TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId inner join TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId inner join TMS_MasterInvestigationMaster t4 on t1.PreInvestigationId = t4.InvestigationId inner join HEM_HospitalDetails t5 on t1.HospitalId = t5.HospitalId LEFT JOIN TMS_MapProcedureInvestigation t6 ON t6.InvestigationId = t1.PreInvestigationId AND t6.PackageId = t1.PackageId AND t6.ProcedureId = t1.ProcedureId where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t6.InvestigationStage = 'Pre'";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
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