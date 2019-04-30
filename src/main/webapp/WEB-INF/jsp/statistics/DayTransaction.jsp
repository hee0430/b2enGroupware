<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.valueItem{
	float: none;
    text-align: left;
}
.valueItem_c{
	float: none;
    text-align: center;
}
.valueItem_r{
	width:90px;
	float: none;
    text-align: right;
}

</style>
<div class="row">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-12 portlets">
				<div class="title">
					<h2>일별 트랜잭션 통계</h2>
				</div>
				<div class="panel">
					<div class="panel-header">
						<!-- <div class="control-btn">
							<a href="#" class="panel-maximize"><i class="icon-size-fullscreen"></i></a>
							<a href="#" class="panel-toggle"><i class="fa fa-angle-down"></i></a>
						</div> -->
					</div>
					<div class="panel-content">
						<form name="form01" id="form01" action="/statistics/transaction/day" method="post">
							<div class="row pull-right">
								<div class="col-md-1" style="width:100px;padding-left:5px;padding-right:5px;">
									<label>연</label>
									<select class="form-control" name="year" id="year">
										<c:forEach  var="item" items="${yearList}">
										<option value="${item}">${item }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-1" style="width:80px;padding-left:5px;padding-right:5px;">
									<label>월</label>
									<select class="form-control" name="month" id="month">
										<c:forEach var="item" begin="1" end="12" step="1">
										<option value="${item}" <c:if test="${month eq item}">selected</c:if>>${item}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-1" style="margin-bottom:25px;margin-right:0px;padding-left:5px;padding-right:0px;top:25px;width:230px;">
									<button type="button" class="dt-button btn btn-dark searchData" style="margin-right:5px">검색</button>
									<button type="button" class="dt-button btn btn-white excelDownload"><span><i class="fa fa-download"></i>다운로드</span></button>
								</div>
							</div>
						</form>
						<ul class="nav nav-tabs" style="border-bottom: 0px solid #ddd;">
							<li class="active"><a href="#tab1" data-toggle="tab">종합</a></li>
							<li class=""><a href="#tab2" data-toggle="tab">인터페이스별</a></li>
						</ul>
						<div class="tab-content" style="overflow-y: auto;border-top: 0px solid #dfdfdf;">
							<div class="tab-pane fade active in" id="tab1">
								<div class="row">
									<div class="col-md-1" style="width:13%;padding:0px 0px; ">
										<table class="table table-custom">
											<thead>
												<tr>
												    <th colspan="2">　</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td colspan="2">전체</td>
												</tr>
												<tr>
													<td colspan="2">성공</td>
												</tr>
												<tr>
													<td colspan="2">실패</td>
												</tr>
												<tr>
													<td colspan="2">처리량(MB)</td>
												</tr>
												<tr>
													<td rowspan="2"><div style="width:80px;">건수기준<br/>피크</div></td>
													<td><div style="width:60px;">시(hour)</div></td>
												</tr>
												<tr>
													<td>건</td>
												</tr>
												<tr>
													<td rowspan="2">처리량기준<br/>피크</td>
													<td>시(hour)</td>
												</tr>
												<tr>
													<td>MB</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-1" style="overflow-y:auto;width:86%;padding:0px 0px; ">
										<table class="table table-hover" style="width:2325px;">
											<thead>
												<tr>
												    <c:forEach begin="1" end="${lastDay}" var="idx">
												    	<th style="text-align:right;width:75px;">${idx}</th>
												    </c:forEach>
												</tr>
											</thead>
											<tbody>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;"><fmt:formatNumber value="${item.totTrnscCo}" pattern="#,###" /></td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;"><fmt:formatNumber value="${item.totTrnscCo - item.failrTrnscCo}" pattern="#,###" /></td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;"><fmt:formatNumber value="${item.failrTrnscCo}" pattern="#,###" /></td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;">
														<fmt:parseNumber var="tmpsize" value="${item.totDataSize/1024/1024}"></fmt:parseNumber>
														<fmt:formatNumber value="${tmpsize}" pattern="#,##0.0" /></td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right">${item.peakTrnscHour}</td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;"><fmt:formatNumber value="${item.peakTrnscCo}" pattern="#,###" /></td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;">${item.peakDataHour}</td>
													</c:forEach>
												</tr>
												<tr>
													<c:forEach var="item" items="${list}">
														<td style="text-align:right;width:75px;">
														<fmt:parseNumber var="tmpsize2" value="${item.peakDataSize/1024/1024}"></fmt:parseNumber>
														<fmt:formatNumber value="${tmpsize2}" pattern="#,##0.0" />
														</td>
													</c:forEach>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12" id="chart1" style="height:400px;"></div>
								</div>
							</div>
							<div class="tab-pane fade" id="tab2">
								<div class="col-md-1" style="width:21%;padding:0px 0px;overflow-x: hidden;">
									<table class="table table-custom">
										<thead>
											<tr>
											    <th style="text-align:center;" colspan="2">　</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="item" items="${interfaceList}">
										<tr>
											<td style="width:210px;"><div style="width:210px;">${ifMap.get(item.key)}<br>(${item.key})</div></td>
											<td style="width:110px;">
											<div>
												<div class="valueItem_c" style="width:110px;">전체</div>
												<div class="valueItem_c" style="width:110px;">성공</div>
												<div class="valueItem_c" style="width:110px;">실패</div>
												<div class="valueItem_c" style="width:110px;">처리량(MB)</div>
												<div class="valueItem_c" style="width:110px;">row수</div>
											</div>
											</td>
										</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="col-md-1" style="overflow-y:auto;width:79%;padding:0px 0px; ">
									<table class="table table-hover">
										<thead>
											<tr>
											    <c:forEach begin="1" end="${lastDay}" var="idx">
											    	<th class="valueItem_r">${idx}</th>
											    </c:forEach>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="item" items="${interfaceList}">
										<tr>
											<c:forEach  var="innerItem" items="${item.value}">
											<td>
												<div>
													<div class="valueItem_r"><fmt:formatNumber value="${innerItem.totTrnscCo - 0}" pattern="#,###" /></div>
													<div class="valueItem_r"><fmt:formatNumber value="${innerItem.totTrnscCo-innerItem.failrTrnscCo}" pattern="#,###" /></div>
													<div class="valueItem_r"><fmt:formatNumber value="${innerItem.failrTrnscCo - 0}" pattern="#,###" /></div>
													<div class="valueItem_r"><fmt:formatNumber value="${innerItem.totDataSize eq null ? \"0\" : innerItem.totDataSize/1024/1024}" pattern="#,##0.0" /></div>
													<div class="valueItem_r"><fmt:formatNumber value="${innerItem.totRowCo eq null ? \"0\" : innerItem.totRowCo}" pattern="#,###" /></div>
												</div>
											</td>
											</c:forEach>
										</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- CHART -->
