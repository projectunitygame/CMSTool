﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CMS_Tools
{
    public partial class Ping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Lib.Logs.SaveLog(Request.Url.AbsoluteUri);
            Response.Write("ping " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss"));
        }
    }
}