<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_TaiKhoanGame.aspx.cs" Inherits="CMS_Tools.Test_TaiKhoanGame" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .avatar_u{
            height: 50px;
            border: 1px solid #ddd;
            border-radius: 50% !important;
        }
        .form-section {
            margin: 20px 0;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
            font-size: 12px;
            color: #333;
            text-transform: uppercase;
        }
        .btn-group-xs>.btn, .btn-xs{
	        font-size:11x !important;
        }
        .table td, .table th {
            font-size: 12px !important;
        }
        .select2-container--bootstrap .select2-selection, .form-control, output{
	        font-size: 12px !important;
        }

        .control-label{
	        text-align:left !important;
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
                        Thông tin player
                    </div>
                    <div class="tools">
                        <a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                        <a href="javascript:;" class="reload" data-original-title="" title=""></a>
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
                    <div class="row">
                        <div class="col-md-4" style="margin-bottom: 10px;">
                            <div class="input-group" id="dateRangeEvent">
                            	<label class="control-label label-balance">Chọn ngày kết xuất dữ liệu</label>
                                <input type="text" class="form-control" placeholder="Date Range(MM/DD/YYYY)" disabled />
                                <span class="input-group-btn" style='position: relative; top: 10px; left: 1px;'>
                                    <button class="btn default date-range-toggle" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3" style="margin-bottom: 10px;">
                        	<label class="control-label label-balance">Chọn lọc dữ liệu theo cột</label>
                            <select id="filterColumn" class="form-control">
                            </select>
                        </div>
                        <div class="col-md-3" style="margin-bottom: 10px;">
                        	<label class="control-label label-balance">Nhập từ khóa tìm kiếm</label>
                            <input type="text" class="form-control" id="txtFindData" placeholder="Search..." />
                        </div>
                        <div class="col-md-2" style="margin-bottom: 10px;">
                        	<label class="control-label label-balance">Tìm kiếm</label>
                            <button id="btnFindData" type="button" class="btn green form-control"><i class="icon-magnifier"></i> Search</button>
                        </div>
                    </div>
                    <div id="sample_1_wrapper" class="dataTables_wrapper form-inline" role="grid">
                        <table class="table table-striped table-bordered table-hover dataTable" id="tbl_datatable"
                            aria-describedby="sample_1_info">
                            <thead>
                                <tr role="row">
                                </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all"></tbody>
                            <tfoot><tr role="row"></tr></tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-----From update customer------>
    <div id="modal_customer" class="modal fade" data-backdrop="static" data-keyboard="false" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="javascript:;" id="form_Agency" class="form-horizontal" novalidate="novalidate">
                    <input type="hidden" id="customerID"/>
                    <div class="modal-body">
                    	<div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            </button>
                            <h4 class="modal-title" id="title_task">
                                <i class="fa fa-edit"></i> QUẢN LÝ THÔNG TIN KHÁCH HÀNG</h4>
                        </div>
                        <div class="form-body">
                            <div class="alert alert-danger display-hide">
                                <button class="close" data-close="alert"></button>
                                Vui lòng kiểm tra và nhập đầy đủ thông tin!
                            </div>
                            <div class="alert alert-success display-hide">
                                <button class="close" data-close="alert"></button>
                                Nhập thông tin hợp lệ
                            </div>
                            <div class=row>
                            	<div class="col-xs-10 col-xs-offset-1">
                                	<div class="form-group  margin-top-20">
                                        <label class="control-label col-md-3">
                                            Mã đại lý: <span class="required" aria-required="true">* </span>
                                        </label>
                                        <div class="col-md-9">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input id="txtAgencyCode" type="text" class="form-control" name="AgencyCode" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-xs-10 col-xs-offset-1">
                                	<div class="form-group">
                                        <label class="control-label col-md-3">
                                            Mật khẩu: <span class="required" aria-required="true">* </span>
                                        </label>
                                        <div class="col-md-6">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input id="txtPassword" type="text" class="form-control" name="password" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <a class="btn btn-primary" onclick="javascript:generate()"><i class="fa fa-lock" aria-hidden="true"></i>&nbsp;Tạo mới</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-xs-10 col-xs-offset-1">
                                	<div class="form-group">
                                        <label class="control-label col-md-3">
                                            Email:
                                        </label>
                                        <div class="col-md-9">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input id="txtEmail" type="text" class="form-control" name="email"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-xs-10 col-xs-offset-1">
                                	<div class="form-group">
                                        <label class="control-label col-md-3">
                                            Số điện thoại: <span class="required" aria-required="true">* </span>
                                        </label>
                                        <div class="col-md-9">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input type="text" style="width:100%;" id="txtPhone" class="form-control" name="Phone" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-xs-10 col-xs-offset-1">
                                	<div class="form-group">
                                        <label class="control-label col-md-3">
                                            Tên đại lý: <span class="required" aria-required="true">* </span>
                                        </label>
                                        <div class="col-md-9">
                                            <div class="input-icon right">
                                                <i class="fa"></i>
                                                <input type="text" style="width:100%;" id="txtAgencyName" class="form-control" name="AgencyName" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn dark btn-outline">Hủy</button>
                        <button type="submit" class="btn green">Đăng Ký</button>
                    </div>
                </form>
            </div>
        </div>
    </div>  

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageJSAdd" runat="server">
    <script src="assets/global/plugins/Base64JS.js"></script>
    <script src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js"></script>
    <script src="assets/global/plugins/jquery-validation/js/additional-methods.min.js"></script>
    <script src="assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/global/plugins/datatables/DT_bootstrap.js"></script>
    <script type="text/javascript">
        var colFilter = null;
        jQuery(document).ready(function () {
          	$('#btnAddAction').remove();
            $('#btnAddNew').html("<i class='fa fa-plus'></  i> Tạo KH Mới");
            FormValidation.init();
            $('#btnAddNew').click(function () {
                ResetForm();
                $('#modal_customer').modal('show');
            });
            $('#txtFindData').on('keyup', function (e) {
                if (e.keyCode == 13) {
                    TableEditable.init();
                }
            });

            $('#btnFindData').click(function () {
                if ($('#txtFindData').val() != "")
                    TableEditable.init();
            });

            $('#filterColumn').on('change', function () {
                if ($('#txtFindData').val() != "")
                    TableEditable.init();
            });

            //load danh sach dai ly
            TableEditable.init();
            $('body').on('click', '.portlet > .portlet-title > .tools > a.reload', function (e) {
                TableEditable.init();
            });
            ComponentsPickers.init();
        });

        var _dateStart = null;
        var _dateEnd = null;
        var ComponentsPickers = function () {
            var handleDateRangePickers = function () {
                if (!jQuery().daterangepicker) {
                    return;
                }

                $('#dateRangeEvent').daterangepicker({
                    opens: (App.isRTL() ? 'left' : 'right'),
                    format: 'MM/DD/YYYY',
                    separator: ' to ',
                    startDate: moment().subtract('year', 2),
                    endDate: moment(),
                    minDate: moment().subtract('year', 5).format('MM/DD/YYYY'),
                    maxDate: moment().format('MM/DD/YYYY'),
                },
                    function (start, end) {
                        _dateStart = start.format('YYYY/MM/DD');
                        _dateEnd = end.format('YYYY/MM/DD');
                        console.log("Callback has been called!");
                        $('#dateRangeEvent input').val(start.format('MM/DD/YYYY') + ' - ' + end.format('MM/DD/YYYY'));
                        TableEditable.init();
                    }
                );
                _dateStart = moment().subtract('year', 2).format('YYYY/MM/DD');
                _dateEnd = moment().format('YYYY/MM/DD');
                $('#dateRangeEvent input').val(_dateStart + ' - ' + _dateEnd);
            };

            return {
                init: function () {
                    handleDateRangePickers();
                }
            };
        }();

        var oTable = null;
        var _pageSize = 50;
        var _dataColumn = null;
        var TableEditable = function () {
            var handleTable = function () {
                var table = $('#tbl_datatable');
                loadTable();
                function loadTable() {
                    $('.divLoading').fadeIn();
                    if (_dateStart == null)
                        _dateStart = moment().subtract('year', 2).format('YYYY/MM/DD');
                    if (_dateEnd == null)
                        _dateEnd = moment().format('YYYY/MM/DD');
                    var param = [];
                    param.push(_dateStart);//@0
                    param.push(_dateEnd);//@1
                    param.push($('#filterColumn').val() != null ? $('#filterColumn').val() : 'AccountID');//@2
                    param.push($('#txtFindData').val());//@3
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
                                if (oTable != null) {
                                    oTable.fnDestroy();
                                }
                                if (_dataColumn == null) {
                                    _dataColumn = data.columnName;
                                    var selectCol = "<option value=''>Select...</option>";
                                  	$('#tbl_datatable thead tr').html("");
                                    //$.each(_dataColumn, function (key, obj) {
                                    //    $('#tbl_datatable thead tr').append("<th>" + obj + "</th>");
                                    //	if (key < _dataColumn.length - 1)
                                    //		selectCol += "<option value='" + obj + "'>" + obj + "</option>";
                                    //});
                                    var strHtmlColName = "";
                                    $.each(_dataColumn, function (key, obj) {
                                        strHtmlColName += "<td>" + obj + "</td>";
                                        if (key < _dataColumn.length - 1)
                                            selectCol += "<option value='" + obj + "'>" + obj + "</option>";
                                    });
                                    $('#tbl_datatable thead tr').append(strHtmlColName);
                                    if (data.data.length > 20) {
                                        $('#tbl_datatable tfoot tr').append(strHtmlColName);
                                    }
                                    $('#filterColumn').html(selectCol);
                                    if ($('#filterColumn').val() == "")
                                    	$('#filterColumn').val("AccountID");
                                }
                                _dataTable = [];
                                var colHiden = [];
                                oTable = table.dataTable({
                                  	"data": data.data,
                                    "lengthMenu": [
                                        [50, 100, 500, -1],
                                        [50, 100, 500, "All"]
                                    ],
                                    "pageLength": _pageSize,
                                    "language": {
                                        "lengthMenu": " _MENU_ records"
                                    },
                                    "columnDefs": [{
                                        'orderable': true,
                                        'targets': colHiden
                                    }, {
                                        "searchable": true,
                                        "targets": [0]
                                    }],
                                    "order": [
                                        [0, "desc"]
                                    ]
                                });
                                var tableWrapper = $("#tbl_datatable_wrapper");
                                jQuery('#tbl_datatable_wrapper .dataTables_filter input').addClass("form-control input-small"); // modify table search input
                                jQuery('#tbl_datatable_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
                                jQuery('#tbl_datatable_wrapper .dataTables_length select').select2(); // initialize select2 dropdown

                                tableWrapper.find(".dataTables_length select").select2({
                                    showSearchInput: false
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
            }

            return {
                //main function to initiate the module
                init: function () {
                    handleTable();
                },
                reloadTable: function () {
                    handleTable();
                }
            };
        }();

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
                        AgencyCode: {
                            minlength: 6,
                            maxlength: 10,
                            required: !0
                        },
                        password: {
                            minlength: 6,
                            maxlength: 20,
                            required: !0
                        },
                        email: {
                            maxlength: 80,
                        },
                        Phone: {
                            maxlength: 10,
                            minlength: 10,
                            number: !0,
                            required: !0
                        },
                        AgencyName: {
                            minlength: 6,
                            maxlength: 150,
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
                            SubmitFormAgency();
                    }
                })
            }
            return {
                init: function () {
                    r()
                }
            }
        }();


        function LockAgency(AgencyId) {
            bootbox.prompt({
                title: "Ghi chú nội dung khóa!",
                centerVertical: true,
                callback: function (result) {
                    if (result === null) {
                        // Prompt dismissed
                    } else {
                        // result has a value
                        $('.divLoading').fadeIn();
                        var json = {
                            "agencyID": AgencyId,
                            "note": result,
                        };
                        $.ajax({
                            type: "POST",
                            url: "Apis/API_Agency.ashx",
                            data: {
                                json: JSON.stringify(json),
                                type: 2
                            },
                            dataType: 'json',
                            success: function (data) {
                                $(".divLoading").fadeOut(500);
                                if (data.status == 1)
                                    TableEditable.init();
                                else
                                    bootbox.alert(data.msg);
                            }
                        });
                    }

                }
            });
        }

        function UnLockAgency(AgencyId) {
            bootbox.confirm("Xác nhận mở khóa tài khoản?", function (result) {
                if (result) {
                    $('.divLoading').fadeIn();
                    var json = {
                        "agencyID": AgencyId
                    };
                    $.ajax({
                        type: "POST",
                        url: "Apis/API_Agency.ashx",
                        data: {
                            json: JSON.stringify(json),
                            type: 3
                        },
                        dataType: 'json',
                        success: function (data) {
                            $(".divLoading").fadeOut(500);
                            if (data.status == 1)
                                TableEditable.init();
                            else
                                bootbox.alert(data.msg);
                        }
                    });
                }
            });
        }
        function SubmitFormAgency() {
            $('.divLoading').fadeIn();
            var json = {
                "agencyCode": $('#txtAgencyCode').val(),
                "password": $('#txtPassword').val(),
                "email": $('#txtEmail').val(),
                "phone": $('#txtPhone').val(),
                "displayName": $('#txtAgencyName').val(),
            };

            $.ajax({
                type: "POST",
                url: "Apis/API_Agency.ashx",
                data: {
                    json: JSON.stringify(json),
                    type: 1
                },
                dataType: 'json',
                success: function (data) {
                    $(".divLoading").fadeOut(500);
                    $('#modal_customer').modal('hide');
                    if (data.status == 1) {
                       bootbox.alert({
                            message: data.msg,
                            callback: function () {
                              TableEditable.init();
                            }
                        });    
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



        //function Update(customerID) {

        //    GetAgency(agencyID, function (agencyInfo) {
        //        if (agencyInfo.status == 0) {
        //            var data = agencyInfo.data[0];
        //            $('#customerID').val(data.CustomerID);
        //            $('#txtCompanyName').val(data.CompanyName);
        //            $('#txtTaxCode').val(data.TaxCode);
        //            $('#txtAddress').val(data.Address);
        //            $('#selectProvince').val(data.City);
        //            $('#selectCountry').val(data.Country);
        //            $('#txtAddress1').val(data.Address1);
        //            $('#selectProvince1').val(data.City1);
        //            $('#selectCountry1').val(data.Country1);
        //            $('#txtAddress2').val(data.Address2);
        //            $('#selectProvince2').val(data.City2);
        //            $('#selectCountry2').val(data.Country2);
        //            $('#txtEmail').val(data.Email);
        //            $('#txtPhone').val(data.Phone);
        //            $('#txtContact').val(data.Contact);
        //            $('#selectStatus').val(data.Status);
        //            $('#txtKM').val(data.KM);
        //            $('#txtKM1').val(data.KM1);
        //            $('#txtKM2').val(data.KM2);
        //            $('#selectLoaiDon').val(data.LoaiDon_ID);
        //            $('#selectLoaiHinhSX').val(data.LoaiHinhSX_ID);
        //            $('#modal_customer').modal('show');
        //            if (data.Country1 == 0)
        //                $('#selectCountry1').val(84);
        //            if (data.Country2 == 0)
        //                $('#selectCountry2').val(84);
        //            $('.selectProvince').select2({
        //                showSearchInput: true
        //            });
        //            $('.selectCountry').select2({
        //                showSearchInput: true
        //            });
        //            $('#selectLoaiDon').select2({
        //                showSearchInput: true
        //            });
        //            $('#selectLoaiHinhSX').select2({
        //                showSearchInput: true
        //            });
        //        }
        //        else
        //            bootbox.alert(customerInfo.msg);
        //    });
        //}

        function ResetForm() {
            $('#form_Agency').trigger('reset');
            $('.form-group').val('');
            $('.form-group').removeClass('has-success').removeClass('has-error');
            $('.form-group i').removeClass('fa-warning').removeClass('fa-check');
        }
        function randomPassword(length) {
            //var chars = "abcdefghijklmnopqrstuvwxyz!@#$%^&*()-+<>ABCDEFGHIJKLMNOP1234567890";
            var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOP1234567890";
            var pass = "";
            for (var x = 0; x < length; x++) {
                var i = Math.floor(Math.random() * chars.length);
                pass += chars.charAt(i);
            }
            return pass;
        }
        function generate() {
            $('#txtPassword').val(randomPassword(8));
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
