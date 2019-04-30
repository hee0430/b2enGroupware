<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.dayItem{
	float: none;
    text-align: right;
    padding :2px;
}
.dayItem_title{
	float: none;
    text-align: center;
    padding :2px;
}

</style>
<div class="row">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-12 portlets">
				<div class="title">
					<h2>에이전트 자원사용 통계</h2>
				</div>
				<div class="panel">
					<div class="panel-header">
					</div>
					<div class="panel-content">
						<ul class="nav nav-tabs" style="border-bottom: 0px solid #ddd;">
							<li class="active"><a href="#tab1" data-toggle="tab">시간별</a></li>
							<li class=""><a href="#tab2" data-toggle="tab">일별</a></li>
							<li class=""><a href="#tab3" data-toggle="tab">월별</a></li>
						</ul>
						<div class="tab-content" style="border-top: 0px solid #dfdfdf;">
							<div class="tab-pane fade active in" id="tab1">
								<div class="row">
									<form name="form01" id="form01" action="/statistics/resource" method="post">
									<input type="hidden" name="tabIndex" value="1">
									<div class="row pull-right" style="margin-right: 15px;">
											<div class="col-md-1" style="width:150px;padding-left:5px;padding-right:5px;">
												<label>에이전트</label>
												<select class="form-control" name="agent" id="agent">
													<c:forEach  var="item" items="${agentList}">
													<c:set var="tmpAgent" value="${item.agentId}-${item.agentNo}"></c:set>
													<option value="${tmpAgent}" <c:if test="${agent eq tmpAgent }">selected</c:if>>${tmpAgent}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1" style="width:100px;padding-left:5px;padding-right:5px;">
												<label>연</label>
												<select class="form-control" name="year" id="year">
													<c:forEach  var="item" items="${yearList}">
													<option value="${item}" <c:if test="${hourData.year eq item }">selected</c:if>>${item}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1" style="width:80px;padding-left:5px;padding-right:5px;">
												<label>월</label>
												<select class="form-control" name="month" id="month">
													<c:forEach var="item" begin="1" end="12" step="1">
													<option value="${item }" <c:if test="${hourData.month eq item }">selected</c:if>>${item }</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1" style="width:80px;padding-left:5px;padding-right:5px;">
												<label>일</label>
												<select class="form-control" name="day" id="day">
													<c:forEach var="item" begin="1" end="${hourData.lastDay}" step="1">
														<option value="${item }" <c:if test="${hourData.day eq item }">selected</c:if>>${item }</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1" style="margin-bottom:25px;margin-right:0px;padding-left:5px;padding-right:0px;top:25px;width:230px;">
												<button type="button" class="dt-button btn btn-dark searchData1" style="margin-right:5px">검색</button>
												<button type="button" class="dt-button btn btn-white excelDownload"><span><i class="fa fa-download"></i>다운로드</span></button>
											</div>
									</div>
									</form>
								</div>
								<div class="row" style="overflow-y: auto;">
									<table class="table table-hover" style="width:2570px;">
										<thead>
											<tr>
												<th style="text-align:center;width:90px;"></th>
												<th style="text-align:center;width:90px;"></th>
											    <th style="text-align:center;width:90px;"></th>
											    <c:forEach begin="0" end="23" var="idx">
											    	<th class="dayItem_title" style="text-align:right;width:100px;">${idx}</th>
											    </c:forEach>
											</tr>
										</thead>
										<tbody>
										<c:forEach  var="agentItem" items="${hourData.list}">
										<tr>
											<td class="dayItem_title" rowspan="2">CPU<br/>(%)</td>
											<td class="dayItem_title">시스템</td>
											<td>
												<div>
													<div class="dayItem_title">평균</div>
													<div class="dayItem_title">최대</div>
												</div>
											</td>
											<c:forEach  var="item" items="${agentItem.value}">
												<td style="text-align:right">
													<div class="dayItem"><fmt:formatNumber value="${item.sysCpu}" pattern="#,##0.0" /></div>
													<div class="dayItem"><fmt:formatNumber value="${item.peakSysCpu}" pattern="#,##0.0" /></div>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<td class="dayItem_title">VM</td>
											<td class="dayItem_title">
												<div>
													<div class="dayItem_title">평균</div>
													<div class="dayItem_title">최대</div>
												</div>
											</td>
											<c:forEach  var="item" items="${agentItem.value}">
												<td style="text-align:right">
													<div class="dayItem"><fmt:formatNumber value="${item.vmCpu}" pattern="#,##0.0" /></div>
													<div class="dayItem"><fmt:formatNumber value="${item.peakVmCpu}" pattern="#,##0.0" /></div>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<td class="dayItem_title" rowspan="2">메모리<br/>(GB)</td>
											<td class="dayItem_title">시스템</td>
											<td>
												<div>
													<div class="dayItem_title">평균</div>
													<div class="dayItem_title">최대</div>
												</div>
											</td>
											<c:forEach  var="item" items="${agentItem.value}">
												<td style="text-align:right">
													<div class="dayItem"><fmt:formatNumber value="${item.sysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
													<div class="dayItem"><fmt:formatNumber value="${item.peakSysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<td class="dayItem_title">VM</td>
											<td>
												<div>
													<div class="dayItem_title">평균</div>
													<div class="dayItem_title">최대</div>
												</div>
											</td>
											<c:forEach  var="item" items="${agentItem.value}">
												<td style="text-align:right">
													<div class="dayItem"><fmt:formatNumber value="${item.vmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
													<div class="dayItem"><fmt:formatNumber value="${item.peakVmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<td class="dayItem_title">디스크<br/>(GB)</td>
											<td class="dayItem_title"></td>
											<td class="dayItem_title">
												<div>
													<div class="dayItem_title">평균</div>
													<div class="dayItem_title">최대</div>
												</div>
											</td>
											<c:forEach  var="item" items="${agentItem.value}">
												<td style="text-align:right">
													<div class="dayItem"><fmt:formatNumber value="${item.disk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
													<div class="dayItem"><fmt:formatNumber value="${item.peakDisk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
												</td>
											</c:forEach>
										</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="tab2">
								<div class="row">
									<form name="form02" id="form02" action="/statistics/resource" method="post">
										<input type="hidden" name="tabIndex" value="2">
										<div class="row pull-right" style="margin-right: 15px;">
										<div class="col-md-1" style="width:150px;padding-left:5px;padding-right:5px;">
											<label>에이전트</label>
											<select class="form-control" name="agent" id="agent">
												<c:forEach  var="item" items="${agentList}">
												<c:set var="tmpAgent" value="${item.agentId}-${item.agentNo}"></c:set>
												<option value="${tmpAgent}" <c:if test="${agent eq tmpAgent }">selected</c:if>>${tmpAgent}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-md-1" style="width:100px;padding-left:5px;padding-right:5px;">
											<label>연</label>
											<select class="form-control" name="year" id="year">
												<c:forEach  var="item" items="${yearList}">
												<option value="${item }"  <c:if test="${dayData.year eq item }">selected</c:if>>${item }</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-md-1" style="width:80px;padding-left:5px;padding-right:5px;">
											<label>월</label>
											<select class="form-control" name="month" id="month">
												<c:forEach var="item" begin="1" end="12" step="1">
												<option value="${item }" <c:if test="${dayData.month eq item }">selected</c:if>>${item }</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-md-1" style="margin-bottom:25px;margin-right:0px;padding-left:5px;padding-right:0px;top:25px;width:230px;">
											<button type="button" class="dt-button btn btn-dark searchData2" style="margin-right:5px">검색</button>
											<button type="button" class="dt-button btn btn-white excelDownload"><span><i class="fa fa-download"></i>다운로드</span></button>
										</div>
									</div>
									</form>


								</div>
								<div class="row">
								<table class="table table-hover" style="width:3270px;">
									<thead>
										<tr>
											<th style="text-align:center;width:90px;"></th>
											<th style="text-align:center;width:90px;"></th>
										    <th style="text-align:center;width:90px;"></th>
										    <c:forEach  begin="1" end="${dayData.lastDay}" var="idx">
										    	<th class="dayItem_title" style="text-align:right;width:100px;">${idx}</th>
										    </c:forEach>
										</tr>
									</thead>
									<tbody>
									<c:forEach  var="agentItem" items="${dayData.list}">
									<tr>
										<td class="dayItem_title" rowspan="2">CPU<br/>(%)</td>
										<td class="dayItem_title">시스템</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.sysCpu}" pattern="###.#" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakSysCpu}" pattern="###.#" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">VM</td>
										<td class="dayItem_title">
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.vmCpu}" pattern="#,##0.0" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakVmCpu}" pattern="#,##0.0" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title" rowspan="2">메모리<br/>(GB)</td>
										<td class="dayItem_title">시스템</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.sysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakSysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">VM</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.vmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakVmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">디스크<br/>(GB)</td>
										<td class="dayItem_title"></td>
										<td class="dayItem_title">
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.disk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakDisk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
											</td>
										</c:forEach>
									</tr>
									</c:forEach>
									</tbody>
								</table>
								</div>
							</div>
							<div class="tab-pane fade" id="tab3">
								<div class="row">
									<form name="form03" id="form03" action="/statistics/resource" method="post">
									<input type="hidden" name="tabIndex" value="3">
									<div class="row pull-right" style="margin-right: 15px;">
										<div class="col-md-1" style="width:150px;padding-left:5px;padding-right:5px;">
											<label>에이전트</label>
											<select class="form-control" name="agent" id="agent">
												<c:forEach  var="item" items="${agentList}">
												<c:set var="tmpAgent" value="${item.agentId}-${item.agentNo}"></c:set>
												<option value="${tmpAgent}" <c:if test="${agent eq tmpAgent }">selected</c:if>>${tmpAgent}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-md-1" style="width:100px;padding-left:5px;padding-right:5px;">
											<label>연</label>
											<select class="form-control" name="year" id="year">
												<c:forEach  var="item" items="${yearList}">
												<option value="${item}" <c:if test="${monthData.year eq item }">selected</c:if>>${item}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-md-1" style="margin-bottom:25px;margin-right:0px;padding-left:5px;padding-right:0px;top:25px;width:230px;">
											<button type="button" class="dt-button btn btn-dark searchData3" style="margin-right:5px">검색</button>
											<button type="button" class="dt-button btn btn-white excelDownload"><span><i class="fa fa-download"></i>다운로드</span></button>
										</div>
									</div>
									</form>
								</div>
								<div class="row">
								<table class="table table-hover" style="">
									<thead>
										<tr>
											<th style="text-align:center;width:90px;"></th>
											<th style="text-align:center;width:90px;"></th>
										    <th style="text-align:center;width:90px;"></th>
										    <c:forEach begin="1" end="12" var="idx">
										    	<th class="dayItem_title" style="text-align:right;width:100px;">${idx}</th>
										    </c:forEach>
										</tr>
									</thead>
									<tbody>
									<c:forEach  var="agentItem" items="${monthData.list}">
									<tr>
										<td class="dayItem_title" rowspan="2">CPU<br/>(%)</td>
										<td class="dayItem_title">시스템</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.sysCpu}" pattern="#,##0.0" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakSysCpu}" pattern="#,##0.0" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">VM</td>
										<td class="dayItem_title">
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.vmCpu}" pattern="#,##0.0" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakVmCpu}" pattern="#,##0.0" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title" rowspan="2">메모리<br/>(GB)</td>
										<td class="dayItem_title">시스템</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.sysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakSysMemory/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalSysMemory/1024/1024/1024}" pattern="#,###" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">VM</td>
										<td>
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.vmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakVmMemory/1024/1024/1024}" pattern="#,##0.0" /> / <fmt:formatNumber value="${item.totalVmMemory/1024/1024/1024}" pattern="#,##0.0" /></div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<td class="dayItem_title">디스크<br/>(GB)</td>
										<td class="dayItem_title"></td>
										<td class="dayItem_title">
											<div>
												<div class="dayItem_title">평균</div>
												<div class="dayItem_title">최대</div>
											</div>
										</td>
										<c:forEach  var="item" items="${agentItem.value}">
											<td style="text-align:right">
												<div class="dayItem"><fmt:formatNumber value="${item.disk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
												<div class="dayItem"><fmt:formatNumber value="${item.peakDisk/1024/1024/1024}" pattern="#,###" /> / <fmt:formatNumber value="${item.totalDisk/1024/1024/1024}" pattern="#,###" /></div>
											</td>
										</c:forEach>
									</tr>
									</c:forEach>
									</tbody>
								</table>
								</div>
							</div>
						</div>
						<div>
							<div class="row">
								<div class="col-md-12" id="cpuChart" style="height:300px;"></div>
							</div>
							<div class="row">
								<div class="col-md-12" id="memoryChart" style="height:300px;"></div>
							</div>
							<div class="row">
								<div class="col-md-12" id="diskChart" style="height:300px;"></div>
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
var selectedTab = "${tabIndex}";

