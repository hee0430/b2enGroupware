<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="/assets/global/images/favicon.png" type="image/png">
    <title>SFLOW Topology Map</title>
  	<link href="/assets/global/css/style.css" rel="stylesheet">
    <link href="/assets/global/css/theme.css" rel="stylesheet">
    <link href="/assets/global/css/ui.css" rel="stylesheet">
    <link href="/assets/css/layout.css" rel="stylesheet">
    <link href="/assets/global/plugins/js-graph-it/js-graph-it.css">
   	<style>
		body { color:#dadada; }

   	</style>
</head>
<body style="background: #333;">
<div>
	<div class="col-md-12 col-xs-12 col-sm-12" style="height: 70px;">
		<div class="col-md-6 col-xs-6 c-gray-light">
			<h3><strong>토폴로지 맵</strong></h3>
		</div>
		<div class="col-md-6 col-xs-6 col-sm-12" style="text-align: right;">
			<canvas id="dateDisplay" width="230" height="70"></canvas>
		</div>
	</div>
	<div class="col-md-12">
	    <div class="main-content" style="margin: 0px 0px;background: inherit;">
   			<div class="page-content"  style="padding: 0px 0px;background: #222222;">
				<div class="col-md-11 portlets" style="padding: 0px 0px;background-color:#333;">
					<div class="panel topolotyPanel" style="background-color:#333;margin-bottom: 0px; min-height: 0px;">
						<div class="panel-content" id="topologyArea" style="background: #222222;height:900px;margin-right: 0px;margin-left: 0px;padding:0px 0px;"></div>
					</div>
				</div>

				<div class="col-md-1 portlets" style="padding: 0px 0px;background-color:#333;background: #222222;">
					<div class="panel queuePanel" style="background-color:#333;margin-bottom: 0px; min-height: 0px;">
						<div class="panel-content" id="queueArea" style="background: #222222;margin-right: 0px;height:1000px;margin-left: 0px;padding:0px 0px;overflow-x: hidden;overflow-y: auto;">

						</div>
					</div>
				</div>

   			</div>
   		</div>
	</div>
</div>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery-migrate-3.0.0.min.js"></script>
<script src="/assets/global/plugins/jquery-ui/jquery-ui.min.js"></script>

<script src="/assets/global/plugins/jui/lib/core.js"></script>
<script src="/assets/global/plugins/jui/lib/chart.js"></script>

<script src="/assets/js/websocket/sockjs.js"></script>
<script src="/assets/js/websocket/stomp.js"></script>
<script src="/assets/js/common.js"></script>

<script src="/assets/global/js/plugins.js"></script>
<script src="/assets/global/js/application.js"></script>

<script src="/assets/global/plugins/segment-display/excanvas.js"></script>
<script src="/assets/global/plugins/segment-display/segment-display.js"></script>
<script>
var stompClient;
var serviceName = 'topology';
var wsUrl = '/${WS_SERVICE_NAME}';
var sessionId = '${pageContext.session.id}';
var request ="${WS_REQUEST}/"+serviceName;
var response = '${WS_RESPONSE}/'+serviceName;
var dateDisplay;
var chart = jui.include("chart.builder");
var itemPosition ={};

jui.define("chart.topology.sort.topology.custom.sort", [], function() {
    return function(data, area, space) {
    	var xy = [];
    	for(var i = 0 ; i < data.length;i++){
    		var item = data[i];
    		if(itemPosition != null &&itemPosition.hasOwnProperty(item.key)){
    			xy.push(itemPosition[item.key])
    		}else{
    			var x = Math.floor((Math.random() * 400) );
    			var y = Math.floor((Math.random() * 600) );
    			xy.push({x: x, y:y});
    		}
    	}
        return xy;
    }
});



$(function () {

	$('.main-content .page-content .portlets.ui-sortable').css('min-height','0px');
	dateDisplay = new SegmentDisplay("dateDisplay");
	setSegmentDisplayOption(dateDisplay, "####.##.##  ##:##:##");
	connect('INIT');
	dateTimer();

	drawQueueChart();

/*
	$('.topolotyPanel .panel-max').bind('click', function(){
		if($('#topologyArea').hasClass('max')){
			$('#topologyArea').removeClass('max');
			$('#topologyArea').addClass('min');
			$('#topologyArea').css('height','550px');
			$('.topolotyPanel .panel-max').find('i').switchClass('icon-size-actual','icon-size-fullscreen');
			$('.queuePanel').show();
		}else{
			$('#topologyArea').removeClass('min');
			$('#topologyArea').addClass('max');
			$('#topologyArea').css('height','900px');
			$('.queuePanel').hide();
			$('.topolotyPanel .panel-max').find('i').switchClass('icon-size-fullscreen','icon-size-actual');
		}
		requestTopology();
		requestQueue();
	});

	$('.queuePanel .panel-max').bind('click', function(){
		if($('.resize_target').hasClass('max')){
			$('.resize_target').removeClass('max');
			$('.resize_target').addClass('min');
			$('.topolotyPanel .panel-max').find('i').switchClass('icon-size-actual','icon-size-fullscreen');
			$('.topolotyPanel').show();
		}else{
			$('.resize_target').removeClass('min');
			$('.resize_target').addClass('max');
			$('.topolotyPanel .panel-max').find('i').switchClass('icon-size-fullscreen','icon-size-actual');
			$('.topolotyPanel').hide();
		}
		requestTopology();
		requestQueue();
	});*/

	var d = setInterval(connectCheker, 10000);
});

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

var sub1;
var sub2;
var intervalId1;
var intervalId2;
var socket;
function connect(type) {
	try{
		socket = new SockJS(wsUrl);
		stompClient = Stomp.over(socket);
		stompClient.connect('', '', function(frame) {
			//drawTopologyChart();
			///console/request/topology
			sub1 = stompClient.subscribe(response+'/topologyChart', topologyChartCallback);
			sub2 = stompClient.subscribe(response+'/queueChart', queueChartCallback);
			requestTopology();
			requestQueue();
		});
	}catch(e){
		alert('서버 연결 실패');
	}
}

function connectCheker() {
	if(socket.readyState != 1){
		//console.log('WebSocket ReConnect!')
		connect('RECONNECT');
	}else{
		//console.log('WebSocket Connect!')
	}
}

var topologyChart;
function requestTopology(){
	stompClient.send('/console/request/topology/topologyChart', {}, {});
}
function requestQueue(){
	stompClient.send('/console/request/topology/queueChart', {}, {});
}

function topologyChartCallback(message){
 	var body = JSON.parse(message.body);
 	var topologyChartData = JSON.parse(body.chartData);
 	itemPosition = JSON.parse(body.positionCn);
 	var topologyChartEdgeData = JSON.parse(body.edgeData);
	var topologyBrush = setTopologyBrush(topologyChartEdgeData);
	drawTopologyChart(topologyChartData, topologyBrush);

}

function setTopologyBrush(edgeData){
	topologyBrush = {
       type: "topologynode",
       nodeText: function(data) {
           if(data.type == "agent") {
               return "{server1}";
           } else if(data.type == "relay") {
               return "{line-separate}";
           } else if(data.type == "partner") {
				return "{dashboard}";
           } else if(data.type == "hbase") {
               return "{document}";
           } else if(data.type == "db") {
               return "{db}";
           } else if(data.type == "http") {
               return "{cloud}";
           } else if(data.type == "ftp") {
               return "{arrow2}";
           }
       },
       colors : function(value, key) {
	     	return value.color;
	   },
       nodeTitle: function(data) {
           return data.name;
       },
       nodeScale: function(data) {
    	   if(data.type=='agent' || data.type == 'relay'){
    		   return 2;
    	   }
    	   return 1;
       },
       edgeData: edgeData,
       edgeText: function(data, align) {
			var text = data.time+'ms';

			if(align == "end") {
				text = "← " + text;
			} else {
				text = text+ " →";
			}

			return text;
		},
		edgeOpacity: function(data) {
			if(data.time > 1000) {
				return 1;
			}

			return 0.75;
		}
	}
	return topologyBrush;
}

function drawTopologyChart(topologyChartData, topologyBrush){
	if(topologyChart != undefined){
		topologyChart.removeBrush();
		topologyChart.addBrush(topologyBrush);
		/*
 		topologyChart.removeWidget();
  		topologyChart.addWidget({
			type: "topologyctrl",
		    zoom: false,
		    move: true
		}); */
		topologyChart.axis(0).data = topologyChartData;
		topologyChart.render(true);
	}else{
		topologyChart = chart("#topologyArea", {
			theme : "dark",
		    icon: {
		        type: "jennifer",
		        path: [
		            "/assets/global/plugins/jui/img/icon/icomoon.eot",
		            "/assets/global/plugins/jui/img/icon/icomoon.svg",
		            "/assets/global/plugins/jui/img/icon/icomoon.ttf",
		            "/assets/global/plugins/jui/img/icon/icomoon.woff"
		        ]
		    },
		    style : {
		    	//topologyEdgeColor : "white",
		    	topologyEdgeWidth : 2
		    },
		    padding: 10,
		    axis: {
		        c: {
		            type: "topologytable"
		            ,sort: "topology.custom.sort"

		        },
		        data: topologyChartData
		    },
		    brush: topologyBrush,
		    event: {
		        	"topology.nodeclick": function(data, e) {
		            	console.log("topology.nodeclick ---------------------");
		        	},
		        	"topology.dragstop": function(data, e) {

		        		var ID = "TPLG_CHART";
						var top = e.chartX;
						var left = e.chartY;
						if(itemPosition == null || itemPosition == ""){
							itemPosition = {};
						}
						itemPosition[data.data.key] = {
							x : top
							,y : left
						};

						var data = {
							agentId : ID
							,agentNo : "0"
							,cn : JSON.stringify(itemPosition)
						}

			 			 $.ajax({
							url : '/xhr/agent/config/position',
							method : 'POST',
							data :data,
							success : function(result, resultCode) {

							}
						});
		        	}
		    },
		    widget: {
		        type: "topologyctrl",
		        zoom: false,
		        move: true
		    }
		});
	}
};





var queueChartData;
function queueChartCallback(message){
 	var body = JSON.parse(message.body);
 	//queueChartData = JSON.parse(body.chartData);
 	$('#queueArea').html('');
 	for(i = 0 ; i < body.length;i++){
 		var item = body[i];

		if(item != null){
	 		var agentId = item.key;
	 		var divText = '<div class="row" id="queueItem-'+agentId+'" style="width:200px;;height:100px;float: left;"></div>';
	 		$('#queueArea').append(divText);

	 		var data = [{ data : item.inSize},{ data:item.outSize},{data:item.inOutSize}];
	 		drawQueueChart(agentId, data);
		}
 	}


 	//	topologyChart.axis(0).update(topologyChartData);
// 		topologyChart.render(true);

}

var agentQueueChart;
function drawQueueChart(agentId , data){
	agentQueueChart = chart("#queueItem-"+agentId, {
		theme : "dark",
		padding : {
        	top : 30,
        	left : 40,
        	right : 60,
        	bottom : 20
    	},
	    axis : [{
	        x : {
	            domain : [ "I","O","IO"],
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) {
	                return 30;
	            },
	            step : 3,
	            line : true
	        },
	        data : data
	    }],
	    brush : [{
	        type : "equalizercolumn",
	        target : [ "data"],
	        unit : 5,
	        size:20
	    }],
	    widget : [
	        {
	            type : "title"
	            ,text : agentId
	        }
	        /* , {
	            type : "legend",
	            format : function(key) {
	                 return "Size";
	            }
	        } */
	        , {
	            type : "tooltip",
	            all : true
	        }
	    ]
	});
}
</script>

</body>

</html>
