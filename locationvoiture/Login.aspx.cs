using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace locationvoiture
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.CssClass = "message message-error";
                lblMessage.Text = "Please enter your email and password.";
                return;
            }

            string passwordHash = ComputeSha256Hash(password);
            string connString = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserID, Name, Role FROM Users WHERE Email=@Email AND PasswordHash=@PasswordHash", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Authentication successful!
                    int userId = (int)reader["UserID"];
                    string name = reader["Name"].ToString();
                    string role = reader["Role"].ToString();

                    Session["UserID"] = userId;
                    Session["UserName"] = name;
                    Session["UserRole"] = role;

                    lblMessage.CssClass = "message message-success";
                    lblMessage.Text = "Login successful! Redirecting...";

                    // Redirect based on role
                    if (role == "Gestionnaire")
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    else if (role == "Proprietaire")
                        Response.Redirect("~/Owner/Dashboard.aspx");
                    else // Client or any other role
                        Response.Redirect("~/Default.aspx");
                }
                else
                {
                    lblMessage.CssClass = "message message-error";
                    lblMessage.Text = "Invalid email or password.";
                }
            }
        }

        // Helper to hash password (same as in Register.aspx.cs)
        private string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                foreach (var t in bytes)
                {
                    builder.Append(t.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}