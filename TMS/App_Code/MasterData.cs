﻿using System;
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
        Updating TMS_Roles data.
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
        Added by TMS_MasterPackageMaster.
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

}
