using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace SEARCHJOBSHEEKERMay16_26.Admin
{
    public partial class personalInformation : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        public void clearTextBox()
        {
            textname.Text = "";
            textemail.Text = "";
            textphone.Text = "";
            textdob.Text = "";
            textsalary.Text = "";
        }


        public void BindGrid()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ProcParashantUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "selectShow");
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ProcParashantUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "INSERT");
            cmd.Parameters.AddWithValue("@PaName", textname.Text);
            cmd.Parameters.AddWithValue("@PaEmail", textemail.Text);
            cmd.Parameters.AddWithValue("@PaPhone", textphone.Text);
            cmd.Parameters.AddWithValue("@PaDob", textdob.Text);
            cmd.Parameters.AddWithValue("@PaSalary", textsalary.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            clearTextBox();
            BindGrid();


        }
    }
}