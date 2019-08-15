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
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.LOCK_CHAT_GAME_ACCOUNT:
                        LOCK_CHAT_GAME_ACCOUNT(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.UNLOCK_CHAT_GAME_ACCOUNT:
                        UNLOCK_CHAT_GAME_ACCOUNT(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.CREATE_SCHEME_NOTIFICATION:
                        CREATE_SCHEME_NOTIFICATION(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.UPDATE_SCHEME_NOTIFICATION:
                        UPDATE_SCHEME_NOTIFICATION(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.DELETE_SCHEME_NOTIFICATION:
                        DELETE_SCHEME_NOTIFICATION(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.CREATE_EVENT_GIFTCODE:
                        CREATE_EVENT_GIFTCODE(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.UPDATE_EVENT_GIFTCODE:
                        UPDATE_EVENT_GIFTCODE(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.DELETE_EVENT_GIFTCODE:
                        DELETE_EVENT_GIFTCODE(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.EXCEPT_FUND_GAME:
                        EXCEPT_FUND_GAME(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.ACCEPT_CARD:
                        ACCEPT_CARD(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.DELETE_CASH_OUT_CARD:
                        DELETE_CASH_OUT_CARD(context);
                        break;
                    case Constants.REQUEST_GAME_ACOUNT_TYPE.DELETE_FAIL_TRANSACTION_CARD:
                        DELETE_FAIL_TRANSACTION_CARD(context);
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
        /// Xóa giao dịch mua thẻ lỗi
        /// </summary>
        /// <param name="context"></param>
        private void DELETE_FAIL_TRANSACTION_CARD(HttpContext context)
        {
            try
            {
                if (context.Session["DELETE_FAIL_TRANSACTION_CARD"] == null || (DateTime.Now - (DateTime)context.Session["DELETE_FAIL_TRANSACTION_CARD"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<DeleteFailTransactionCard>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<DeleteFailTransactionCard>(json);
                        if (jsonData != null)
                        {
                            //jsonData.AccountName = accountInfo.UserName;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/DeleteFailTransactionCard");
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
                Logs.SaveError("ERROR DELETE_FAIL_TRANSACTION_CARD: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["DELETE_FAIL_TRANSACTION_CARD"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }
        /// <summary>
        /// Xóa yêu cầu rút tiền thẻ
        /// </summary>
        /// <param name="context"></param>
        private void DELETE_CASH_OUT_CARD(HttpContext context)
        {
            try
            {
                if (context.Session["DELETE_CASH_OUT_CARD"] == null || (DateTime.Now - (DateTime)context.Session["DELETE_CASH_OUT_CARD"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<DeleteCashOutCard>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<DeleteCashOutCard>(json);
                        if (jsonData != null)
                        {
                            //jsonData.AccountName = accountInfo.UserName;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/DeleteCashOutCard");
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
                Logs.SaveError("ERROR DELETE_CASH_OUT_CARD: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["DELETE_CASH_OUT_CARD"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }
        /// <summary>
        /// Duyệt thẻ
        /// </summary>
        /// <param name="context"></param>
        private void ACCEPT_CARD(HttpContext context)
        {
            try
            {
                if (context.Session["ACCEPT_CARD"] == null || (DateTime.Now - (DateTime)context.Session["ACCEPT_CARD"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<AcceptCard>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<AcceptCard>(json);
                        if (jsonData != null)
                        {
                            //jsonData.AccountName = accountInfo.UserName;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/AcceptCard");
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
                Logs.SaveError("ERROR ACCEPT_CARD: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["ACCEPT_CARD"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void EXCEPT_FUND_GAME(HttpContext context)
        {
            try
            {
                if (context.Session["EXCEPT_FUND_GAME"] == null || (DateTime.Now - (DateTime)context.Session["EXCEPT_FUND_GAME"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<ExceptFundGame>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<ExceptFundGame>(json);
                        if (jsonData != null)
                        {
                            jsonData.AccountName = accountInfo.UserName;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/ExceptFundGame");
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
                Logs.SaveError("ERROR EXCEPT_FUND_GAME: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["EXCEPT_FUND_GAME"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void DELETE_EVENT_GIFTCODE(HttpContext context)
        {
            try
            {
                if (context.Session["DELETE_EVENT_GIFTCODE"] == null || (DateTime.Now - (DateTime)context.Session["DELETE_EVENT_GIFTCODE"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<DeleteEventGiftCode>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<DeleteEventGiftCode>(json);
                        if (jsonData != null)
                        {
                            //jsonData.Author = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/DeleteEventGiftCode");
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
                Logs.SaveError("ERROR DELETE_EVENT_GIFTCODE: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["DELETE_EVENT_GIFTCODE"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void UPDATE_EVENT_GIFTCODE(HttpContext context)
        {
            try
            {
                if (context.Session["UPDATE_EVENT_GIFTCODE"] == null || (DateTime.Now - (DateTime)context.Session["UPDATE_EVENT_GIFTCODE"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<UpdateEventGiftCode>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<UpdateEventGiftCode>(json);
                        if (jsonData != null)
                        {
                            //jsonData.Author = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/UpdateEventGiftCode");
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
                Logs.SaveError("ERROR UPDATE_EVENT_GIFTCODE: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["UPDATE_EVENT_GIFTCODE"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void CREATE_EVENT_GIFTCODE(HttpContext context)
        {
            try
            {
                if (context.Session["CREATE_EVENT_GIFTCODE"] == null || (DateTime.Now - (DateTime)context.Session["CREATE_EVENT_GIFTCODE"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<CreateEventGiftCode>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<CreateEventGiftCode>(json);
                        if (jsonData != null)
                        {
                            if (string.IsNullOrEmpty(jsonData.Name))
                            {
                                result.status = Constants.NUMBER_CODE.EVENT_GIFTCODE_VALI;
                                result.msg = "Tên giftcode không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Name.Length > 200)
                            {
                                result.status = Constants.NUMBER_CODE.EVENT_GIFTCODE_VALI;
                                result.msg = "Tên giftcode không được lớn hơn 500 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (string.IsNullOrEmpty(jsonData.Prefix))
                            {
                                result.status = Constants.NUMBER_CODE.EVENT_GIFTCODE_VALI;
                                result.msg = "Tiền tố giftcode không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Prefix.Length > 5)
                            {
                                result.status = Constants.NUMBER_CODE.EVENT_GIFTCODE_VALI;
                                result.msg = "Tiền tố giftcode không được lớn hơn 5 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            jsonData.AgencyId = 0;
                            jsonData.Created = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/CreateEventGiftCode");
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
                Logs.SaveError("ERROR CREATE_EVENT_GIFTCODE: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["CREATE_EVENT_GIFTCODE"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void DELETE_SCHEME_NOTIFICATION(HttpContext context)
        {
            try
            {
                if (context.Session["DELETE_SCHEME_NOTIFICATION"] == null || (DateTime.Now - (DateTime)context.Session["DELETE_SCHEME_NOTIFICATION"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<DeleteSchemeNotificationGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<DeleteSchemeNotificationGameEnity>(json);
                        if (jsonData != null)
                        {
                            //jsonData.Author = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/DeleteSchemeNotificationGame");
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
                Logs.SaveError("ERROR DELETE_SCHEME_NOTIFICATION: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["DELETE_SCHEME_NOTIFICATION"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void UPDATE_SCHEME_NOTIFICATION(HttpContext context)
        {
            try
            {
                if (context.Session["UPDATE_SCHEME_NOTIFICATION"] == null || (DateTime.Now - (DateTime)context.Session["UPDATE_SCHEME_NOTIFICATION"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<UpdateSchemeNotificationGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<UpdateSchemeNotificationGameEnity>(json);
                        if (jsonData != null)
                        {
                            if (string.IsNullOrEmpty(jsonData.Message))
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Nội dung thông báo không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Message.Length > 500)
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Nội dung thông báo không được lớn hơn 500 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Title.Length > 250)
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Title thông báo không được lớn hơn 250 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            //jsonData.Author = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/UpdateSchemeNotificationGame");
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
                Logs.SaveError("ERROR UPDATE_SCHEME_NOTIFICATION: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["UPDATE_SCHEME_NOTIFICATION"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        private void CREATE_SCHEME_NOTIFICATION(HttpContext context)
        {
            try
            {
                if (context.Session["CREATE_SCHEME_NOTIFICATION"] == null || (DateTime.Now - (DateTime)context.Session["CREATE_SCHEME_NOTIFICATION"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<CreateSchemeNotificationGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<CreateSchemeNotificationGameEnity>(json);
                        if (jsonData != null)
                        {

                            if (string.IsNullOrEmpty(jsonData.Message))
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Nội dung thông báo không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Message.Length >500)
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Nội dung thông báo không được lớn hơn 500 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            else if (jsonData.Title.Length > 250)
                            {
                                result.status = Constants.NUMBER_CODE.NOTIFICATION_VALI;
                                result.msg = "Title thông báo không được lớn hơn 250 ký tự";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }

                            //jsonData.Author = accountInfo.AccountId;
                            //jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            //Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/CreateSchemeNotificationGame");
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
                Logs.SaveError("ERROR CREATE_SCHEME_NOTIFICATION: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["CREATE_SCHEME_NOTIFICATION"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }


        /// <summary>
        /// Mở khóa chat game
        /// </summary>
        /// <param name="context"></param>
        private void UNLOCK_CHAT_GAME_ACCOUNT(HttpContext context)
        {
            try
            {
                if (context.Session["UNLOCK_CHAT_GAME_ACCOUNT"] == null || (DateTime.Now - (DateTime)context.Session["UNLOCK_CHAT_GAME_ACCOUNT"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<UnlockChatAccountGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<UnlockChatAccountGameEnity>(json);
                        if (jsonData != null)
                        {
                            jsonData.Author = accountInfo.AccountId;
                            jsonData.Reason = "Tài khoản mở khóa chat: " + accountInfo.UserName;

                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/UnlockChatAccountGame");
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
                Logs.SaveError("ERROR UNLOCK_CHAT_GAME_ACCOUNT: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["UNLOCK_CHAT_GAME_ACCOUNT"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
        }

        /// <summary>
        /// Khóa chat game
        /// </summary>
        /// <param name="context"></param>
        private void LOCK_CHAT_GAME_ACCOUNT(HttpContext context)
        {
            try
            {
                if (context.Session["LOCK_CHAT_GAME_ACCOUNT"] == null || (DateTime.Now - (DateTime)context.Session["LOCK_CHAT_GAME_ACCOUNT"]).TotalMilliseconds > Constants.TIME_REQUEST)
                {
                    string json = context.Request.Form["json"];
                    if (!string.IsNullOrEmpty(json))
                    {
                        try
                        {
                            JsonConvert.DeserializeObject<LockChatAccountGameEnity>(json);
                        }
                        catch (Exception)
                        {
                            result.status = Constants.NUMBER_CODE.ERROR_EX;
                            result.msg = "Sai thông tin nhập vào";
                            context.Response.Write(JsonConvert.SerializeObject(result));
                            return;
                        }

                        var jsonData = JsonConvert.DeserializeObject<LockChatAccountGameEnity>(json);
                        if (jsonData != null)
                        {
                            jsonData.Author = accountInfo.AccountId;
                            jsonData.Reason = "Tài khoản khóa chat: " + accountInfo.UserName + ", Ghi chú: " + jsonData.Reason;
                            if (jsonData.Reason.Length > 500)
                            {
                                result.status = Constants.NUMBER_CODE.LOCK_ACCOUNT_GAME_VALI;
                                result.msg = "Nội dung thông báo không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
                            Logs.SaveLog(JsonConvert.SerializeObject(jsonData));

                            PayloadApi p = new PayloadApi()
                            {
                                clientIP = UtilClass.GetIPAddress(),
                                data = Encryptor.EncryptString(JsonConvert.SerializeObject(jsonData), Constants.API_SECRETKEY)
                            };
                            var responseData = UtilClass.SendPost(JsonConvert.SerializeObject(p), Constants.API_URL + "api/v1/GameAccount/LockChatAccountGame");
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
                Logs.SaveError("ERROR LOCK_CHAT_GAME_ACCOUNT: " + ex);
                result.status = Constants.NUMBER_CODE.ERROR_EX;
                result.msg = Constants.NUMBER_CODE.ERROR_EX.ToString();
            }
            finally
            {
                context.Session["LOCK_CHAT_GAME_ACCOUNT"] = DateTime.Now;
            }
            context.Response.Write(JsonConvert.SerializeObject(result));
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
                            if (jsonData.Reason.Length > 500)
                            {
                                result.status = Constants.NUMBER_CODE.LOCK_ACCOUNT_GAME_VALI;
                                result.msg = "Nội dung thông báo không được để trống";
                                context.Response.Write(JsonConvert.SerializeObject(result));
                                return;
                            }
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

        public class LockChatAccountGameEnity
        {
            public long AccountID;
            public string Reason;
            public int Author;
        }

        public class UnlockChatAccountGameEnity
        {
            public long AccountID;
            public string Reason;
            public int Author;
        }

        public class CreateSchemeNotificationGameEnity
        {
            public CreateSchemeNotificationGameEnity()
            {
                Title = "";
                Platform = "ALL";
            }
            public string Title;
            public string Message;
            public string Platform;
            public DateTime DateSend;
            public string Loop;
            public string Status;
        }

        public class UpdateSchemeNotificationGameEnity
        {
            public UpdateSchemeNotificationGameEnity()
            {
                Title = "";
                Platform = "ALL";
            }
            public int Id;
            public string Title;
            public string Message;
            public string Platform;
            public DateTime DateSend;
            public string Loop;
            public string Status;
        }

        public class DeleteSchemeNotificationGameEnity
        {
            public int Id;
        }

        public class CreateEventGiftCode
        {
            public CreateEventGiftCode()
            {
                Type = 0;
                Created = 0;
            }
            public string Name;
            public int Created;
            public long Price;
            public int Type;
            public int AgencyId;
            public int Qty;
            public string Prefix;
            public DateTime Expired;
        }
        public class DeleteEventGiftCode
        {
            public string ID;
        }

        public class UpdateEventGiftCode
        {
            public int ID;
            public DateTime Expired;
        }
        public class ExceptFundGame
        {
            public int GameID;
            public int RoomID;
            public long Value;
            public string AccountName;
        }
        public class AcceptCard
        {
            public long CardID;
        }
        public class DeleteCashOutCard
        {
            public long CardID;
        }
        public class DeleteFailTransactionCard
        {
            public long ID;
        }
        #endregion
    }
}