$(document).ready(function() {
	$('.searchData1').bind('click', function(){
		form01.submit();
	});
	$('.searchData2').bind('click', function(){
		form02.submit();
	});
	$('.searchData3').bind('click', function(){
		form03.submit();
	});
	$('.excelDownload').bind('click', excelDownload);
	$('#month').bind('change', changeDayOption);
	$('#year').bind('change', changeDayOption);

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		var target = $(e.target).attr("href") // activated tab
		if(target == '#tab1'){
			updateChartData(JSON.parse('${hourData.cpuChart}'), JSON.parse('${hourData.memoryChart}'), JSON.parse('${hourData.diskChart}'));
		}else if(target == '#tab2'){
			updateChartData(JSON.parse('${dayData.cpuChart}'), JSON.parse('${dayData.memoryChart}'), JSON.parse('${dayData.diskChart}'));
		}else if(target == '#tab3'){
			updateChartData(JSON.parse('${monthData.cpuChart}'), JSON.parse('${monthData.memoryChart}'), JSON.parse('${monthData.diskChart}'));
		}
	});

	drawCpuChart();
	drawMemoryChart();
	drawDiskChart();

 	//$($('a[data-toggle="tab"]')[eval(selectedTab)-1]).tab('show');

	if(selectedTab == '1'){
		updateChartData(JSON.parse('${hourData.cpuChart}'), JSON.parse('${hourData.memoryChart}'), JSON.parse('${hourData.diskChart}'));
	}else if(selectedTab == '2'){
		updateChartData(JSON.parse('${dayData.cpuChart}'), JSON.parse('${dayData.memoryChart}'), JSON.parse('${dayData.diskChart}'));
	}else if(selectedTab == '3'){
		updateChartData(JSON.parse('${monthData.cpuChart}'), JSON.parse('${monthData.memoryChart}'), JSON.parse('${monthData.diskChart}'));
	}
});

