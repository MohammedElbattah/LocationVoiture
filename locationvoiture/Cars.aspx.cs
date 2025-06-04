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
	public partial class Cars : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCars();
            }
        }

        private void LoadCars()
        {
            phCars.Controls.Clear();
            lblNoCars.Text = "";

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            string model = Request.QueryString["model"] ?? "";
            string type = Request.QueryString["type"] ?? "";
            string minPrice = Request.QueryString["minPrice"] ?? "";
            string maxPrice = Request.QueryString["maxPrice"] ?? "";

            string query = "SELECT CarID, Model, Type, PricePerDay FROM Cars WHERE 1=1";
            if (!string.IsNullOrEmpty(model))
                query += " AND Model LIKE @Model";
            if (!string.IsNullOrEmpty(type))
                query += " AND Type = @Type";
            if (!string.IsNullOrEmpty(minPrice))
                query += " AND PricePerDay >= @MinPrice";
            if (!string.IsNullOrEmpty(maxPrice))
                query += " AND PricePerDay <= @MaxPrice";

            bool found = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
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
                        found = true;
                        string carId = reader["CarID"].ToString();
                        string carModel = reader["Model"].ToString();
                        string carType = reader["Type"].ToString();
                        string price = Convert.ToDecimal(reader["PricePerDay"]).ToString("0") + " MAD / jour";
                        string carImage = GetCarImage(carModel);

                        // Generate each card as HTML
                        string html = $@"
                        <div class='car-card'>
                            <img src='{carImage}' alt='{carModel}' />
                            <div class='car-title'>{carModel}</div>
                            <div class='car-type'>{carType}</div>
                            <div class='car-price'>{price}</div>
                            <button class='reserve-btn' type='button' onclick=""reserveCar('{carId}')"">Réserver</button>
                        </div>
                    ";

                        phCars.Controls.Add(new Literal { Text = html });
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                lblNoCars.Text = "Erreur : " + ex.Message;
                return;
            }

            if (!found)
            {
                lblNoCars.Text = "Aucune voiture trouvée.";
            }
        }

        // Map model names to images (add more as you like)
        private string GetCarImage(string model)
        {
            model = model.ToLower();
            if (model.Contains("fiat")) return "https://cdn.pixabay.com/photo/2017/01/06/19/15/fiat-1954547_1280.jpg";
            if (model.Contains("bmw")) return "https://cdn.pixabay.com/photo/2014/10/22/17/22/bmw-498244_1280.jpg";
            if (model.Contains("golf") || model.Contains("volkswagen")) return "https://cdn.pixabay.com/photo/2016/12/27/15/57/auto-1930491_1280.jpg";
            if (model.Contains("mercedes")) return "https://cdn.pixabay.com/photo/2017/01/06/19/15/mercedes-1954548_1280.jpg";
            // Default/fallback image
            return "https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_1280.jpg";
        }
    }
}
