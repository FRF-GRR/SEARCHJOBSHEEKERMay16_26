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
    public partial class Registration_Jobsheeker : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProfile();
                BindHobbies();
                BindState();
            }

        }



        public void BindProfile()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJobProfile", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddlJobProfile.DataValueField = "Jid";
            ddlJobProfile.DataTextField = "JName";
            ddlJobProfile.DataSource = dt;
            ddlJobProfile.DataBind();
            ddlJobProfile.Items.Insert(0, new ListItem("--Select Job Profile--", "0"));
        }

        public void BindHobbies()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblHobbies", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            cblHobbies.DataValueField = "Hid";
            cblHobbies.DataTextField = "HName";
            cblHobbies.DataSource = dt;
            cblHobbies.DataBind();
        }

        public void BindState()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblState", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddlState.DataValueField = "Sid";
            ddlState.DataTextField = "SName";
            ddlState.DataSource = dt;
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
        }

        public void BindCity()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblCity where Sid='" + ddlState.SelectedValue + "'", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddlCity.DataValueField = "Cid";
            ddlCity.DataTextField = "CName";
            ddlCity.DataSource = dt;
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {

            //Checkbox ki liye use kiy jata hai
            string pp = "";
            for (int i = 0; i < cblHobbies.Items.Count; i++)
            {
                if (cblHobbies.Items[i].Selected)
                {
                    pp += cblHobbies.Items[i].Value + ",";
                }
            }
            pp = pp.TrimEnd(',');

            //File Upload
            string FN = Path.GetFileName(fuImage.PostedFile.FileName);
            fuImage.SaveAs(Server.MapPath("JobSheekerImage" + "\\" + FN));

            Con.Open();
            SqlCommand cmd = new SqlCommand("ProcJobseeker", Con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", "Insert");
            cmd.Parameters.AddWithValue("@JSName", textName.Text);
            cmd.Parameters.AddWithValue("@JSEmail", textEmail.Text);
            cmd.Parameters.AddWithValue("@JSPassword", textPassword.Text);
            cmd.Parameters.AddWithValue("@JSHobbies", pp);
            cmd.Parameters.AddWithValue("@JSJobProfile", ddlJobProfile.SelectedValue);
            cmd.Parameters.AddWithValue("@JSGender", rblGender.SelectedValue);
            cmd.Parameters.AddWithValue("@JSState", ddlState.SelectedValue);
            cmd.Parameters.AddWithValue("@JSCity", ddlCity.SelectedValue);
            cmd.Parameters.AddWithValue("@JSImage", FN);
            cmd.ExecuteNonQuery();
            Con.Close();
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity();
        }
    }
}