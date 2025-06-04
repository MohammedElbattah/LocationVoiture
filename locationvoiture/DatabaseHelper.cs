using System;
using System.Configuration;
using System.Data.SqlClient;



namespace locationvoiture
{
    internal class DatabaseHelper
    {
       
        public static bool TestConnection()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocationVoiture"].ConnectionString))
            {
                try
                {
                    conn.Open();
                    return true;
                }
                catch (Exception ex)
                {
                    // Show detailed error message in browser for now (remove in production!)
                    System.Web.HttpContext.Current.Response.Write("Connection failed: " + ex.Message);
                    return false;
                }
            }
        }
    }
}

