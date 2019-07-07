using CMS_Tools.Lib;
using CMS_Tools.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CMS_Tools.Apis
{
    /// <summary>
    /// Summary description for API_Agency
    /// </summary>
    public class API_Agency : IHttpHandler
    {
        UserInfo accountInfo;
        Result result = new Result();
        List<Constants.USER_PERMISSTIONS> uSER_RULEs = new List<Constants.USER_PERMISSTIONS>();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json;charset=utf-8";
            try
            {
                #region CHECK ACCOUNT LOGIN
                accountInfo = Account.GetAccountInfo(context);

                if (accountInfo == null)
                {
                    result.status = Constants.NUMBER_CODE.ACCOUNT_NOT_LOGIN;
                    result.msg = Constants.NUMBER_CODE.ACCOUNT_NOT_LOGIN.ToString();
                    context.Response.Write(JsonConvert.SerializeObject(result));
                    return;
                }
                #endregion

                Constants.REQUEST_AGENCY_TYPE requestType = (Constants.REQUEST_AGENCY_TYPE)int.Parse(context.Request.Form["type"]);
                switch (requestType)
                {
                    case Constants.REQUEST_AGENCY_TYPE.CREATE_AGENCY:
                        CREATE_AGENCY(context);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                Logs.SaveError("ERROR API_Agency: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
                context.Response.Write(JsonConvert.SerializeObject(result));
            }
        }

        /// <summary>
        /// Tạo đại lý cấp 1 mới
        /// </summary>
        /// <param name="context"></param>
        private void CREATE_AGENCY(HttpContext context)
        {
            try
            {
                if (context.Session["CREATE_AGENCY"] == null || ((DateTime)context.Session["CREATE_AGENCY"] - DateTime.Now).TotalMilliseconds < Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        var jsonData = JsonConvert.DeserializeObject<AgencyEntity>(json);
                        if(jsonData != null)
                        {
                            if (string.IsNullOrEmpty(jsonData.agencyCode))
                            {
                                result.status = Constants.NUMBER_CODE.DATA_NULL;
                                result.msg = "Mã đại lý không được bỏ trống!";
                            }
                            else if (string.IsNullOrEmpty(jsonData.password))
                            {
                                result.status = Constants.NUMBER_CODE.DATA_NULL;
                                result.msg = "!";
                            }
                            else {
                                PayloadApi p = new PayloadApi()
                                {
                                    clientIP = UtilClass.GetIPAddress(),
                                    data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                                };
                                var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "/api/v1/Agency/CreateAgency");
                                context.Response.Write(responseData);
                                return;
                            }
                        }
                        else
                        {
                            result.status = Constants.NUMBER_CODE.DATA_NULL;
                            result.msg = Constants.NUMBER_CODE.DATA_NULL.ToString();
                        }
                    }
                    else
                    {
                        result.status = Constants.NUMBER_CODE.DATA_NULL;
                        result.msg = Constants.NUMBER_CODE.DATA_NULL.ToString();
                    }
                }
                else
                {
                    result.status = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER;
                    result.msg = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER.ToString();
                }
            }
            catch (Exception ex)
            {
                Logs.SaveError("ERROR CREATE_AGENCY: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["CREATE_AGENCY"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    public class AgencyEntity
    {
        public string agencyCode;
        public string password;
        public string email;
        public string phone;
        public string displayName;
        public int ownerID;
        public string IP;
        public decimal limitTransaction;
        public decimal limitTransactionDaily;
        public int creatorID;
        public string creatorName;
    }
}