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

namespace SEARCHJOBSHEEKERMay16_26.JobRecruiter
{
    public partial class JobRecruiterJobPost : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["JRID"] != null && Session["JRID"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    BindState();
                    BindProfile();
                    BindGrid();
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        // agar login page ko bydefault run karna hai to usko set as start karna padega project me right click karke set as start p
        public void BindProfile()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJobProfile", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddljp.DataValueField = "Jid";
            ddljp.DataTextField = "JName";
            ddljp.DataSource = dt;
            ddljp.DataBind();
            ddljp.Items.Insert(0, new ListItem("--Select Job Profile--", "0"));
        }

        public void BindState()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblState", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddlstate.DataValueField = "Sid";
            ddlstate.DataTextField = "SName";
            ddlstate.DataSource = dt;
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
        }

        public void BindCity()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblCity where Sid='" + ddlstate.SelectedValue + "'", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddlcity.DataValueField = "Cid";
            ddlcity.DataTextField = "CName";
            ddlcity.DataSource = dt;
            ddlcity.DataBind();
            ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }

        public void Clear()
        {
            ddljp.SelectedIndex = 0;
            ddlminexp.SelectedIndex = 0;
            ddlmaxexp.SelectedIndex = 0;
            minsalary.Text = "";
            maxsalary.Text = "";
            ddlstate.SelectedIndex = 0;
            ddlcity.SelectedIndex = 0;
            numberofvacancies.Text = "";
        }
        public void BindGrid()
        {
            SqlCommand cmd = new SqlCommand("ProcJobPost", Con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "Show");
            cmd.Parameters.AddWithValue("@JobRecruiterId ", Session["JRID"]);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvjobshow.DataSource = dt;
            gvjobshow.DataBind();
            GridView1.DataSource = dt;
            GridView1.DataBind();


        }



        protected void ddlstate_SelectedIndexChanged1(object sender, EventArgs e)
        {
            BindCity();
        }


        protected void btnjobpost_Click(object sender, EventArgs e)
        {
            if (btnjobpost.Text == "Submit")
            {
                Con.Open();
                SqlCommand cmd = new SqlCommand("ProcJobPost", Con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Insert");
                cmd.Parameters.AddWithValue("@JobRecruiterId", Session["JRID"]);
                cmd.Parameters.AddWithValue("@JobPostJobProfile", ddljp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMinExp", ddlminexp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMaxExp", ddlmaxexp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMinSalary", minsalary.Text);
                cmd.Parameters.AddWithValue("@JobPostMaxSalary", maxsalary.Text);
                cmd.Parameters.AddWithValue("@JobPostState", ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostCity", ddlcity.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostVacancy", numberofvacancies.Text);
                cmd.ExecuteNonQuery();
                Con.Close();
                BindGrid();
                Clear();
            }
            else if (btnjobpost.Text == "Update")
            {
                Con.Open();
                SqlCommand cmd = new SqlCommand("ProcJobPost", Con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Update");
                cmd.Parameters.AddWithValue("@JobPostId", ViewState["JobPostId"]);
                cmd.Parameters.AddWithValue("@JobRecruiterId", Session["JRID"]);
                cmd.Parameters.AddWithValue("@JobPostJobProfile", ddljp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMinExp", ddlminexp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMaxExp", ddlmaxexp.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostMinSalary", minsalary.Text);
                cmd.Parameters.AddWithValue("@JobPostMaxSalary", maxsalary.Text);
                cmd.Parameters.AddWithValue("@JobPostState", ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostCity", ddlcity.SelectedValue);
                cmd.Parameters.AddWithValue("@JobPostVacancy", numberofvacancies.Text);
                cmd.ExecuteNonQuery();
                Con.Close();
                BindGrid();
                Clear();
                btnjobpost.Text = "Submit";

            }
        }

        protected void gvjobshow_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete1")
            {
                Con.Open();
                SqlCommand cmd = new SqlCommand("ProcJobPost", Con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Delete");
                cmd.Parameters.AddWithValue("@JobPostId", e.CommandArgument);
                cmd.ExecuteNonQuery();
                Con.Close();
                BindGrid();
            }
            else if (e.CommandName == "Edit1")
            {
                Con.Open();
                SqlCommand cmd = new SqlCommand("ProcJobPost", Con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Edit");
                cmd.Parameters.AddWithValue("@JobPostId", e.CommandArgument);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Con.Close();
                if (dt.Rows.Count > 0)
                {
                    ddljp.SelectedValue = dt.Rows[0]["JobPostJobProfile"].ToString();
                    ddlminexp.SelectedValue = dt.Rows[0]["JobPostMinExp"].ToString();
                    ddlmaxexp.SelectedValue = dt.Rows[0]["JobPostMaxExp"].ToString();
                    minsalary.Text = dt.Rows[0]["JobPostMinSalary"].ToString();
                    maxsalary.Text = dt.Rows[0]["JobPostMaxSalary"].ToString();
                    ddlstate.SelectedValue = dt.Rows[0]["JobPostState"].ToString();
                    BindCity();
                    ddlcity.SelectedValue = dt.Rows[0]["JobPostCity"].ToString();
                    numberofvacancies.Text = dt.Rows[0]["JobPostVacancy"].ToString();
                    btnjobpost.Text = "Update";
                    ViewState["JobPostId"] = e.CommandArgument;
                }

            }
            else if (e.CommandName == "ChangeStatus")
            {
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

                Label lblStatus = (Label)row.FindControl("lblStatus");

                int Status = Convert.ToInt32(lblStatus.Text);

                if (Status == 1)
                {
                    Status = 0;
                }
                else
                {
                    Status = 1;
                }

                Con.Open();

                SqlCommand cmd = new SqlCommand("update tblJobPost set JobPostStatus=@Status where JobPostId=@Id", Con);

                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.AddWithValue("@Id", e.CommandArgument);

                cmd.ExecuteNonQuery();

                Con.Close();

                BindGrid();
            }

        }
    }
}