using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class MasterData
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    public void InsertErrorLog(string UserId, string PageName, string ErrorMessage, string StackTrace, string ErrorType)
    {
        string Query = "insert into TMS_ErrorLog(UserId, PageName, ErrorMessage, StackTrace, ErrorType, CreatedOn)values(@UserId, @PageName, @ErrorMessage, @StackTrace, @ErrorType,GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@UserId", UserId);
        cmd.Parameters.AddWithValue("@PageName", PageName);
        cmd.Parameters.AddWithValue("@ErrorMessage", ErrorMessage);
        cmd.Parameters.AddWithValue("@StackTrace", StackTrace);
        cmd.Parameters.AddWithValue("@ErrorType", ErrorType);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        con.Close();
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public DataTable GetUserRoles()
    {
        try
        {
            string Query = "Select RoleId, RoleName from TMS_Roles ORDER BY RoleId";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetCreatedUserDetail()
    {
        try
        {
            string Query = "Select DISTINCT t1.UserId, t1.Username, r1.RoleName, IsNull(d1.Title,'NA') as DistrictName, IsNull(h1.HospitalName, 'NA') as HospitalName, t1.FullName, t1.UserAddress, t1.MobileNo, FORMAT (t1.CreatedOn, 'dd-MMM-yyyy ') as CreatedOn from TMS_Users t1 LEFT JOIN TMS_Roles r1 ON t1.RoleId = r1.RoleId LEFT JOIN HEM_HospitalDetails h1 ON t1.HospitalId = h1.Id LEFT JOIN HEM_MasterDistricts d1 ON t1.DistrictId = d1.Id";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetHospitalList()
    {
        try
        {
            string Query = "Select HospitalId, HospitalName from HEM_HospitalDetails where IsActive = 1 AND IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetHospitalDetail(int HospitalId)
    {
        try
        {
            string Query = "select h1.HospitalName, h1.ContactPersonMobile, h1.ContactPersonEmail,  h1.EnrolledInTMS, h1.HospitalPan, h1.Address, h1.City, h1.PinCode, h1.EstablishmentYear, h1.PanHolderName, h1.LandLineNumber, h1.AccreditationLevel, h1.NameofOthersAccreditationBoard, h1.HospitalTypeId, h2.Title as HospitalType, h1.HospitalSubTypeId, h1.DistrictID, h1.EmpanelmentTypeId, h1.BlockId, h1.VillageId, h1.SpecialityTypeId, h1.HospitalOwnershipTypeId, h1.FileUrl from HEM_HospitalDetails h1 LEFT JOIN HEM_MasterHospitalTypes h2 ON h1.HospitalTypeId = h2.Id where h1.HospitalId = @HospitalId";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@HospitalId", HospitalId);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetState()
    {
        try
        {
            string Query = @"if exists(select Id from HEM_MasterStates)
	                               Begin
	                               	select Id, Title from HEM_MasterStates
	                               End
	                               else
	                               Begin
	                               	select 0 as Id
	                               End";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetDistrict()
    {
        try
        {
            string Query = "select Id, Title from HEM_MasterDistricts where IsActive = 1 AND IsDeleted = 0 ORDER BY Title";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetDistrictStateWise(int Id)
    {
        try
        {
            string Query = "select Id, Title from HEM_MasterDistricts where StateId = @Id AND IsActive = 1 AND IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@Id", Id);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetBlockDistrictWise(int Id)
    {
        try
        {
            string Query = "Select Id, Title from HEM_MasterBlocks where DistrictId = @Id And IsActive = 1 And IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@Id", Id);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }
    public DataTable GetVillageBlockWise(int Id)
    {
        try
        {
            string Query = "select Id, Title from HEM_MasterVillages where BlockId = @Id AND IsActive = 1 AND IsDeleted = 0";
            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            sd.SelectCommand.Parameters.AddWithValue("@Id", Id);
            con.Open();
            sd.Fill(ds);
            con.Close();
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterActionMaster.
        Selecting TMS_MasterActionMaster data for PPD.
    */
    public DataTable GetMasterActions()
    {
        string Query = "SELECT ActionId, ActionName from TMS_MasterActionMaster WHERE PPD = 1";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterImplantMaster.
        Selecting TMS_MasterImplantMaster data.
    */
    public DataTable GetImplantMasterData()
    {
        string Query = "SELECT ImplantId, ImplantCode, ImplantName, MaxImplant, ImplantAmount, IsActive, CreatedOn, UpdatedOn FROM TMS_MasterImplantMaster ORDER BY ImplantId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterImplantMaster.
        Inserting into TMS_MasterImplantMaster table.
    */
    public void InsertImplant(string ImplantCode, string ImplantName, string MaxImplant, string ImplantAmount)
    {
        string Query = "INSERT INTO TMS_MasterImplantMaster(ImplantCode, ImplantName, MaxImplant, ImplantAmount, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@ImplantCode,@ImplantName, @MaxImplant, @ImplantAmount, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ImplantCode", ImplantCode);
        cmd.Parameters.AddWithValue("@ImplantName", ImplantName);
        cmd.Parameters.AddWithValue("@MaxImplant", MaxImplant);
        cmd.Parameters.AddWithValue("@ImplantAmount", ImplantAmount);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterImplantMaster.
        Updating table TMS_MasterImplantMaster.
    */
    public void UpdateImplant(string ImplantId, string ImplantCode, string ImplantName, string MaxImplant, string ImplantAmount)
    {
        string Query = "UPDATE TMS_MasterImplantMaster SET ImplantCode = @ImplantCode, ImplantName = @ImplantName, MaxImplant = @MaxImplant, ImplantAmount = @ImplantAmount, UpdatedOn = GETDATE() where ImplantId = @ImplantId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ImplantCode", ImplantCode);
        cmd.Parameters.AddWithValue("@ImplantName", ImplantName);
        cmd.Parameters.AddWithValue("@MaxImplant", MaxImplant);
        cmd.Parameters.AddWithValue("@ImplantAmount", ImplantAmount);
        cmd.Parameters.AddWithValue("@ImplantId", ImplantId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterImplantMaster.
        Managing status active or inactive TMS_MasterImplantMaster.
    */
    public void ToogleImplant(string ImplantId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterImplantMaster SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE ImplantId = @ImplantId";
        }
        else
        {
            Query = "UPDATE TMS_MasterImplantMaster SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE ImplantId = @ImplantId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ImplantId", ImplantId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPackageDetail.
        Selecting TMS_MasterPackageDetail data.
    */
    public DataTable GetProcedureDetails()
    {
        string Query = "SELECT ProcedureId, ProcedureCode FROM TMS_MasterPackageDetail";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPreAuthMandatoryDocument.
        Inserting data into TMS_MasterPreAuthMandatoryDocument.
    */
    public void InsertPreAuthManditoryDocument(string DocumentName, string DocumentFor)
    {
        string Query = "INSERT INTO TMS_MasterPreAuthMandatoryDocument(DocumentName, DocumentFor, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@DocumentName, @DocumentFor, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@DocumentName", DocumentName);
        cmd.Parameters.AddWithValue("@DocumentFor", DocumentFor);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPreAuthMandatoryDocument.
        Selecting TMS_MasterPreAuthMandatoryDocument data.
    */
    public DataTable GetPreAuthManditoryDocument()
    {
        string Query = "SELECT DocumentId, DocumentName, DocumentFor, IsActive, IsDeleted, CreatedOn, UpdatedOn FROM TMS_MasterPreAuthMandatoryDocument ORDER BY DocumentId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPreAuthMandatoryDocument.
        Managing status active or inactive TMS_MasterPreAuthMandatoryDocument.
    */
    public void TooglePreAuthMandateDocument(string DocumentId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterPreAuthMandatoryDocument SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE DocumentId = @DocumentId";
        }
        else
        {
            Query = "UPDATE TMS_MasterPreAuthMandatoryDocument SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE DocumentId = @DocumentId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@DocumentId", DocumentId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPreAuthMandatoryDocument.
        Updating TMS_MasterPreAuthMandatoryDocument data.
    */
    public void UpdatePreAuthMandateDocument(string DocumentId, string DocumentName, string DocumentFor)
    {
        string Query = "UPDATE TMS_MasterPreAuthMandatoryDocument SET DocumentName = @DocumentName, DocumentFor = @DocumentFor, UpdatedOn = GETDATE() where DocumentId = @DocumentId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@DocumentId", DocumentId);
        cmd.Parameters.AddWithValue("@DocumentName", DocumentName);
        cmd.Parameters.AddWithValue("@DocumentFor", DocumentFor);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureSpecialRule.
        Inserting data into TMS_MapProcedureSpecialRule.
    */
    public void InsertProcedureSpecialRule(string ProcedureId, string RuleDescription)
    {
        string Query = "INSERT INTO TMS_MapProcedureSpecialRule(ProcedureId, RuleDescription, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@ProcedureId, @RuleDescription, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@RuleDescription", RuleDescription);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureSpecialRule.
        Selecting TMS_MapProcedureSpecialRule data.
    */
    public DataTable GetProcedureRuleMasterData()
    {
        string Query = "SELECT t1.ProcedureSpecialId, t1.ProcedureId, t2.ProcedureCode, t1.RuleDescription, t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn FROM TMS_MapProcedureSpecialRule t1 INNER JOIN  TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId ORDER BY ProcedureSpecialId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureSpecialRule.
        Managing status active or inactive TMS_MapProcedureSpecialRule.
    */
    public void ToogleProcedureRule(string ProcedureSpecialId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MapProcedureSpecialRule SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE ProcedureSpecialId = @ProcedureSpecialId";
        }
        else
        {
            Query = "UPDATE TMS_MapProcedureSpecialRule SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE ProcedureSpecialId = @ProcedureSpecialId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureSpecialId", ProcedureSpecialId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureSpecialRule.
        Updating TMS_MapProcedureSpecialRule data.
    */
    public void UpdateProcedureRule(string ProcedureSpecialId, string ProcedureId, string RuleDescription)
    {
        string Query = "UPDATE TMS_MapProcedureSpecialRule SET ProcedureId = @ProcedureId, RuleDescription = @RuleDescription, UpdatedOn = GETDATE() where ProcedureSpecialId = @ProcedureSpecialId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@RuleDescription", RuleDescription);
        cmd.Parameters.AddWithValue("@ProcedureSpecialId", ProcedureSpecialId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureAddOnPrimary.
        Selecting TMS_MapProcedureAddOnPrimary data.
    */
    public DataTable GetProcedureAddOnPrimaryMasterData()
    {
        string Query = "SELECT t1.ProcedurePrimaryId, t1.ProcedureId, t1.AddOnPrimaryId, t2.ProcedureCode, t3.ProcedureCode AS AddOnProcedureCode, t1.Remarks, t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn FROM TMS_MapProcedureAddOnPrimary t1 INNER JOIN TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId INNER JOIN TMS_MasterPackageDetail t3 ON t1.AddOnPrimaryId = t3.ProcedureId INNER JOIN TMS_MasterPackageMaster t4 ON t2.PackageId = t4.PackageId ORDER BY t1.ProcedurePrimaryId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureAddOnPrimary.
        Inserting data into TMS_MapProcedureAddOnPrimary.
    */
    public void InsertMapProcedureAddOnPrimary(string ProcedureId, string AddOnPrimaryId, string Remarks)
    {
        string Query = "INSERT INTO TMS_MapProcedureAddOnPrimary(ProcedureId, AddOnPrimaryId, Remarks, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@ProcedureId, @AddOnPrimaryId, @Remarks, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@AddOnPrimaryId", AddOnPrimaryId);
        cmd.Parameters.AddWithValue("@Remarks", Remarks);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureAddOnPrimary.
        Updating TMS_MapProcedureAddOnPrimary data.
    */
    public void UpdateMapProcedureAddOnPrimary(string ProcedurePrimaryId, string ProcedureId, string AddOnPrimaryId, string Remarks)
    {
        string Query = "UPDATE TMS_MapProcedureAddOnPrimary SET ProcedureId = @ProcedureId, AddOnPrimaryId = @AddOnPrimaryId, Remarks = @Remarks, UpdatedOn = GETDATE() where ProcedurePrimaryId = @ProcedurePrimaryId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedurePrimaryId", ProcedurePrimaryId);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@AddOnPrimaryId", AddOnPrimaryId);
        cmd.Parameters.AddWithValue("@Remarks", Remarks);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureAddOnPrimary.
        Managing status active or inactive TMS_MapProcedureAddOnPrimary.
    */
    public void ToogleMapProcedureAddOnPrimary(string ProcedurePrimaryId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MapProcedureAddOnPrimary SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE ProcedurePrimaryId = @ProcedurePrimaryId";
        }
        else
        {
            Query = "UPDATE TMS_MapProcedureAddOnPrimary SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE ProcedurePrimaryId = @ProcedurePrimaryId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedurePrimaryId", ProcedurePrimaryId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_Roles.
        Selecting TMS_Roles data.
    */
    public DataTable GetRoles()
    {
        dt.Clear();
        string Query = "SELECT RoleId, RoleName, IsActive, IsDeleted, CreatedOn, UpdatedOn, DeletedOn FROM TMS_Roles ORDER BY RoleId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_Roles.
        Inserting data into TMS_Roles.
    */
    public void AddRoles(string RoleName)
    {
        string Query = "INSERT INTO TMS_Roles(RoleName, IsActive, IsDeleted, CreatedOn, UpdatedOn)values(@RoleName, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@RoleName", RoleName);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_Roles.
        Managing status active or inactive TMS_Roles.
    */
    public void ToogleRole(string RoleId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_Roles SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE RoleId = @RoleId";
        }
        else
        {
            Query = "UPDATE TMS_Roles SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE RoleId = @RoleId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@RoleId", RoleId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_Roles.
        Updating table TMS_Roles.
    */
    public void UpdateRole(string RoleId, string RoleName)
    {
        string Query = "UPDATE TMS_Roles SET RoleName = @RoleName, UpdatedOn = GETDATE() WHERE RoleId = @RoleId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@RoleId", RoleId);
        cmd.Parameters.AddWithValue("@RoleName", RoleName);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPackageMaster.
        Selecting TMS_MasterPackageMaster data.
    */
    public DataTable GetPackageMaster()
    {
        dt.Clear();
        string Query = "SELECT PackageId, SpecialityCode, SpecialityName, IsActive, IsDeleted, CreatedOn, UpdatedOn, DeletedOn from TMS_MasterPackageMaster ORDER BY PackageId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPackageMaster.
        Updating TMS_MasterPackageMaster data.
    */
    public void AddPackage(string SpecialityCode, string SpecialityName)
    {
        string Query = "INSERT INTO TMS_MasterPackageMaster(SpecialityCode, SpecialityName, IsActive, IsDeleted, CreatedOn, UpdatedOn)values(@SpecialityCode, @SpecialityName, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@SpecialityCode", SpecialityCode);
        cmd.Parameters.AddWithValue("@SpecialityName", SpecialityName);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPackageMaster.
        Managing status active or inactive TMS_MasterPackageMaster.
    */
    public void TooglePackageMaster(string PackageId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterPackageMaster SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE PackageId = @PackageId";
        }
        else
        {
            Query = "UPDATE TMS_MasterPackageMaster SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE PackageId = @PackageId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PackageId", PackageId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterPackageMaster.
        Updating table TMS_MasterPackageMaster.
    */
    public void UpdatePackageMaster(string PackageId, string SpecialityCode, string SpecialityName)
    {
        string Query = "UPDATE TMS_MasterPackageMaster SET SpecialityCode = @SpecialityCode, SpecialityName = @SpecialityName, UpdatedOn = GETDATE() WHERE PackageId = @PackageId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PackageId", PackageId);
        cmd.Parameters.AddWithValue("@SpecialityCode", SpecialityCode);
        cmd.Parameters.AddWithValue("@SpecialityName", SpecialityName);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void AddPrimaryDiagnosis(string PrimaryDiagnosisName, string IcdValue)
    {
        string Query = "INSERT INTO TMS_MasterPrimaryDiagnosis(PrimaryDiagnosisName, ICDValue, IsActive, IsDeleted, CreatedOn, UpdatedOn)values(@PrimaryDiagnosisName, @IcdValue, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PrimaryDiagnosisName", PrimaryDiagnosisName);
        cmd.Parameters.AddWithValue("@IcdValue", IcdValue);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetPrimaryDiagnosis()
    {
        dt.Clear();
        string Query = "SELECT PDId, PrimaryDiagnosisName, ICDValue, IsActive, IsDeleted, CreatedOn, UpdatedOn, DeletedOn FROM TMS_MasterPrimaryDiagnosis ORDER BY PDId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void TooglePrimaryDiagnosis(string PDId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterPrimaryDiagnosis SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE PDId = @PDId";
        }
        else
        {
            Query = "UPDATE TMS_MasterPrimaryDiagnosis SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE PDId = @PDId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void UpdatePrimaryDiagnosis(string PDId, string Diagnosis, string IcdValue)
    {
        string Query = "UPDATE TMS_MasterPrimaryDiagnosis SET PrimaryDiagnosisName = @Diagnosis, ICDValue = @IcdValue, UpdatedOn = GETDATE() WHERE PDId = @PDId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@Diagnosis", Diagnosis);
        cmd.Parameters.AddWithValue("@IcdValue", IcdValue);
        cmd.Parameters.AddWithValue("@PDId", PDId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void AddProcedureLabel(string LabelName)
    {
        string Query = "INSERT INTO TMS_MasterProcedureLabel(LabelName, IsActive, IsDeleted, CreatedOn, UpdatedOn)values(@LabelName, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@LabelName", LabelName);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetProcedureLabel()
    {
        dt.Clear();
        string Query = "SELECT ProcedureLabelId, LabelName, IsActive, IsDeleted, CreatedOn, UpdatedOn, DeleteOn from TMS_MasterProcedureLabel ORDER BY ProcedureLabelId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void ToogleProcedureLabel(string ProcedureLabelId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterProcedureLabel SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE ProcedureLabelId = @ProcedureLabelId";
        }
        else
        {
            Query = "UPDATE TMS_MasterProcedureLabel SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE ProcedureLabelId = @ProcedureLabelId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureLabelId", ProcedureLabelId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void UpdateProcedureLabel(string ProcedureLabelId, string LabelName)
    {
        string Query = "UPDATE TMS_MasterProcedureLabel SET LabelName = @LabelName, UpdatedOn = GETDATE() WHERE ProcedureLabelId = @ProcedureLabelId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@LabelName", LabelName);
        cmd.Parameters.AddWithValue("@ProcedureLabelId", ProcedureLabelId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetImplantDetails()
    {
        string Query = "SELECT ImplantId, CONCAT(ImplantCode, ' (' , ImplantName, ')') AS ImplantCode FROM TMS_MasterImplantMaster";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void InsertMapProcedureImplant(string ProcedureId, string ImplantId)
    {
        string Query = "INSERT INTO TMS_MapProcedureImplant(ProcedureId, ImplantId, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@ProcedureId, @ImplantId, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@ImplantId", ImplantId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetMapProcedureImplant()
    {
        dt.Clear();
        string Query = "SELECT t1.ProcedureImplantId, t2.ProcedureId, t2.ProcedureCode, t2.ProcedureName, t2.ProcedureAmount, t3.ImplantId, t3.ImplantCode, t3.ImplantName, t3.ImplantAmount , t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn, t1.DeletedOn FROM TMS_MapProcedureImplant t1 LEFT JOIN TMS_MasterPackageDetail t2 ON t2.ProcedureId = t1.ProcedureId LEFT JOIN TMS_MasterImplantMaster t3 ON t3.ImplantId = t1.ImplantId ORDER BY t1.ProcedureImplantId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void ToogleMapProcedureImplant(string ProcedureImplantId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MapProcedureImplant SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE ProcedureImplantId = @ProcedureImplantId";
        }
        else
        {
            Query = "UPDATE TMS_MapProcedureImplant SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE ProcedureImplantId = @ProcedureImplantId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureImplantId", ProcedureImplantId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void UpdateMapProcedureImplant(string ProcedureImplantId, string ProcedureId, string ImplantId)
    {
        string Query = "UPDATE TMS_MapProcedureImplant SET ProcedureId = @ProcedureId, ImplantId = @ImplantId, UpdatedOn = GETDATE() where ProcedureImplantId = @ProcedureImplantId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureImplantId", ProcedureImplantId);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@ImplantId", ImplantId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetStratificationDetails()
    {
        string Query = "SELECT StratificationId, CONCAT(StratificationCode,' (', StratificationName, '-',StratificationDetail,')') AS StratificationCode FROM TMS_MasterStratificationMaster";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void InsertMapProcedureStratification(string ProcedureId, string StratificationId)
    {
        string Query = "INSERT INTO TMS_MapProcedureStratification(ProcedureId, StratificationId, IsActive, IsDeleted, CreatedOn, UpdatedOn)VALUES(@ProcedureId, @StratificationId, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@StratificationId", StratificationId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public DataTable GetMapProcedureStratification()
    {
        dt.Clear();
        string Query = "SELECT t1.ProcedureStratificationId, t2.ProcedureId, t2.ProcedureCode, t2.ProcedureName, t2.ProcedureAmount, t3.StratificationId, t3.StratificationCode, CONCAT(t3.StratificationName, ' (', t3.StratificationDetail, ')') AS StratificationName, t3.StratificationAmount , t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn, t1.DeletedOn FROM TMS_MapProcedureStratification t1 LEFT JOIN TMS_MasterPackageDetail t2 ON t2.ProcedureId = t1.ProcedureId LEFT JOIN TMS_MasterStratificationMaster t3 ON t3.StratificationId = t1.StratificationId ORDER BY t1.ProcedureStratificationId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(dt);
        con.Close();
        return dt;
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void ToogleMapProcedureStratification(string ProcedureStratificationId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MapProcedureStratification SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE ProcedureStratificationId = @ProcedureStratificationId";
        }
        else
        {
            Query = "UPDATE TMS_MapProcedureStratification SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE ProcedureStratificationId = @ProcedureStratificationId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureStratificationId", ProcedureStratificationId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    /*
        Added by Aemilius Gaurav.
    */
    public void UpdateMapProcedureStratification(string ProcedureStratificationId, string ProcedureId, string StratificationId)
    {
        string Query = "UPDATE TMS_MapProcedureStratification SET ProcedureId = @ProcedureId, StratificationId = @StratificationId, UpdatedOn = GETDATE() where ProcedureStratificationId = @ProcedureStratificationId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureStratificationId", ProcedureStratificationId);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@StratificationId", StratificationId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    //public DataTable GetMasterActions()
    //{
    //    string Query = "select ActionId, ActionName from TMS_MasterActionMaster";
    //    SqlDataAdapter sd = new SqlDataAdapter(Query, con);
    //    con.Open();
    //    sd.Fill(ds);
    //    con.Close();
    //    dt = ds.Tables[0];
    //    return dt;
    //}

    //Package Detail by Harsha
    public DataTable GetPackageDetailsMasterData()
    {
        string Query = "SELECT t1.PackageId, t2.SpecialityName, t1.ProcedureId, t1.ProcedureCode, t1.ProcedureName, t1.ProcedureAmount, t1.IsMultipleProcedure, t1.IsLevelApplied, t1.IsAutoApproved, t1.ProcedureType, t1.Reservance, t1.IsStratificationRequired, t1.MaxStratification, t1.IsImplantRequired, t1.MaxImplant, t1.IsSpecialCondition, t1.ReservationPublicHospital, t1.ReservationTertiaryHospital, t1.LevelOfCare, t1.LOS, PreInvestigation, t1.PostInvestigation, t1.ProcedureLabel, SpecialConditionPopUp, SpecialConditionRule, t1.IsEnhancementApplicable, t1.IsMedicalSurgical, t1.IsDayCare, t1.ClubbingId, t1.ClubbingRemarks, t1.IsCycleBased, t1.NoOfCycle, t1.CycleBasedRemarks, t1.IsSittingProcedure, t1.SittingNoOfDays, t1.SittingProcedureRemarks,  t1.IsActive, t1.CreatedOn, t1.UpdatedOn FROM TMS_MasterPackageDetail t1 inner join TMS_MasterPackageMaster t2 on t1.PackageId = t2.PackageId ORDER BY t1.ProcedureId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public void InsertPackageDetailsMaster(string PackageId, string ProcedureCode, string ProcedureName, string ProcedureAmount, string IsMultipleProcedure, string IsLevelApplied, string IsAutoApproved, string ProcedureType, string Reservance, string IsStratificationRequired, string MaxStratification, string IsImplantRequired, string MaxImplant, string IsSpecialCondition, string ReservationPublicHospital, string ReservationTertiaryHospital, string LevelOfCare, string LOS, string PreInvestigation, string PostInvestigation, string ProcedureLabel, string SpecialConditionPopUp, string SpecialConditionRule, string IsEnhancementApplicable, string IsMedicalSurgical, string IsDayCare, string ClubbingId, string ClubbingRemarks, string IsCycleBased, string NoOfCycle, string CycleBasedRemarks, string IsSittingProcedure, string SittingNoOfDays, string SittingProcedureRemarks)
    {
        string Query = "INSERT INTO TMS_MasterPackageDetail(PackageId, ProcedureCode, ProcedureName, ProcedureAmount, IsMultipleProcedure, IsLevelApplied, IsAutoApproved, ProcedureType, Reservance, IsStratificationRequired, MaxStratification, IsImplantRequired, MaxImplant, IsSpecialCondition, ReservationPublicHospital, ReservationTertiaryHospital, LevelOfCare, LOS, PreInvestigation, PostInvestigation, ProcedureLabel, SpecialConditionPopUp, SpecialConditionRule, IsEnhancementApplicable, IsMedicalSurgical, IsDayCare, ClubbingId, ClubbingRemarks, IsCycleBased, NoOfCycle, CycleBasedRemarks, IsSittingProcedure, SittingNoOfDays, SittingProcedureRemarks, IsActive, IsDeleted, CreatedOn, UpdatedOn) VALUES (@PackageId, @ProcedureCode, @ProcedureName, @ProcedureAmount, @IsMultipleProcedure, @IsLevelApplied, @IsAutoApproved, @ProcedureType, @Reservance, @IsStratificationRequired, @MaxStratification, @IsImplantRequired, @MaxImplant, @IsSpecialCondition, @ReservationPublicHospital, @ReservationTertiaryHospital, @LevelOfCare, @LOS, @PreInvestigation, @PostInvestigation, @ProcedureLabel, @SpecialConditionPopUp, @SpecialConditionRule, @IsEnhancementApplicable, @IsMedicalSurgical, @IsDayCare, @ClubbingId, @ClubbingRemarks, @IsCycleBased, @NoOfCycle, @CycleBasedRemarks, @IsSittingProcedure, @SittingNoOfDays, @SittingProcedureRemarks, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PackageId", PackageId);
        cmd.Parameters.AddWithValue("@ProcedureCode", ProcedureCode);
        cmd.Parameters.AddWithValue("@ProcedureName", ProcedureName);
        cmd.Parameters.AddWithValue("@ProcedureAmount", ProcedureAmount);
        cmd.Parameters.AddWithValue("@IsMultipleProcedure", IsMultipleProcedure);
        cmd.Parameters.AddWithValue("@IsLevelApplied", IsLevelApplied);
        cmd.Parameters.AddWithValue("@IsAutoApproved", IsAutoApproved);
        cmd.Parameters.AddWithValue("@ProcedureType", ProcedureType);
        cmd.Parameters.AddWithValue("@Reservance", Reservance);
        cmd.Parameters.AddWithValue("@IsStratificationRequired", IsStratificationRequired);
        cmd.Parameters.AddWithValue("@MaxStratification", MaxStratification);
        cmd.Parameters.AddWithValue("@IsImplantRequired", IsImplantRequired);
        cmd.Parameters.AddWithValue("@MaxImplant", MaxImplant);
        cmd.Parameters.AddWithValue("@IsSpecialCondition", IsSpecialCondition);
        cmd.Parameters.AddWithValue("@ReservationPublicHospital", ReservationPublicHospital);
        cmd.Parameters.AddWithValue("@ReservationTertiaryHospital", ReservationTertiaryHospital);
        cmd.Parameters.AddWithValue("@LevelOfCare", LevelOfCare);
        cmd.Parameters.AddWithValue("@LOS", LOS);
        cmd.Parameters.AddWithValue("@PreInvestigation", PreInvestigation);
        cmd.Parameters.AddWithValue("@PostInvestigation", PostInvestigation);
        cmd.Parameters.AddWithValue("@ProcedureLabel", ProcedureLabel);
        cmd.Parameters.AddWithValue("@SpecialConditionPopUp", SpecialConditionPopUp);
        cmd.Parameters.AddWithValue("@SpecialConditionRule", SpecialConditionRule);
        cmd.Parameters.AddWithValue("@IsEnhancementApplicable", IsEnhancementApplicable);
        cmd.Parameters.AddWithValue("@IsMedicalSurgical", IsMedicalSurgical);
        cmd.Parameters.AddWithValue("@IsDayCare", IsDayCare);
        cmd.Parameters.AddWithValue("@ClubbingId", ClubbingId);
        cmd.Parameters.AddWithValue("@ClubbingRemarks", ClubbingRemarks);
        cmd.Parameters.AddWithValue("@IsCycleBased", IsCycleBased);
        cmd.Parameters.AddWithValue("@NoOfCycle", NoOfCycle);
        cmd.Parameters.AddWithValue("@CycleBasedRemarks", CycleBasedRemarks);
        cmd.Parameters.AddWithValue("@IsSittingProcedure", IsSittingProcedure);
        cmd.Parameters.AddWithValue("@SittingNoOfDays", SittingNoOfDays);
        cmd.Parameters.AddWithValue("@SittingProcedureRemarks", SittingProcedureRemarks);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void UpdatePackageDetailsMaster(string ProcedureId, string PackageId, string ProcedureCode, string ProcedureName, string ProcedureAmount, string IsMultipleProcedure, string IsLevelApplied, string IsAutoApproved, string ProcedureType, string Reservance, string IsStratificationRequired, string MaxStratification, string IsImplantRequired, string MaxImplant, string IsSpecialCondition, string ReservationPublicHospital, string ReservationTertiaryHospital, string LevelOfCare, string LOS, string PreInvestigation, string PostInvestigation, string ProcedureLabel, string SpecialConditionPopUp, string SpecialConditionRule, string IsEnhancementApplicable, string IsMedicalSurgical, string IsDayCare, string ClubbingId, string ClubbingRemarks, string IsCycleBased, string NoOfCycle, string CycleBasedRemarks, string IsSittingProcedure, string SittingNoOfDays, string SittingProcedureRemarks)
    {
        string Query = "UPDATE TMS_MasterPackageDetail SET PackageId = @PackageId, ProcedureCode = @ProcedureCode, ProcedureName = @ProcedureName, ProcedureAmount = @ProcedureAmount, IsMultipleProcedure = @IsMultipleProcedure, IsLevelApplied = @IsLevelApplied, IsAutoApproved = @IsAutoApproved, ProcedureType = @ProcedureType, Reservance = @Reservance, IsStratificationRequired = @IsStratificationRequired, MaxStratification = @MaxStratification, IsSpecialCondition = @IsSpecialCondition, ReservationPublicHospital = @ReservationPublicHospital, ReservationTertiaryHospital = @ReservationTertiaryHospital, LevelOfCare = @LevelOfCare, LOS = @LOS, PreInvestigation = @PreInvestigation, PostInvestigation = @PostInvestigation, ProcedureLabel = @ProcedureLabel, SpecialConditionPopUp = @SpecialConditionPopUp, SpecialConditionRule = @SpecialConditionRule, IsEnhancementApplicable = @IsEnhancementApplicable, IsMedicalSurgical = @IsMedicalSurgical, IsDayCare = @IsDayCare, ClubbingId = @ClubbingId, ClubbingRemarks = @ClubbingRemarks, IsCycleBased = @IsCycleBased, NoOfCycle = @NoOfCycle, CycleBasedRemarks = @CycleBasedRemarks, IsSittingProcedure = @IsSittingProcedure, SittingNoOfDays = @SittingNoOfDays, SittingProcedureRemarks = @SittingProcedureRemarks, UpdatedOn = GETDATE() WHERE ProcedureId = @ProcedureId;";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PackageId", PackageId);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@ProcedureCode", ProcedureCode);
        cmd.Parameters.AddWithValue("@ProcedureName", ProcedureName);
        cmd.Parameters.AddWithValue("@ProcedureAmount", ProcedureAmount);
        cmd.Parameters.AddWithValue("@IsMultipleProcedure", IsMultipleProcedure);
        cmd.Parameters.AddWithValue("@IsLevelApplied", IsLevelApplied);
        cmd.Parameters.AddWithValue("@IsAutoApproved", IsAutoApproved);
        cmd.Parameters.AddWithValue("@ProcedureType", ProcedureType);
        cmd.Parameters.AddWithValue("@Reservance", Reservance);
        cmd.Parameters.AddWithValue("@IsStratificationRequired", IsStratificationRequired);
        cmd.Parameters.AddWithValue("@MaxStratification", MaxStratification);
        cmd.Parameters.AddWithValue("@IsImplantRequired", IsImplantRequired);
        cmd.Parameters.AddWithValue("@MaxImplant", MaxImplant);
        cmd.Parameters.AddWithValue("@IsSpecialCondition", IsSpecialCondition);
        cmd.Parameters.AddWithValue("@ReservationPublicHospital", ReservationPublicHospital);
        cmd.Parameters.AddWithValue("@ReservationTertiaryHospital", ReservationTertiaryHospital);
        cmd.Parameters.AddWithValue("@LevelOfCare", LevelOfCare);
        cmd.Parameters.AddWithValue("@LOS", LOS);
        cmd.Parameters.AddWithValue("@PreInvestigation", PreInvestigation);
        cmd.Parameters.AddWithValue("@PostInvestigation", PostInvestigation);
        cmd.Parameters.AddWithValue("@ProcedureLabel", ProcedureLabel);
        cmd.Parameters.AddWithValue("@SpecialConditionPopUp", SpecialConditionPopUp);
        cmd.Parameters.AddWithValue("@SpecialConditionRule", SpecialConditionRule);
        cmd.Parameters.AddWithValue("@IsEnhancementApplicable", IsEnhancementApplicable);
        cmd.Parameters.AddWithValue("@IsMedicalSurgical", IsMedicalSurgical);
        cmd.Parameters.AddWithValue("@IsDayCare", IsDayCare);
        cmd.Parameters.AddWithValue("@ClubbingId", ClubbingId);
        cmd.Parameters.AddWithValue("@ClubbingRemarks", ClubbingRemarks);
        cmd.Parameters.AddWithValue("@IsCycleBased", IsCycleBased);
        cmd.Parameters.AddWithValue("@NoOfCycle", NoOfCycle);
        cmd.Parameters.AddWithValue("@CycleBasedRemarks", CycleBasedRemarks);
        cmd.Parameters.AddWithValue("@IsSittingProcedure", IsSittingProcedure);
        cmd.Parameters.AddWithValue("@SittingNoOfDays", SittingNoOfDays);
        cmd.Parameters.AddWithValue("@SittingProcedureRemarks", SittingProcedureRemarks);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void StatusMasterPackage(string ProcedureId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterPackageDetail SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE ProcedureId = @ProcedureId";
        }
        else
        {
            Query = "UPDATE TMS_MasterPackageDetail SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE ProcedureId = @ProcedureId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public DataTable GetClubbingRemarks()
    {
        dt.Clear();
        string Query = "select ClubbingId, ClubbingRemarks from TMS_MasterClubbingRemarks where IsActive=1 and IsDeleted=0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;

    }
    //Master PopUp by Harsha 
    public DataTable GetMasterPopupMasterData()
    {
        string Query = "SELECT PopUpId, PopUpDescription, IsActive, IsDeleted, CreatedOn, UpdatedOn FROM TMS_MasterPopUpMaster ORDER BY PopUpId DESC";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public void InsertMasterPopup(string PopUpDescription)
    {
        string Query = "INSERT INTO TMS_MasterPopUpMaster(PopUpDescription, IsActive, IsDeleted, CreatedOn, UpdatedOn) VALUES(@PopUpDescription, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PopUpDescription", PopUpDescription);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void UpdateMasterPopup(string PopUpId, string PopUpDescription)
    {
        string Query = "UPDATE TMS_MasterPopUpMaster SET PopUpDescription = @PopUpDescription, UpdatedOn = GETDATE() where PopUpId = @PopUpId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PopUpDescription", PopUpDescription);
        cmd.Parameters.AddWithValue("@PopUpId", PopUpId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void StatusMasterPopup(string PopUpId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MasterPopUpMaster SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeletedOn = NULL WHERE PopUpId = @PopUpId";
        }
        else
        {
            Query = "UPDATE TMS_MasterPopUpMaster SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeletedOn = GETDATE() WHERE PopUpId = @PopUpId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PopUpId", PopUpId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    //Map Procedure Non Related by Harsha 
    public DataTable GetMapProcedureNonRelatedData()
    {
        string Query = "SELECT t1.ProcedureNonRelatedId, t1.ProcedureId, t1.NonRelatedId, p1.ProcedureCode AS ProcedureCode_ProcedureId, p2.ProcedureCode AS ProcedureCode_NonRelatedId, t1.Remarks, t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn FROM TMS_MapProcedureNonRelated t1 LEFT JOIN TMS_MasterPackageDetail p1 ON t1.ProcedureId = p1.ProcedureId LEFT JOIN TMS_MasterPackageDetail p2 ON t1.NonRelatedId = p2.ProcedureId ORDER BY t1.ProcedureNonRelatedId DESC;";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }
    public void InsertMapProcedureNonRelated(string PrimaryProcedureCode, string NonRelatedId, string Remarks)
    {
        string Query = "INSERT INTO TMS_MapProcedureNonRelated(ProcedureId, NonRelatedId, Remarks, IsActive, IsDeleted, CreatedOn, UpdatedOn) VALUES(@PrimaryProcedureCode, @NonRelatedId, @Remarks, 1, 0, GETDATE(), GETDATE())";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@PrimaryProcedureCode", PrimaryProcedureCode);
        cmd.Parameters.AddWithValue("@NonRelatedId", NonRelatedId); // Corrected parameter name
        cmd.Parameters.AddWithValue("@Remarks", Remarks);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void UpdateMapProcedureNonRelated(string ProcedureNonRelatedId, string ProcedureId, string NonRelatedId, string Remarks)
    {
        string Query = "UPDATE TMS_MapProcedureNonRelated SET ProcedureId = @ProcedureId, NonRelatedId = @NonRelatedId, Remarks = @Remarks, UpdatedOn = GETDATE() where ProcedureNonRelatedId = @ProcedureNonRelatedId";
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        cmd.Parameters.AddWithValue("@NonRelatedId", NonRelatedId);
        cmd.Parameters.AddWithValue("@Remarks", Remarks);
        cmd.Parameters.AddWithValue("@ProcedureNonRelatedId", ProcedureNonRelatedId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    public void StatusMapProcedureNonRelated(string ProcedureNonRelatedId, bool Status)
    {
        string Query;
        if (Status)
        {
            Query = "UPDATE TMS_MapProcedureNonRelated SET IsActive = 1, IsDeleted = 0, UpdatedOn = GETDATE(), DeleteOn = NULL WHERE ProcedureNonRelatedId = @ProcedureNonRelatedId";
        }
        else
        {
            Query = "UPDATE TMS_MapProcedureNonRelated SET IsActive = 0, IsDeleted = 1, UpdatedOn = GETDATE(), DeleteOn = GETDATE() WHERE ProcedureNonRelatedId = @ProcedureNonRelatedId";
        }
        SqlCommand cmd = new SqlCommand(Query, con);
        cmd.Parameters.AddWithValue("@ProcedureNonRelatedId", ProcedureNonRelatedId);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public DataTable GetProcedureCode()
    {
        dt.Clear();
        string Query = "select ProcedureId, ProcedureCode from TMS_MasterPackageDetail where IsActive=1 and IsDeleted=0";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;

    }
}
