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
        .table tr{
            background:#fff7d8;
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
                    <form action="javascript:;" id="form_Agency" class="form-horizontal" novalidate="novalidate">
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
                            	<div class="col-md-8 col-md-offset-2">
                                	<div class="form-group row">
                                        <label class="control-label col-md-2">
                                            Mã đại lý: <span class="required" aria-required="true">* </span>
                                        </label>
                                        <div class="col-md-10">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input id="txtAgencyID" type="text" class="form-control" name="" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="control-label col-md-2">
                                            Nội dung:
                                        </label>
                                        <div class="col-md-10">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <textarea row='5' id="txtNote" type="text" class="form-control" name="email"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-md-offset-3">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <td><b>Mệnh giá</b></td>
                                                    <td><b>Gold</b></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>20000000</td>
                                                    <td>16000000</td>
                                                </tr>
                                                <tr>
                                                    <td>50000000</td>
                                                    <td>40000000</td>
                                                </tr>
                                                <tr>
                                                    <td>100000000</td>
                                                    <td>80000000</td>
                                                </tr>
                                                <tr>
                                                    <td>200000000</td>
                                                    <td>1600000000</td>
                                                </tr>
                                                <tr>
                                                    <td>500000000</td>
                                                    <td>4000000000</td>
                                                </tr>
                                                <tr>
                                                    <td>1000000000</td>
                                                    <td>8000000000</td>
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
                        type: 4013,
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
</script>
</asp:Content>
