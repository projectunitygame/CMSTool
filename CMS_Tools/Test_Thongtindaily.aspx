<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_Thongtindaily.aspx.cs" Inherits="CMS_Tools.Test_Thongtindaily" %>
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
                        Khách Hàng
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
                                <input type="text" class="form-control" placeholder="Date Range(MM/DD/YYYY)" disabled />
                                <span class="input-group-btn">
                                    <button class="btn default date-range-toggle" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3" style="margin-bottom: 10px;">
                            <select id="filterColumn" class="form-control"></select>
                        </div>
                        <div class="col-md-3" style="margin-bottom: 10px;">
                            <input type="text" class="form-control" id="txtFindData" placeholder="Search..." />
                        </div>
                        <div class="col-md-2" style="margin-bottom: 10px;">
                            <button id="btnFindData" type="button" class="btn green form-control"><i class="icon-magnifier"></i>Search</button>
                        </div>
                    </div>
                    <div id="sample_1_wrapper" class="dataTables_wrapper form-inline" role="grid">
                        <table class="table table-striped table-bordered table-hover dataTable" id="tbl_datatable"
                            aria-describedby="sample_1_info">
                            <thead>
                                <tr role="row">
                                    <td>Idx</td>
                                    <td>TransactionID</td>
                                    <td>SenderID</td>
                                    <td>SenderName</td>
                                    <td>RecipientID</td>
                                    <td>RecipientName</td>
                                    <td>Amount</td>
                                    <td>Encrypt_Amount</td>
                                    <td>Balance_Before</td>
                                    <td>Balance_After</td>
                                    <td>Balance_Bonus_Before</td>
                                    <td>Balance_Bonus_After</td>
                                    <td>Balance_Lock_Before</td>
                                    <td>Balance_Lock_After</td>
                                    <td>Encrypt_Balance_Before</td>
                                    <td>Encrypt_Balance_After</td>
                                    <td>Encrypt_Balance_Bonus_Before</td>
                                    <td>Encrypt_Balance_Bonus_After</td>
                                    <td>Encrypt_Balance_Lock_Before</td>
                                    <td>Encrypt_Balance_Lock_After</td>
                                    <td>Reason</td>
                                    <td>DateCreated</td>
                                    <td>LastUpdate</td>
                                    <td>Status</td>
                                    <td>IP</td>
                                    <td>CreatorID</td>
                                    <td>CreatorName</td>
                                    <td>HashCode</td>
                                </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageJSAdd" runat="server">
    <script src="assets/global/plugins/Base64JS.js"></script>
    <script src="assets/global/plugins/jquery-validation/js/additional-methods.min.js"></script>
    <script src="assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/global/plugins/datatables/DT_bootstrap.js"></script>
    <script type="text/javascript">
        var colFilter = null;
        jQuery(document).ready(function () {
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
        var _pageSize = 10;
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
                    param.push($('#filterColumn').val() != null ? $('#filterColumn').val() : 'DateCreated');//@2
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
                                    $.each(_dataColumn, function (key, obj) {
                                        if (key < _dataColumn.length - 1) {
                                            if (key != 0 && key != 2 && key != 3 && key != 7 && key != 14 && key != 15 && key != 16 && key != 17 && key != 18 && key != 19 && key != 22 && key != 23 && key != 24 && key != 27 && key != 10 && key != 11 && key != 12 && key != 13 ) {
                                                selectCol += "<option value='" + obj + "'>" + obj + "</option>";
                                            }
                                        }
                                    });
                                    $('#filterColumn').html(selectCol);
                                    if ($('#filterColumn').val() == "")
                                        $('#filterColumn').val("DateCreated");
                                }
                                var colHiden = [];
                                oTable = table.dataTable({
                                    "data": data.data,
                                    "lengthMenu": [
                                        [10, 50, 100, 500, -1],
                                        [10, 50, 100, 500, "All"]
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

                                //an column
                                var bVis = oTable.fnSettings().aoColumns[0].bVisible;
                                oTable.fnSetColumnVis(0, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[2].bVisible;
                                oTable.fnSetColumnVis(2, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[3].bVisible;
                                oTable.fnSetColumnVis(3, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[7].bVisible;
                                oTable.fnSetColumnVis(7, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[14].bVisible;
                                oTable.fnSetColumnVis(14, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[15].bVisible;
                                oTable.fnSetColumnVis(15, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[16].bVisible;
                                oTable.fnSetColumnVis(16, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[17].bVisible;
                                oTable.fnSetColumnVis(17, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[18].bVisible;
                                oTable.fnSetColumnVis(18, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[19].bVisible;
                                oTable.fnSetColumnVis(19, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[22].bVisible;
                                oTable.fnSetColumnVis(22, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[23].bVisible;
                                oTable.fnSetColumnVis(23, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[24].bVisible;
                                oTable.fnSetColumnVis(24, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[26].bVisible;
                                oTable.fnSetColumnVis(26, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[27].bVisible;
                                oTable.fnSetColumnVis(27, bVis ? false : true);
                                //bonus
                                var bVis = oTable.fnSettings().aoColumns[10].bVisible;
                                oTable.fnSetColumnVis(10, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[11].bVisible;
                                oTable.fnSetColumnVis(11, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[12].bVisible;
                                oTable.fnSetColumnVis(12, bVis ? false : true);
                                var bVis = oTable.fnSettings().aoColumns[13].bVisible;
                                oTable.fnSetColumnVis(13, bVis ? false : true);

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



        function formatMoney(num) {
            if (num > 0)
                return num.toLocaleString('en-US');
            else
                return num;
        }
</script>
</asp:Content>
