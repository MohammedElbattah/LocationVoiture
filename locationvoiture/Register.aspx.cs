using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace locationvoiture
{
	public partial class Register : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "All fields are required!";
                return;
            }

            // Hash the password
            string passwordHash = ComputeSha256Hash(password);

            string connString = ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Check if email already exists
                SqlCommand checkUser = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", conn);
                checkUser.Parameters.AddWithValue("@Email", email);

                int userExists = (int)checkUser.ExecuteScalar();
                if (userExists > 0)
                {
                    lblMessage.Text = "Email is already registered!";
                    return;
                }

                // Insert user
                SqlCommand insertUser = new SqlCommand(
                    "INSERT INTO Users (Name, Email, PasswordHash, Role) VALUES (@Name, @Email, @PasswordHash, @Role)", conn);
                insertUser.Parameters.AddWithValue("@Name", name);
                insertUser.Parameters.AddWithValue("@Email", email);
                insertUser.Parameters.AddWithValue("@PasswordHash", passwordHash);
                insertUser.Parameters.AddWithValue("@Role", role);

                int rows = insertUser.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Registration successful! You can now login.";
                    // Optionally redirect to login page:
                    // Response.Redirect("Login.aspx");
                }
                else
                {
                    lblMessage.Text = "Registration failed. Try again.";
                }
            }
        }

        // Helper to hash password
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
