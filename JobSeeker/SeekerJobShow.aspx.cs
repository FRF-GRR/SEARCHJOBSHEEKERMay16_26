using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Diagnostics.Eventing.Reader;


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
                BindAppliedJob();

            }

        }
        public void BindGridShowJob()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select JobPostId,JRName,JName,JobPostMinExp,JobPostMaxExp,JobPostMinSalary,JobPostMaxSalary,Cname,Sname,JobPostVacancy  from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid  join tblCity on tblJobPost.JobPostCity = tblCity.CId where AdminStatus = 0", Con);
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
                BindGridShowJob();
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


        public void BindAppliedJob()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("select * from tblJobSeekerJobApply where JSID=@JSID", Con);
            cmd.Parameters.AddWithValue("@JSID", Session["JSID"]);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            gvappledjobshow.DataSource = dt;
            gvappledjobshow.DataBind();

        }

        protected void gvappledjobshow_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                Con.Open();

                // Pehle resume path nikaal lo delete se pehle
                SqlCommand getCmd = new SqlCommand(
                    "select ResumePath from tblJobSeekerJobApply where JSJobApplyID=@JSJobApplyID", Con);
                getCmd.Parameters.AddWithValue("@JSJobApplyID", e.CommandArgument);
                SqlDataAdapter sda = new SqlDataAdapter(getCmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ViewState["resumepath"] = dt.Rows[0]["ResumePath"].ToString(); ;

                SqlCommand cmd = new SqlCommand(
                    "delete from tblJobSeekerJobApply where JSJobApplyID=@JSJobApplyID", Con);
                cmd.Parameters.AddWithValue("@JSJobApplyID", e.CommandArgument);
                cmd.ExecuteNonQuery();
                Con.Close();
                File.Delete(Server.MapPath(ViewState["resumepath"].ToString()));
                BindAppliedJob();
                LoadAppliedJobIds();

            }
            else
            {
                // yahi se redirect ho jayega, koi alag event nahi chahiye
                Response.Redirect("../JobSeeker/applyjob.aspx?JSJobApplyID=" + e.CommandArgument.ToString());
            }


        }


        protected void btnSearchJob_Click(object sender, EventArgs e)
        {
            appliedJobIds.Clear();
            LoadAppliedJobIds();

            if (txtSearchJob.Text.Trim() == "")
            {
                BindGridShowJob();
                return;
            }
            else
            {
                Con.Open();
                SqlCommand cmd = new SqlCommand("Select JobPostId,JRName,JName,JobPostMinExp,JobPostMaxExp,JobPostMinSalary,JobPostMaxSalary,Cname,Sname,JobPostVacancy  from tblJobPost  join tblJobRecruiter on tblJobPost.JobRecruiterId = tblJobRecruiter.JRID join tblJobProfile on tblJobPost.JobPostJobProfile = tblJobProfile.Jid  join tblState on tblJobPost.JobPostState = tblState.Sid  join tblCity on tblJobPost.JobPostCity = tblCity.CId where CName like @SearchJob or SName like @SearchJob or JName like @SearchJob or JRName like @SearchJob", Con);
                cmd.Parameters.AddWithValue("@SearchJob", "%" + txtSearchJob.Text.Trim() + "%");
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Con.Close();
                gvjobshow.DataSource = dt;
                gvjobshow.DataBind();
            }

        }
    }
}

