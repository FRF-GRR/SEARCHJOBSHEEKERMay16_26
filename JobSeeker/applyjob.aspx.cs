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

namespace SEARCHJOBSHEEKERMay16_26.JobSeeker
{
    public partial class applyjob : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["JSID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // ---- YAHIN PAR QueryString se JobID uthaya jaata hai ----
                if (Request.QueryString["jobid"] != null)
                {
                    int jobId = Convert.ToInt32(Request.QueryString["jobid"]);
                    lblJobID.Text = jobId.ToString();   // hidden Label mein store kar diya
                }
                else
                {
                    Response.Redirect("~/JobSeeker/SeekerJobShow.aspx"); // jobid nahi mila toh wapas bhej do
                    return;
                }

            }
        }

        private void ClearTextBoxes()
        {
            textname.Text = "";
            textemail.Text = "";
            textcontactnumber.Text = "";
            textcurrentlocation.Text = "";
            textcurrentcompany.Text = "";
            textexpectedsalary.Text = "";
            textskills.Text = "";
            textquery.Text = "";
            ddlexprience.SelectedIndex = 0;   // DropDownList ko default value par le aao
        }

        protected void btnapply_Click(object sender, EventArgs e)
        {
            int jobId = Convert.ToInt32(lblJobID.Text);

            string FN = Path.GetFileName(furesume.PostedFile.FileName);
            string uniqueFN = Guid.NewGuid().ToString() + "_" + FN;   // duplicate filename se bachne ke liye

            string folderPath = Server.MapPath("~/JobApplyeResume/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            furesume.SaveAs(folderPath + uniqueFN);

            string resumeDbPath = "~/JobApplyeResume/" + uniqueFN;   // <-- yeh poora path DB mein jaayega



            con.Open();
            SqlCommand cmd = new SqlCommand("proctblJobSeekerJobApplyInsert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@JobID", jobId);
            cmd.Parameters.AddWithValue("@JSID", Session["JSID"]);
            cmd.Parameters.AddWithValue("@JSJobApplyname", textname.Text);
            cmd.Parameters.AddWithValue("@JSJobApplyEmail", textemail.Text);
            cmd.Parameters.AddWithValue("@JSJobApplyContact", textcontactnumber.Text);
            cmd.Parameters.AddWithValue("@CurrentLocation", textcurrentlocation.Text);
            cmd.Parameters.AddWithValue("@Experience", ddlexprience.SelectedValue);
            cmd.Parameters.AddWithValue("@CurrentCompany", textcurrentcompany.Text);
            cmd.Parameters.AddWithValue("@ExpectedSalary", textexpectedsalary.Text);
            cmd.Parameters.AddWithValue("@Skills", textskills.Text);
            cmd.Parameters.AddWithValue("@CoverMessage", textquery.Text);
            cmd.Parameters.AddWithValue("@ResumePath", resumeDbPath);   // FN ki jagah resumeDbPath
            cmd.ExecuteNonQuery();
            con.Close();
            ClearTextBoxes();
        }
    }
}