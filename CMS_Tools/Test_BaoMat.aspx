<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_BaoMat.aspx.cs" Inherits="CMS_Tools.Test_BaoMat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-group
        {
            float: left;
            clear: both;
            width: 100%;  
        }
        .actions{margin-top:10px !important}
        .menuID
        {
            float: left;
            margin: 9px 5px 0 10px !important;    
        }
        .rulesID
        {
            float: right;
            min-width:150px;
            width:auto;
            overflow:auto;
        }
        .rulesID ul{float:left;}
        #nestable_list_1 h2 {
            font-weight: normal;
        }
        #nestable_list_1 label {
            display: inline-block;
            margin: 15px 0 5px 0;
        }
        #nestable_list_1 select {
            width: 350px;
        }
        #get {
            float: right;
            margin: 25px auto 0;
        }
        #timer{color:#666666}
        #linkhomepage a{color:#f07b07; text-decoration:none;}
        #linkhomepage a:link{color:#f07b07; text-decoration:none;}
        #linkhomepage a:hover{color:Blue; text-decoration:none;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageBar" runat="server">
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <i class="icon-home"></i>
                <a href="Home.aspx">Home</a>
                <i class="fa fa-angle-right"></i>
            </li>
            <li>
                <span><label id="PageBar_lblMenuName">Sub menu</label></span>
            </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                <button id="btnAddAction" type="button" class="btn btn-fit-height blue dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true" aria-expanded="false">
                    Chức năng <i class="fa fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu pull-right" role="menu">
                    <li>
                        <a href="javascript:;" id="btnAddNew"><i class="fa fa-plus"><!--  i--> Tạo KH Mới</i></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageContent" runat="server">
    <h1 class="page-title">Quản lý phân quyền</h1>

                
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <i class="icon-home"></i>
                <a href="Home.aspx">Home</a>
                <i class="fa fa-angle-right"></i>
            </li>
            <li>
                <span>Phân Quyền</span>
            </li>
        </ul>
    </div>
           
                <!-- END PAGE HEADER-->
                
    <div class="row">
        <div class="col-md-12">
            <div class="margin-bottom-10" id="nestable_list_menu">
                <button type="button" class="btn" id="btn_update" onclick="UpdateViewMenu()" >Update</button>
            </div>
        </div>
    </div>
    <div class="portlet box grey">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-comments"></i>Danh sách trang
            </div>
            <div class="tools">
                <a href="javascript:;" class="collapse" data-original-title="" title=""></a>
            </div>
        </div>
        <div class="portlet-body ">
            <div class="divLoading" style="display: none;">
                <div class="lds-default">
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
                <span>Đang xử lý...</span>
            </div>
            <div class="dd" id="nestable_list_1">
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="42" id="m_42">
                        <div class="dd-handle">Game Data</div>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="43" id="m_43">
                                <div class="dd-handle">Game ID</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="75" id="m_75">
                                <div class="dd-handle">Thông báo</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="102" id="m_102">
                                <div class="dd-handle">Cấu hình bot tài xỉu</div>
                            </li>
                        </ol>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="10" id="m_10">
                        <div class="dd-handle">Báo Cáo - Thống Kê</div>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="22" id="m_22">
                        <div class="dd-handle">Game Log</div>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="45" id="m_45">
                                <div class="dd-handle">Lịch sử chơi</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="44" id="m_44">
                                <div class="dd-handle">Kungfu Panda</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="54" id="m_54">
                                <div class="dd-handle">Tài Xỉu</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="90" id="m_90">
                                <div class="dd-handle">Tam Quốc</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="91" id="m_91">
                                <div class="dd-handle">Ba Cây</div>
                            </li>
                        </ol>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="27" id="m_27">
                        <div class="dd-handle">Nạp tiền đại lý</div>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="30" id="m_30">
                        <div class="dd-handle">Giao dịch</div>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="77" id="m_77">
                                <div class="dd-handle">User chuyển tiền</div>
                            </li>
                        </ol>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="32" id="m_32">
                        <div class="dd-handle">Báo Cáo - Thống Kê</div>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="68" id="m_68">
                                <div class="dd-handle">Báo Cáo - Thống Kê</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="70" id="m_70">
                                <div class="dd-handle">Báo Cáo - Thống Kê</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="71" id="m_71">
                                <div class="dd-handle">Báo Cáo - Thống Kê</div>
                            </li>
                        </ol>
                    </li>
                </ol>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="error" class="alert alert-danger display-hide">
                <strong>Error!</strong> The daily cronjob has failed.
            </div>
            <div id="success" class="alert alert-success display-hide">
                <strong>Success!</strong> The page has been added.
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageJSAdd" runat="server">
    <script src="assets/global/plugins/nestable/jquery.nestable.js" type="text/javascript"></script>
    <script src="assets/global/plugins/kendo/kendo.all.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var colFilter = null;
        jQuery(document).ready(function () {
            $('body').append('<link href="assets/global/plugins/kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />');
            $('body').append('<link href="assets/global/plugins/kendo/kendo.silver.min.css" rel="stylesheet" type="text/css" />');
            $('body').append('<link href="assets/global/plugins/nestable/jquery.nestable.css" rel="stylesheet" />');
                
            $('.page-toolbar').remove();
            
            LoadViewMenu();
        });

        function UpdateViewMenu() {
            var arrMenu = [];
            $.each($('.menuID:checked'), function (i, obj) {
                var vallue = obj.attributes['value'].value;
                var id = obj.attributes['id'].value;
                arrMenu.push(vallue);
            });
            $.ajax({
                type: "POST",
                url: "Apis/Menu.ashx",
                data: {
                    type: 34,
                    viewmenu: arrMenu.join()
                    },
                dataType: 'json',
                success: function (data) {
                    bootbox.alert({
                        message: data.msg,
                        callback: function () {
                        }
                    });
                },
                complete: function () {
                    $(".divLoading").fadeOut(500);
                }
            });
        }

        function LoadViewMenu() {
            var param = [];
            $('.divLoading').show();
            $.ajax({
                type: "POST",
                url: "Apis/Menu.ashx",
                data: {
                    type: 13,
                    mid: AppManage.getURLParameter('m'),
                    p: JSON.stringify(param)
                },
                dataType: 'json',
                success: function (data) {
                    if (data.status == 5005) {
                        window.location.assign("login.aspx");
                        return;
                    }
                    if (data.status == 0) {

                        var listMenu = data.data[0][1].split(',');
                        $.each(listMenu, function (i, obj) {
                            //$('.menuID')[i].checked = true;
                            //console.log(document.getElementsByClassName('menuID')[i].attributes['value'].value);
                            if (document.getElementsByClassName('menuID')[i].attributes['value'].value == obj) {
                                document.getElementsByClassName('menuID')[i].checked = true;
                            }
                            //console.log($('#m_42').attr('type'));
                        });
                    }
                    else {
                        bootbox.alert({
                            message: data.msg,
                            callback: function () {
                            }
                        });
                    }
                },
                complete: function () {
                    $(".divLoading").fadeOut(500);
                }
            });
        }

        function formatMoney(num) {
            if (num > 0)
                return num.toLocaleString('en-US');
            else
                return num;
        }
        function escapeRegExp(str) {
            return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
        }

        function replaceAll(str, find, replace) {
            return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
        }
</script>
</asp:Content>