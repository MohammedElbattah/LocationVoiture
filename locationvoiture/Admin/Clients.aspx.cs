using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace locationvoiture.Admin
{
    public partial class Clients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Gestionnaire")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
            {
                LoadClients();
            }
        }

        private void LoadClients()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT UserID, Name, Email, Role FROM Users WHERE Role = 'Client'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvClients.DataSource = dt;
                gvClients.DataBind();

                lblMsg.Text = dt.Rows.Count == 0 ? "No clients found." : "";
            }
        }
    }
}
