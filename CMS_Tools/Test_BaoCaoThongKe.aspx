<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Test_BaoCaoThongKe.aspx.cs" Inherits="CMS_Tools.Test_BaoCaoThongKe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .af-kpi-box-footer{
        text-align: center;
        text-align: center;
        border-top: 1px solid #ddd;
        padding: 6px;
        margin: 0;
        font-weight: 500 !important;
        margin-top:20px;
    }
.kpi-border{
border: 1px solid #ddd;
-webkit-border-radius: 5px !important;
-moz-border-radius: 5px !important;
border-radius: 5px !important;
background:#eaeaea
}
.clearfix{clear:both}
.af-kpi-box-pieces-container .af-kpi-box-piece{    border-right: 1px dashed #ddd;}
.af-kpi-box-pieces-container .af-kpi-box-piece:last-child {
    border-right: none;
}
.af-kpi-box-piece h5{font-weight: 500 !important;  font-size: 12px;}
.af-kpi-box-piece h2{margin: 0;}
#chartdiv {
  width: 100%;
  height: 500px;
margin-top: 50px;
}
.kpi-box{margin-bottom: 20px;}
#PageContent_PageID{
	background: #FFF;
    padding: 20px;
}
#chartdiv{
    width: 100%;
    height: 400px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageContent" runat="server">
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
    <div class="table-toolbar">
        <div class="row">
            <div class="col-md-3" style="margin-bottom: 10px;">
                Asia/Bangkok Timezone UTC+7
                <div class="input-group" id="dateRangeEvent">
                    <input type="text" class="form-control" placeholder="Date Range(MM/DD/YYYY)" disabled />
                    <span class="input-group-btn">
                        <button class="btn default date-range-toggle" type="button"><i class="fa fa-calendar"></i></button>
                    </span>
                </div>
            </div>
            <div class="col-md-3" style="margin-bottom: 10px; display: none">
                Chọn games
                <select id="gameList" class="form-control">
                    <option value=''>--Tất cả games--</option>
                    <option value='1'>Kungfu Panda</option>
                    <option value='2'>Thần tài</option>
                    <option value='3'>Tam quốc</option>
                    <option value='4'>Mini Poker</option>
                    <option value='5'>Mini Slot</option>
                    <option value='6'>Kim cương</option>
                    <option value='7'>Cao thấp</option>
                    <option value='8'>Tài xỉu</option>
                    <option value='9'>SuperNova</option>
                    <option value='10'>Bầu cua</option>
                    <option value='11'>Ba cây</option>
                    <option value='15'>Sam Dem La</option>
                    <option value='35'>Sam solo</option>
                    <option value='33'>TLMN</option>
                    <option value='107'>TLMN solo</option>
                </select>
            </div>
        </div>
    </div>
    <div class='row' style='display: block;'>
        <div class="col-md-5 kpi-box">
            <div class='kpi-border af-kpi-box-pieces-container'>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>Web</h5>
                    <h2>
                        <text id="nru-web" style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>Android</h5>
                    <h2>
                        <text id='nru-android' style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>IOS</h5>
                    <h2>
                        <text id='nru-ios' style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class='clearfix'>
                    <h5 class="af-kpi-box-footer">NRU</h5>
                </div>
            </div>
        </div>
        <div class="col-md-5 kpi-box">
            <div class='kpi-border af-kpi-box-pieces-container'>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>Web</h5>
                    <h2>
                        <text id='dau-web' style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>Android</h5>
                    <h2>
                        <text id='dau-android' style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class="col-md-4 af-kpi-box-piece">
                    <h5>IOS</h5>
                    <h2>
                        <text id='dau-ios' style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class='clearfix'>
                    <h5 class="af-kpi-box-footer">DAU</h5>
                </div>
            </div>
        </div>
        <div class="col-md-2 kpi-box">
            <div class='kpi-border af-kpi-box-pieces-container'>
                <div class="col-md-12 af-kpi-box-piece">
                    <h5>PCCU Current</h5>
                    <h2>
                        <text id="pccu-current" style="transition: background-color 0.8s ease-out 0s, color, opacity;">0</text>
                    </h2>
                </div>
                <div class='clearfix'>
                    <h5 class="af-kpi-box-footer">PCCU</h5>
                </div>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class="col-md-12" style="margin-bottom: 10px;">
            <div class="portlet box blue ">
                <div class="portlet-title">
                    <div class="caption">
                        NAU Report
                    </div>
                    <div class="tools">
                        <a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                    </div>
                </div>
                <div class="portlet-body">
                     <div id="sample_1_wrapper" class="dataTables_wrapper form-inline" role="grid">
                        <table class="table table-striped table-bordered table-hover dataTable" id="tbl_datatable"
                            aria-describedby="sample_1_info">
                            <thead>
                                <tr role="row"></tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all"></tbody>
                            <tfoot>
                                <tr role="row"></tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <div id="chartdiv"></div>
                </div>
            </div>
           
        </div>
        
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageJSAdd" runat="server">
    <script src="assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/global/plugins/datatables/DT_bootstrap.js"></script>
    <script src="assets/global/plugins/amcharts/v4/core.js"></script>
    <script src="assets/global/plugins/amcharts/v4/charts.js"></script>
    <script src="assets/global/plugins/amcharts/v4/animated.js"></script>
    <script type="text/javascript">
        var colFilter = null;
        jQuery(document).ready(function () {
            $('.page-toolbar').remove();
            
            if ($('#ContentPlaceHolder_MAIN_ruleAdd').val() == "0")
                $('.sample_editable_1_new').remove();

            ComponentsPickers.init();
            TableEditable.init();
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
                    startDate: moment().subtract('month', 1),
                    endDate: moment(),
                    minDate: moment().subtract('month', 12).format('MM/DD/YYYY'),
                    maxDate: moment().format('MM/DD/YYYY'),
                },
                    function (start, end) {
                        _dateStart = start.format('YYYY/MM/DD');
                        _dateEnd = end.format('YYYY/MM/DD');
                        //alert(_dateEnd);
                        console.log("Callback has been called!");
                        $('#dateRangeEvent input').val(start.format('MM/DD/YYYY') + ' - ' + end.format('MM/DD/YYYY'));
                        AppTracking.init();
                    }
                );
                _dateStart = moment().subtract('month', 1).format('YYYY/MM/DD');
                _dateEnd = moment().format('YYYY/MM/DD');
                $('#dateRangeEvent input').val(_dateStart + ' - ' + _dateEnd);
            };

            return {
                //main function to initiate the module
                init: function () {
                    handleDateRangePickers();
                }
            };
        }();

        function loadChart() {
            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            // Create chart instance
            var chart = am4core.create("chartdiv", am4charts.XYChart);

            chart.colors.step = 2;
            chart.maskBullets = false;
            AppTracking.loadTrackingData(function (data) {
                if (data.length == 0) {
                    bootbox.alert("No Data!");
                    return;
                }
                var totalClicks = 0;
                var avg_convertsionRate = 0;
                var totalOrganic = 0
                var totalNonOrganic = 0;
                var totalConverionRate = 0;
                $.each(data, function (key, obj) {
                    totalClicks += obj.Clicks;
                    totalOrganic += obj.Organic_Installs;
                    totalNonOrganic += obj.Non_Organic_Installs;
                    totalConverionRate += obj.ConversionRate_Installs
                });
                avg_convertsionRate = (totalConverionRate / data.length).toFixed(2);
                $('#numClicks').html(totalClicks);
                $('#numNonOrganic').html(totalNonOrganic);
                $('#numOrganic').html(totalOrganic);
                $('#numClickInstall').html(avg_convertsionRate + '%');
                chart.data = data;
                // Create axes
                var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
                dateAxis.renderer.grid.template.location = 0;
                dateAxis.renderer.minGridDistance = 50;
                dateAxis.renderer.grid.template.disabled = true;
                dateAxis.renderer.fullWidthTooltip = true;

                var OrganicInstallAxis = chart.yAxes.push(new am4charts.ValueAxis());
                OrganicInstallAxis.title.text = "Install";
                OrganicInstallAxis.renderer.grid.template.disabled = true;

                var ClicksAxis = chart.yAxes.push(new am4charts.ValueAxis());
                ClicksAxis.title.text = "Clicks";
                ClicksAxis.renderer.grid.template.disabled = true;
                ClicksAxis.renderer.opposite = true;

                // Create series
                var organicInstallSeries = chart.series.push(new am4charts.ColumnSeries());
                organicInstallSeries.dataFields.valueY = "Organic_Installs";
                organicInstallSeries.dataFields.dateX = "Date";
                organicInstallSeries.yAxis = OrganicInstallAxis;
                organicInstallSeries.name = "Organic Installs";
                organicInstallSeries.columns.template.fillOpacity = 0.7;
                organicInstallSeries.columns.template.propertyFields.strokeDasharray = "dashLength";
                organicInstallSeries.columns.template.propertyFields.fillOpacity = "alpha";
                var organicInstallState = organicInstallSeries.columns.template.states.create("hover");
                organicInstallState.properties.fillOpacity = 0.9;

                var non_organicInstallSeries = chart.series.push(new am4charts.LineSeries());
                non_organicInstallSeries.dataFields.valueY = "Non_Organic_Installs";
                non_organicInstallSeries.dataFields.dateX = "Date";
                non_organicInstallSeries.yAxis = OrganicInstallAxis;
                non_organicInstallSeries.name = "Non-Organic Installs";
                non_organicInstallSeries.strokeWidth = 2;
                non_organicInstallSeries.propertyFields.strokeDasharray = "dashLength";

                var non_organicInstallBullet = non_organicInstallSeries.bullets.push(new am4charts.Bullet());
                var non_organicInstallRectangle = non_organicInstallBullet.createChild(am4core.Rectangle);
                non_organicInstallBullet.horizontalCenter = "middle";
                non_organicInstallBullet.verticalCenter = "middle";
                non_organicInstallBullet.width = 7;
                non_organicInstallBullet.height = 7;
                non_organicInstallRectangle.width = 7;
                non_organicInstallRectangle.height = 7;
                var durationState = non_organicInstallBullet.states.create("hover");
                durationState.properties.scale = 1.2;

                var ConversionRate_InstallsSeries = chart.series.push(new am4charts.LineSeries());
                ConversionRate_InstallsSeries.dataFields.valueY = "ConversionRate_Installs";
                ConversionRate_InstallsSeries.dataFields.dateX = "Date";
                ConversionRate_InstallsSeries.yAxis = OrganicInstallAxis;
                ConversionRate_InstallsSeries.name = "ConversionRate";
                ConversionRate_InstallsSeries.strokeWidth = 2;
                ConversionRate_InstallsSeries.propertyFields.strokeDasharray = "dashLength";
                var ConversionRateBullet = ConversionRate_InstallsSeries.bullets.push(new am4charts.CircleBullet());
                ConversionRateBullet.circle.fill = am4core.color("#fff");
                ConversionRateBullet.circle.strokeWidth = 2;

                var Clicks_InstallsSeries = chart.series.push(new am4charts.LineSeries());
                Clicks_InstallsSeries.dataFields.valueY = "Clicks";
                Clicks_InstallsSeries.dataFields.dateX = "Date";
                Clicks_InstallsSeries.dataFields.categoryX = "Date";
                Clicks_InstallsSeries.yAxis = ClicksAxis;
                Clicks_InstallsSeries.name = "Clicks";
                Clicks_InstallsSeries.strokeWidth = 2;
                Clicks_InstallsSeries.propertyFields.strokeDasharray = "dashLength";
                Clicks_InstallsSeries.tooltipText = `[bold]{categoryX}[/]
                -----------------
                Clicks: {Clicks}
                ConversionRate: {ConversionRate_Installs}%
                Non_Organic: {Non_Organic_Installs}
                Organic: {Organic_Installs}
                Login: {Login_launcher}
                Playgame: {PlayGame}`;
                Clicks_InstallsSeries.tooltip.pointerOrientation = "vertical";

                var ClicksBullet = ConversionRate_InstallsSeries.bullets.push(new am4charts.CircleBullet());
                ClicksBullet.circle.fill = am4core.color("#fff");
                ClicksBullet.circle.strokeWidth = 2;

                var ClicksState = ClicksBullet.states.create("hover");
                ClicksState.properties.scale = 1.2;

                var loginSeries = chart.series.push(new am4charts.LineSeries());
                loginSeries.dataFields.valueY = "Login_launcher";
                loginSeries.dataFields.dateX = "Date";
                loginSeries.yAxis = OrganicInstallAxis;
                loginSeries.name = "Login Launcher";
                loginSeries.strokeWidth = 2;
                loginSeries.propertyFields.strokeDasharray = "dashLength";
                var LoginBullet = loginSeries.bullets.push(new am4charts.CircleBullet());
                LoginBullet.circle.fill = am4core.color("#fff");
                LoginBullet.circle.strokeWidth = 2;

                var playgameSeries = chart.series.push(new am4charts.LineSeries());
                playgameSeries.dataFields.valueY = "PlayGame";
                playgameSeries.dataFields.dateX = "Date";
                playgameSeries.yAxis = OrganicInstallAxis;
                playgameSeries.name = "Playgame";
                playgameSeries.strokeWidth = 2;
                playgameSeries.propertyFields.strokeDasharray = "dashLength";
                var PlayBullet = playgameSeries.bullets.push(new am4charts.CircleBullet());
                PlayBullet.circle.fill = am4core.color("#fff");
                PlayBullet.circle.strokeWidth = 2;

                // Add legend
                chart.legend = new am4charts.Legend();

                // Add cursor
                chart.cursor = new am4charts.XYCursor();
                chart.cursor.fullWidthLineX = true;
                chart.cursor.xAxis = dateAxis;
                chart.cursor.lineX.strokeOpacity = 0;
                chart.cursor.lineX.fill = am4core.color("#000");
                chart.cursor.lineX.fillOpacity = 0.1;
            });
        }


        var oTable = null;
        var _pageSize = 50;
        var _dataColumn = null;
        var colFilter = null;
        var TableEditable = function () {
            var handleTable = function () {
                var table = $('#tbl_datatable');
                loadTable();
                function loadTable() {
                    $('.divLoading').fadeIn();
                    if (_dateStart == null)
                        _dateStart = moment().subtract('month', 1).format('YYYY/MM/DD');
                    if (_dateEnd == null)
                        _dateEnd = moment().format('YYYY/MM/DD');
                    var param = [];
                    param.push(_dateStart);//@0
                    param.push(_dateEnd);//@1
                    $.ajax({
                        type: "POST",
                        url: "Apis/Menu.ashx",
                        data: {
                            type: 13,
                            mid: 50, //DAU
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
                                _dataColumn = data.columnName;
                                var columnLength = data.columnName.length;
                                if (colFilter == null) {
                                    $('#tbl_datatable thead tr').html("");
                                    colFilter = _dataColumn;
                                    var strHtmlColName = "";
                                    _dataColumn.splice(_dataColumn.length - 1, 1);
                                    $.each(_dataColumn, function (key, obj) {
                                        strHtmlColName += "<td>" + obj + "</td>";
                                    });
                                    $('#tbl_datatable thead tr').append(strHtmlColName);
                                    if (data.data.length > 20) {
                                        $('#tbl_datatable tfoot tr').append(strHtmlColName);
                                    }
                                }
                                else {
                                    $('#tbl_datatable thead tr').empty();
                                    var strHtmlColName = "";
                                    $.each(_dataColumn, function (key, obj) {
                                        strHtmlColName += "<td>" + obj + "</td>";
                                    });
                                    if (data.data.length > 20) {
                                        $('#tbl_datatable tfoot tr').append(strHtmlColName);
                                    }
                                }
                                var dataReport = data.data;
                                var chartData = [];
                                var countRow = dataReport.length;
                                $('#dau-web').html(dataReport[countRow - 1][1])//android
                                $('#dau-android').html(dataReport[countRow - 1][2])//ios
                                $('#dau-ios').html(dataReport[countRow - 1][3])//web
                                for (var i = 0; i < countRow; i++) {
                                    dataReport[i].splice(columnLength - 1, 1);
                                    chartData.push({
                                        "date": data.data[i][0],
                                        "android": data.data[i][1],
                                        "ios": data.data[i][2],
                                        "web": data.data[i][3]
                                    });
                                }
                                console.log(dataReport);
                                var colHiden = [];
                                oTable = table.dataTable({
                                    "data": dataReport,
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
                                loadThongkeChart(chartData);
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


        function loadThongkeChart(dataChart) {
            am4core.ready(function () {
                am4core.useTheme(am4themes_animated);
                var chart = am4core.create("chartdiv", am4charts.XYChart);
                chart.data = dataChart;
                chart.colors.step = 2;
                chart.maskBullets = false;
                // Create axes
                var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
                dateAxis.renderer.grid.template.location = 0;
                dateAxis.renderer.minGridDistance = 50;

                var distanceAxis = chart.yAxes.push(new am4charts.ValueAxis());
                distanceAxis.title.text = "User Login";
                distanceAxis.renderer.grid.template.disabled = true;

                //var durationAxis = chart.yAxes.push(new am4charts.ValueAxis());
                //durationAxis.title.text = "Tiền ra";
                //durationAxis.renderer.grid.template.disabled = true;
                //durationAxis.renderer.opposite = true;

                // Create series
                var distanceSeries = chart.series.push(new am4charts.ColumnSeries());
                distanceSeries.dataFields.valueY = "android";
                distanceSeries.dataFields.dateX = "date";
                distanceSeries.yAxis = distanceAxis;
                distanceSeries.tooltipText = "{valueY}";
                distanceSeries.name = "Android";
                distanceSeries.columns.template.fillOpacity = 0.7;
                distanceSeries.columns.template.propertyFields.strokeDasharray = "dashLength";
                distanceSeries.columns.template.propertyFields.fillOpacity = "alpha";

                var disatnceState = distanceSeries.columns.template.states.create("hover");
                disatnceState.properties.fillOpacity = 0.9;

                var webSeries = chart.series.push(new am4charts.ColumnSeries());
                webSeries.dataFields.valueY = "web";
                webSeries.dataFields.dateX = "date";
                webSeries.yAxis = distanceAxis;
                webSeries.tooltipText = "{valueY}";
                webSeries.name = "Web";
                webSeries.columns.template.fillOpacity = 0.7;
                webSeries.columns.template.propertyFields.strokeDasharray = "dashLength";
                webSeries.columns.template.propertyFields.fillOpacity = "alpha";

                var webState = webSeries.columns.template.states.create("hover");
                webState.properties.fillOpacity = 0.9;

                var durationSeries = chart.series.push(new am4charts.LineSeries());
                durationSeries.dataFields.valueY = "ios";
                durationSeries.dataFields.dateX = "date";
                durationSeries.yAxis = distanceAxis;
                durationSeries.name = "iOS";
                durationSeries.strokeWidth = 2;
                durationSeries.propertyFields.strokeDasharray = "dashLength";
                durationSeries.tooltipText = "{valueY}";

                var durationBullet = durationSeries.bullets.push(new am4charts.Bullet());
                var durationRectangle = durationBullet.createChild(am4core.Rectangle);
                durationBullet.horizontalCenter = "middle";
                durationBullet.verticalCenter = "middle";
                durationBullet.width = 7;
                durationBullet.height = 7;
                durationRectangle.width = 7;
                durationRectangle.height = 7;

                var durationState = durationBullet.states.create("hover");
                durationState.properties.scale = 1.2;
                // Add legend
                chart.legend = new am4charts.Legend();

                // Add cursor
                chart.cursor = new am4charts.XYCursor();
                chart.cursor.fullWidthLineX = true;
                chart.cursor.xAxis = dateAxis;
                chart.cursor.lineX.strokeOpacity = 0;
                chart.cursor.lineX.fill = am4core.color("#000");
                chart.cursor.lineX.fillOpacity = 0.1;

            }); // end am4core.ready()
        }
    </script>
</asp:Content>
