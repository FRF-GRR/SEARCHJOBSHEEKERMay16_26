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
    public partial class AppliedJobBySeeker : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadApplications();
            }
        }


        private void LoadApplications()
        {
            SqlCommand cmd = new SqlCommand(
                @"SELECT ja.JSJobApplyID,jp.JobPostId,jpjp.JName, jpjp.JName, ja.JSJobApplyName, 
                         ja.JSJobApplyEmail, ja.JSJobApplyContact, ja.Experience, 
                         ja.CurrentCompany,ja.CurrentLocation ,ja.Skills, ja.ExpectedSalary, 
                         ja.ResumePath, ja.AppliedDate, ja.Status
                  FROM tblJobSeekerJobApply ja
                  INNER JOIN tblJobPost jp ON JobID = JobPostId 
                    INNER JOIN tblJobProfile jpjp  ON jpjp.Jid = jp.JobPostJobProfile 
                  WHERE JobRecruiterId =@JobRecruiterId
                  ORDER BY AppliedDate DESC", con);

            cmd.Parameters.AddWithValue("@JobRecruiterId ", Session["JRID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridViewApplications.DataSource = dt;
            GridViewApplications.DataBind();

        }

        protected void GridViewApplications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int applyId = Convert.ToInt32(e.CommandArgument);
            int newStatus = -1;

            if (e.CommandName == "Approve")
                newStatus = 1;
            else if (e.CommandName == "Reject")
                newStatus = 2;

            if (newStatus != -1)
            {

                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE tblJobSeekerJobApply SET Status=@Status WHERE JSJobApplyID=@JSJobApplyID", con);
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@JSJobApplyID", applyId);


                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                LoadApplications();  // Grid refresh karo taaki updated status turant dikhe
            }
        }

        protected void GridViewApplications_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                int status = Convert.ToInt32(rowView["Status"]);

                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                Button btnApprove = (Button)e.Row.FindControl("btnApprove");
                Button btnReject = (Button)e.Row.FindControl("btnReject");

                if (status == 0)
                {
                    lblStatus.Text = "Pending";
                    lblStatus.ForeColor = System.Drawing.Color.Orange;
                }
                else if (status == 1)
                {
                    lblStatus.Text = "Approved";
                    lblStatus.ForeColor = System.Drawing.Color.Green;
                }
                else if (status == 2)
                {
                    lblStatus.Text = "Rejected";
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }

                // ---- Buttons hamesha visible rahenge, bas current status wala button disable hoga ----
                if (status == 1)  // pehle se Approved hai
                {
                    btnApprove.Enabled = false;   // Approve button disable (already approved hai)
                    btnReject.Enabled = true;     // Reject abhi bhi kar sakte ho
                }
                else if (status == 2)  // pehle se Rejected hai
                {
                    btnApprove.Enabled = true;    // Approve kar sakte ho (mann badal gaya toh)
                    btnReject.Enabled = false;    // Reject button disable (already rejected hai)
                }
                else // Pending hai
                {
                    btnApprove.Enabled = true;
                    btnReject.Enabled = true;
                }
            }

        }
    }
}

