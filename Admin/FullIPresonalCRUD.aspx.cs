using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SEARCHJOBSHEEKERMay16_26.Admin
{
    public partial class FullIPresonalCRUD : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Connectivity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }

        }

        public void Clear()
        {
            txtName.Text = "";
            ddlGender.SelectedIndex = 0;
            txtEmail.Text = "";
            txtContact.Text = "";
            txtAddhar.Text = "";
            txtDateOfBirth.Text = "";
            txtPassword.Text = "";
        }

        public void BindGrid()
        {
            SqlCommand cmd = new SqlCommand("sp_PersonalInformation_CRUD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "SELECT");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvpshow.DataSource = dt;
            gvpshow.DataBind();
        }


        protected void btnSubmit_Click1(object sender, EventArgs e)
        {
            string FN1 = Path.GetFileName(fuImage.PostedFile.FileName);
            fuImage.SaveAs(Server.MapPath("~/Admin/PImgSave" + "\\" + FN1));

            string FN2 = Path.GetFileName(fuSignature.PostedFile.FileName);
            fuSignature.SaveAs(Server.MapPath("~/Admin/PImgSave" + "\\" + FN2));
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_PersonalInformation_CRUD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "INSERT");
            cmd.Parameters.AddWithValue("@pName", txtName.Text);
            cmd.Parameters.AddWithValue("@pGender", ddlGender.SelectedValue);
            cmd.Parameters.AddWithValue("@pEmail", txtEmail.Text);
            cmd.Parameters.AddWithValue("@pContact", txtContact.Text);
            cmd.Parameters.AddWithValue("@pAddhar", txtAddhar.Text);
            cmd.Parameters.AddWithValue("@pDateOfBirth", txtDateOfBirth.Text);
            cmd.Parameters.AddWithValue("@pImage", FN1);
            cmd.Parameters.AddWithValue("@pSignature", FN2);
            cmd.Parameters.AddWithValue("@pPassword", txtPassword.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            BindGrid();
            Clear();

        }
    }
}