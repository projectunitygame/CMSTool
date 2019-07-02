﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace CMS_Tools.Lib
{
    public static class Constants
    {
        public const int TIME_REQUEST = 500;
        public const int TIMOUT_CONNECT_SQL = 60000;
        public static string STR_CONNECT_IDENTITY = WebConfigurationManager.AppSettings["CONNECT_IDENTITY"];
        public readonly static string GG_JSON_FILE = WebConfigurationManager.AppSettings["GG_ClientJSON"];
        public const string KEY_CONNECT_STRING = "9465162a63e95a093f2e556b95f0895b";
        public const string KEY_SQL = "48dc695d5f6203fd54b85c93b022ffe5";
        public const string KEY_SERVER = "63dc8f4d5805b4b972e769b9d50ff004";
        public const string secretKey = "YVHI%$#$#augef903EBHnug3242@$$&dfsf%#^*[]4851RUGBHHJLW=";
        public static string COPY_RIGHT = WebConfigurationManager.AppSettings["COPY_RIGHT"];
        public static string SERVER_TYPE = WebConfigurationManager.AppSettings["SERVER_TYPE"];
        public static string SERVER_VER = WebConfigurationManager.AppSettings["SERVER_VER"];
        public static string API_URL = WebConfigurationManager.AppSettings["API_URL"];
        public const string PING_URL = "https://www.datphuprinting.vn/ping.aspx";
        private readonly static List<USER_PERMISSTIONS> PERMISSTIONS = new List<USER_PERMISSTIONS>();
        public readonly static string API_PUBLICKEY = WebConfigurationManager.AppSettings["PUBLICKEY"];
        public readonly static string API_SECRETKEY = WebConfigurationManager.AppSettings["SECRETKEY"];
        public readonly static short API_SERVICEID = short.Parse(WebConfigurationManager.AppSettings["SERVICEID"]);
        public static List<USER_PERMISSTIONS> GET_PERMISSTIONS() {
            if (PERMISSTIONS.Count == 0)
            {
                foreach (int value in Enum.GetValues(typeof(USER_PERMISSTIONS)))
                {
                    PERMISSTIONS.Add((USER_PERMISSTIONS)value);
                }
            }
            return PERMISSTIONS.ToList();
        }

        public static bool TryParseEnum<TEnum>(this int enumValue, out TEnum retVal)
        {
            retVal = default(TEnum);
            bool success = Enum.IsDefined(typeof(TEnum), enumValue);
            if (success)
            {
                retVal = (TEnum)Enum.ToObject(typeof(TEnum), enumValue);
            }
            return success;
        }

        public enum LOG_TYPE : byte
        {
            TRACKING_LOGS = 0,
            CUSTOMER_LOGS,
            ERROR_LOGS
        }

        public enum USER_PERMISSTIONS: int
        {
            VIEW = 0,
            ADD,
            UPDATE,
            DELETE,
            TASK_VIEW,
            TASK_ADD,
            TASK_UPDATE,
            TASK_DELETE,
            TASK_OWNER
        }

        public enum USER_STATUS : int
        {
            LOGIN_SUCCESS = 0
        }

        public enum TOKEN_ACCOUNT_STATUS: byte
        {
            NOT_ACTIVE = 0,
            ACTIVE
        }

        public enum LOGIN_TYPE: byte
        {
            SINGLEID = 1,
            GOOGLE,
            FB
        }

        public enum LOGOUT_TYPE : byte
        {
            ALL_DEVICE = 255,
            SINGLE_DEVICE = 0
        }

        public enum NUMBER_CODE: int
        {
            ERROR = -1,
            SUCCESS = 0,
            LOGIN_SUCCESS,
            //code sql
            WRONG_KEY_SQL = 999,
            INSERT_ACCOUNT_ERROR = 102,
            UPDATE_HASHCODE_ACCOUNT_ERROR,
            INSERT_ACCOUNT_LOGIN_ERROR,
            UPDATE_HASHCODE_ACCOUNT_LOGIN_ERROR,
            INSERT_DEVICE_ERROR,
            INSERT_TOKEN_LOGIN_ERROR,
            UPDATE_TOKEN_LOGIN_ERROR,
            CREATE_MENU_ERROR,
            TOKEN_WRONG,
            LOGOUT_ERROR,
            ACCOUNT_LOCK,
            MENU_NULL,
            UPDATE_MENU_ERROR,
            INSERT_MENU_LOG_ERROR,
            CLONE_MENU_ERROR,
            UPDATE_HASHCODE_MENU_ERROR,
            ACCOUNT_NULL,
            LOCK_ACCOUNT_FAIL,
            ACCOUNT_GROUP_EXIST,
            ADD_ACCOUNT_GROUP_ERROR,
            UPDATE_ACCOUNT_GROUP_ERROR,
            UPDATE_HASHCODE_ACCOUNT_GROUP_ERROR,
            GROUP_RULE_IS_NULL,
            UPDATE_GROUP_RULE_ERROR,
            UPDATE_STATUS_ACCOUNT_ERROR,
            CHANGE_PASSWORD_FAILD,
            CATEGORYID_IS_NULL,
            ADD_ARTICLE_FAILD,
            UPDATE_ARTICLE_FAILD,
            ADD_ARTICLE_TAG_FAILD,
            //code c#
            ERROR_EX = 5000,
            REQUEST_NOT_FOUND,
            USERNAME_IS_NULL,
            PASS_IS_NULL,
            DATA_NULL,
            ACCOUNT_NOT_LOGIN,
            SIGN_OUT_FAID,
            MENU_ID_IS_NULL,
            YOU_DO_NOT_PERMISSION_TO_ACCESS,
            MENU_NOT_FOUND,
            PARENT_ID_INVALID,
            TOKEN_EXPIRE,
            ACCOUNT_LIST_NULL,
            LOCK_ACCOUNT_FAID,
            MENU_NOT_ALLOW_INSERT,
            INSERT_DATATABLE_FAILD,
            SEND_MAIL_FAILD,
            RESET_PASSWORD_TIMEOUT,
            PASS_INVALID,
            DATE_INVALID,
            ERROR_CONNECT_SERVER,
            COMPANY_NAME_IS_NULL,
            CUSTOMER_ID_INVALID,
            CITY_IS_NULL,
            COUNTRY_IS_NULL,
            KM_INVALID,
            REQUEST_TYPE_NOT_FOUND,
            NUMBER_INVALID
        }

        public enum REQUEST_TYPE: int
        {
            LOGIN = 0,
            SIGN_OUT,
            LOCK_SCREEN,
            FORGOT_PASSWORD,
            RESET_PASSWORD,
            CHANGE_PASSWORD,
            CHANGE_AVATAR,
            UPDATE_PROFILE,
            CREATE_MENU,
            UPDATE_MENU,
            REMOVE_MENU,
            GET_LIST_MENU,
            GET_MENU,
            GET_DATA_BY_MENU,
            GET_DATA_BY_QUERY,
            GET_MENU_DETAIL,
            CLONE_MENU,
            GET_ACCOUNT_LIST,
            LOCK_ACCOUNT,
            GET_LIST_DATABASE,
            INSERT_DATATABLE,
            UPDATE_DATATABLE,
            DELETE_DATATABLE,
            GET_PERMISSIONS,
            GET_ACCOUNT_GROUP_BY_ID,
            GET_ALL_MENU,
            UPDATE_GROUP_PERMISSIONS,
            CREATE_ACCOUNT,
            UPDATE_STATUS_ACCOUNT,
            UPDATE_ARTICLE,
            ADD_CATEGORY,
            UPDATE_CATEGORY,
            REMOVE_CATEGORY,
            GET_CATEGORIES_TAGS,


            API_CREATE_CUSTOMER = 4000,
            API_UPDATE_CUSTOMER,
            API_GET_CUSTOMER,
            API_LOCK_CUSTOER,
            API_UNLOCK_CUSTOMER,
            API_GET_PROVINCE,
            API_GET_COUNTRY,
            API_GET_NHACUNGCAP,
            API_GET_LOAIDONHANG,
            API_GET_KIEUTHUNG,
            API_GET_LOAIHINHSX,
            API_GET_CHATLIEU,
            API_GET_LOAISONG,
            API_FIND_CUSTOMERS,
            API_GET_CUSTOMER_BY_CODE,
            API_GET_TINHTOAN_KICHTHUOC_THUNG,
            API_ADD_NEW_ORDER_DETAIL,
            API_UPDATE_ORDER_DETAIL,
            API_SAVE_ORDER,
            API_REMOVE_ORDER_DETAIL,
            API_GET_LIST_ORDER_DETAIL_TEMP,
            API_GET_LIST_ORDER_DETAIL,
            API_GET_LIST_ORDERS,
            API_FIND_CUSTOMERS_BY_ORDER,
            API_GET_LIST_ORDER_DETAIL_BY_ORDERCODE,
            API_GET_ORDER_INFO,
            API_GET_ORDER_PRINT_INFO,
            API_GET_GIACONGDONGDAN,
            API_ADD_ORDER_DAT_GIAY_TAM,
            API_UPDATE_ORDER_DAT_GIAY_TAM,
            API_REMOVE_ORDER_DAT_GIAY_TAM,
            API_UPDATE_GIAYTONKHO,
            API_REMOVE_ORDER,
            API_UPDATE_DONHANG_SANXUAT,
            API_NHAP_KHO_SX,
            API_PHAN_HOI_SX
        }

        public enum WEBSOCKET_STATUS: int
        {
            DISCONNECT_SERVER,
            DISCONNECT_CLIENT,
            KICK_USER
        }



        #region DEFINE PACKET
        public enum PACKET_TYPE : int
        {
            USER_PACKET = 0,
            NOTIFICATION_PACKET,
            CHAT_PACKET,
            MENU_PACKET
        }

        public enum USER_PACKET_SUB : int
        {
            USER_JOIN = 0,
            USER_LOCK,
            CHANGE_AVATAR,
            CHANGE_USERNAME,
            LOAD_USERS_ONLINE
        }

        public enum CHAT_PACKET_SUB : int
        {
            SEND_MESSAGE,
            CREATE_GROUP,
            JOIN_GROUP,
            LEAVE_GROUP,
            SEARCH_CHAT,
            LOAD_CHAT_MESSAGE
        }
        #endregion
    }
}