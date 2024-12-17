using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CPD_MultipleImage : System.Web.UI.Page
{
    private DataTable dtImages;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitializeGrid(); 
        }
    }
    private void InitializeGrid()
    {
        DataTable dtImages = new DataTable();
        dtImages.Columns.Add("ImagePath", typeof(string));
        dtImages.Rows.Add(""); 
        ViewState["ImageTable"] = dtImages;

        gvUploadImages.DataSource = dtImages;
        gvUploadImages.DataBind();
    }
    protected void btnAddRow_Click(object sender, EventArgs e)
    {
        DataTable dtImages = ViewState["ImageTable"] as DataTable;
        dtImages.Rows.Add("");
        ViewState["ImageTable"] = dtImages;

        gvUploadImages.DataSource = dtImages;
        gvUploadImages.DataBind();
    }
    protected void gvUploadImages_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UploadImage")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvUploadImages.Rows[rowIndex];
            FileUpload fuImage = row.FindControl("fuImage") as FileUpload;

            if (fuImage != null && fuImage.HasFile)
            {
                string fileName = Path.GetFileName(fuImage.PostedFile.FileName);
                string filePath = Server.MapPath("~/UploadedImages/") + fileName;
                fuImage.SaveAs(filePath);
                DataTable dtImages = ViewState["ImageTable"] as DataTable;
                dtImages.Rows[rowIndex]["ImagePath"] = fileName;
                ViewState["ImageTable"] = dtImages;

                gvUploadImages.DataSource = dtImages;
                gvUploadImages.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "UploadSuccess", "alert('Image uploaded successfully.');", true);
            }
        }
    }
    //protected void btnSaveAll_Click(object sender, EventArgs e)
    //{
    //    DataTable dtImages = ViewState["ImageTable"] as DataTable;

    //    foreach (DataRow row in dtImages.Rows)
    //    {
    //        string imagePath = row["ImagePath"].ToString();

    //        if (!string.IsNullOrEmpty(imagePath))
    //        {
    //            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString))
    //            {
    //                using (SqlCommand cmd = new SqlCommand("INSERT INTO ImagesTable (ImagePath) VALUES (@ImagePath)", con))
    //                {
    //                    cmd.Parameters.AddWithValue("@ImagePath", imagePath);
    //                    con.Open();
    //                    cmd.ExecuteNonQuery();
    //                    con.Close();
    //                }
    //            }
    //        }
    //    }

    //    ScriptManager.RegisterStartupScript(this, GetType(), "SaveSuccess", "alert('All images saved successfully.');", true);
    //}
    protected void btnSaveAll_Click(object sender, EventArgs e)
    {
        DataTable dtImages = ViewState["ImageTable"] as DataTable;

        if (dtImages != null && dtImages.Rows.Count > 0)
        {
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString);
                con.Open();

                foreach (DataRow row in dtImages.Rows)
                {
                    string imagePath = row["ImagePath"].ToString();

                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        cmd = new SqlCommand("INSERT INTO ImagesTable (ImagePath) VALUES (@ImagePath)", con);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "SaveSuccess", "alert('All images saved successfully.');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "SaveError", "alert('Error saving images: {ex.Message}');", true);
            }
            finally
            {
                if (cmd != null)
                {
                    cmd.Dispose();
                }
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "NoImages", "alert('No images to save.');", true);
        }
    }

    private void SaveImagePathToDatabase(string imagePath)
    {
        string connString = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "INSERT INTO ImagesTable (ImagePath) VALUES (@ImagePath)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ImagePath", imagePath);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

}
