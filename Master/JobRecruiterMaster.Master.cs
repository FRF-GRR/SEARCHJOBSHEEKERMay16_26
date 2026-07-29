using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEARCHJOBSHEEKERMay16_26.Master
{
    public partial class JobRecruiterMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["JRID"].ToString() == "" || Session["JRID"] == null)
                {
                    Response.Redirect("~/default.aspx");
                }

            }



        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/default.aspx");
        }
    }
}