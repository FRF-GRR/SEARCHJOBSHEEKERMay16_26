using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;


namespace SEARCHJOBSHEEKERMay16_26.JobSeeker
{
    public partial class SeekerJobShow : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }

        }
        public void BindGrid()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid full join tblCity on tblJobPost.JobPostCity = tblCity.CId ", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            gvjobshow.DataSource = dt;
            gvjobshow.DataBind();
        }



        protected void btnn_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("../JobSeeker/applyjob.aspx?jobid=" + e.CommandArgument);//jobid  lekar jayega is called query string parameter
        }


    }
}