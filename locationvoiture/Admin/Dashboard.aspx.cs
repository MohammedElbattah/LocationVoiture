using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture.Admin
{
	public partial class Dashboard : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only Gestionnaire/Admin can access
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Gestionnaire")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
            {
                LoadStats();
                LoadRecentReservations();
            }
        }

        private void LoadStats()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Total Cars
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Cars", conn);
                lblTotalCars.Text = cmd.ExecuteScalar().ToString();

                // Total Reservations
                cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations", conn);
                lblTotalReservations.Text = cmd.ExecuteScalar().ToString();

                // Total Owners
                cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 'Proprietaire'", conn);
                lblTotalOwners.Text = cmd.ExecuteScalar().ToString();

                // Total Clients
                cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 'Client'", conn);
                lblTotalClients.Text = cmd.ExecuteScalar().ToString();

                // Total Income
                cmd = new SqlCommand(@"SELECT ISNULL(SUM(c.PricePerDay * (DATEDIFF(day, r.StartDate, r.EndDate)+1)), 0)
                                    FROM Reservations r INNER JOIN Cars c ON r.CarID = c.CarID", conn);
                object totalIncome = cmd.ExecuteScalar();
                decimal income = (totalIncome == DBNull.Value) ? 0 : Convert.ToDecimal(totalIncome);
                lblTotalIncome.Text = income.ToString("N0") + " MAD";
            }
        }

        private void LoadRecentReservations()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT TOP 10 
                        r.ReservationID, 
                        c.Model AS CarModel,
                        (SELECT Name FROM Users WHERE UserID = c.OwnerID) AS OwnerName,
                        (SELECT Name FROM Users WHERE UserID = r.UserID) AS ClientName,
                        r.StartDate, r.EndDate, r.Status, r.ReservationDate
                    FROM Reservations r
                    INNER JOIN Cars c ON r.CarID = c.CarID
                    ORDER BY r.ReservationDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRecentReservations.DataSource = dt;
                gvRecentReservations.DataBind();
            }
        }
    }
}