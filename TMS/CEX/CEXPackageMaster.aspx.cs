using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AbuaTMS;
using WebGrease.Css.Ast;

public partial class CEX_CEXPackageMaster : System.Web.UI.Page
{
    private string strMessage;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private DataSet ds = new DataSet();
    private MasterData md = new MasterData();
    private  CEX cex = new CEX();
    string pageName;

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
                hdUserId.Value = Session["UserId"].ToString();

                getSpecialityName();
                GetPackageMaster(null, null);
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


    protected void ddSpecialityName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            dt.Clear();
            int packageId;
            if (int.TryParse(ddSpecialityName.SelectedValue, out packageId))
            {
                dt = cex.GetProcedureName(packageId);
                if (dt.Rows.Count > 0)
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.DataValueField = "ProcedureId";
                    ddProcedureName.DataTextField = "ProcedureName";
                    ddProcedureName.DataSource = dt;
                    ddProcedureName.DataBind();
                    ddProcedureName.Items.Insert(0, new ListItem("--Select--", "0"));
                }
                else
                {
                    ddProcedureName.Items.Clear();
                    ddProcedureName.Items.Insert(0, new ListItem("--No Procedure Available--", "0"));
                    
                }
            }
            else
            {
                ddProcedureName.Items.Clear();
                ddProcedureName.Items.Insert(0, new ListItem("--SELECT SPECIALITY FIRST--", "0"));
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~/Unauthorize.aspx", false);
            return;
        }
    }
    //public void GetPackageMaster(string PackageId, string ProcedureId)
    //{
    //    try
    //    {
    //        dt.Clear();
    //        dt = cex.GetPackageMaster(PackageId, ProcedureId);
    //        if (dt != null && dt.Rows.Count > 0)
    //        {
    //            lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
    //            gridPackageMaster.DataSource = dt;
    //            gridPackageMaster.DataBind();
    //        }
    //        else
    //        {
    //            lbRecordCount.Text = "Total No Records: 0";
    //            gridPackageMaster.DataSource = "";
    //            gridPackageMaster.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //        md.InsertErrorLog(hdUserId.Value, pageName, ex.Message, ex.StackTrace, ex.GetType().ToString());
    //        Response.Redirect("~/Unauthorize.aspx", false);
    //    }
    //}

    public void GetPackageMaster(string PackageId, string ProcedureId)
    {
        try
        {
            dt.Clear();
            dt = cex.GetPackageMaster(PackageId, ProcedureId);

            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();

                // Store the current PackageId and ProcedureId in ViewState
                ViewState["PackageId"] = PackageId;
                ViewState["ProcedureId"] = ProcedureId;

                gridPackageMaster.DataSource = dt;
                gridPackageMaster.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridPackageMaster.DataSource = new DataTable();
                gridPackageMaster.DataBind();
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



    protected void gridPackageMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridPackageMaster.PageIndex = e.NewPageIndex;
        //GetPackageMaster(null, null);
        gridPackageMaster.PageIndex = e.NewPageIndex;

        // Retrieve the previously set PackageId and ProcedureId from ViewState
        string packageId = ViewState["PackageId"] as string;
        string procedureId = ViewState["ProcedureId"] as string;

        // Call GetPackageMaster with the retained parameters
        GetPackageMaster(packageId, procedureId);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string selectedSpeciality = ddSpecialityName.SelectedValue;
            string selectedProcedure = ddProcedureName.SelectedValue;

            if (selectedSpeciality != "0" && selectedProcedure != "0")
            {
                GetPackageMaster(
                    selectedSpeciality != "0" ? selectedSpeciality : null,
                    selectedProcedure != "0" ? selectedProcedure : null
                );
            }
            else if (selectedSpeciality != "0" && selectedProcedure == "0")
            {
                GetPackageMaster(selectedSpeciality , null);
            }
            else
            {
                GetPackageMaster(null, null);
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            lbRecordCount.Text = string.Empty;
            ddSpecialityName.SelectedIndex = 0;
            ddProcedureName.Items.Clear();
            ddProcedureName.Items.Insert(0, new ListItem("--SELECT SPECIALITY FIRST--", "0"));
            GetPackageMaster(null, null);
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
}
