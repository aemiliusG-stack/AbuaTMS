using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;

public partial class ADMIN_PreAuthDocumentMaster : System.Web.UI.Page
{
    private string strMessage, pageName;
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
    private DataTable dt = new DataTable();
    private MasterData md = new MasterData();

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
            if (!IsPostBack)
            {
                hdUserId.Value = Session["UserId"].ToString();
                GetPreAuthManditoryDocument();
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string DocumentName = tbDocumentName.Text.ToString();
            string SelectedData = dropDocumentFor.SelectedValue;
            if (!SelectedData.Equals("0") && !DocumentName.IsEmpty())
            {

                DataTable dt = new DataTable();
                dt = md.CheckExistingMandateDocument(DocumentName);
                if (dt != null)
                {
                    if (dt.Rows.Count > 0 && dt.Rows[0]["DocumentId"].ToString().Trim() != null)
                    {
                        strMessage = "window.alert('Duplicate Document Found...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                    }
                    else
                    {
                        md.InsertPreAuthManditoryDocument(DocumentName, SelectedData);
                        tbDocumentName.Text = "";
                        dropDocumentFor.SelectedIndex = 0;
                        strMessage = "window.alert('Document Added Successfully...!!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        GetPreAuthManditoryDocument();
                    }
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        tbDocumentName.Text = "";
        dropDocumentFor.SelectedIndex = 0;
        hdDcoumentId.Value = null;
        btnUpdate.Visible = false;
        btnAdd.Visible = true;
    }

    public void GetPreAuthManditoryDocument()
    {
        try
        {
            dt.Clear();
            dt = md.GetPreAuthManditoryDocument();
            if (dt != null && dt.Rows.Count > 0)
            {
                lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                gridManditoryDocument.DataSource = dt;
                gridManditoryDocument.DataBind();
            }
            else
            {
                lbRecordCount.Text = "Total No Records: 0";
                gridManditoryDocument.DataSource = null;
                gridManditoryDocument.DataBind();
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string SearchText = tbSearch.Text;
            if (!SearchText.Equals(""))
            {
                dt.Clear();
                dt = md.SearchPreAuthManditoryDocument(SearchText);
                if (dt != null && dt.Rows.Count > 0)
                {
                    lbRecordCount.Text = "Total No Records: " + dt.Rows.Count.ToString();
                    gridManditoryDocument.DataSource = dt;
                    gridManditoryDocument.DataBind();
                }
                else
                {
                    lbRecordCount.Text = "Total No Records: 0";
                    gridManditoryDocument.DataSource = null;
                    gridManditoryDocument.DataBind();
                }
            }
            else
            {
                GetPreAuthManditoryDocument();
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


    protected void gridManditoryDocument_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridManditoryDocument.PageIndex = e.NewPageIndex;
        GetPreAuthManditoryDocument();
    }

    protected void gridManditoryDocument_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbStatus = (Label)e.Row.FindControl("lbStatus");
            Label lbDocumentFor = (Label)e.Row.FindControl("lbDocumentFor");
            string IsActive = lbStatus.Text.ToString();
            string DocumentFor = lbDocumentFor.Text.ToString();
            if (IsActive != null && IsActive.Equals("False"))
            {
                lbStatus.Text = "InActive";
                lbStatus.CssClass = "btn btn-danger btn-sm rounded-pill";
            }
            else
            {
                lbStatus.Text = "Active";
                lbStatus.CssClass = "btn btn-success btn-sm rounded-pill";
            }

            if (DocumentFor.Equals("1"))
            {
                lbDocumentFor.Text = "Pre Investigation";
            }
            else
            {
                lbDocumentFor.Text = "Post Investigation";
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Label lbDocumentId = (Label)row.FindControl("lbDocumentId");
            Label lbIsActive = (Label)row.FindControl("lbStatus");
            string IsActive = lbIsActive.Text.ToString();
            string DocumentId = lbDocumentId.Text.ToString();

            if (IsActive.Equals("InActive"))
            {
                md.TooglePreAuthMandateDocument(DocumentId, true);
            }
            else
            {
                md.TooglePreAuthMandateDocument(DocumentId, false);
            }
            strMessage = "window.alert('Document Status Update Successfully...!!');";
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
            GetPreAuthManditoryDocument();
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

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        Label lbDocumentId = (Label)row.FindControl("lbDocumentId");
        Label lbDocumentName = (Label)row.FindControl("lbDocumentName");
        Label lbDocumentFor = (Label)row.FindControl("lbDocumentFor");
        hdDcoumentId.Value = lbDocumentId.Text.ToString();
        string DocumentName = lbDocumentName.Text.ToString();
        string DocumentFor = lbDocumentFor.Text.ToString();
        if (DocumentFor.Equals("Pre Investigation"))
        {
            dropDocumentFor.SelectedIndex = 1;
        }
        else
        {
            dropDocumentFor.SelectedIndex = 2;
        }
        tbDocumentName.Text = DocumentName;
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdDcoumentId.Value != null)
            {
                string DocumentName = tbDocumentName.Text;
                string SelectedData = dropDocumentFor.SelectedValue;
                if (!DocumentName.Equals("") && SelectedData != null && !SelectedData.Equals("0"))
                {
                    DataTable dt = new DataTable();
                    dt = md.CheckExistingMandateDocument(DocumentName);
                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0 && dt.Rows[0]["DocumentId"].ToString().Trim() != null)
                        {
                            strMessage = "window.alert('Duplicate Document Found...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                        }
                        else
                        {
                            md.UpdatePreAuthMandateDocument(hdDcoumentId.Value, DocumentName, SelectedData);
                            tbDocumentName.Text = "";
                            dropDocumentFor.SelectedIndex = 0;
                            hdDcoumentId.Value = null;
                            btnUpdate.Visible = false;
                            btnAdd.Visible = true;
                            strMessage = "window.alert('Document Updated Successfully...!!');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", strMessage, true);
                            GetPreAuthManditoryDocument();
                        }
                    }
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
}