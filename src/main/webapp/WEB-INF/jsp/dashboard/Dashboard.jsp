<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="/assets/global/images/favicon.png" type="image/png">
    <title>SFLOW Dashboard</title>
    <link href="/assets/global/css/style.css" rel="stylesheet">
    <link href="/assets/global/css/theme.css" rel="stylesheet">
    <link href="/assets/global/css/ui.css" rel="stylesheet">
    <link href="/assets/css/layout.css" rel="stylesheet">
	<!-- <link href="/assets/global/plugins/multiSelect/multi.min.css" rel="stylesheet"> -->

<style>
.tooltip-inner {
    min-width: 50px;
}

body { color:#dadada; }

.count-header{
	height:100px;
	border-radius:0px;
}
.errorEventLine:before {
    position: absolute;
    content: ' ';
    width: 3px;
    background: #ccc;
    left: -10px;
    z-index: 0;
    height: 100%;
    top: 0;
}
.timeline-item{
	padding-left:0px;
	padding-right:0px;
}
.errorEventDot:after {
    content: "";
    position: absolute;
    height: 15px;
    width: 15px;
    background-color: #ccc;
    left: -16px;
    top:3px;
    border-radius: 50%;
}
.errorEventDot{
	top:8px;
	width:17%;
	padding-left:2px;
}
.errorEventContent{
	width:83%;
	border-radius: 5px 5px 5px 5px;
	padding: 3px 7px 2px 10px;
	background:#C9625F;
	color:white;
}
.errorEventContent:before {
    border-right: 7px solid #fff;
    border: 7px solid transparent;
    content: '';
    height: 0px;
    position: absolute;
    right: 100%;
    top: 16px;
    width: 0;
}
.errorEventContent::before {
    border-color: transparent;
    border-right-color:#C9625F;
    left: auto;
    right: 100%;
    top: 6px;
}
.errorEventContent {
	margin-top:5px;
}
.errorEventLine {
	font-size: 14px;
}
.badge {
    display: inline-block;
    min-width: 10px;
    padding: 3px 7px;
    font-size: 12px;
    font-weight: 700;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    background-color: #777;
    border-radius: 10px;
}
.badge-header {
    font-size: 12px;
    padding: 2px 5px;
    position: relative;
    right: 8px;
    top: -8px;
    -webkit-border-radius: 8px;
    -moz-border-radius: 8px;
    border-radius: 8px;
}
.interfaceItemTitle{
	width:inherit;
	height:18px;
	margin-top:10px;
	margin-bottom:0px;
	padding-right:15px;
}
.interfaceItemWrapper{
	width: 192px;
    height: 100px;
    margin-right:6px;
    margin-bottom:7px;
    padding-left:1px;
    padding-right:1px;
    float: left;
    color:white;
}
.interfaceItemWrapper:nth-child(7n){
	margin-right:0px;
}
.interfaceItemWrapper.wrapper_gray{
    background:gray;
}
.interfaceItemWrapper.wrapper_orange{
    background:#ff9122 !important;
}
.interfaceItemError {
	float:right;
    position:relative;
	right: -13px;
    top: -23px;
    -webkit-border-radius: 8px;
    -moz-border-radius: 8px;
    border-radius: 10px;
    background-color: #c14444;
	display: inline-block;
    min-width: 10px;
    padding: 4px 7px;
    font-size: 14px;
    font-weight: 100;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
}
.interfaceItemContent{
	float: right;
	margin-top:0px;
}
.control-btn{
    display: inline-block !important;
    position: absolute;
    right: 26px;
    top: 8px;
    z-index: 2;
}

.blink{
    animation:blink 700ms infinite alternate;
}

@keyframes blink {
    from { opacity:1; }
    to { opacity:0; }
};

</style>
</head>
<body style="background: #333;min-width: 1920px;">
<div>
	<div class="col-md-12  col-sm-12" style="width:1910px;height: 70px;">
		<div class="col-md-6 col-xs-6 c-gray-light">
			<h3><strong>트랜잭션 대시보드</strong></h3>
		</div>
		<div class="col-md-6 col-xs-6 col-sm-12" style="text-align: right;">
			<canvas id="dateDisplay" width="230" height="70"></canvas>
		</div>
	</div>
	<div class="col-md-12" style="width:1910px;">
		<div class="col-md-3  col-sm-12">
			<div class="col-md-12 col-sm-12 count-header" style="background: #2196F3;color: white;">
				<div class="row">
					<div class="col-md-5 col-xs-5" style="height:50px;"><h2><strong>전체</strong></h2></div>
					<div class="col-md-7 col-xs-7" style="height:50px;text-align:right;padding-top:14px;"><h1><strong id="countDatatotal">0</strong></h1></div>
				</div>
				<div class="row" style="padding-top:16px;">
					<div class="col-md-5 col-xs-5" style="height:34px;background:#2f80e7;"><h4 style="margin-top:8px;">전일</h4></div>
					<div class="col-md-7 col-xs-7" style="height:34px;background:#2f80e7;text-align:right;"><h4 id="pastCountDatatotal" style="margin-top:8px;">0</h4></div>
				</div>
			</div>
		</div>
		<div class="col-md-3 ">
			<div class="col-md-12 count-header" style="background: #3b5998;color: white;">
				<div class="row">
					<div class="col-md-5 col-xs-5" style="height:50px;"><h2><strong>처리중</strong></h2></div>
					<div class="col-md-7 col-xs-7" style="height:50px;text-align:right;padding-top:14px;"><h1><strong id="countDataProcess">0</strong></h1></div>
				</div>
				<div class="row" style="padding-top:16px;">
					<div class="col-md-5 col-xs-5" style="height:34px;background:#334e88;"><h4 style="margin-top:8px;">전일</h4></div>
					<div class="col-md-7 col-xs-7" style="height:34px;background:#334e88;text-align:right;"><h4 id="pastCountDataProcess" style="margin-top:8px;">0</h4></div>
				</div>
			</div>
		</div>
		<div class="col-md-3 ">
			<div class="col-md-12  count-header" style="background: #4caf50;color: white;">
				<div class="row">
					<div class="col-md-5 col-xs-5" style="height:50px;"><h2><strong>성공</strong></h2></div>
					<div class="col-md-7 col-xs-7" style="height:50px;text-align:right;padding-top:14px;"><h1><strong id="countDataSuccess">0</strong></h1></div>
				</div>
				<div class="row" style="padding-top:16px;">
					<div class="col-md-5 col-xs-5" style="height:34px;background:#4ca250;"><h4 style="margin-top:8px;">전일</h4></div>
					<div class="col-md-7 col-xs-7" style="height:34px;background:#4ca250;text-align:right;"><h4 id="pastCountDataSuccess" style="margin-top:8px;">0</h4></div>
				</div>
			</div>
		</div>
		<div class="col-md-3 ">
			<div class="col-md-12 count-header" style="background: #ff5252;color: white;">
				<div class="row">
					<div class="col-md-5 col-xs-5" style="height:50px;"><h2><strong>실패</strong></h2></div>
					<div class="col-md-7 col-xs-7" style="height:50px;text-align:right;padding-top:14px;"><h1><strong id="countDataError">0</strong></h1></div>
				</div>
				<div class="row" style="padding-top:16px;">
					<div class="col-md-5 col-xs-5" style="height:34px;background:#c14444;"><h4 style="margin-top:8px;">전일</h4></div>
					<div class="col-md-7 col-xs-7" style="height:34px;background:#c14444;text-align:right;"><h4 id="pastCountDataError" style="margin-top:8px;">0</h4></div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-12 " style="padding-left:0px;">
		<div class="col-md-10 " style="width:1440px;">
			<div class="col-md-12 " style="width:1411.19px;margin-top:20px;">
				<div class="col-md-6 " id="transactionChart" style="height:450px;padding-left:0px;padding-right:0px;"></div>
				<div class="col-md-6 " id="transactionSpread"  style="height:450px;padding-left:0px;padding-right:0px;"></div>
			</div>
			<div class="col-md-12 " style="margin-top:10px;padding-left:0px;padding-right:0px;">
			    <div class="col-md-12 " style="width:1419.19px;">
                	<div class="panel-header">
						<h4><strong>중점 모니터링</strong></h4>
						<div class="control-btn">
							<a href="javascript:mntrngTrgtManage();" data-rel="tooltip" data-placement="right" data-original-title="설정"><i class="fa fa-cog"  style="color:white;"></i></a>
						</div>
					</div>
                	<div class="panel-content" id="interfaceChart" >
                	</div>
                </div>
			</div>
		</div>
		<div class="col-md-2 " style="padding-left:0px;width:455px;">
			<div class="col-md-12 " id="alertContainer" style="margin-top:20px;padding-left:0px;padding-right:0px;">
				<div class="col-md-12" id="errorPatternDonut" style="width:440px;height: 376px;padding:  0px 0px 0px 0px;background: #333;margin-top: 10px;"></div>
				<div class="col-md-12" id="errorAgentDonut" style="width:440px;height: 376px;padding:  0px 0px 0px 0px;background: #333;margin-top: 50px;"></div>

			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="mntrngTrgtManage" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>중점 모니터링 설정</strong>
				</h4>
			</div>
			<form id="mntrngTrgtForm" name="mntrngTrgtForm" class="form-horizontal form-validation" onsubmit="return false;">
			<div class="modal-body">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="mntrngTrgtManageSave();">저장</button>
			</div>
			</form>
		</div>
	</div>
</div>

<form name="goWebPage" method="post" target="aster" action="/monitoring/transactionList">
	<input type="hidden" id="trnscId" name="trnscId">
</form>

<!-- Jquery -->
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery-migrate-3.0.0.min.js"></script>
<script src="/assets/global/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="/assets/global/plugins/bootstrap/js/bootstrap.js"></script>

<!-- CHART -->
<script src="/assets/global/plugins/jui/lib/core.js"></script>
<script src="/assets/global/plugins/jui/lib/chart.js"></script>
<script src="/assets/global/plugins/segment-display/excanvas.js"></script>
<script src="/assets/global/plugins/segment-display/segment-display.js"></script>

<!-- <script src="/assets/global/plugins/multiSelect/multi.min.js"></script> -->
<script src="/assets/global/plugins/dual-list-box/dual-list-box.js"></script>
<script src="/assets/global/plugins/noty/jquery.noty.packaged.min.js"></script>  <!-- Notifications -->
<!-- WEBSOCKET -->
<script src="/assets/js/websocket/sockjs.js"></script>
<script src="/assets/js/websocket/stomp.js"></script>
<script src="/assets/js/common.js"></script>

<script>
var socket;
var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';
var stompClient;
var serviceName = 'dashboard';
var wsUrl = '/${WS_SERVICE_NAME}';
var loginId = '${loginId}';
var request ="${WS_REQUEST}/"+serviceName;
var response = '${WS_RESPONSE}/'+serviceName;
var dateDisplay;
var time = jui.include("util.time");
var sessionId = '${pageContext.session.id}';
//모니터링 대상 최대 갯수
var MAX_ITEM_COUNT = 21;//14;

var sub1;
var sub2;
var sub3;
var sub4;
var sub5;
var sub6;

$(function () {
	$('[data-rel="tooltip"]').tooltip();
	dateDisplay = new SegmentDisplay("dateDisplay");
	setSegmentDisplayOption(dateDisplay, "####.##.##  ##:##:##");
	connect();
	dateTimer();
	transactionColumnChart();
	$('#errorPatternDonut').hide();
	$('#errorAgentDonut').hide();
	drawErrorPatternDonutChart();
	drawErrorAgentDonutChart();
	transactionSpread();
	var d = setInterval(connectCheker, 10000);
	var transactionSpreadChartDrawTimer = setInterval(transactionSpreadChartDraw, 2000);
});

function blink(selector){
	$(selector).fadeOut(500, function(){
	   	$(this).fadeIn(500, function(){

	   	});
	});
}
function connect() {
	try{
		var userIdParam = {id : loginId};

		socket = new SockJS(wsUrl);
		stompClient = Stomp.over(socket);
		stompClient.connect('', '', function(frame) {

			// 소요시간 분포
			sub1 = stompClient.subscribe(response+'/transactionSpread', transactionSpreadCallback, {});

			// 상단 4군데
			sub2 = stompClient.subscribe(response+'/topCount', topCountCallback, {});

			//시간대별 추이
			sub3 = stompClient.subscribe(response+'/transactionChart', transactionColumnChartCallback, {});
			stompClient.send(request+'/transactionChart', {}, {});

			//중점 모니터링 바닥 (로그인 세션별로 다르게 )
			sub4 = stompClient.subscribe(response+'/monitoringTargetInterface/'+loginId, monitoringTargetInterfaceCallback, {});
			stompClient.send(request+'/monitoringTargetInterface', {}, {});

			// 중점모니터링 데이터 수신 (로그인 세션별로 다르게 )
			sub5 = stompClient.subscribe(response+'/iftargetMonitoring/'+loginId, iftargetMonitoringCallback, {});

			// 오류유형, 에이전트별 오류
			sub6 = stompClient.subscribe(response+'/donutChartData', drawDonutChart, {});
			$.getJSON('/dashboard/donutChartDataRequest',null,null);

		});
	}catch(e){
		alert('서버 연결 실패');
	}
}

function connectCheker() {
	if(socket.readyState != 1){
		//console.log('WebSocket ReConnect!')
		connect();
	}else{
		//console.log('WebSocket Connect!')
	}

	//alertnoty 중에서 삭제 시간이 지났는데 살아있는 아이는 지워주자
	var now = new Date();
	$('.alert.alert-danger').each(function(idx,object){
		var showTime = $(object).data("showTime");
		if((+now) - showTime > 15000 ){
			$(object).click()
		}
	});

}

function endconnect(){
	stompClient.disconnect(function(){
		stompClient.unsubscribe(sub1);
		stompClient.unsubscribe(sub2);
		stompClient.unsubscribe(sub3);
	});
}

function monitoringTargetInterfaceCallback(message){
	var data =  JSON.parse(message.body);
	if (eval('data.'+STATUS_KEY) == STATUS_VALUE_OK) {

		var targetList = data.data;
		var color = '';
		var now = 0;
		$('#interfaceChart').html('');
		for(i = 0 ; i < targetList.length; i++){
			var item = targetList[i];
			var color = 'gray';
			if(item.processSttus == 'E'){
				color = 'orange'
			}
			$('#interfaceChart').append(interfaceChartItem(item, color));
			now++;
		}
		for(now ; now < MAX_ITEM_COUNT; now++){
			$('#interfaceChart').append(interfaceChartEmptyItem());
		}
	}else{
		$('#interfaceChart').html('');
		$('#interfaceChart').append('로그인 정보가 없습니다.<br>다시 로그인 하세요.');
	}
}

function iftargetMonitoringCallback(message){
	var dataList = JSON.parse(message.body);
	if(dataList.length > 0){
		var lastExcDt = dataList[0].lastExcDt;
		var totalCo = dataList[0].totalCo;
		var errorCo = dataList[0].errorCo;
		var lastExcSttus = dataList[0].lastExcSttus;
		var nm = dataList[0].nm;
		var id = dataList[0].id;
		var trnsCo = dataList[0].trnsCo;

		var objectId = '#if_target_'+id;
		var object = $(objectId);

		object.find('.interfaceItemError').html(errorCo);
		if(errorCo > 0){
			object.find('.interfaceItemError').show();
		}
		object.find('.totalCo').html(totalCo);
		object.find('.lastExcDt').html(lastExcDt);
		if(lastExcSttus == 'E'){
			object.removeClass('wrapper_gray');
			object.addClass('wrapper_orange');
		}else{
			object.addClass('wrapper_gray')
			object.removeClass('wrapper_orange');
		}

		var loopCount = 1;
		if(trnsCo > 10){
			loopCount = 2
		}
		if(trnsCo > 50){
			loopCount = 3
		}
		if(trnsCo > 100){
			loopCount = 4
		}

		//for(var i = 0 ; i < loopCount ; i ++){
			blink(objectId);
		//}
	}
}

function getDomain() {
	var now = new Date();
	var start =  now;
    var end = time.add(now, time.minutes, -5);

    return [end, start];
}

var transactionSpreadData = [];
function transactionSpreadCallback(message){
	var transactionData = message.body;
	var tr;
	if(transactionData){
		dataList = JSON.parse(transactionData);
		for(var i =0; i< dataList.length; i++){
			var tr = dataList[i];
			var data = {
				time : new Date(tr.endDt),
		    	processTime : tr.processTime,
		    	type : tr.processSttus == 'S'  ? "success":"error",
			    trnscId : tr.trnscId
			}
			if(tr.processSttus != 'S'){
				alertNoty(tr.intrfcId, tr.intrfcNm, '', tr.endDt, tr.processCn );
			}
			transactionSpreadData.push(data);
		}
		//transactionSpreadChartDraw();
	}
}

var transactionSpreadChartDrawTimer;
function transactionSpreadChartDraw(){
	var domain = getDomain();
	for(var i = 0; i < transactionSpreadData.length; i++) {
		if(transactionSpreadData[i].time.getTime() <= domain[0].getTime() + 1000) {
	    	transactionSpreadData.shift();
	     }else{
	    	 break;
	     }
	}

	transactionSpreadChart.axis(0).update(transactionSpreadData);
	transactionSpreadChart.axis(0).set("x", { domain : domain });
	transactionSpreadChart.render();
}

function topCountCallback(message){
	var data = JSON.parse(message.body);
	$('#countDatatotal').html(data.countData.TOTAL);
	$('#countDataSuccess').html(data.countData.SUCCESS);
	$('#countDataError').html(data.countData.ERROR);
	$('#countDataProcess').html(data.countData.PROCESS);

	$('#pastCountDatatotal').html(data.pastCountData.TOTAL);
	$('#pastCountDataSuccess').html(data.pastCountData.SUCCESS);
	$('#pastCountDataError').html(data.pastCountData.ERROR);
	$('#pastCountDataProcess').html(data.pastCountData.PROCESS);
}

function disconnect() {
	stompClient.disconnect();
}

function dateTimer() {
    var today = new Date();
    var year = today.getFullYear();
    var mo = today.getUTCMonth()+1;
    var day = today.getUTCDate();
	var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
    mo = checkTime(mo);
    day = checkTime(day);
    var value = year + "." + mo + "." + day +"  "+ h + ":" + m + ":" + s;
    dateDisplay.setValue(value);
    var d = setTimeout(dateTimer, 1000);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
}

var names = {
	성공 : "성공",
	실패 : "실패",
	전일 : "전일"
}
var transactionColumnChart;
var transactionColumnChartData = [];
function transactionColumnChart(){
	var builder = jui.include("chart.builder");
	transactionColumnChart  = builder("#transactionChart", {
		theme : "dark",
	    axis : {
	        x : {
	            domain : "time",
	            color : "gray"
	        },
	        y : {
	            type : "range",
	            domain: function(data){
	            	var today = (data.성공 + data.실패);
	            	var yesterday = data.전일;
	            	return Math.max(today, yesterday);
	            },
	            step : 20,
	            color : "gray"
	        },
	        data : transactionColumnChartData
	    },
 	    brush : [{
	        type : "stackcolumn",
	        target : [ "실패", "성공" ],
	        colors : [ "#ff5252", "#4caf50"],
	        size : 12
	    },{
	        type : "line",
	        target : [ "전일" ],
	        colors : [ "orange"]
	    }],
	    widget : [{
	        type : "title",
	        text : "시간대별 추이(최근 24시간)",
	        dy : 10
	    } ,{
	        type : "tooltip",
	        format : function(data, k) {
	              return {
	            	key : names[k],
                	value : data[k]
	            }
	        },
	        brush : [0]
	    } ,{
        	type : "legend"
        	,brush : [0, 1]
		}],
	    style : {
	        gridAxisBorderWidth : 2,
	        titleFontSize : "14px",
	        //titleFontWeight : "bold",
	        tooltipBorderColor : "#dcdcdc"
	    }
	});
}
function transactionColumnChartCallback(message){
	var body = JSON.parse(message.body);
	var data = body.transactionChartListData;
	var xDomain ='';
	transactionColumnChart.axis(0).update(data);
	//transactionColumnChart.axis(0).set("x", { domain : xDomain });
	transactionSpreadChart.render();
}

function alertNoty(intfrcId, intfrcNm, orgNm, time, exceptionMessage){
	var targetList = $('#alertContainer .timeline-item');

	var length = targetList.length;
	if(length == 17 ){
		targetList[16].remove();
	}

	var today = new Date(Date.parse(time));
	var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
    var time = h + ":" + m + ":" + s;
	showAlartNoty(time, intfrcId, intfrcNm, orgNm, exceptionMessage);
}

function getNumber() {
    return Math.round(Math.random() * 30  % 20);
}

var opener111;
var transactionSpreadChart;
function transactionSpread(){
	var builder = jui.include("chart.builder");

	transactionSpreadChart  = builder("#transactionSpread", {
		theme : "dark",
	    padding : {
	        left : 70
	    },
	    axis : {
	        x : {
	            type : "date",
	            domain : getDomain(),
	            interval : 1,
	            format : "HH:mm",
	            realtime : "minutes",
	            key: "time",
	            line : true,
	            color : "gray"
	        },
	        y : {
	            type : "range",
	            domain : "processTime",
	            step : 10,
	            line : true,
	            color : "gray"
	        },
	        data : transactionSpreadData
	    },
	    brush : {
	        type : "scatter",
        	symbol : "cross",
	        size : 5,
	        target : ["processTime"],
	        colors : function(data){
	        	var color = "#4caf50";
	        	if(data.type != 'success'){
	        		color = "#ff5252";
	        	}
	        	return color;
	        }
	    },
	    widget : [{
	        type : "title",
	        text : "소요시간 분포(최근 5분, ms)"
	    }, {
	        type : "dragselect",
	        dataType : "list" // or "list"
	    }, {
	        type : "tooltip"
	    }],
	    event : {
	        "dragselect.end": function(data) {
	            console.log(data);
	        },
	        "click": function(data) {
	        	goWebPage.trnscId.value=data.data.trnscId;
	        	window.open("", "aster");
	        	goWebPage.submit();
	        }
	    }
	});
}

function interfaceChartItem(item, color){
	var interfaceItem = "";
	var hideStyle = "";
	if(item.errorCo == 0){
		hideStyle = 'style="display:none;"';
	}

	interfaceItem+='<div class="interfaceItemWrapper wrapper_'+color+'" id="if_target_'+item.id+'">\n';
	interfaceItem+='	<div class="col-md-12" style="height: 35px;">\n';
	interfaceItem+='		<h5 class="interfaceItemTitle" >'+item.nm+'</h5>\n';
	interfaceItem+='		<span class="interfaceItemError" '+hideStyle+'>'+item.errorCo+'</span>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='	<div class="col-md-12">\n';
	interfaceItem+='		<h2 class="interfaceItemContent totalCo" style="min-height:37px;">'+item.totalCo+'</h2>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='	<div class="col-md-12">\n';
	interfaceItem+='		<h5 class="interfaceItemContent lastExcDt">'+item.lastExcDt+'</h5>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='</div>\n';

	return interfaceItem;
}

function interfaceChartEmptyItem(){
	var interfaceItem = "";
	interfaceItem+='<div class="interfaceItemWrapper wrapper_gray">\n';
	interfaceItem+='	<div class="col-md-12" style="height: 35px;">\n';
	interfaceItem+='		<h5 class="interfaceItemTitle"></h5>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='	<div class="col-md-12">\n';
	interfaceItem+='		<h2 class="interfaceItemContent"></h2>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='	<div class="col-md-12">\n';
	interfaceItem+='		<h5 class="interfaceItemContent"></h5>\n';
	interfaceItem+='	</div>\n';
	interfaceItem+='</div>\n';

	return interfaceItem;
}

function setSegmentDisplayOption(display, formet){
	display.pattern         = formet;
	display.digitHeight     = 41;
	display.digitWidth      = 20;
	display.digitDistance   = 7;
	display.displayAngle    = 3;
	display.segmentWidth    = 5;
	display.segmentDistance = 0.8;
	display.segmentCount    = 7;
	display.cornerType      = 3;
	display.colorOn         = "#e95d0f";
	display.colorOff        = "#333";
	display.draw();
}

function mntrngTrgtManage(){
	$.ajax({
		url : '/dashboard/monitoringTargetManage',
		method :'POST',
		success : function(result){
			var modalBody = $('#mntrngTrgtManage #mntrngTrgtForm').find('.modal-body');
			modalBody.html(result);
			$('#mntrngTrgtManage').modal();
		}
	});
}

var tmp;
function mntrngTrgtManageSave(){
	var target = $('.selected option');
	if(target.length > MAX_ITEM_COUNT ){
		alert('중점 모니터링 대상 인터페이스는 최대 ' + MAX_ITEM_COUNT+'개 까지만 지정할 수 있습니다.');
		return false;
	}

	$('#mntrngTrgtManage').modal('hide');

	var form = document.createElement('form');
	form.name="mntrngTrgtForm";
	form.method="POST";
	for(var i = 0 ; i < target.length ; i++){
		var item = target[i];
		var input1 = document.createElement('input');
		input1.name="dspyOrder";
		input1.value= i+1;
		form.appendChild(input1);
		var input2 = document.createElement('input');
		input2.name="intrfcSeq";
		input2.value= item.value;
		form.appendChild(input2);
	}

	var sendData = $(form).serialize();

  	$.ajax({
		url : '/xhr/dashboard/monitoringTargetManage',
		method :'POST',
		data : sendData,
		//dataType : 'json',
		//contentType: 'application/json',
		success : function(result){
			stompClient.send(request+'/monitoringTargetInterface', {}, {});
		}
	});
}

function drawDonutChart(data) {
	drawDonutChartCallback(data);
}

var errorPatternDonutChart;
var errorPatternDonutChartData = [];

var donutPadding = 45;
var donutsize = 50;
var donutDx = -65;
var legendDx = -15;

function drawErrorPatternDonutChart() {
	builder = jui.include("chart.builder");
	errorPatternDonutChart  = builder("#errorPatternDonut", {
		padding : donutPadding,
		axis : {
			data : [errorPatternDonutChartData]
		},
		style : {
			backgroundColor : "#333",
			pieTotalValueFontColor : "#fff",
			legendFontColor : "#fff",
			titleFontColor : "#fff"
		},
		brush : {
			type : "donut"
			,showValue : true
			,size : donutsize
			,format : function(k, v) {
				return k + '(' + v + ')';
			}
			,colors : ["#FE7F2D","#FCCA46","#233D4D","#A1C181","#579C87"]
			,dx : donutDx// 중앙부터 시작, -면 왼쪽으로 이동, +면 오른쪽으로 이동
		},
		widget : [
			{
				type : "legend"
				, orient : "right"
				, filter : false
				, format : function(data, dataArray) {
					return data + " (" + dataArray[0][data] + ")";
				},
				dx : legendDx // orient 기준, -면 왼쪽으로 이동, +면 오른쪽으로 이동
			},
			{
				type : "tooltip",
				orient : "left",
				format : function(data, k) {
					return {
					//key: names[k],
					key : k,
					value : data[k]
					}
				}
			},{
	        	type : "title",
				orient : "top",
				align : "start",
	        	text : "실패 유형별 건수",
	        	dx: 60
	    	}
		]
	});
}


var errorAgentDonutChart;
var errorAgentDonutChartData = [];

function drawErrorAgentDonutChart() {
	builder = jui.include("chart.builder");
	errorAgentDonutChart  = builder("#errorAgentDonut", {
		padding : donutPadding,
		axis : {
			data : [errorAgentDonutChartData]
		},
		style : {
			backgroundColor : "#333",
			pieTotalValueFontColor : "#fff",
			legendFontColor : "#fff",
			titleFontColor : "#fff"
		},
		brush : {
			type : "donut"
			,showValue : true
			,size : donutsize
			,format : function(k, v) {
				return k + '(' + v + ')';
			}
			,colors : ["#FE7F2D","#FCCA46","#233D4D","#A1C181","#579C87"]
			,dx : donutDx // 중앙부터 시작, -면 왼쪽으로 이동, +면 오른쪽으로 이동
		},
		widget : [
			{
				type : "legend"
				, orient : "right"
				, filter : false
				, format : function(data, dataArray) {
					return data + " (" + dataArray[0][data] + ")";
				}
				,dx : legendDx // orient 기준, -면 왼쪽으로 이동, +면 오른쪽으로 이동
			},
			{
				type : "tooltip",
				orient : "left",
				format : function(data, k) {
					return {
						key : k,
						value : data[k]
					}
				}
			},{
	        	type : "title",
				orient : "top",
				align : "start",
	        	text : "에이전트별 실패 건수",
	        	dx: 48
	    	}
		]
	});
}

function drawDonutChartCallback(message){
	var dataMap = JSON.parse(message.body);

	if(dataMap.exceptionPatternSize == 0){
		$('#errorPatternDonut').hide();
	}else{
		$('#errorPatternDonut').show();
		errorPatternDonutChartData = dataMap.exceptionPattern;
		errorPatternDonutChart.axis(0).update([errorPatternDonutChartData]);
		errorPatternDonutChart.render(true);
	}
	if(dataMap.exceptionAgentSize == 0){
		$('#errorAgentDonut').hide();
	}else{
		$('#errorAgentDonut').show();
		errorAgentDonutChartData = dataMap.exceptionAgent;
		errorAgentDonutChart.axis(0).update([errorAgentDonutChartData]);
		errorAgentDonutChart.render(true);
	}
}


function showAlartNoty(time, intfrcId, intfrcNm, orgNm, exceptionMessage){
	var date = new Date();

	var content = "";
	content+='	<div class="alert alert-danger media fade in" data-show-time="'+(+date)+'" style="height:64.4px;width:440px;margin-right: 17px;padding-top:10px;padding-bottom:10px;">';
	content+='		<p><strong>'+intfrcNm+'('+intfrcId+')</strong></p>';
	content+='		<p>'+exceptionMessage+ '('+time+')</p>';
	content+='	</div>';

	var position = 'topRight';
	var openAnimation = 'animated fadeIn';
    var closeAnimation = 'animated fadeOut';
    var container = '#alertContainer'

	var n = $(container).noty({
	    text        : content,
	    dismissQueue: true,
	    layout      : position,
	    theme       : 'mint',
	    maxVisible  : 11,
        buttons     : '',
	    animation   : {
	        open  : openAnimation,
	        close : closeAnimation,
	        speed: 100
	    },
	    timeout: 15000,
	    callback: {
            onShow: function() {}
        }
	});
}

</script>
</body>
</html>