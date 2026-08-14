using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

namespace SEARCHJOBSHEEKERMay16_26.JobRecruiter
{
    public partial class JobRecruiterJobShow : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["JRID"] != null && Session["JRID"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    BindGrid();
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        public void BindGrid()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid full join tblCity on tblJobPost.JobPostCity = tblCity.CId  Where tblJobPost.JobRecruiterId = '" + Session["JRID"] + "'", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            gvjobshow.DataSource = dt;
            gvjobshow.DataBind();
        }
    }

}