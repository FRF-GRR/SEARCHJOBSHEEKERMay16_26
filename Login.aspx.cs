using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEARCHJOBSHEEKERMay16_26
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            if (ddlUsertype.SelectedValue == "1")
            {
                // Handle JobSeeker case
                Con.Open();
                SqlCommand cmd = new SqlCommand("select * from tblJobSeeker Where JSEmail='" + TextEmail.Text + "' AND JSPassword='" + TextPassword.Text + "'", Con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Con.Close();
                if (dt.Rows.Count > 0)
                {
                    Session["JSImage"] = dt.Rows[0]["JSImage"];
                    Session["JSName"] = dt.Rows[0]["JSName"];
                    Session["JSID"] = dt.Rows[0]["JSID"];
                    Response.Redirect("~/JobSeeker/Welcom.aspx");
                }
                else
                {
                    LabelMessage.Text = "login Failed";
                }
            }
            else if (ddlUsertype.SelectedValue == "2")
            {
                // Handle JobRecruiter case
                Con.Open();
                SqlCommand cmd = new SqlCommand("select * from tblJobRecruiter Where JREmail='" + TextEmail.Text + "' AND JRPassword='" + TextPassword.Text + "'", Con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Con.Close();
                if (dt.Rows.Count > 0)
                {
                    Session["JRID"] = dt.Rows[0]["JRID"];
                    Response.Redirect("~/JobRecruiter/WebForm1.aspx");
                }
                else
                {
                    LabelMessage.Text = "login Failed";
                }
            }

            else if (ddlUsertype.SelectedValue == "3")
            {
                // Handle Admin case
                Con.Open();
                SqlCommand cmd = new SqlCommand("select * from tblAdmin Where AdminEmail='" + TextEmail.Text + "' AND AdminPassword='" + TextPassword.Text + "'", Con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Con.Close();
                if (dt.Rows.Count > 0)
                {
                    Session["ADMINID"] = dt.Rows[0]["ADMINID"];
                    Session["Aname"] = dt.Rows[0]["ADMINname"].ToString();

                    Response.Redirect("~/Admin/Welcome.aspx");
                }
                else
                {
                    LabelMessage.Text = "login Failed";
                }
            }

        }
    }
}