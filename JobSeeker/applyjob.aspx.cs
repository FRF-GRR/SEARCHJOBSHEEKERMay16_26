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
        //public int JSJobApplyID = Convert.ToInt32("lblHiddenID.Text");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["JSID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // YAHIN PAR QueryString se JobID uthaya jaata hai ----
                if (Request.QueryString["JSJobApplyID"] != null)
                {
                    // ===== EDIT MODE =====
                    int jsJobApplyId = Convert.ToInt32(Request.QueryString["JSJobApplyID"]);
                    ViewState["EditId"] = jsJobApplyId;
                    LoadDataForEdit();
                }
                else if (Request.QueryString["jobid"] != null)
                {
                    // ===== NORMAL APPLY MODE =====
                    int jobId = Convert.ToInt32(Request.QueryString["jobid"]);
                    ViewState["JobID"] = jobId;
                    ViewState["EditId"] = null;
                    // Yaha textbox khali hi rahenge, kuch load karne ki zarurat nahi
                }
                else
                {
                    // Na JobID hai na JSJobApplyID — galat tarike se page open hua
                    Response.Redirect("~/JobSeeker/SeekerJobShow.aspx");
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


            string resumeDbPath = null;

            // ✅ Sirf tab process karo jab user ne naya file diya ho
            if (furesume.HasFile)
            {
                string FN = Path.GetFileName(furesume.PostedFile.FileName);
                string uniqueFN = Guid.NewGuid().ToString() + "_" + FN;

                string folderPath = Server.MapPath("~/JobApplyeResume/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                furesume.SaveAs(folderPath + uniqueFN);
                resumeDbPath = "~/JobApplyeResume/" + uniqueFN;
            }

            if (btnapply.Text == "Submit Application")
            {
                if (resumeDbPath == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "msg",
                        "alert('Kripya resume upload karein.');", true);
                    return;
                }

                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("proctblJobSeekerJobApplyInsert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@JobID", ViewState["JobID"]);
                    cmd.Parameters.AddWithValue("@JSID", Convert.ToInt32(Session["JSID"]));
                    cmd.Parameters.AddWithValue("@JSJobApplyname", textname.Text);
                    cmd.Parameters.AddWithValue("@JSJobApplyEmail", textemail.Text);
                    cmd.Parameters.AddWithValue("@JSJobApplyContact", textcontactnumber.Text);
                    cmd.Parameters.AddWithValue("@CurrentLocation", textcurrentlocation.Text);
                    cmd.Parameters.AddWithValue("@Experience", ddlexprience.SelectedValue);
                    cmd.Parameters.AddWithValue("@CurrentCompany", textcurrentcompany.Text);
                    cmd.Parameters.AddWithValue("@ExpectedSalary", textexpectedsalary.Text);
                    cmd.Parameters.AddWithValue("@Skills", textskills.Text);
                    cmd.Parameters.AddWithValue("@CoverMessage", textquery.Text);
                    cmd.Parameters.AddWithValue("@ResumePath", resumeDbPath);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ClearTextBoxes();
                }
                catch (Exception ex)
                {
                    // Ab crash nahi hoga, browser mein readable error dikhega
                    ClientScript.RegisterStartupScript(this.GetType(), "msg",
                        "alert('Error: " + ex.Message.Replace("'", "").Replace("\n", " ") + "');", true);
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
                }
            }
            else if (btnapply.Text == "Update")
            {
                // ✅ Sirf naya resume upload hua ho tabhi purana delete karo
                if (resumeDbPath != null)
                {
                    if (ViewState["resume"] != null)
                    {
                        string oldPath = Server.MapPath(ViewState["resume"].ToString());
                        if (File.Exists(oldPath))
                            File.Delete(oldPath);
                    }
                }
                else
                {
                    // Naya file nahi diya — purana path hi rakho
                    resumeDbPath = ViewState["resume"] != null ? ViewState["resume"].ToString() : "";
                }

                con.Open();
                SqlCommand cmd = new SqlCommand("proctblJobSeekerJobApplyUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@JSJobApplyID", ViewState["EditId"]);
                cmd.Parameters.AddWithValue("@JSJobApplyname", textname.Text);
                cmd.Parameters.AddWithValue("@JSJobApplyEmail", textemail.Text);
                cmd.Parameters.AddWithValue("@JSJobApplyContact", textcontactnumber.Text);
                cmd.Parameters.AddWithValue("@CurrentLocation", textcurrentlocation.Text);
                cmd.Parameters.AddWithValue("@Experience", ddlexprience.SelectedValue);
                cmd.Parameters.AddWithValue("@CurrentCompany", textcurrentcompany.Text);
                cmd.Parameters.AddWithValue("@ExpectedSalary", textexpectedsalary.Text);
                cmd.Parameters.AddWithValue("@Skills", textskills.Text);
                cmd.Parameters.AddWithValue("@CoverMessage", textquery.Text);
                cmd.Parameters.AddWithValue("@ResumePath", resumeDbPath);
                cmd.ExecuteNonQuery();
                con.Close();
                ClearTextBoxes();
                btnapply.Text = "Submit Application";

            }
            redirectToJobShow();

        }

        public void redirectToJobShow()
        {
            Response.Redirect("~/JobSeeker/SeekerJobShow.aspx");

        }



        public void LoadDataForEdit()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("proctblJobSeekerJobApplyEdit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@JSJobApplyID", ViewState["EditId"]);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                textname.Text = dt.Rows[0]["JSJobApplyName"].ToString();
                textemail.Text = dt.Rows[0]["JSJobApplyEmail"].ToString();
                textcontactnumber.Text = dt.Rows[0]["JSJobApplyContact"].ToString();
                textcurrentlocation.Text = dt.Rows[0]["CurrentLocation"].ToString();
                ddlexprience.SelectedValue = dt.Rows[0]["Experience"].ToString();
                textcurrentcompany.Text = dt.Rows[0]["CurrentCompany"].ToString();
                textexpectedsalary.Text = dt.Rows[0]["ExpectedSalary"].ToString();
                textskills.Text = dt.Rows[0]["Skills"].ToString();
                textquery.Text = dt.Rows[0]["CoverMessage"].ToString();
                ViewState["resume"] = dt.Rows[0]["ResumePath"].ToString();
                btnapply.Text = "Update";
            }


        }

    }

}

