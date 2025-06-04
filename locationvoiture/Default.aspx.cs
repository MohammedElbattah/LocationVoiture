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
	public partial class Default : System.Web.UI.Page
	{
        private int CarsToShow
        {
            get { return ViewState["CarsToShow"] != null ? (int)ViewState["CarsToShow"] : 6; }
            set { ViewState["CarsToShow"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCars();
        }

        // Search button click: reset paging and search/filter
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CarsToShow = 6; // Reset to 6 cars on new search
            LoadCars();
        }

        // Load More button click: show 6 more cars
        protected void btnLoadMore_Click(object sender, EventArgs e)
        {
            CarsToShow += 6; // Show 6 more cars
            LoadCars();
        }

        private void LoadCars()
        {
            phCars.Controls.Clear();
            lblNoCars.Text = "";

            string model = txtModel.Text.Trim();
            string type = ddlType.SelectedValue;
            string minPrice = txtMinPrice.Text.Trim();
            string maxPrice = txtMaxPrice.Text.Trim();

            // Build the query with search/filter/paging
            string query = $"SELECT TOP {CarsToShow} CarID, Model, Type, PricePerDay, Location, Mileage, Transmission, Fuel, Seats, Reviews, Rating, MainImage FROM Cars WHERE 1=1";
            if (!string.IsNullOrEmpty(model))
                query += " AND Model LIKE @Model";
            if (!string.IsNullOrEmpty(type))
                query += " AND Type = @Type";
            if (!string.IsNullOrEmpty(minPrice))
                query += " AND PricePerDay >= @MinPrice";
            if (!string.IsNullOrEmpty(maxPrice))
                query += " AND PricePerDay <= @MaxPrice";
            query += " ORDER BY CarID DESC";

            int count = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    if (!string.IsNullOrEmpty(model))
                        cmd.Parameters.AddWithValue("@Model", "%" + model + "%");
                    if (!string.IsNullOrEmpty(type))
                        cmd.Parameters.AddWithValue("@Type", type);
                    if (!string.IsNullOrEmpty(minPrice))
                        cmd.Parameters.AddWithValue("@MinPrice", minPrice);
                    if (!string.IsNullOrEmpty(maxPrice))
                        cmd.Parameters.AddWithValue("@MaxPrice", maxPrice);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        count++;
                        // Null-safe reads for every field!
                        string carId = reader["CarID"].ToString();
                        string carModel = reader["Model"].ToString();
                        string carType = reader["Type"].ToString();
                        string price = reader["PricePerDay"] == DBNull.Value ? "--" : Convert.ToDecimal(reader["PricePerDay"]).ToString("0.00")  ;
                        string location = reader["Location"] == DBNull.Value ? "Not set" : reader["Location"].ToString();
                        string mileage = reader["Mileage"] == DBNull.Value ? "--" : reader["Mileage"].ToString();
                        string transmission = reader["Transmission"] == DBNull.Value ? "Automatic" : reader["Transmission"].ToString();
                        string fuel = reader["Fuel"] == DBNull.Value ? "Diesel" : reader["Fuel"].ToString();
                        string seats = reader["Seats"] == DBNull.Value ? "5" : reader["Seats"].ToString();
                        string reviews = reader["Reviews"] == DBNull.Value ? "0" : reader["Reviews"].ToString();
                        string rating = reader["Rating"] == DBNull.Value ? "5.0" : reader["Rating"].ToString();
                        string carImage = (reader["MainImage"] == DBNull.Value || string.IsNullOrWhiteSpace(reader["MainImage"].ToString()))
                            ? GetCarImage(carModel)
                            : reader["MainImage"].ToString();

                        string html = $@"
                        <div class='car-card' onclick=""goToDetails('{carId}')"">
                            <img src='{carImage}' alt='{carModel}' />
                            <div class='car-content'>
                                <div class='car-title'>{carModel}</div>
                                <div class='car-location'><i class='fa fa-location-dot'></i> {location}</div>
                                <div class='car-details-row'>
                                    <div class='car-detail'><i class='fa fa-gauge'></i> {mileage} miles</div>
                                    <div class='car-detail'><i class='fa fa-gears'></i> {transmission}</div>
                                </div>
                                <div class='car-details-row'>
                                    <div class='car-detail'><i class='fa fa-gas-pump'></i> {fuel}</div>
                                    <div class='car-detail'><i class='fa fa-chair'></i> {seats} seats</div>
                                </div>
                                <div class='car-price-row'>
                                    <span class='car-from'>From <span class='car-price'>DH{price}</span></span>
                                    <button type='button' class='see-details' onclick=""event.stopPropagation();goToDetails('{carId}')"">See Details</button>
                                </div>
                            </div>
                        </div>
                    ";
                        phCars.Controls.Add(new Literal { Text = html });
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                lblNoCars.Text = "Error: " + ex.ToString();
                btnLoadMore.Visible = false;
                return;
            }

            // Only show Load More if there might be more cars
            btnLoadMore.Visible = (count == CarsToShow);
            if (count == 0)
                lblNoCars.Text = "No cars found for your search!";
        }

        // Helper: fallback image if MainImage is missing
        private string GetCarImage(string model)
        {
            model = model.ToLower();
            if (model.Contains("audi")) return "https://cdn.pixabay.com/photo/2017/07/16/10/43/audi-2504987_1280.jpg";
            if (model.Contains("mercedes")) return "https://cdn.pixabay.com/photo/2017/01/06/19/15/mercedes-1954548_1280.jpg";
            if (model.Contains("golf") || model.Contains("volkswagen")) return "https://cdn.pixabay.com/photo/2016/12/27/15/57/auto-1930491_1280.jpg";
            if (model.Contains("fiat")) return "https://cdn.pixabay.com/photo/2017/01/06/19/15/fiat-1954547_1280.jpg";
            // Default image
            return "https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_1280.jpg";
        }
    }
}