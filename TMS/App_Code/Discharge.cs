using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class Discharge
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dtTemp = new DataTable();
    private DataSet ds = new DataSet();
    private int rowsAffected =0;
    public DataTable getSinglePatientDetails(int HospitalId, string CardNumber, int PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t2.PatientName, t2.CardNumber, t2.PatientRegId, t2.PatientFamilyId, t1.CaseNumber, 'NA' as CaseStatus, t2.RegDate, t2.MobileNumber, h3.Title as HospitalType, t2.Gender, CONCAT(t2.Age,' Years') as Age, (CASE WHEN IsChild = 1 THEN 'Yes' ELSE 'No' END) as IsNewBornBaby, (CASE WHEN t2.IsAadharVerified = 1 THEN 'Yes' ELSE 'No' END) as IsAadharVerified, (CASE WHEN t2.IsBiometricVerified = 1 THEN 'Yes' ELSE 'No' END) as IsBiometricVerified, t2.ImageURL, h1.Title as District, t2.ChildName, t2.ChildGender, t2.ChildDOB, t2.ChildFatherName, t2.ChildMotherName, t2.ChildImageURL from TMS_PatientAdmissionDetail t1 LEFT JOIN TMS_PatientRegistration t2 ON t1.PatientRegId = t2.PatientRegId LEFT JOIN HEM_MasterDistricts h1 ON t2.DistrictId = h1.Id LEFT JOIN HEM_HospitalDetails h2 ON t1.HospitalId = h2.HospitalId LEFT JOIN HEM_MasterHospitalTypes h3 ON h2.HospitalTypeId = h3.Id where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getPatientTotalPackageCost(int HospitalId, string CardNumber, int PatientRegId)
    {
        dtTemp.Clear();
        string Query = "select t1.AdmissionId, t1.AdmissionType, FORMAT (t1.AdmissionDate, 'dd-MM-yyyy ') as AdmissionDate, t1.IncentivePercentage, SUM(t1.PackageCost) as PackageCost, SUM(t1.IncentiveAmount) as IncentiveAmount, (CASE WHEN t1.IsEnhancementTaken = 1 THEN (SUM(t1.TotalPackageCost) + SUM(EnhancementAmount)) ELSE SUM(t1.TotalPackageCost) END) AS TotalPackageCost from TMS_PatientAdmissionDetail t1 where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegId AND t1.IsActive = 1 AND t1.IsDeleted = 0 GROUP BY t1.AdmissionId, t1.AdmissionType, t1.AdmissionDate, t1.IncentivePercentage, t1.IsEnhancementTaken";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getDoctorType()
    {
        dtTemp.Clear();
        string Query = "select Id, Title from HEM_MasterMedicalExpertiseSubTypes where MasterMedicalExpertiseTypesId = 1 AND IsActive = 1 AND IsDeleted = 0 ORDER BY Title";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getDoctorList(int Id)
    {
        dtTemp.Clear();
        string Query = "select DISTINCT Id, Name from HEM_HospitalManPowers where MedicalSubExpertiseId = @Id ORDER BY Name";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@Id", Id.ToString());
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getDoctorDetailByDoctorId(int Id)
    {
        dtTemp.Clear();
        string Query = "select DISTINCT h1.Id, h1.Name, h1.RegistrationNumber, h2.Title as Qualification, h1.MobileNumber from HEM_HospitalManPowers h1 LEFT JOIN HEM_MasterQualifications h2 ON h1.QualificationId = h2.Id where h1.Id = @Id";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@Id", Id.ToString());
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable getAnesthetistList()
    {
        dtTemp.Clear();
        string Query = "select DISTINCT Id, Name from HEM_HospitalManPowers where MedicalSubExpertiseId = (Select Id from HEM_MasterMedicalExpertiseSubTypes where Title = 'Anesthetist') ORDER BY Name";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable checkIsEnhancementApplicable(int HospitalId, string CardNumber, int PatientRegId)
    {
        dtTemp.Clear();
        string Query = "if exists(select t2.IsEnhancementApplicable from TMS_PatientTreatmentProtocol t1 LEFT JOIN TMS_MasterPackageDetail t2 ON t1.PackageId = t2.PackageId AND t1.ProcedureId = t2.ProcedureId where t1.HospitalId = @HospitalId AND t1.CardNumber = @CardNumber AND t1.PatientRegId = @PatientRegid AND t2.IsEnhancementApplicable = 1 AND t1.IsActive = 1 AND t1.IsDeleted = 0) BEGIN select 1 as checkId END ELSE BEGIN select 0 as checkId END";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
        sd.SelectCommand.Parameters.AddWithValue("@CardNumber", CardNumber);
        sd.SelectCommand.Parameters.AddWithValue("@PatientRegId", PatientRegId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
    public DataTable GetStratificationForEnhancement(string ProcedureId)
    {
        dtTemp.Clear();
        string Query = "if exists(select StratificationId from TMS_MapProcedureStratification where ProcedureId IN(@ProcedureId) AND IsActive = 1)BEGIN select DISTINCT 1 as Id, t1.StratificationId, t2.StratificationCode, t2.StratificationName, CONCAT(t2.StratificationCode, ', ', t2.StratificationName, ' - ', t2.StratificationDetail) as StratificationDetail, REPLACE(t2.StratificationAmount, 'None','0') as StratificationAmount from TMS_MapProcedureStratification t1 LEFT JOIN TMS_MasterStratificationMaster t2  ON t1.StratificationId = t2.StratificationId where t1.ProcedureId IN(@ProcedureId) AND t1.IsActive = 1 END ELSE BEGIN select 1 as Id, 0 as StratificationId END";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        con.Open();
        sd.Fill(dtTemp);
        con.Close();
        return dtTemp;
    }
}