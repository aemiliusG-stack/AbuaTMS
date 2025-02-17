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
using System.Web.Security;

public class CEX
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected;
    private MasterData md = new MasterData();
    private string base64String = "";
    string pageName;

    public DataTable GetClaimPatientDetails()
    {
        DataTable dt = new DataTable();
        try
        {
            string query = "TMS_CEXClaimPatientDetails";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                using (SqlDataAdapter sd = new SqlDataAdapter(cmd))
                {
                    sd.Fill(dt);
                }
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
        return dt;
    }

    public DataTable GetClaimWorkFlow(int claimId)
    {
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t3.RejectName AS RejectionReason FROM TMS_PatientActionHistory t1 INNER JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @ClaimId AND t1.IsClaimInitiated = 1";

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
    public DataTable GetPreauthWorkFlow(int claimId)
    {
        string Query = "SELECT t1.ActionDate, t2.RoleName, t1.Remarks, t1.ActionTaken, t1.Amount, t3.RejectName AS RejectionReason FROM TMS_PatientActionHistory t1 INNER JOIN TMS_Roles t2 ON t1.ActionTakenBy = t2.RoleId LEFT JOIN TMS_MasterRejectReason t3 ON t1.RejectReasonId = t3.RejectId WHERE t1.ClaimId = @ClaimId AND t1.IsClaimInitiated = 0";

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

    public bool InsertCEXNonTechChecklist(string caseNo, string Role, string cardNumber, string userId, string claimId, string admissionId, int isNameCorrect, int isGenderCorrect, int doesPhotoMatch, string admissionDateCS, int doesAddDateMatchCS, string surgeryDateCS, int doesSurDateMatchCS, string dischargeDateCS, int doesDischargeDateMatchCS, int isPatientSignVerified, int isReportVerified, int isDateAndNameCorrect, string nonTechChecklistRemarks)
    {
        try
        {
            string query = @"INSERT INTO TMS_CEXNonTechChecklist(CaseNo,RoleId, CardNumber, UserId, ClaimId, AddmissionId, IsNameCorrect, IsGenderCorrect, DoesPhotoMatch, AdmissionDateCS, DoesAddDateMatchCS, SurgeryDateCS, DoesSurDateMatchCS, DischargeDateCS, DoesDischDateMatchCS, IsPatientSignVerified, IsReportVerified, IsDateAndNameCorrect, NonTechChecklistRemarks, IsActive ,CreatedOn ,UpdatedOn)
			VALUES(@CaseNo,@RoleId, @cardNumber, @UserId, @ClaimId, @AddmissionId, @IsNameCorrect, @IsGenderCorrect, @DoesPhotoMatch, @AdmissionDateCS, @DoesAddDateMatchCS, @SurgeryDateCS, @DoesSurDateMatchCS, @DischargeDateCS, @DoesDischDateMatchCS, @IsPatientSignVerified, @IsReportVerified, @IsDateAndNameCorrect, @NonTechChecklistRemarks, 1, GETDATE(), GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@CaseNo", caseNo);
            sd.InsertCommand.Parameters.AddWithValue("@RoleId", Role);
            sd.InsertCommand.Parameters.AddWithValue("@CardNumber", cardNumber);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            sd.InsertCommand.Parameters.AddWithValue("@AddmissionId", admissionId);
            sd.InsertCommand.Parameters.AddWithValue("@IsNameCorrect", isNameCorrect);
            sd.InsertCommand.Parameters.AddWithValue("@IsGenderCorrect", isGenderCorrect);
            sd.InsertCommand.Parameters.AddWithValue("@DoesPhotoMatch", doesPhotoMatch);
            sd.InsertCommand.Parameters.AddWithValue("@AdmissionDateCS", admissionDateCS);
            sd.InsertCommand.Parameters.AddWithValue("@DoesAddDateMatchCS", doesAddDateMatchCS);
            sd.InsertCommand.Parameters.AddWithValue("@SurgeryDateCS", surgeryDateCS);
            sd.InsertCommand.Parameters.AddWithValue("@DoesSurDateMatchCS", doesSurDateMatchCS);
            sd.InsertCommand.Parameters.AddWithValue("@DischargeDateCS", dischargeDateCS);
            sd.InsertCommand.Parameters.AddWithValue("@DoesDischDateMatchCS", doesDischargeDateMatchCS);
            sd.InsertCommand.Parameters.AddWithValue("@IsPatientSignVerified", isPatientSignVerified);
            sd.InsertCommand.Parameters.AddWithValue("@IsReportVerified", isReportVerified);
            sd.InsertCommand.Parameters.AddWithValue("@IsDateAndNameCorrect", isDateAndNameCorrect);
            sd.InsertCommand.Parameters.AddWithValue("@NonTechChecklistRemarks", nonTechChecklistRemarks);

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool UpdateClaimMasterForCEXInsurer(string caseNo, string userId, string claimId)
    {
        try
        {
            string query = @"UPDATE TMS_ClaimMaster
				SET ForwardedByInsurer = 5, ForwardActionInsurer = 2, ForwardedToInsurer = 7 , CurrentHandleByInsurer = 0 , CEXInsurerId = @UserId , IsCEXInsurerApproved = 1, UpdatedOn = GETDATE()
				WHERE CaseNumber = @CaseNo AND ClaimId = @ClaimId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@CaseNo", caseNo);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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

    public bool UpdateClaimMasterForCEXHybrid(string caseNo, string userId, string claimId)
    {
        try
        {
            string query = @"UPDATE TMS_ClaimMaster
				SET ForwardedByInsurer = 5, ForwardedToInsurer = 7 , ForwardActionInsurer = 2,ForwardActionTrust = 2, CurrentHandleByInsurer = 0 ,ForwardedByTrust = 6, ForwardedToTrust = 8 ,CurrentHandleByTrust = 0,  CEXInsurerId = @UserId , CEXTrustId = @UserId,IsCEXInsurerApproved = 1,IsCEXTrustApproved = 1, UpdatedOn = GETDATE()
				WHERE CaseNumber = @CaseNo AND ClaimId = @ClaimId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@CaseNo", caseNo);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool UpdateIfHybride(string claimId, string userId)
    {
        try
        {
            string query = @"UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = @UserId, CurrentHandleByTrust = @UserId WHERE ClaimId = @ClaimId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool UpdateClaimMasterForCEXTrust(string caseNo, string userId, string claimId)
    {
        try
        {
            string query = @"UPDATE TMS_ClaimMaster
				SET ForwardedByTrust = 6, ForwardActionTrust = 2, ForwardedToTrust = 8 ,CurrentHandleByTrust = 0 , CEXTrustId = @UserId , IsCEXTrustApproved = 1, UpdatedOn = GETDATE()
				WHERE CaseNumber = @CaseNo AND ClaimId = @ClaimId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@CaseNo", caseNo);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool PatientActionForCEXInsurer(string userId, string claimId, string admissionId, int amount, string nonTechChecklistRemarks)
    {
        try
        {
            string query = @"INSERT INTO TMS_PatientActionHistory(ClaimId, IsClaimInitiated,AdmissionId,ActionDate,ActionTakenBy,ActionTaken,Remarks,CaseStatusId,Amount, IsActive,CreatedOn)
	VALUES( @ClaimId,1,@AdmissionId,GETDATE(),@UserId,'Claim Forwarded by CEX(Insurance)',@Remarks,46,@Amount, 1, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            sd.InsertCommand.Parameters.AddWithValue("@AdmissionId", admissionId);
            sd.InsertCommand.Parameters.AddWithValue("@Amount", amount);
            sd.InsertCommand.Parameters.AddWithValue("@Remarks", nonTechChecklistRemarks);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool PatientActionForCEXHybrid(string userId, string claimId, string admissionId, int amount, string nonTechChecklistRemarks)
    {
        try
        {
            string query = @"INSERT INTO TMS_PatientActionHistory(ClaimId,AdmissionId,ActionDate,ActionTakenBy,ActionTaken,Remarks,CaseStatusId,Amount, IsActive,CreatedOn)
	VALUES( @ClaimId,@AdmissionId,GETDATE(),@UserId,'Claim Forwarded by CEX(Hybrid)', @Remarks, 44, @Amount, 1, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            sd.InsertCommand.Parameters.AddWithValue("@AdmissionId", admissionId);
            sd.InsertCommand.Parameters.AddWithValue("@Amount", amount);
            sd.InsertCommand.Parameters.AddWithValue("@Remarks", nonTechChecklistRemarks);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool PatientActionForCEXTrust(string userId, string claimId, string admissionId, int amount, string nonTechChecklistRemarks)
    {
        try
        {
            string query = @"INSERT INTO TMS_PatientActionHistory(ClaimId,AdmissionId,ActionDate,ActionTakenBy,ActionTaken,Remarks,CaseStatusId,Amount, IsActive,CreatedOn)
	VALUES( @ClaimId,@AdmissionId,GETDATE(),@UserId,'Claim Forwarded by CEX',@Remarks,45,@Amount, 1, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@UserId", userId);
            sd.InsertCommand.Parameters.AddWithValue("@ClaimId", claimId);
            sd.InsertCommand.Parameters.AddWithValue("@AdmissionId", admissionId);
            sd.InsertCommand.Parameters.AddWithValue("@Amount", amount);
            sd.InsertCommand.Parameters.AddWithValue("@Remarks", nonTechChecklistRemarks);
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            con.Open();
            int rowsAffected = sd.InsertCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
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
    public bool DoesNonTechChecklistExist(string caseNumber, string RoleId)
    {
        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_CEXNonTechChecklist WHERE CaseNo = @CaseNo AND RoleId = @RoleId  AND IsActive = 1";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CaseNo", caseNumber);
            cmd.Parameters.AddWithValue("@RoleId", RoleId);

            con.Open();
            int existingRecords = (int)cmd.ExecuteScalar(); // Retrieve the count of matching records
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
    public bool IsOncologyCase(string caseNo)
    {
        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_PatientTreatmentProtocol t1 Left Join TMS_MasterPackageMaster t2 ON t1.PackageId = t2.PackageId
                            Left Join TMS_PatientAdmissionDetail t3 ON t1.PatientRegId = t3.PatientRegId WHERE t3.CaseNumber = @CaseNumber AND t1.PackageId in (10,24,25)";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CaseNumber", caseNo);

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



    public string DisplayImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }

    public DataTable GetTreatmentDischarge(string ClaimId)
    {
        string Query = "SELECT T4.Title as TypeOfMedicalExpertise, T2.Name as DoctorName, T2.RegistrationNumber as DoctorRegistrationNumber, T5.Title as Qualification, T2.MobileNumber as DoctorContactNumber, T2.Name AS AnaesthetistName, T2.RegistrationNumber AS AnaesthetistRegNo, T2.MobileNumber AS AnaesthetistMobNo, T1.IncisionType, T1.OPPhotosWebexTaken, T1.VideoRecordingDone, T1.SwabCountInstrumentsCount, T1.SuturesLigatures, T1.SpecimenRequired, T1.DrainageCount, T1.BloodLoss, T1.PostOperativeInstructions, T1.PatientCondition, T1.ComplicationsIfAny, T1.TreatmentSurgeryStartDate, T1.SurgeryStartTime, T1.SurgeryEndTime, T1.TreatmentGiven, T1.OperativeFindings, T1.PostOperativePeriod, T1.PostSurgeryInvestigationGiven, T1.StatusAtDischarge, T1.Review, T1.Advice, T1.IsDischarged, T1.DischargeDate, T1.NextFollowUpDate, T1.ConsultAtBlock, T1.FloorNo, T1.RoomNo, T1.IsSpecialCase,T6.SpecialCaseValue, T1.FinalDiagnosis,T1.FinalDiagnosisDesc, T1.ProcedureConsent FROM TMS_DischargeDetail T1 LEFT JOIN HEM_HospitalManPowers T2 ON T1.AnesthetistId = T2.Id  LEFT JOIN HEM_MasterMedicalExpertiseSubTypes T4 ON T1.DoctorTypeId = T4.Id LEFT JOIN HEM_MasterQualifications T5 ON T2.QualificationId = T5.Id LEFT JOIN TMS_SpecialCasevalue T6 ON T1.SpecialCaseValue = T6.SpecialCaseId WHERE T1.ClaimId = @ClaimId AND T1.IsActive = 1 AND T1.IsDeleted = 0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ClaimId", ClaimId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetSpecialityName()
    {
        dt.Clear();
        try
        {
            string Query = "select PackageId, SpecialityName + '(' + SpecialityCode + ')' AS SpecialityName  from TMS_MasterPackageMaster where IsActive=1 and IsDeleted=0 Order By SpecialityName";
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

    public DataTable GetProcedureCode()
    {
        dt.Clear();
        try
        {
            string Query = "select ProcedureId, ProcedureCode + '(' + ProcedureName + ')' AS ProcedureCode from TMS_MasterPackageDetail where IsActive=1 and IsDeleted=0 Order By ProcedureCode";
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
    public DataTable GetProcedureName(int PackageId)
    {
        dt.Clear();
        try
        {
            string query = "SELECT ProcedureId, ProcedureName FROM TMS_MasterPackageDetail WHERE PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0 ORDER BY ProcedureName";
            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@PackageId", PackageId);
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
    public int TransferCase(string ClaimId, string RoleName)
    {
        string Query = "";

        if (RoleName.ToUpper() == "CEX(INSURER)")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = 0 , CurrentHandleByTrust = 0   WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        else if (RoleName.ToUpper() == "CEX(TRUST)")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByTrust = 0 , CurrentHandleByInsurer = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ClaimId", ClaimId);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        con.Close();
        con.Open();
        int rowsAffected = cmd.ExecuteNonQuery();
        con.Close();

        return rowsAffected;
    }

    public DataTable GetPackageMaster2(string PackageId, string ProcedureId)
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
    public DataTable getTreatmentProtocol(string CaseNo)
    {
        dt.Clear();
        try
        {
            string Query = "SELECT t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, COUNT(t3.ProcedureName) AS Quantity, CASE WHEN t1.ImplantId IS NULL OR t1.ImplantId = 0 THEN 'NA' ELSE t4.ImplantName END AS ImplantName,CASE WHEN t1.StratificationId IS NULL OR t1.StratificationId = 0 THEN 'NA' ELSE t5.StratificationName END AS StratificationName FROM TMS_PatientTreatmentProtocol t1 INNER JOIN TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId INNER JOIN TMS_MasterPackageDetail t3 on t1.ProcedureId = t3.ProcedureId LEFT JOIN TMS_MasterImplantMaster t4 on t1.ImplantId= t4.ImplantId LEFT JOIN TMS_MasterStratificationMaster t5 on t5.StratificationId=t1.StratificationId INNER JOIN TMS_PatientAdmissionDetail t6 on t6.PatientRegId = t1.PatientRegId WHERE t6.CaseNumber = @CaseNo GROUP BY t2.SpecialityName, t3.ProcedureName, t1.ProcedureAmountFinal, t1.ImplantId, t4.ImplantName, t1.StratificationId, t5.StratificationName";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@CaseNo", CaseNo);
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
    public DataTable getTreatmentSurgeryDate(string HospitalId, string PatientRegId, string CardNo)
    {
        dt.Clear();
        try
        {
            string Query = "select t1.PatientRegId, t1.ProcedureId, t2.ProcedureCode, t2.ProcedureName, CONVERT(VARCHAR, TreatmentStartDate, 23) as TreatmentStartDate from TMS_PatientTreatmentProtocol t1 LEFT JOIN TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId where t1.HospitalId = @HospitalId AND t1.PatientRegId = @PatientRegId AND t1.CardNumber = @CardNumber AND t1.IsActive = 1 AND t1.IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
            sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
            sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNo);
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
            document.Add(new Image(imageData));
            if (image != images.Last())
            {
                document.Add(new AreaBreak());
            }
        }
        document.Close();
        return ms.ToArray();
    }

    public DataTable GetManditoryDocument(string CardNumber)
    {
        dt.Clear();
        string Query = "SELECT DocumentId, DocumentFor, FolderName, UploadedFileName, UploadStatus FROM TMS_PatientMandatoryDocument WHERE CardNumber = @CardNumber AND DocumentId = 3 AND IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        con.Close();
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

}