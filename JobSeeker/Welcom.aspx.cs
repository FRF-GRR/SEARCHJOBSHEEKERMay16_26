using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

namespace SEARCHJOBSHEEKERMay16_26.JobSeeker
{
    public partial class Welcom : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["JSID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                lblShow.Text = Session["JSName"].ToString();
            }
        }
    }
}