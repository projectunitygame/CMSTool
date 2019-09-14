<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_QuanTri_PhanQuyen.aspx.cs" Inherits="CMS_Tools.Test_BaoMat" %>
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
                                <input class="menuID" type="checkbox" value="112" id="m_112">
                                <div class="dd-handle">Vippoint</div>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="113" id="m_113">
                                        <div class="dd-handle">Lịch sử đổi thưởng</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="114" id="m_114">
                                        <div class="dd-handle">Danh sách quà tặng</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="115" id="m_115">
                                        <div class="dd-handle">Cấu hình Vip point</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="116" id="m_116">
                                        <div class="dd-handle">Tỷ lệ Vip point</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="122" id="m_122">
                                        <div class="dd-handle">Thể lệ giải thưởng ĐL tuần</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="123" id="m_123">
                                        <div class="dd-handle">Lịch sử cộng vippoint</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="124" id="m_124">
                                        <div class="dd-handle">Thể lệ giải thưởng ĐL tháng</div>
                                    </li>
                                </ol>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="43" id="m_43">
                                <div class="dd-handle">Game ID</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="64" id="m_64">
                                <div class="dd-handle">GiftCode</div>
                                 <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="65" id="m_65">
                                        <div class="dd-handle">Event</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="66" id="m_66">
                                        <div class="dd-handle">Thông tin Giftcode</div>
                                    </li>
                                </ol>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="72" id="m_72">
                                <div class="dd-handle">Thông báo</div>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="73" id="m_73">
                                        <div class="dd-handle">Kho thẻ</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="92" id="m_92">
                                        <div class="dd-handle">Duyệt thẻ</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="93" id="m_93">
                                        <div class="dd-handle">Mua thẻ lỗi</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="97" id="m_97">
                                        <div class="dd-handle">Cấu hình thẻ</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="98" id="m_98">
                                        <div class="dd-handle">Thống kê đổi nạp</div>
                                    </li>
                                </ol>
                                <ol class="dd-list" style="">
                                    <li class="dd-item">
                                        <input class="menuID" type="checkbox" value="101" id="m_101">
                                        <div class="dd-handle">Lịch sử duyệt thẻ</div>
                                    </li>
                                </ol>
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
                                <input class="menuID" type="checkbox" value="79" id="m_79">
                                <div class="dd-handle">Quỹ Thưởng</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="94" id="m_94">
                                <div class="dd-handle">Lịch sử nổ hũ</div>
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
                        <input class="menuID" type="checkbox" value="24" id="m_24">
                        <div class="dd-handle">Tài khoản đại lý</div>
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
                                <input class="menuID" type="checkbox" value="76" id="m_76">
                                <div class="dd-handle">Giao dịch đại lý</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="77" id="m_77">
                                <div class="dd-handle">User chuyển tiền</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="108" id="m_108">
                                <div class="dd-handle">Chuyển tiền game cá</div>
                            </li>
                        </ol>
                    </li>
                </ol>
                <ol class="dd-list" style="">
                    <li class="dd-item">
                        <input class="menuID" type="checkbox" value="32" id="m_32">
                        <div class="dd-handle">Tài khoản games</div>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="68" id="m_68">
                                <div class="dd-handle">Tìm tài khoản</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="70" id="m_70">
                                <div class="dd-handle">Tài khoản bị khóa</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="71" id="m_71">
                                <div class="dd-handle">Lịch sử khóa tài khoản</div>
                            </li>
                        </ol>
                        <ol class="dd-list" style="">
                            <li class="dd-item">
                                <input class="menuID" type="checkbox" value="107" id="m_107">
                                <div class="dd-handle">Lịch sử cộng tiền</div>
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
            var id = AppManage.getURLParameter('id') != null ? AppManage.getURLParameter('id') : "0";
            console.log("id:" + id);
            LoadViewMenu(id);
        });

        function UpdateViewMenu() {
            var arrMenu = [];
            var id = AppManage.getURLParameter('id') != null ? AppManage.getURLParameter('id') : "0";
            $.each($('.menuID:checked'), function (i, obj) {
                var vallue = obj.attributes['value'].value;
                arrMenu.push(vallue);
            });
            $.ajax({
                type: "POST",
                url: "Apis/Menu.ashx",
                data: {
                    type: 34,
                    viewmenu: arrMenu.join(),
                    id: id
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

        function LoadViewMenu(id) {
            var param = [];
            param.push(id);
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
                        if (data.data.length > 0) {
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