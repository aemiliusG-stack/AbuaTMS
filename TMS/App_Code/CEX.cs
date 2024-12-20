using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using CareerPath.DAL;
using iText.IO.Image;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using System.Linq;
using System.Net;
using Org.BouncyCastle.Asn1.X509;
using WebGrease.Css.Ast;




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
    public bool DoesNonTechChecklistExist(string caseNumber)
    {

        SqlParameter[] p1 = new SqlParameter[1];
        p1[0] = new SqlParameter("@CaseNo", caseNumber);
        p1[0].DbType = DbType.String;

        int recordExists = (int)SqlHelper.ExecuteScalar(con, CommandType.Text, "SELECT COUNT(*) FROM TMS_CEXNonTechChecklist WHERE CaseNo = @CaseNo AND IsActive = 1 AND IsDeleted = 0", p1);
        return recordExists > 0;
    }
    public string DisplayImage(string folderName, string imageFileName)
    {
        string imageBaseUrl = ConfigurationManager.AppSettings["ImageUrlPath"];
        string imageUrl = string.Format("{0}{1}/{2}", imageBaseUrl, folderName, imageFileName);
        byte[] imageBytes = File.ReadAllBytes(imageUrl);
        base64String = Convert.ToBase64String(imageBytes);
        return base64String;
    }
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

    public DataTable GetProcedureCode()
    {
        dt.Clear();
        try
        {
            string Query = "select ProcedureId, ProcedureCode from TMS_MasterPackageDetail where IsActive=1 and IsDeleted=0";
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
            string query = "SELECT ProcedureId, ProcedureName FROM TMS_MasterPackageDetail WHERE PackageId = @PackageId AND IsActive = 1 AND IsDeleted = 0";
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
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByInsurer = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
        }
        else if (RoleName.ToUpper() == "CEX(TRUST)")
        {
            Query = "UPDATE TMS_ClaimMaster SET CurrentHandleByTrust = 0 WHERE ClaimId = @ClaimId AND IsActive = 1 AND IsDeleted = 0";
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

    public DataTable GetPackageMaster2(string PackageId, string ProcedureId) //, int OffSet, int PageSize
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

}