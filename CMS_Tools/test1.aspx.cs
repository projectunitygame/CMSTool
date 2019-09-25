using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CMS_Tools
{
    public partial class test1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write(Lib.Encryptor.DecryptString("0x01000000B51CF90DF1154B6F34AA2265A27385B7D3AB7AA802DFF70E9D9F98CC06C363D9", Lib.Constants.KEY_SQL));
            //Lib.SMS.SendMessage("0962474560", "testsms");
        }
    }
}