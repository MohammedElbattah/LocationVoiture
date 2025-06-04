using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture.Owner
{
	public partial class EditCar : System.Web.UI.Page
	{
        protected int carId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Proprietaire")
                Response.Redirect("~/Login.aspx");

            if (!int.TryParse(Request.QueryString["carid"], out carId))
            {
                lblMsg.Text = "<div class='msg-error'>Invalid car ID.</div>";
                btnUpdate.Enabled = false;
                return;
            }

            if (!IsPostBack)
                LoadCar();
        }

        private void LoadCar()
        {
            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Cars WHERE CarID=@CarID AND OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@CarID", carId);
                cmd.Parameters.AddWithValue("@OwnerID", Convert.ToInt32(Session["UserID"]));
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtModel.Text = reader["Model"].ToString();
                    ddlType.SelectedValue = reader["Type"].ToString();
                    txtPrice.Text = reader["PricePerDay"].ToString();
                    ddlStatus.SelectedValue = reader["Status"].ToString();
                    txtMainImage.Text = reader["MainImage"].ToString();
                    txtImage1.Text = reader["Image1"].ToString();
                    txtImage2.Text = reader["Image2"].ToString();
                    txtImage3.Text = reader["Image3"].ToString();
                    txtImage4.Text = reader["Image4"].ToString();
                }
                else
                {
                    lblMsg.Text = "<div class='msg-error'>Car not found or you do not have permission to edit it.</div>";
                    btnUpdate.Enabled = false;
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim(), out price) || price <= 0)
            {
                lblMsg.Text = "<div class='msg-error'>Enter a valid price.</div>";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE Cars SET 
                    Model=@Model, Type=@Type, PricePerDay=@PricePerDay, Status=@Status,
                    MainImage=@MainImage, Image1=@Image1, Image2=@Image2, Image3=@Image3, Image4=@Image4
                    WHERE CarID=@CarID AND OwnerID=@OwnerID", conn);
                cmd.Parameters.AddWithValue("@Model", txtModel.Text.Trim());
                cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
                cmd.Parameters.AddWithValue("@PricePerDay", price);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@MainImage", txtMainImage.Text.Trim());
                cmd.Parameters.AddWithValue("@Image1", txtImage1.Text.Trim());
                cmd.Parameters.AddWithValue("@Image2", txtImage2.Text.Trim());
                cmd.Parameters.AddWithValue("@Image3", txtImage3.Text.Trim());
                cmd.Parameters.AddWithValue("@Image4", txtImage4.Text.Trim());
                cmd.Parameters.AddWithValue("@CarID", carId);
                cmd.Parameters.AddWithValue("@OwnerID", Convert.ToInt32(Session["UserID"]));
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                    lblMsg.Text = "<div class='msg-success'>Car updated successfully!</div>";
                else
                    lblMsg.Text = "<div class='msg-error'>Update failed. Try again.</div>";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}