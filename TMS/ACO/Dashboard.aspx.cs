using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ACO_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //BindPendencyData();
        }
    }
    //private void BindPendencyData()
    //{
    //    List<PendencyModel> pendencyList = GetPendencyData();
    //    PendencyRepeater.DataSource = pendencyList;
    //    PendencyRepeater.DataBind();
    //}
    //public List<PendencyModel> GetPendencyData()
    //{
    //    List<PendencyModel> pendencyList = new List<PendencyModel>();

    //    string connectionString = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

    //    using (SqlConnection conn = new SqlConnection(connectionString))
    //    {
    //        string query = "SELECT SNo, RoleName, Today, Overall FROM PendencyTable"; // Modify this to your actual query
    //        SqlCommand cmd = new SqlCommand(query, conn);

    //        conn.Open();
    //        using (SqlDataReader reader = cmd.ExecuteReader())
    //        {
    //            while (reader.Read())
    //            {
    //                pendencyList.Add(new PendencyModel
    //                {
    //                    SNo = Convert.ToInt32(reader["SNo"]),
    //                    RoleName = reader["RoleName"].ToString(),
    //                    Today = Convert.ToInt32(reader["Today"]),
    //                    Overall = Convert.ToInt32(reader["Overall"])
    //                });
    //            }
    //        }
    //    }

    //    return pendencyList;
    //}

    protected void RefreshButton_Click(object sender, EventArgs e)
    {
        //BindPendencyData();
    }
    public class PendencyModel
    {
        public int SNo { get; set; }
        public string RoleName { get; set; }
        public int Today { get; set; }
        public int Overall { get; set; }
    }

}