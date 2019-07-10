<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_Thongtindaily.aspx.cs" Inherits="CMS_Tools.Test_Thongtindaily" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .easy-autocomplete-container ul li, .easy-autocomplete-container ul .eac-category {
            font-size: 12px !important;
        }

        .loading1 {
            width: 29px;
            position: relative;
            float: left;
            left: -40px;
            top: 3px;
        }

        .loading1 img {
            max-width: 100%;
        }

        .easy-autocomplete {
            float: left;
            margin-right: 10px;
            width:100% !important;
        }
        
        .add-cash-title{
            margin-bottom: 5px;
            background: #d9e7f9;
        }
        .add-cash-title h2{
            text-align:center;
            font-weight:bold;
            color: darkslategrey;
        }
        
        #tbl-menh-gia thead tr{
            background: #cec18e;
        }
        #tbl-menh-gia tbody tr{
            background:#fff7d8;
            cursor:pointer;
        }
        #tbl-menh-gia tbody tr.activeVal{
            background:#940000;
            color:#eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue ">
                <div class="portlet-title">
                    <div class="caption">
                        Nạp Tiền Đại Lý
                    </div>
                </div>
                <div class="portlet-body">
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
                    <form action="javascript:" id="form_Agency" class="form-horizontal" novalidate="novalidate">
                    <input type="hidden" id="customerID"/>
                    <div class="modal-body">
                        <div class="form-body">
                            <div class="alert alert-danger display-hide">
                                <button class="close" data-close="alert"></button>
                                Vui lòng kiểm tra và nhập đầy đủ thông tin!
                            </div>
                            <div class="alert alert-success display-hide">
                                <button class="close" data-close="alert"></button>
                                Nhập thông tin hợp lệ
                            </div>
                            <div class="row">
                            	<div class="col-md-10 col-md-offset-1" style="margin-bottom:10px">
                                    <div class="col-md-6">
                                        <div class="row add-cash-title">
                                            <h2>Thông tin nạp tiền</h2>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">
                                                Mã đại lý: <span class="required" aria-required="true">* </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-icon right">
                                                    <i class="fa"></i>
                                                    <input id="txtAgencyID" type="text" class="form-control" name="AgencyID" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">
                                                Mệnh giá nạp: <span class="required" aria-required="true">* </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-icon right">
                                                    <i class="fa"></i>
                                                    <select class="form-control" id="txt_MenhGia" name="MenhGia" required="">
                                                        <option value="">Chọn mệnh giá...</option>
                                                        <option value="20000000" money="16000000">20,000,000</option>
                                                        <option value="50000000" money="40000000">50,000,000</option>
                                                        <option value="100000000"  money="80000000">100,000,000</option>
                                                        <option value="200000000"  money="160000000">200,000,000</option>
                                                        <option value="500000000"  money="400000000">500,000,000</option>
                                                        <option value="1000000000"  money="800000000">1,000,000,000</option>
                                                   </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">
                                                Nội dung:
                                            </label>
                                            <div class="col-md-9">
                                                <div class="input-icon right">
                                                    <i class="fa"></i>
                                                    <textarea id="txtNode" class="form-control" style="resize: none" rows="7" cols="1"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6" style="border-left: 1px solid currentColor;">
                                        <div class="row add-cash-title">
                                            <h2>Bảng quy đổi</h2>
                                        </div>
                                        <table class="table" id="tbl-menh-gia">
                                            <thead>
                                                <tr>
                                                    <td><b>Mệnh giá</b></td>
                                                    <td><b>Gold</b></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>20,000,000</td>
                                                    <td>16,000,000</td>
                                                </tr>
                                                <tr>
                                                    <td>50,000,000</td>
                                                    <td>40,000,000</td>
                                                </tr>
                                                <tr>
                                                    <td>100,000,000</td>
                                                    <td>80,000,000</td>
                                                </tr>
                                                <tr>
                                                    <td>200,000,000</td>
                                                    <td>160,000,000</td>
                                                </tr>
                                                <tr>
                                                    <td>500,000,000</td>
                                                    <td>400,000,000</td>
                                                </tr>
                                                <tr>
                                                    <td>1,000,000,000</td>
                                                    <td>800,000,000</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green">Nạp Tiền</button>
                    </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageJSAdd" runat="server">
    <script src="assets/global/plugins/Base64JS.js"></script>
    <script src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js"></script>s
    <script>
        $(function () {
            $('#btnAddAction').hide();
            var agencyID = AppManage.getURLParameter('agencyid');
            if (agencyID != null)
                $("#txtAgencyID").val(Base64.decode(agencyID));

            var options = {
                url: function (param) {
                    return "Apis/API_Agency.ashx";
                },
                getValue: function (element) {
                    $('.loading1').fadeOut(10);
                    return element.AgencyID + '-' + element.DisplayName;
                },
                ajaxSettings: {
                    dataType: "json",
                    method: "POST",
                    data: {
                        type: 4,
                        mid: AppManage.getURLParameter('m')
                    }
                },
                preparePostData: function (data) {
                    $('.loading1').fadeIn();
                    data.param = $("#txtAgencyID").val();
                    return data;
                },
                requestDelay: 500
            };
            $("#txtAgencyID").easyAutocomplete(options);
        })

        jQuery(document).ready(function () {
            FormValidation.init();
        
        });
        function formatMoney(num) {
            if (num > 0)
                return num.toLocaleString('en-US');
            else
                return num;
        }

        function AddCash() {
            bootbox.confirm("Xác nhận nạp " + $('#txt_MenhGia').val() + " vào tài khoản " + $('#txtAgencyID').val(), function (r) {
                if (r)
                    PerformAddCash();
            });
        }

        function PerformAddCash() {
            $(".divLoading").fadeIn();
            var uwinID = $('#txtAgencyID').val().split('-')[0];
            var json = {
                agencyID: uwinID.split('.')[1],
                amount: formatMoney($('#txt_MenhGia').val()),
                //amount: formatMoney($("#txt_MenhGia").find(':selected').attr('money')),
                reason: $('#txtNode').val()
            }
            $.ajax({
                type: "POST",
                url: "Apis/API_Agency.ashx",
                data: {
                    json: JSON.stringify(json),
                    type: 5
                },
                dataType: 'json',
                success: function (data) {
                    $(".divLoading").fadeOut(500);
                    $('#modal_customer').modal('hide');
                    if (data.status == 1) {
                        bootbox.alert({
                            message: data.msg,
                            callback: function () {
                            }
                        });
                        ResetForm();
                        $('#tbl-menh-gia tbody tr').removeClass('activeVal');
                    }
                    else {
                        bootbox.alert({
                            message: data.msg,
                            callback: function () {
                            }
                        });
                    }
                }
            });
        }

        var FormValidation = function () {
            var r = function () {
                var e = $("#form_Agency"),
                    r = $(".alert-danger", e),
                    i = $(".alert-success", e);
                e.validate({
                    errorElement: "span",
                    errorClass: "help-block help-block-error",
                    focusInvalid: !1,
                    ignore: "",
                    rules: {
                        AgencyID: {
                            required: !0
                        },
                        MenhGia: {
                            required: !0
                        }
                        //province: {
                        //    required: !0
                        //},
                        //country: {
                        //    required: !0
                        //}
                        //digits: {
                        //    required: !0,
                        //    digits: !0
                        //},
                        //creditcard: {
                        //    required: !0,
                        //    creditcard: !0
                        //}
                    },
                    invalidHandler: function (e, t) {
                        i.hide(), r.show(), App.scrollTo(r, -200)
                    },
                    errorPlacement: function (e, r) {
                        var i = $(r).parent(".input-icon").children("i");
                        i.removeClass("fa-check").addClass("fa-warning"), i.attr("data-original-title", e.text()).tooltip({
                            container: "body"
                        })
                    },
                    highlight: function (e) {
                        $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
                    },
                    unhighlight: function (e) { },
                    success: function (e, r) {
                        var i = $(r).parent(".input-icon").children("i");
                        $(r).closest(".form-group").removeClass("has-error").addClass("has-success"), i.removeClass("fa-warning").addClass("fa-check");
                    },
                    submitHandler: function (e) {
                        //i.show(), 
                        r.hide(),
                            AddCash();
                    }
                })
            }
            return {
                init: function () {
                    r()
                }
            }
        }();

        function ResetForm() {
            $('#form_Agency').trigger('reset');
            $('.form-group').removeClass('has-success').removeClass('has-error');
            $('.form-group i').removeClass('fa-warning').removeClass('fa-check');
        }

        $(document).ready(function () {
            $('#txt_MenhGia').change(function () {
                if ($("#txt_MenhGia")[0].selectedIndex > 0) {
                    $('#tbl-menh-gia tbody tr').removeClass('activeVal');
                    $('#tbl-menh-gia tbody tr').eq($("#txt_MenhGia")[0].selectedIndex - 1).addClass('activeVal');
                }

            });
        });
        $(document).ready(function () {
            $('#tbl-menh-gia tbody tr').click(function () {
                if ($(this).hasClass('activeVal')) { return; }
                $('#tbl-menh-gia tbody tr').removeClass('activeVal');
                $(this).addClass('activeVal');
                $('#txt_MenhGia option').eq($(this).index() + 1).prop('selected', true);
            });
        });
</script>
</asp:Content>
