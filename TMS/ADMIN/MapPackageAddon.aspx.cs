using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ADMIN_MapPackageAddon : System.Web.UI.Page
{
    private string strMessage;
    string pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private CEX cex = new CEX();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pageName = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Unauthorize.aspx", false);
                return;
            }
            else if (!IsPostBack)
            {
                if (Session["RoleId"].ToString() == "1" && Session["RoleName"].ToString() == "ADMIN")
                {
                    getSpecialityName();
                    getProcedureCode();
                    GetMapAddonDetails();
                }
                else
                {
                    Response.Redirect("~/Unauthorize.aspx", false);
                }
            }
        }
        catch (Exception ex)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }


    protected void getSpecialityName()
    {
        try
        {
            dt = cex.GetSpecialityName();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddSpecialityName.Items.Clear();
                ddSpecialityName.DataValueField = "PackageId";
                ddSpecialityName.DataTextField = "SpecialityName";
                ddSpecialityName.DataSource = dt;
                ddSpecialityName.DataBind();
                ddSpecialityName.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddSpecialityName.Items.Clear();
                ddSpecialityName.Items.Insert(0, new ListItem("--No Speciality Name Available--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void getProcedureCode()
    {
        try
        {
            dt = cex.GetProcedureCode();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddProcedureCode.Items.Clear();
                ddProcedureCode.DataValueField = "ProcedureId";
                ddProcedureCode.DataTextField = "ProcedureCode";
                ddProcedureCode.DataSource = dt;
                ddProcedureCode.DataBind();
                ddProcedureCode.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddProcedureCode.Items.Clear();
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnActiveStatus_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;

            int packageAddOnId = Convert.ToInt32(btn.CommandArgument);

            bool isUpdated = md.UpdateMApAddOnStatus(packageAddOnId);

            if (isUpdated)
            {
                gridPackageAddOn.DataBind();
                GetMapAddonDetails();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void ClearAll()
    {
        ddSpecialityName.SelectedIndex = 0;
        ddProcedureCode.SelectedIndex = 0;
        btnSubmit.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddSpecialityName.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            string packageId = ddSpecialityName.SelectedValue.Trim();
            string procedureId = ddProcedureCode.SelectedValue;

            bool checkDuplicate = md.CheckDuplicatePackageAddOn(packageId, procedureId);
            if (checkDuplicate)
            {
                strMessage = "window.alert('This AddOn is Already Registered!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
                return;
            }

            bool resultId = md.AddPackageAddOn(packageId, procedureId);

            if (resultId)
            {
                ClearAll();
                GetMapAddonDetails();
                strMessage = "window.alert('Registered Successfully!');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
            else
            {
                strMessage = "window.alert('Failed to Register the AddOn.');";
                ScriptManager.RegisterStartupScript(btnSubmit, btnSubmit.GetType(), "Result", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddSpecialityName.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            if (ddProcedureCode.SelectedIndex == 0)
            {
                strMessage = "window.alert('Please Fill Required Details!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnSubmit.GetType(), "Error", strMessage, true);
                return;
            }
            
            int packageAddOnId;
            if (!int.TryParse(hdAddOnId.Value, out packageAddOnId))
            {
                strMessage = "window.alert('Invalid AddOn ID!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                return;
            }

            int packageId = int.Parse(ddSpecialityName.SelectedValue.Trim());
            int procedureId = int.Parse(ddProcedureCode.SelectedValue.Trim());

            DataTable currentAddonDetails = md.GetAddOnDetailsById(packageAddOnId);

            if (currentAddonDetails.Rows.Count > 0)
            {
                var currentData = currentAddonDetails.Rows[0];

                int currentPackageId = Convert.ToInt32(currentData["PackageId"]);
                int currentProcedureId = Convert.ToInt32(currentData["ProcedureCode"]);

                if (currentPackageId == packageId && currentProcedureId == procedureId)
                {
                    strMessage = "window.alert('Please make any changes to update the Package AddOn.');";
                    ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                    return;
                }
                else
                {
                    bool isDuplicateEntryinAddon = md.CheckAddOnDuplicacy(packageId, procedureId, packageAddOnId);
                    if (isDuplicateEntryinAddon)
                    {
                        strMessage = "window.alert('The combination you have entered already exists. Please choose a different combination!');";
                        ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Error", strMessage, true);
                        return;
                    }
                }
            }
            bool IsUpdated = md.UpdateMapAddOnNew(packageAddOnId,packageId, procedureId);

            if (IsUpdated)
            {
                ClearAll();
                GetMapAddonDetails();
                strMessage = "window.alert('Updated Successfully!');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);

            }
            else
            {
                strMessage = "window.alert('Failed to Update the AddOn.');";
                ScriptManager.RegisterStartupScript(btnUpdate, btnUpdate.GetType(), "Result", strMessage, true);
            }
        }
        catch (Exception ex)
        {
            md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
            Response.Redirect("~/Unauthorize.aspx", false);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

    protected void gridPackageAddOn_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditAddOn")
        {
            try
            {
                ddSpecialityName.SelectedIndex = 0;
                ddProcedureCode.SelectedIndex = 0;
                int packageAddOnId = Convert.ToInt32(e.CommandArgument);

                DataTable PackageAddOnIdDetail = md.GetAddOnDetailsById(packageAddOnId);

                if (PackageAddOnIdDetail.Rows.Count > 0)
                {
                    string specialityName = PackageAddOnIdDetail.Rows[0]["SpecialityName"].ToString();
                    string procedureCode = PackageAddOnIdDetail.Rows[0]["MapProcedureCode"].ToString();
                    if (ddSpecialityName.Items.FindByText(specialityName) != null)
                    {
                        ddSpecialityName.SelectedValue = ddSpecialityName.Items.FindByText(specialityName).Value;
                    }

                    if (ddProcedureCode.Items.FindByText(procedureCode) != null)
                    {
                        ddProcedureCode.SelectedValue = ddProcedureCode.Items.FindByText(procedureCode).Value;
                    }

                    hdAddOnId.Value = packageAddOnId.ToString();

                    btnSubmit.Visible = false;
                    btnUpdate.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('AddOn details not found!');", true);
                }
            }
            catch (Exception ex)
            {
                md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while fetching action details.');", true);

            }
        }
    }

    protected void gridPackageAddOn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        gridPackageAddOn.PageIndex = e.NewPageIndex;
        string searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;

        GetMapAddonDetails(searchTerm);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        GetMapAddonDetails(searchTerm);
    }
    protected void GetMapAddonDetails(string searchTerm = "")
    {
        if (!IsPostBack && string.IsNullOrEmpty(searchTerm))
        {
            searchTerm = ViewState["SearchTerm"] != null ? ViewState["SearchTerm"].ToString() : string.Empty;
        }
        else
        {
            ViewState["SearchTerm"] = searchTerm;
        }
        dt.Clear();
        dt = md.GetMapAddOnDetail();
        if (!string.IsNullOrEmpty(searchTerm))
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = "Speciality LIKE '%" + searchTerm + "%' OR ProcedureCode LIKE '%" + searchTerm + "%'";
            dt = dv.ToTable();

            lbRecordCount.Text = "Total No. of Record Related " + searchTerm + ": " + dt.Rows.Count.ToString();
        }
        else
        {
            lbRecordCount.Text = "Total No. of Records: " + dt.Rows.Count.ToString();
        }
        
        if (dt.Rows.Count > 0)
        {
            lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
            gridPackageAddOn.DataSource = dt;
            gridPackageAddOn.DataBind();
        }
        else
        {
            lbRecordCount.Text = "Total No Records: 0";
            gridPackageAddOn.DataSource = null;
            gridPackageAddOn.DataBind();
        }
    }
}