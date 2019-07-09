using CMS_Tools.Lib;
using CMS_Tools.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace CMS_Tools.Apis
{
    /// <summary>
    /// Summary description for API_Agency
    /// </summary>
    public class API_Agency : IHttpHandler, IRequiresSessionState
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
                    case Constants.REQUEST_AGENCY_TYPE.LOCK_AGENCY:
                        LOCK_AGENCY(context);
                        break;
                    case Constants.REQUEST_AGENCY_TYPE.UNLOCK_AGENCY:
                        UNLOCK_AGENCY(context);
                        break;
                    default:
                        result.status = Constants.NUMBER_CODE.REQUEST_NOT_FOUND;
                        result.msg = Constants.NUMBER_CODE.REQUEST_NOT_FOUND.ToString();
                        context.Response.Write(JsonConvert.SerializeObject(result));
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
        /// Mở khóa đại lý
        /// </summary>
        /// <param name="context"></param>
        private void UNLOCK_AGENCY(HttpContext context)
        {
            try
            {
                if (context.Session["UNLOCK_AGENCY"] == null || ((DateTime)context.Session["UNLOCK_AGENCY"] - DateTime.Now).TotalMilliseconds < Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        var jsonData = JsonConvert.DeserializeObject<UnLockAgencyEntity>(json);
                        if (jsonData != null)
                        {
                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));
                            if (string.IsNullOrEmpty(jsonData.agencyID))
                            {
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Mã đại lý không được trống!";
                            }
                            else
                            {
                                jsonData.creatorID = accountInfo.AccountId;
                                jsonData.creatorName = accountInfo.UserName;

                                PayloadApi p = new PayloadApi()
                                {
                                    clientIP = UtilClass.GetIPAddress(),
                                    data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                                };
                                var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/Agency/UnLockAgency");
                                context.Response.Write(responseData);
                                return;
                            }
                        }
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
                Logs.SaveError("ERROR UNLOCK_AGENCY: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["UNLOCK_AGENCY"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        /// <summary>
        /// Khóa đại lý
        /// </summary>
        /// <param name="context"></param>
        private void LOCK_AGENCY(HttpContext context)
        {
            try
            {
                if (context.Session["LOCK_AGENCY"] == null || ((DateTime)context.Session["LOCK_AGENCY"] - DateTime.Now).TotalMilliseconds < Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        var jsonData = JsonConvert.DeserializeObject<LockAgencyEntity>(json);
                        if (jsonData != null)
                        {
                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));
                            if (string.IsNullOrEmpty(jsonData.agencyID))
                            {
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Mã đại lý không được trống!";
                            }
                            else
                            {
                                jsonData.creatorID = accountInfo.AccountId;
                                jsonData.creatorName = accountInfo.UserName;

                                PayloadApi p = new PayloadApi()
                                {
                                    clientIP = UtilClass.GetIPAddress(),
                                    data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                                };
                                var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/Agency/LockAgency");
                                context.Response.Write(responseData);
                                return;
                            }
                        }
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
                Logs.SaveError("ERROR LOCK_AGENCY: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["LOCK_AGENCY"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }


        /// <summary>
        /// Tạo đại lý cấp 1 mới
        /// </summary>
        /// <param name="context"></param>
        private void CREATE_AGENCY(HttpContext context)
        {
            short debug = 0;
            try
            {
                if (context.Session["CREATE_AGENCY"] == null || ((DateTime)context.Session["CREATE_AGENCY"] - DateTime.Now).TotalMilliseconds < Constants.TIME_REQUEST)
                {
                    debug = 1;
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        debug = 2;
                        var jsonData = JsonConvert.DeserializeObject<AgencyEntity>(json);
                        if (jsonData != null)
                        {
                            debug = 3;
                            if (string.IsNullOrEmpty(jsonData.agencyCode))
                            {
                                debug = 301;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Mã đại lý không được bỏ trống!";
                            }
                            else if(jsonData.agencyCode.Length < 6 || jsonData.agencyCode.Length >20)
                            {
                                debug = 302;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Mã đại lý phải từ 6-20 ký tự";
                            }
                            else if (string.IsNullOrEmpty(jsonData.password))
                            {
                                debug = 303;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Password không được để trống";
                            }
                            else if (jsonData.password.Length <6 && jsonData.password.Length >20)
                            {
                                debug = 304;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Password phải từ 6-20 ký tự";
                            }
                            else if (jsonData.email.Length > 80)
                            {
                                debug = 3051;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Email không được dài hơn 80 ký tự";
                            }
                            else if (string.IsNullOrEmpty(jsonData.phone))
                            {
                                debug = 306;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Số điện thoại không được để trống";
                            }
                            else if (jsonData.phone.Length != 10)
                            {
                                debug = 307;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Số điện thoại phải là 10 chữ số";
                            }
                            else if (string.IsNullOrEmpty(jsonData.displayName))
                            {
                                debug = 308;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Tên hiển thị không được để trống";
                            }
                            else if (jsonData.displayName.Length < 6)
                            {
                                debug = 309;
                                result.status = Constants.NUMBER_CODE.INFO_CREATE_AGENCY_VALI;
                                result.msg = "Tên hiển thị phải nhiều hơn 5 ký tự";
                            }
                            else {
                                debug = 310;

                                jsonData.IP = UtilClass.GetIPAddress();
                                jsonData.creatorID = accountInfo.AccountId;
                                jsonData.creatorName = accountInfo.UserName;
                                jsonData.limitTransaction = Constants.limitTransaction;
                                jsonData.limitTransactionDaily = Constants.limitTransactionDaily;

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
                            debug = 4;
                            result.status = Constants.NUMBER_CODE.DATA_NULL;
                            result.msg = Constants.NUMBER_CODE.DATA_NULL.ToString();
                        }
                    }
                    else
                    {
                        debug = 5;
                        result.status = Constants.NUMBER_CODE.DATA_NULL;
                        result.msg = Constants.NUMBER_CODE.DATA_NULL.ToString();
                    }
                }
                else
                {
                    debug = 6;
                    result.status = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER;
                    result.msg = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER.ToString();
                }
            }
            catch (Exception ex)
            {
                Logs.SaveError("ERROR CREATE_AGENCY: [debug]:" +debug + "\n,\n" + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                Logs.SaveError("[debug]:" + debug);
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



    #region EnityClass
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

    public class LockAgencyEntity
    {
        public string agencyID;
        public string note; //ghi chú khi khoa tai khoan của đại lý
        public int creatorID;
        public string creatorName;
    }

    public class UnLockAgencyEntity
    {
        public string agencyID;
        public int creatorID;
        public string creatorName;
    }
    #endregion


}