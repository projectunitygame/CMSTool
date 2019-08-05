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
    /// Summary description for API_GameAccount
    /// </summary>
    public class API_GameAccount : IHttpHandler, IRequiresSessionState
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

                Constants.REQUEST_GAME_ACOUNT_TYPE requestType = (Constants.REQUEST_GAME_ACOUNT_TYPE)int.Parse(context.Request.Form["type"]);
                switch (requestType)
                {
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.LOCK_GAME_ACCOUNT:
                        LOCK_GAME_ACCOUNT(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.UNLOCK_GAME_ACCOUNT:
                        UNLOCK_GAME_ACCOUNT(context);
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
        /// Mở khóa đăng nhập game
        /// </summary>
        /// <param name="context"></param>
        private void UNLOCK_GAME_ACCOUNT(HttpContext context)
        {
            try
            {
                if (context.Session["UNLOCK_GAME_ACCOUNT"] == null || (DateTime.Now - (DateTime)context.Session["UNLOCK_GAME_ACCOUNT"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<UnlockAccountGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<UnlockAccountGameEnity>(json);
                        if (jsonData != null)
                        {
                            jsonData.Author = accountInfo.AccountId;
                            jsonData.Reason = "Tài khoản mở khóa: " + accountInfo.UserName;

                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/UnlockAccountGame");
                            context.Response.Write(responseData);
                            return;
                        }
                    }
                }
                else
                {
                    result.status = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER;
                    result.msg = "Thao tác quá nhanh! vui lòng thử lại";
                }
            }
            catch (Exception ex)
            {
                Logs.SaveError("ERROR UNLOCK_GAME_ACCOUNT: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["UNLOCK_GAME_ACCOUNT"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        /// <summary>
        /// Khóa đăng nhập game
        /// </summary>
        /// <param name="context"></param>
        private void LOCK_GAME_ACCOUNT(HttpContext context)
        {
            try
            {
                if (context.Session["LOCK_GAME_ACCOUNT"] == null || (DateTime.Now - (DateTime)context.Session["LOCK_GAME_ACCOUNT"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<LockAccountGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<LockAccountGameEnity>(json);
                        if (jsonData != null)
                        {
                            jsonData.Author = accountInfo.AccountId;
                            jsonData.Reason = "Tài khoản khóa: " + accountInfo.UserName + ", Ghi chú: " + jsonData.Reason;
                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/LockAccountGame");
                            context.Response.Write(responseData);
                            return;
                        }
                    }
                }
                else
                {
                    result.status = Constants.NUMBER_CODE.ERROR_CONNECT_SERVER;
                    result.msg = "Thao tác quá nhanh! vui lòng thử lại";
                }
            }
            catch (Exception ex)
            {
                Logs.SaveError("ERROR LOCK_GAME_ACCOUNT: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["LOCK_GAME_ACCOUNT"] = DateTime.Now;
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


        #region Enity class
        public class LockAccountGameEnity
        {
            public long AccountID;
            public string Reason;
            public int Author;
        }

        public class UnlockAccountGameEnity
        {
            public long AccountID;
            public string Reason;
            public int Author;
        }
        #endregion
    }
}