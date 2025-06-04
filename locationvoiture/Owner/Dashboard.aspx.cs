using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture.Owner
{
	public partial class Dashboard : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Proprietaire")
                Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                LoadStats();
                LoadMyCars();
            }
        }

        private void LoadStats()
        {
            int ownerId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Count cars
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Cars WHERE OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@OwnerID", ownerId);
                lblTotalCars.Text = cmd.ExecuteScalar().ToString();

                // Count reservations for this owner's cars and sum price
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
