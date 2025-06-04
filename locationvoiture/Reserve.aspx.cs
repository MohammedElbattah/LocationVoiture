using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture
{
	public partial class Reservations : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCarSummary();
        }

        private void LoadCarSummary()
        {
            string carId = Request.QueryString["carid"];
            if (string.IsNullOrEmpty(carId))
            {
                lblMsg.Text = "<span class='error'>No car selected.</span>";
                btnReserve.Visible = false;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT Model, Type, PricePerDay, MainImage FROM Cars WHERE CarID=@CarID", conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblModel.Text = reader["Model"].ToString();
                    lblType.Text = reader["Type"].ToString();
                    lblPrice.Text = reader["PricePerDay"].ToString();
                    imgCar.Src = reader["MainImage"].ToString();
                }
                else
                {
                    lblMsg.Text = "<span class='error'>Car not found.</span>";
                    btnReserve.Visible = false;
                }
                reader.Close();
            }
        }

        protected void btnReserve_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx?return=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            string carId = Request.QueryString["carid"];
            int userId = Convert.ToInt32(Session["UserID"]);
            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtStartDate.Text, out startDate) || !DateTime.TryParse(txtEndDate.Text, out endDate))
            {
                lblMsg.Text = "<span class='error'>Invalid dates!</span>";
                return;
            }
            if (endDate < startDate)
            {
                lblMsg.Text = "<span class='error'>End date must be after start date!</span>";
                return;
            }

            string fullName = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string pickupLocation = txtPickupLocation.Text.Trim();
            string notes = txtNotes.Text.Trim();

            // Optional: Check for overlapping reservations here

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Reservations (CarID, UserID, StartDate, EndDate, ReservationDate, Status, FullName, Phone, PickupLocation, Notes) " +
                    "VALUES (@CarID, @UserID, @StartDate, @EndDate, GETDATE(), 'Pending', @FullName, @Phone, @PickupLocation, @Notes)", conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@PickupLocation", pickupLocation);
                cmd.Parameters.AddWithValue("@Notes", notes);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    lblMsg.Text = "<span class='confirmation'>Reservation confirmed! We’ll contact you soon.</span>";
                    btnReserve.Visible = false;
                }
                else
                {
                    lblMsg.Text = "<span class='error'>Reservation failed. Try again!</span>";
                }
            }
        }
    }
}