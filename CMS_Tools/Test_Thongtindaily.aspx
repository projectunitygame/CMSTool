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
                    <form action="javascript:AddCash();" id="form_Agency" class="form-horizontal" novalidate="novalidate">
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
                                                    <input id="txtAgencyID" type="text" class="form-control" name="" />
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
                                                    <select class="form-control" id="txt_MenhGia" required="">
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
    <script>
        $(function () {
            $('#btnAddAction').hide();


            var options = {
                url: function (param) {
                    return "Apis/API_Agency.ashx";
                },
                getValue: function (element) {
                    $('.loading1').fadeOut(10);
                    console.log(element);
                    return element.AgencyID + ' - ' + element.DisplayName;
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

        function formatMoney(num) {
            if (num > 0)
                return num.toLocaleString('en-US');
            else
                return num;
        }

        function AddCash() {
            $(".divLoading").fadeIn();
            var json = {
                agencyID: $('#txtAgencyID').val().substring(0, 1),
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
                        TableEditable.init();
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
                if ($(this).hasClass('activeVal')) { return;}
                $('#tbl-menh-gia tbody tr').removeClass('activeVal');
                $('#tbl-menh-gia tbody tr').removeClass('activeVal');
                $(this).addClass('activeVal');
                $('#txt_MenhGia option').eq($(this).index() + 1).prop('selected', true);
            });
        });
</script>
</asp:Content>
