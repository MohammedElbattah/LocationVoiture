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
	public partial class Cars : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Gestionnaire")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
            {
                LoadAllCars();
            }
        }

        private void LoadAllCars()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        c.CarID, c.Model, c.Type, c.PricePerDay, c.Status, c.MainImage,
                        u.Name AS OwnerName
                    FROM Cars c
                    LEFT JOIN Users u ON c.OwnerID = u.UserID
                    ORDER BY c.CarID DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCars.DataSource = dt;
                gvCars.DataBind();

                if (dt.Rows.Count == 0)
                    lblMsg.Text = "No cars found in the system.";
                else
                    lblMsg.Text = "";
            }
        }


        public  string GetStatusClass(object statusObj)
        {
            if (statusObj == null) return "badge-dispo";
            string status = statusObj.ToString();
            if (status == "Non Disponible") return "badge-non-dispo";
            if (status == "En Maintenance") return "badge-maintenance";
            return "badge-dispo";
        }

        protected void gvCars_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int carId = Convert.ToInt32(gvCars.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                // (Optional) Delete all reservations for this car before deleting car
                SqlCommand cmdDelRes = new SqlCommand("DELETE FROM Reservations WHERE CarID=@CarID", conn);
                cmdDelRes.Parameters.AddWithValue("@CarID", carId);
                cmdDelRes.ExecuteNonQuery();

                SqlCommand cmd = new SqlCommand("DELETE FROM Cars WHERE CarID=@CarID", conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                    lblMsg.Text = "<div class='msg-success'>Car deleted successfully.</div>";
                else
                    lblMsg.Text = "<div class='msg-error'>Delete failed.</div>";
            }
            LoadAllCars();
        }

    }
}