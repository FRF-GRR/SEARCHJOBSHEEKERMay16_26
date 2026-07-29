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
        private List<int> appliedJobIds = new List<int>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAppliedJobIds();
                BindGrid();
            }

        }
        public void BindGrid()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select JobPostId,JRName,JName,JobPostMinExp,JobPostMaxExp,JobPostMinSalary,JobPostMaxSalary,Cname,Sname,JobPostVacancy  from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid  join tblCity on tblJobPost.JobPostCity = tblCity.CId ", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            gvjobshow.DataSource = dt;
            gvjobshow.DataBind();
        }
        private void LoadAppliedJobIds()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT JobID FROM tblJobSeekerJobApply WHERE JSID = @JSID", con);
                cmd.Parameters.AddWithValue("@JSID", Session["JSID"]);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    appliedJobIds.Add(Convert.ToInt32(dr["JobID"]));
                }
            }
        }


        protected void btnn_Command(object sender, CommandEventArgs e)
        {

            Response.Redirect("../JobSeeker/applyjob.aspx?jobid=" + e.CommandArgument);//jobid  lekar jayega is called query string parameter


        }

        protected void gvjobshow_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int currentJobId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "JobPostId"));

                Button btnn = (Button)e.Row.FindControl("btnn");
                Label lblApplied = (Label)e.Row.FindControl("lblApplied");

                if (appliedJobIds.Contains(currentJobId))
                {
                    btnn.Visible = false;
                    lblApplied.Visible = true;
                }
                else
                {
                    btnn.Visible = true;
                    lblApplied.Visible = false;
                }
            }
        }
    }
}