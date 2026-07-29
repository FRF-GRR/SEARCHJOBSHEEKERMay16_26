using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEARCHJOBSHEEKERMay16_26.JobRecruiter
{
    public partial class JobRecruiterJobManage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        public void BindGrid()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid full join tblCity on tblJobPost.JobPostCity = tblCity.CId  where tblJobPost.JobPostStatus =1 ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            gvManage.DataSource = dt;
            gvManage.DataBind();

        }

        protected void gvManage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete1")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("delete from tblJobPost where  JobPostId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
                BindGrid();
            }
        }
    }
}