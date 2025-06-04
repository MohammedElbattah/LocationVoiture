using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture.Owner
{
	public partial class AddCar : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Proprietaire")
                Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                LoadStats();
                LoadMyCars();
                pnlAddCar.Visible = false;
            }
        }

        private void LoadStats()
        {
            int ownerId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Cars WHERE OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@OwnerID", ownerId);
                lblTotalCars.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*), ISNULL(SUM(c.PricePerDay * (DATEDIFF(day, r.StartDate, r.EndDate)+1)), 0) FROM Reservations r INNER JOIN Cars c ON r.CarID = c.CarID WHERE c.OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@OwnerID", ownerId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTotalReservations.Text = reader.GetInt32(0).ToString();
                    lblIncome.Text = reader.GetDecimal(1).ToString("0");
                }
                reader.Close();
            }
        }

        private void LoadMyCars()
        {
            int ownerId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT CarID, Model, Type, PricePerDay, Status, MainImage FROM Cars WHERE OwnerID=@OwnerID";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@OwnerID", ownerId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCars.DataSource = dt;
                gvCars.DataBind();

                if (dt.Rows.Count == 0)
                    lblMsg.Text = "You have no cars yet. Click 'Add New Car' to add your first!";
                else
                    lblMsg.Text = "";
            }
        }

        // Add Car logic (inside dashboard)
        protected void btnShowAddCar_Click(object sender, EventArgs e)
        {
            pnlAddCar.Visible = true;
            lblAddCarMsg.Text = "";
        }
        protected void btnCancelAdd_Click(object sender, EventArgs e)
        {
            pnlAddCar.Visible = false;
            ClearAddCarFields();
        }
        protected void btnAddCar_Click(object sender, EventArgs e)
        {
            int ownerId = Convert.ToInt32(Session["UserID"]);
            string model = txtModel.Text.Trim();
            string type = ddlType.SelectedValue;
            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim(), out price) || price <= 0)
            {
                lblAddCarMsg.Text = "<div class='msg-error'>Enter a valid price.</div>";
                return;
            }
            string status = ddlStatus.SelectedValue;
            string mainImage = txtMainImage.Text.Trim();
            string image1 = txtImage1.Text.Trim();
            string image2 = txtImage2.Text.Trim();
            string image3 = txtImage3.Text.Trim();
            string image4 = txtImage4.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"INSERT INTO Cars (Model, Type, PricePerDay, Status, OwnerID, MainImage, Image1, Image2, Image3, Image4)
                                                  VALUES (@Model, @Type, @PricePerDay, @Status, @OwnerID, @MainImage, @Image1, @Image2, @Image3, @Image4)", conn);
                cmd.Parameters.AddWithValue("@Model", model);
                cmd.Parameters.AddWithValue("@Type", type);
                cmd.Parameters.AddWithValue("@PricePerDay", price);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@OwnerID", ownerId);
                cmd.Parameters.AddWithValue("@MainImage", mainImage);
                cmd.Parameters.AddWithValue("@Image1", image1);
                cmd.Parameters.AddWithValue("@Image2", image2);
                cmd.Parameters.AddWithValue("@Image3", image3);
                cmd.Parameters.AddWithValue("@Image4", image4);
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    lblAddCarMsg.Text = "<div class='msg-success'>Car added successfully!</div>";
                    pnlAddCar.Visible = false;
                    ClearAddCarFields();
                    LoadStats();
                    LoadMyCars();
                }
                else
                {
                    lblAddCarMsg.Text = "<div class='msg-error'>Failed to add car. Try again.</div>";
                }
            }
        }
        private void ClearAddCarFields()
        {
            txtModel.Text = "";
            ddlType.SelectedIndex = 0;
            txtPrice.Text = "";
            ddlStatus.SelectedIndex = 0;
            txtMainImage.Text = "";
            txtImage1.Text = "";
            txtImage2.Text = "";
            txtImage3.Text = "";
            txtImage4.Text = "";
        }
        protected void gvCars_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int carId = Convert.ToInt32(gvCars.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Cars WHERE CarID=@CarID AND OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                cmd.Parameters.AddWithValue("@OwnerID", Convert.ToInt32(Session["UserID"]));
                cmd.ExecuteNonQuery();
            }
            LoadStats();
            LoadMyCars();
        }
    }
}