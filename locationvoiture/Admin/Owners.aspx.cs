using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace locationvoiture.Admin
{
    public partial class Owners : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Gestionnaire")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
            {
                LoadOwners();
            }
        }

        private void LoadOwners()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT UserID, Name, Email, Role FROM Users WHERE Role = 'Proprietaire'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOwners.DataSource = dt;
                gvOwners.DataBind();
                lblMsg.Text = dt.Rows.Count == 0 ? "No owners found." : "";
            }
        }
    }
}