<script src="/assets/global/plugins/jui/lib/core.js"></script>
<script src="/assets/global/plugins/jui/lib/chart.js"></script>
<script type="text/javascript">
var resultValue;
var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

$(document).ready(function() {
	$('.searchData').bind('click', function(){
		form01.submit();
	});
	$('.excelDownload').bind('click', excelDownload);

	chart1();
});


var transactionColumnChart;

var transactionColumnChartData = [];

function chart1(){
	transactionColumnChartData = JSON.parse('${chart1}');
	var builder = jui.include("chart.builder");
	try{
		transactionColumnChart  = builder("#chart1", {
			theme : "jennifer",
		    padding : {
		    	left : 80,
		        right : 80
		    },
		    axis :
			[{
				x : {
	            	domain : "date",
	            	color : "gray"
	        	},
	        	y : {
	            	type : "range",
	            	domain: function(data){
	            		return data.전체;
	            	},
            		format : function(value) {
                		return value + "건";
            		},
	            	step : 10,
	            	color : "gray"
	        	},
	        	data : transactionColumnChartData
		    },
			{
	        	x : {
	        		hide: true
	        	},
	        	y : {
	            	domain : function(value){
	            		return value.처리량;
	            	},
            		format : function(value) {
                		return (value/1024/1024).toFixed(1) + " MB";
            		},
	            	color : "gray",
	            	orient : "right"
	        	},
	        	extend : 0
	    	}],
	 	    brush : [{
		        type : "stackcolumn",
		        target : ["실패", "성공"],
		        colors : ["#ff5252","#4caf50"],
		        size : 0,
		        axis : 0
		    },{
		        type : "line",
		        target :  "처리량" ,
		        colors : [ "orange"],
		        axis : 1
		    },{
	        	type : "scatter", target : "처리량", colors : [ "orange" ], symbol : "circle", size: 12, axis : 1
	    	}],
		    widget : [{
		        type : "title",
		        text : "일별 통계",
		        dy : 10
		    } ,{
		        type : "tooltip",
		        /* format : function(data, k) {
		            return '전일';
		        }, */
		        brush : [ 0, 1, 2]
		    } ,{
	        	type : "legend",
	        	brush : [ 0, 1]
			}],
		    style : {
		        gridAxisBorderWidth : 2,
		        titleFontSize : "14px",
		        tooltipBorderColor : "#dcdcdc"
		    }
		});
	}catch(e){

	}
}

function excelDownload() {
	var type= $($('.nav.nav-tabs li')[0]).hasClass('active') ? '2' : '5';
	var year = $('#year').val();
	var month = $('#month').val();
	var day = 1;

	$.fileDownload('/statistics/excel/'+type+'/'+year+'/'+month+'/'+day, {
	}).done(function() {
		alert('Excel download successful');
	}).fail(function() {
		alert('Excel download failed');
	});
}

</script>
</html>