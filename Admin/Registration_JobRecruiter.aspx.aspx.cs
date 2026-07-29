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

namespace SEARCHJOBSHEEKERMay16_26.Admin
{
    public partial class Registration_JobRecruiter_aspx : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindState();
                BindJRType();
            }

        }
        public void BindJRType()
        {
            Con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblJRType", Con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Con.Close();
            ddljrtype.DataValueField = "JRTid";
            ddljrtype.DataTextField = "JRTName";
            ddljrtype.DataSource = dt;
            ddljrtype.DataBind();
            ddljrtype.Items.Insert(0, new ListItem("--Select Job Recruiter Type--", "0"));
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


        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity();
        }
        //string pras = Path.GetFileName(fuimage.PostedFile.FileName);
        //fuimage.SaveAs(Server.MapPath("JobRecruiterImage" + "\\" + pras));


        protected void btnregister_Click1(object sender, EventArgs e)
        {
            //File Upload
            string FN = Path.GetFileName(fuimage.PostedFile.FileName);
            fuimage.SaveAs(Server.MapPath("JobRecruiterImage" + "\\" + FN));

            Con.Open();
            SqlCommand cmd = new SqlCommand("ProcJobRecruiter", Con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", "Insert");

            cmd.Parameters.AddWithValue("@JRName", txtname.Text);
            cmd.Parameters.AddWithValue("@JREmail", txtemail.Text);
            cmd.Parameters.AddWithValue("@JRPassword", txtpassword.Text);

            cmd.Parameters.AddWithValue("@JRType", ddljrtype.SelectedValue);
            cmd.Parameters.AddWithValue("@JRContactPerson", txtcontactperson.Text);
            cmd.Parameters.AddWithValue("@JRContactNumber", txtcontactnumber.Text);

            cmd.Parameters.AddWithValue("@JRState", ddlstate.SelectedValue);
            cmd.Parameters.AddWithValue("@JRCity", ddlcity.SelectedValue);
            cmd.Parameters.AddWithValue("@JRImage", FN);
            cmd.ExecuteNonQuery();
            Con.Close();

        }
    }
}
