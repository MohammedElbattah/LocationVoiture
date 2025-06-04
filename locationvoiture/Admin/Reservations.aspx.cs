using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace locationvoiture.Admin
{
    public partial class Reservations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Gestionnaire")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
            {
                LoadReservations();
            }
        }

        private void LoadReservations()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        r.ReservationID,
                        u.Name AS UserFullName,
                        c.Model AS CarModel,
                        r.StartDate,
                        r.EndDate,
                        r.ReservationDate,
                        r.Status,
                        r.FullName,
                        r.Phone,
                        r.PickupLocation,
                        r.Notes
                    FROM Reservations r
                    LEFT JOIN Users u ON r.UserID = u.UserID
                    LEFT JOIN Cars c ON r.CarID = c.CarID
                    ORDER BY r.ReservationID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvReservations.DataSource = dt;
                gvReservations.DataBind();

                lblMsg.Text = dt.Rows.Count == 0 ? "No reservations found." : "";
            }
        }
    }
}