function changeDayOption(){
	var year = $('#year').val();
	var month = $('#month').val();
	var lastDay = ( new Date( year, month, 0) ).getDate();

	var lastIdx = eval(lastDay);
	$('#day').html('')
	for(i = 1 ; i <=lastIdx;i++){
		$('#day').append('<option value="'+i+'">'+i+'</option>"\n');
	}
}

var builder = jui.include("chart.builder");
var cpuChart;
var memoryChart;
var diskChart;
var cpuChartData = [];
var memoryChartData = [];
var diskChartData = [];
var z;
function updateChartData(cpu, memory, disk){
	cpuChartData = cpu;
	memoryChartData = memory;
	diskChartData = disk;

	cpuChart.axis(0).update(cpuChartData);
	cpuChart.render();

	memoryChart.axis(0).update(memoryChartData);
	memoryChart.render();

	diskChart.axis(0).update(diskChartData);
	diskChart.render();

}

function drawCpuChart(){
	try{
		cpuChart  = builder("#cpuChart", {
			theme : "jennifer",
		    padding : {

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
	            		return data.VM == 0 ? 1 : data.VM;
	            	},
            		format : function(value) {
                		return value.toFixed(2);
            		},
	            	step : 10,
	            	color : "gray"
	        	},
	        	data : cpuChartData
		    }],
	 	    brush : [
	 	    	{type : "area",	target : "시스템", colors : ["#DDDDDD"] ,opacity  : 0.8}
		        ,{type : "area",	target : "VM", colors : ["#4caf50"] ,opacity  : 0.8}
		        ,{type : "scatter", target : "시스템", axis : 0, colors : [ "#DDDDDD" ], symbol : "circle", size: 4}
		        ,{type : "scatter", target : "VM", axis : 0, colors : [ "#4caf50" ], symbol : "circle", size: 4}
		    ],
		    widget : [{
		        type : "title",
		        text : "CPU 사용량(%)",
		        dy : 10
		    } ,{
		        type : "tooltip",
		        brush : [2, 3]
		    } ,{
	        	type : "legend",
	        	brush : [0, 1]
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

function drawMemoryChart(){
	try{
		memoryChart  = builder("#memoryChart", {
			theme : "jennifer",
		    padding : {
		    },
		    axis :
			[{
				x : {
	            	domain : "date",
	            	color : "gray"/* ,
	            	type : "range",
	            	step : 12 */
	        	},
	        	y : {
	            	type : "range",
	            	domain: function(data){
	            		return (data.VM할당) ;
	            	},
            		format : function(value) {
                		return value.toFixed(2) ;
            		},
	            	step : 10,
	            	color : "gray"
	        	},
	        	data : memoryChartData
		    }],
	 	    brush : [
	 	    	{type : "area",target : ["VM", "VM할당"],colors : ["#4caf50", "#DDDDDD"],opacity  : 0.8}
		        ,{type : "scatter", target : "VM", axis : 0, colors : [ "#4caf50" ], symbol : "circle", size: 4}
		        ,{type : "scatter", target : "VM할당", axis : 0, colors : [ "#DDDDDD" ], symbol : "circle", size: 4}
		    ],
		    widget : [{
		        type : "title",
		        text : "메모리 사용량(GB)",
		        dy : 10
		    } ,{
		        type : "tooltip"
		        ,brush : [1,2]
		    } ,{
	        	type : "legend"
	        	,brush : [0]
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


function drawDiskChart(){
	try{
		diskChart  = builder("#diskChart", {
			theme : "jennifer",
		    padding : {

		    },
		    axis :
			[{
				x : {
	            	domain : "date",
	            	color : "gray"/* ,
	            	type : "range",
	            	step : 12 */
	        	},
	        	y : {
	            	type : "range",
	            	domain: function(data){
	            		return (data.전체) ;
	            	},
            		format : function(value) {
                		return value.toFixed(2);
            		},
	            	step : 10,
	            	color : "gray"
	        	},
	        	data : diskChartData
		    }],
	 	    brush : [
	 	    	{type : "area",target : ["전체"],colors : ["#DDDDDD"],opacity  : 0.8}
	 	    	,{type : "area",target : ["사용중"],colors : ["#4caf50"],opacity  : 0.8}
		        ,{type : "scatter", target : "전체", axis : 0, colors : [ "#DDDDDD" ], symbol : "circle", size: 4}
		        ,{type : "scatter", target : "사용중", axis : 0, colors : [ "#4caf50" ], symbol : "circle", size: 4}
		    ],
		    widget : [{
		        type : "title",
		        text : "디스크 사용량(GB)",
		        dy : 10
		    } ,{
		        type : "tooltip"
	        	,brush : [2,3]

		    } ,{
	        	type : "legend"
	        	,brush : [0, 1]
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
	var type='7';
	var year = $('#year').val();
	var month = $('#month').val();
	var day = $('#day').val();

	$.fileDownload('/statistics/excel/'+type+'/'+year+'/'+month+'/'+day, {
	}).done(function() {
		alert('Excel download successful');
	}).fail(function() {
		alert('Excel download failed');
	});
}
</script>
</html>