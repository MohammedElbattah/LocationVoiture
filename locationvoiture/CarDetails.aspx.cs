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
	public partial class CarDetails : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCarDetails();
        }

        private void LoadCarDetails()
        {
            string carId = Request.QueryString["carid"];
            if (string.IsNullOrEmpty(carId))
            {
                lblReserveMsg.Text = "Car not found.";
                btnReserve.Visible = false;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            string query = "SELECT TOP 1 * FROM Cars WHERE CarID = @CarID";
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTitle.Text = reader["Model"].ToString();
                    lblLocation.Text = reader["Location"]?.ToString() ?? "Not set";
                    lblMileage.Text = reader["Mileage"]?.ToString() ?? "25,100";
                    lblTransmission.Text = reader["Transmission"]?.ToString() ?? "Automatic";
                    lblFuel.Text = reader["Fuel"]?.ToString() ?? "Diesel";
                    lblSeats.Text = reader["Seats"]?.ToString() ?? "5";
                    lblPrice.Text = Convert.ToDecimal(reader["PricePerDay"]).ToString("0.00");
                    lblRating.Text = reader["Rating"]?.ToString() ?? "4.95";
                    lblReviews.Text = reader["Reviews"]?.ToString() ?? "500";

                    // Main image and gallery
                    string mainImg = reader["MainImage"]?.ToString();
                    List<string> images = new List<string>();
                    if (!string.IsNullOrEmpty(mainImg))
                        images.Add(mainImg);

                    // Up to 4 additional images
                    for (int i = 1; i <= 4; i++)
                    {
                        string col = "Image" + i;
                        if (reader[col] != DBNull.Value && !string.IsNullOrEmpty(reader[col].ToString()))
                            images.Add(reader[col].ToString());
                    }

                    if (images.Count == 0)
                        images.Add("https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_1280.jpg");

                    mainCarImg.Src = images[0];
                    rptGallery.DataSource = images;
                    rptGallery.DataBind();
                }
                else
                {
                    lblReserveMsg.Text = "Car not found.";
                    btnReserve.Visible = false;
                }
                reader.Close();
            }
        }

        protected void btnReserve_Click(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx?return=CarDetails.aspx?carid=" + Request.QueryString["carid"]);
                return;
            }

            // Redirect to reservation page (to be created)
            Response.Redirect("Reserve.aspx?carid=" + Request.QueryString["carid"]);
        }
    }
}