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
    Added by Shivani.
    Retrieving Action Details From Table TMS_MasterActionMaster
*/
    public DataTable GetActionDetail()
    {

        try
        {
            string Query = @"
        SELECT 
            ActionId, 
            ActionName, 
            CASE WHEN PPD = 1 THEN 'Active' ELSE 'Inactive' END AS PPD, 
            CASE WHEN CEX = 1 THEN 'Active' ELSE 'Inactive' END AS CEX, 
            CASE WHEN CPD = 1 THEN 'Active' ELSE 'Inactive' END AS CPD, 
            CASE WHEN ACO = 1 THEN 'Active' ELSE 'Inactive' END AS ACO, 
            CASE WHEN SHA = 1 THEN 'Active' ELSE 'Inactive' END AS SHA, 
            CASE WHEN IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive, 
            FORMAT(CreatedOn, 'dd-MMM-yyyy') AS CreatedOn 
        FROM TMS_MasterActionMaster";

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();

            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return dt;
    }

    /*
        Added by Shivani.
        Checking Duplicacy of Action Name From Table TMS_MasterActionMaster
    */
    public bool CheckDuplicateActionMaster(string actionName)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MasterActionMaster WHERE ActionName = @ActionName";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ActionName", actionName);

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

    /*
        Added by Shivani.
        Inserting Action Into TMS_MasterActionMaster
    */
    public bool AddActionMaster(string actionName, bool ppd, bool cex, bool cpd, bool aco, bool sha)
    {
        try
        {
            string query = @"INSERT INTO TMS_MasterActionMaster (ActionName, PPD, CEX, CPD, ACO, SHA, CreatedOn, IsActive)
                           VALUES (@ActionName, @PPD, @CEX, @CPD, @ACO, @SHA, GETDATE(), 1)";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@ActionName", actionName);
            sd.InsertCommand.Parameters.AddWithValue("@PPD", ppd);
            sd.InsertCommand.Parameters.AddWithValue("@CEX", cex);
            sd.InsertCommand.Parameters.AddWithValue("@CPD", cpd);
            sd.InsertCommand.Parameters.AddWithValue("@ACO", aco);
            sd.InsertCommand.Parameters.AddWithValue("@SHA", sha);

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

    /*
        Added by Shivani.
        Updating Active Status of Action In Table TMS_MasterActionMaster
    */
    public bool UpdateActionStatus(int actionId)
    {
        try
        {
            string query = "UPDATE TMS_MasterActionMaster SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ActionId = @ActionId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ActionId", actionId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
       Added by Shivani.
       Retrieving Action Details On Behalf of ActionId from Table TMS_MasterActionMaster
   */
    public DataTable GetActionDetailsById(int actionId)
    {
        try
        {
            string query = "SELECT ActionName, PPD, CEX, CPD, ACO, SHA FROM TMS_MasterActionMaster WHERE ActionId = @ActionId";

            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@ActionId", actionId);

            con.Open();
            sd.Fill(dt);
            con.Close();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            throw new Exception("Error fetching action details", ex);
        }
        return dt;
    }

    /*
        Added by Shivani.
        Checking Action Name Duplicacy While Updating.
    */
    public bool CheckActionNameDuplicacy(int actionId, string actionName)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MasterActionMaster WHERE ActionName = @ActionName and ActionId <> @ActionId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ActionId", actionId);
            cmd.Parameters.AddWithValue("@ActionName", actionName);

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

    /*
        Added by Shivani.
        Updating Table TMS_MasterActionMaster
    */
    public bool UpdateActionNew(int actionId, string actionName, bool ppd, bool cex, bool cpd, bool aco, bool sha)
    {
        try
        {
            string query = @"UPDATE TMS_MasterActionMaster SET ActionName = @ActionName, PPD = @PPD, CEX = @CEX, CPD = @CPD, ACO = @ACO, SHA = @SHA WHERE ActionId = @ActionId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ActionId", actionId);
            sd.UpdateCommand.Parameters.AddWithValue("@ActionName", actionName);
            sd.UpdateCommand.Parameters.AddWithValue("@PPD", ppd);
            sd.UpdateCommand.Parameters.AddWithValue("@CEX", cex);
            sd.UpdateCommand.Parameters.AddWithValue("@CPD", cpd);
            sd.UpdateCommand.Parameters.AddWithValue("@ACO", aco);
            sd.UpdateCommand.Parameters.AddWithValue("@SHA", sha);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
     Added by Shivani.
     Retrieving Data From Table TMS_MasterPackageMaster
 */
    public DataTable GetMapAddOnDetail()
    {
        try
        {
            string Query = @"
                     SELECT 
                         A1.PackageAddOnId, 
                         A2.SpecialityCode + '(' + A2.SpecialityName + ')' AS Speciality, 
                         A3.ProcedureCode AS ProcedureCode,
                         CASE WHEN A1.IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive,
                         FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn 
                     FROM  
                     TMS_MapPackageAddOn A1 
                     LEFT JOIN  
                         TMS_MasterPackageMaster A2 
                            ON A1.PackageId = A2.PackageId 
                     LEFT JOIN 
                         TMS_MasterPackageDetail A3  
                             ON A1.ProcedureCode = A3.ProcedureId;";

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();

            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return dt;
    }

    /*
      Added by Shivani.
      Updating Active Status of table TMS_MapPackageAddOn
    */
    public bool UpdateMApAddOnStatus(int packageAddOnId)
    {
        try
        {
            DataTable dt = new DataTable(); // To adhere to the required style
            string query = "UPDATE TMS_MapPackageAddOn SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE PackageAddOnId = @PackageAddOnId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@PackageAddOnId", packageAddOnId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            // Optionally log or rethrow the exception
            throw new Exception("Error updating action status", ex);
        }
    }

    /*
        Added by Shivani.
        Checking Duplicacy Mapped Package Add On From Table TMS_MapPackageAddOn
    */
    public bool CheckDuplicatePackageAddOn(string packageId, string procedureId)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapPackageAddOn WHERE PackageId = @PackageId AND ProcedureCode = @ProcedureCode";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PackageId", packageId);
            cmd.Parameters.AddWithValue("@ProcedureCode", procedureId);

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

    /*
        Added by Shivani.
        Inserting New Entry in Map Package AddOn
        Table : TMS_MapPackageAddOn
    */
    public bool AddPackageAddOn(string packageId, string procedureId)
    {
        try
        {
            string query = @"INSERT INTO TMS_MapPackageAddOn (PackageId, ProcedureCode, IsActive, CreatedOn, IsDeleted, UpdatedOn)
                             VALUES (@PackageId, @ProcedureId, 1, GETDATE(), 0, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@PackageId", packageId);
            sd.InsertCommand.Parameters.AddWithValue("@ProcedureId", procedureId);

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

    /*
       Added by Shivani.
       Fetching Mapped AddOn Details By PackageAddOnId
       Table: TMS_MapPackageAddOn
   */
    public DataTable GetAddOnDetailsById(int packageAddOnId)
    {
        DataTable dt = new DataTable();
        try
        {
            string query = @"
         SELECT 
             A1.PackageAddOnId, 
             A1.PackageId,
             A1.ProcedureCode,
             A2.SpecialityName,
             A2.SpecialityCode + '(' + A2.SpecialityName + ')' AS Speciality,
             A3.ProcedureCode AS MapProcedureCode,
             CASE WHEN A1.IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive,
             FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn
         FROM
             TMS_MapPackageAddOn A1
         LEFT JOIN
             TMS_MasterPackageMaster A2
             ON A1.PackageId = A2.PackageId
         LEFT JOIN
             TMS_MasterPackageDetail A3
             ON A1.ProcedureCode = A3.ProcedureId
         WHERE 
             A1.PackageAddOnId = @PackageAddOnId;";

            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@PackageAddOnId", packageAddOnId);

            con.Open();
            sd.Fill(dt);
            con.Close();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            throw new Exception("Error fetching action details", ex);
        }
        return dt;
    }

    /*
        Added by Shivani.
        Check Duplicacy While Updating Map Package AddOn
        Table: TMS_MapPackageAddOn
    */
    public bool CheckAddOnDuplicacy(int packageId, int procedureId, int packageAddOnId)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapPackageAddOn WHERE PackageId = @PackageId AND ProcedureCode = @ProcedureId AND PackageAddOnId <> @PackageAddOnId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProcedureId", procedureId);
            cmd.Parameters.AddWithValue("@PackageId", packageId);
            cmd.Parameters.AddWithValue("@PackageAddOnId", packageAddOnId);

            con.Open();
            int existingRecords = (cmd.ExecuteScalar() as int? ?? 0);
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

    /*
        Added by Shivani.
        Updating Mapped Package AddOn
        Table: TMS_MapPackageAddOn
    */
    public bool UpdateMapAddOnNew(int packageAddOnId, int packageId, int procedureId)
    {
        try
        {
            string query = @"UPDATE TMS_MapPackageAddOn SET PackageId = @PackageId,ProcedureCode = @ProcedureId,UpdatedOn = GETDATE() WHERE PackageAddOnId = @PackageAddOnId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@PackageId", packageId);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedureId", procedureId);
            sd.UpdateCommand.Parameters.AddWithValue("@PackageAddOnId", packageAddOnId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
        Added by Shivani.
        Retrieving Stratification Master Details
        Table: TMS_MasterStratificationMaster
    */
    public DataTable GetStratDetail()
    {

        try
        {
            string Query = @"
        SELECT 
             StratificationId,StratificationCode,StratificationName,StratificationDetail,StratificationAmount,
             CASE WHEN IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive, 
             FORMAT(CreatedOn, 'dd-MMM-yyyy') AS CreatedOn 
        FROM TMS_MasterStratificationMaster";

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();

            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return dt;
    }

    /*
        Added by Shivani.
        Checking Duplicacy of stratification Code  
        Table TMS_MasterStratificationMaster
    */
    public bool CheckDuplicateStratMaster(string stratCode)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MasterStratificationMaster WHERE StratificationCode = @StratificationCode";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@StratificationCode", stratCode);

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

    /*
        Added by Shivani.
         Inserting Streatification Into Table TMS_MasterStratificationMaster
    */
    public bool AddStratMaster(string stratCode, string stratName, string stratDetails, string stratAmount)
    {
        try
        {
            string query = @"INSERT INTO TMS_MasterStratificationMaster
            (StratificationCode, StratificationName, StratificationDetail, StratificationAmount, CreatedOn,UpdatedOn, IsActive,IsDeleted)
        VALUES
            (@StratificationCode, @StratificationName, @StratificationDetail, @StratificationAmount, GETDATE(),GETDATE(), 1,0)";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@StratificationCode", stratCode);
            sd.InsertCommand.Parameters.AddWithValue("@StratificationName", stratName);
            sd.InsertCommand.Parameters.AddWithValue("@StratificationDetail", stratDetails);
            sd.InsertCommand.Parameters.AddWithValue("@StratificationAmount", stratAmount);

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

    /*
       Added by Shivani.
       Stratification Details by Id
       Table TMS_MasterStratificationMaster
   */
    public DataTable GetStratDetailsById(long stratificationId)
    {
        try
        {
            string query = "Select StratificationCode,StratificationName,StratificationDetail,StratificationAmount FROM TMS_MasterStratificationMaster WHERE StratificationId = @StratificationId";

            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@StratificationId", stratificationId);

            con.Open();
            sd.Fill(dt);
            con.Close();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            throw new Exception("Error fetching action details", ex);
        }
        return dt;
    }

    /*
        Added by Shivani.
        Checking Stratification Duplicacy While Updating.
        Table: TMS_MasterStratificationMaster 
    */
    public bool CheckStratCodeDuplicacy(long stratificationId, string stratCode)
    {

        try
        {
            string query = @"SELECT COUNT(1)  FROM TMS_MasterStratificationMaster WHERE StratificationCode = @StratificationCode AND StratificationId <> @StratificationId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@StratificationCode", stratCode);
            cmd.Parameters.AddWithValue("@StratificationId", stratificationId);

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

    /*
        Added by Shivani.
        Updating Table TMS_MasterStratificationMaster
    */
    public bool UpdateStratNew(long stratificationId, string stratCode, string stratName, string stratDetails, string stratAmount)
    {
        try
        {
            string query = @"UPDATE TMS_MasterStratificationMaster SET StratificationCode = @StratificationCode, StratificationName = @StratificationName, StratificationDetail = @StratificationDetail,StratificationAmount = @StratificationAmount,UpdatedOn = GETDATE() WHERE StratificationId = @StratificationId;";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationId", stratificationId);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationCode", stratCode);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationName", stratName);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationDetail", stratDetails);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationAmount", stratAmount);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
      Added by Shivani.
      Updating Active status from Table TMS_MasterStratificationMaster
    */
    public bool UpdateStratStatus(int stratificationId)
    {
        try
        {
            DataTable dt = new DataTable(); // To adhere to the required style
            string query = "UPDATE TMS_MasterStratificationMaster SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE StratificationId = @StratificationId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@StratificationId", stratificationId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            // Optionally log or rethrow the exception
            throw new Exception("Error updating action status", ex);
        }
    }


    /*
        Added by Shivani.
        Retrieving Map Procedure FollowUp Details
    */
    public DataTable GetProceduireFollowUpDetail()
    {
        try
        {
            string Query = @"
                    SELECT  A1.ProcedureFollowId,
                            A1.ProcedureId,
                            A2.ProcedureCode AS ProcedureCode, 
                            A1.FollowUpId,
                            A3.ProcedureCode AS ProcedureFollowUpCode,
                    CASE 
                            WHEN A1.IsActive = 1 THEN 'Active' 
                            ELSE 'Inactive' 
                            END AS IsActive,
                    FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn
                    FROM 
                    TMS_MapProcedureFollowUp A1
                    LEFT JOIN 
                        TMS_MasterPackageDetail A2
                            ON A1.ProcedureId = A2.ProcedureId
                    LEFT JOIN 
                        TMS_MasterPackageDetail A3
                            ON A1.FollowUpId = A3.ProcedureId;";

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();

            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return dt;
    }

    /*
        Added by Shivani.
        Checking Duplicacy while Inserting from Table TMS_MapProcedureFollowUp
    */
    public bool CheckDuplicateFollowup(string procedureId, string followUpId)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapProcedureFollowUp WHERE ProcedureId = @ProcedureId AND FollowUpId = @FollowUpId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@FollowUpId", followUpId);
            cmd.Parameters.AddWithValue("@ProcedureId", procedureId);

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

    /*
        Added by Shivani.
        Inserting Mapped Procedure FollowUp in Table TMS_MapProcedureFollowUp
    */
    public bool AddMapFollowUp(string procedureId, string followUpId)
    {
        try
        {
            string query = @"INSERT INTO TMS_MapProcedureFollowUp (ProcedureId, FollowUpId, IsActive, CreatedOn, IsDeleted, UpdatedOn)
                             VALUES (@ProcedureId, @FollowUpId, 1, GETDATE(), 0, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@ProcedureId", procedureId);
            sd.InsertCommand.Parameters.AddWithValue("@FollowUpId", followUpId);

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

    /*
       Added by Shivani.
       Retrieving Mapped FollowUp Details By Id
       Table: TMS_MapProcedureFollowUp
   */
    public DataTable GetFollowDetailsById(int followUpId)
    {
        DataTable dt = new DataTable();
        try
        {
            string query = @"
         SELECT 
             A1.ProcedureFollowId,
             A1.ProcedureId,
             A2.ProcedureCode AS ProcedureCode, 
          A1.FollowUpId,
             A3.ProcedureCode AS ProcedureFollowUpCode,
             CASE WHEN A1.IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive,
             FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn
         FROM
             TMS_MapProcedureFollowUp A1
         LEFT JOIN 
             TMS_MasterPackageDetail A2
                 ON A1.ProcedureId = A2.ProcedureId
         LEFT JOIN 
             TMS_MasterPackageDetail A3
                 ON A1.FollowUpId = A3.ProcedureId
         WHERE 
             A1.ProcedureFollowId = @ProcedureFollowId;";

            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@ProcedureFollowId", followUpId);

            con.Open();
            sd.Fill(dt);
            con.Close();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            throw new Exception("Error fetching action details", ex);
        }
        return dt;
    }

    /*
        Added by Shivani.
        Checking Duplicacy while Updating Table TMS_MapProcedureFollowUp
    */
    public bool CheckFollowUpDuplicacy(int ProcedureFollowId, int followUpId, int procedureId)
    {
        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapProcedureFollowUp WHERE ProcedureId = @ProcedureId AND FollowUpId = @FollowUpId AND ProcedureFollowId <> @ProcedureFollowId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProcedureId", procedureId);
            cmd.Parameters.AddWithValue("@FollowUpId", followUpId);
            cmd.Parameters.AddWithValue("@ProcedureFollowId", ProcedureFollowId);

            con.Open();
            int existingRecords = (cmd.ExecuteScalar() as int? ?? 0);
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

    /*
        Added by Shivani.
        Updating Mapped Procedure FollowUp Table TMS_MapProcedureFollowUp
    */
    public bool UpdateProcedureFollowUpNew(int ProcedureFollowId, int followUpId, int procedureId)
    {
        try
        {
            string query = @"UPDATE TMS_MapProcedureFollowUp SET ProcedureId = @ProcedureId , FollowUpId = @FollowUpId , UpdatedOn = GETDATE() WHERE ProcedureFollowId = @ProcedureFollowId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedureId", procedureId);
            sd.UpdateCommand.Parameters.AddWithValue("@FollowUpId", followUpId);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedureFollowId", ProcedureFollowId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
      Added by Shivani.
      Updating Active Status From TMS_MapProcedureFollowUp
    */
    public bool UpdateMapProcedureFollowUpStatus(int procedureFollowId)
    {
        try
        {
            DataTable dt = new DataTable();
            string query = "UPDATE TMS_MapProcedureFollowUp SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ProcedureFollowId = @ProcedureFollowId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedureFollowId", procedureFollowId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            // Optionally log or rethrow the exception
            throw new Exception("Error updating action status", ex);
        }
    }


    /*
        Added by Shivani.
        Retrieving Mapped Procedure PopUp
    */
    public DataTable GetMapPopUpDetail()
    {
        try
        {
            string Query = @"SELECT A1.ProcedurePopUpId,A2.PopUpDescription,A3.ProcedureCode, A4.RoleName, 
                                CASE WHEN A1.IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS IsActive,
                                FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn FROM TMS_MapProcedurePopUp A1 LEFT JOIN TMS_MasterPopUpMaster A2 ON A1.PopUpId=A2.PopUpId
                           LEFT JOIN TMS_MasterPackageDetail A3 ON A1.ProcedureId = A3.ProcedureId LEFT JOIN TMS_Roles A4 ON A1.PopUpRoleId = A4.RoleId";

            SqlDataAdapter sd = new SqlDataAdapter(Query, con);
            con.Open();
            sd.Fill(ds);
            con.Close();

            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return dt;
    }

    /*
        Added by Shivani.
        Retriving PopUp Description From Table TMS_MasterPopUpMaster
    */
    public DataTable GetPopDescription()
    {
        dt.Clear();
        try
        {
            string Query = "select PopUpId,PopUpDescription from TMS_MasterPopUpMaster where IsActive=1 and IsDeleted=0";
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

    /*
        Added by Shivani.
        Checking Duplicacy while Inserting Data in Table TMS_MapProcedurePopUp
    */
    public bool CheckDuplicateMappedPopUp(int popUpId, int popUpRoleId, int procedureId)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapProcedurePopUp WHERE PopUpId = @PopUpId AND ProcedureId = @ProcedureId AND PopUpRoleId = @PopUpRoleId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PopUpId", popUpId);
            cmd.Parameters.AddWithValue("@PopUpRoleId", popUpRoleId);
            cmd.Parameters.AddWithValue("@ProcedureId", procedureId);

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

    /*
        Added by Shivani.
        Inserting Data into TMS_MapProcedurePopUp
    */
    public bool AddMappedPopUp(int popUpId, int popUpRoleId, int procedureId)
    {
        try
        {
            string query = @"INSERT INTO TMS_MapProcedurePopUp (PopUpId, ProcedureId,PopUpRoleId, IsActive, CreatedOn, IsDeleted, UpdatedOn)
                             VALUES (@PopUpId, @ProcedureId,@PopUpRoleId, 1, GETDATE(), 0, GETDATE())";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.InsertCommand = new SqlCommand(query, con);
            sd.InsertCommand.Parameters.AddWithValue("@PopUpId", popUpId);
            sd.InsertCommand.Parameters.AddWithValue("@PopUpRoleId", popUpRoleId);
            sd.InsertCommand.Parameters.AddWithValue("@ProcedureId", procedureId);

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

    /*
        Added by Shivani.
        Retriving Mapped PopUp Details By Id  TMS_MapProcedurePopUp
    */
    public DataTable GetMappedPopUpDetailsById(int procedurePopUpId)
    {
        DataTable dt = new DataTable();
        try
        {
            string query = @"SELECT A1.ProcedurePopUpId,A1.ProcedureId,A1.PopUpRoleId,A1.PopUpId,A2.PopUpDescription,A3.ProcedureCode, A4.RoleName, A1.IsActive,FORMAT(A1.CreatedOn, 'dd-MMM-yyyy') AS CreatedOn FROM TMS_MapProcedurePopUp A1 LEFT JOIN TMS_MasterPopUpMaster A2 ON A1.PopUpId=A2.PopUpId
                           LEFT JOIN TMS_MasterPackageDetail A3 ON A1.ProcedureId = A3.ProcedureId LEFT JOIN TMS_Roles A4 ON A1.PopUpRoleId = A4.RoleId WHERE A1.ProcedurePopUpId = @ProcedurePopUpId";

            SqlDataAdapter sd = new SqlDataAdapter(query, con);
            sd.SelectCommand.Parameters.AddWithValue("@ProcedurePopUpId", procedurePopUpId);

            con.Open();
            sd.Fill(dt);
            con.Close();
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            throw new Exception("Error fetching action details", ex);
        }
        return dt;
    }

    /*
        Added by Shivani.
        Checking Du8plicacy while Updating Table TMS_MapProcedurePopUp
    */
    public bool CheckMappedPopUpDuplicacy(int popUpId, int procedureId, int popUpRoleId, int procedurePopUpId)
    {

        try
        {
            string query = @"SELECT COUNT(1) FROM TMS_MapProcedurePopUp WHERE PopUpId = @PopUpId AND ProcedureId = @ProcedureId AND PopUpRoleId = @PopUpRoleId AND ProcedurePopUpId <> @ProcedurePopUpId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PopUpId", popUpId);
            cmd.Parameters.AddWithValue("@ProcedureId", procedureId);
            cmd.Parameters.AddWithValue("@PopUpRoleId", popUpRoleId);
            cmd.Parameters.AddWithValue("@ProcedurePopUpId", procedurePopUpId);

            con.Open();
            int existingRecords = (cmd.ExecuteScalar() as int? ?? 0);
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

    /*
        Added by Shivani.
        Updating Table TMS_MapProcedurePopUp
    */
    public bool UpdateMapPopUpNew(int procedurePopUpId, int popUpId, int procedureId, int popUpRoleId)
    {
        try
        {
            string query = @"UPDATE TMS_MapProcedurePopUp SET PopUpId = @PopUpId, ProcedureId = @ProcedureId,PopUpRoleId = @PopUpRoleId,UpdatedOn = GETDATE() WHERE ProcedurePopUpId = @ProcedurePopUpId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedurePopUpId", procedurePopUpId);
            sd.UpdateCommand.Parameters.AddWithValue("@PopUpId", popUpId);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedureId", procedureId);
            sd.UpdateCommand.Parameters.AddWithValue("@PopUpRoleId", popUpRoleId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
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

    /*
        Added by Shivani.
        Updating Active Status from table TMS_MapProcedurePopUp
    */
    public bool UpdateMApPopUpStatus(int procedurePopUpId)
    {
        try
        {
            DataTable dt = new DataTable(); // To adhere to the required style
            string query = "UPDATE TMS_MapProcedurePopUp SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ProcedurePopUpId = @ProcedurePopUpId";

            SqlDataAdapter sd = new SqlDataAdapter();
            sd.UpdateCommand = new SqlCommand(query, con);
            sd.UpdateCommand.Parameters.AddWithValue("@ProcedurePopUpId", procedurePopUpId);

            con.Open();
            int rowsAffected = sd.UpdateCommand.ExecuteNonQuery();
            con.Close();

            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            // Optionally log or rethrow the exception
            throw new Exception("Error updating action status", ex);
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
        Searching TMS_MasterImplantMaster data.
    */
    public DataTable SearchImplantMasterData(string ImplantCode)
    {
        string Query = "SELECT ImplantId, ImplantCode, ImplantName, MaxImplant, ImplantAmount, IsActive, CreatedOn, UpdatedOn FROM TMS_MasterImplantMaster WHERE ImplantCode = @ImplantCode";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ImplantCode", ImplantCode);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MasterImplantMaster.
        Checking duplicate record TMS_MasterImplantMaster table.
    */
    public DataTable CheckExistingImplant(string ImplantCode, string ImplantName)
    {
        string Query = "SELECT ImplantId FROM TMS_MasterImplantMaster WHERE ImplantCode = @ImplantCode AND ImplantName = @ImplantName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ImplantCode", ImplantCode);
        sd.SelectCommand.Parameters.AddWithValue("@ImplantName", ImplantName);
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
        Checking duplicate record TMS_MasterPreAuthMandatoryDocument table.
    */
    public DataTable CheckExistingMandateDocument(string DocumentName)
    {
        string Query = "SELECT DocumentId FROM TMS_MasterPreAuthMandatoryDocument WHERE DocumentName = @DocumentName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DocumentName", DocumentName);
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
        Searching TMS_MasterPreAuthMandatoryDocument data.
    */
    public DataTable SearchPreAuthManditoryDocument(string DocumentName)
    {
        string Query = "SELECT DocumentId, DocumentName, DocumentFor, IsActive, IsDeleted, CreatedOn, UpdatedOn FROM TMS_MasterPreAuthMandatoryDocument WHERE DocumentName = @DocumentName";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@DocumentName", DocumentName);
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
        Checking duplicate record TMS_MapProcedureSpecialRule table.
    */
    public DataTable CheckExistingMapProcedureSpecialRule(string ProcedureId)
    {
        string Query = "SELECT ProcedureSpecialId FROM TMS_MapProcedureSpecialRule WHERE ProcedureId = @ProcedureId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
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
        Searching TMS_MapProcedureSpecialRule data.
    */
    public DataTable SearchProcedureRuleMasterData(string ProcedureCode)
    {
        string Query = "SELECT t1.ProcedureSpecialId, t1.ProcedureId, t2.ProcedureCode, t1.RuleDescription, t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn FROM TMS_MapProcedureSpecialRule t1 INNER JOIN  TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId WHERE t2.ProcedureCode = @ProcedureCode";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureCode", ProcedureCode);
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
        Searching TMS_MapProcedureAddOnPrimary data.
    */
    public DataTable SearchProcedureAddOnPrimaryMasterData(string ProcedureCode)
    {
        string Query = "SELECT t1.ProcedurePrimaryId, t1.ProcedureId, t1.AddOnPrimaryId, t2.ProcedureCode, t3.ProcedureCode AS AddOnProcedureCode, t1.Remarks, t1.IsActive, t1.IsDeleted, t1.CreatedOn, t1.UpdatedOn FROM TMS_MapProcedureAddOnPrimary t1 INNER JOIN TMS_MasterPackageDetail t2 ON t1.ProcedureId = t2.ProcedureId INNER JOIN TMS_MasterPackageDetail t3 ON t1.AddOnPrimaryId = t3.ProcedureId INNER JOIN TMS_MasterPackageMaster t4 ON t2.PackageId = t4.PackageId WHERE t2.ProcedureCode = @ProcedureCode OR t3.ProcedureCode = @ProcedureCode";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureCode", ProcedureCode);
        con.Open();
        sd.Fill(ds);
        con.Close();
        dt = ds.Tables[0];
        return dt;
    }

    /*
        Added by Nirmal.
        Table: TMS_MapProcedureAddOnPrimary.
        Checking duplicate record TMS_MapProcedureAddOnPrimary table.
    */
    public DataTable CheckExistingMapProcedureAddOnPrimary(string ProcedureId, string AddOnPrimaryId)
    {
        string Query = "SELECT ProcedurePrimaryId FROM TMS_MapProcedureAddOnPrimary WHERE ProcedureId = @ProcedureId AND AddOnPrimaryId = @AddOnPrimaryId";
        SqlDataAdapter sd = new SqlDataAdapter(Query, con);
        sd.SelectCommand.Parameters.AddWithValue("@ProcedureId", ProcedureId);
        sd.SelectCommand.Parameters.AddWithValue("@AddOnPrimaryId", AddOnPrimaryId);
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
