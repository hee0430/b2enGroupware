<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.message-item:FIRST-CHILD {
	border-top: 1px solid #ECEBEB;
}
</style>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<div class="row" style="margin-top:20px;">
	<div class="col-md-12" style="padding: 0px 0px 0px 0px;">
		<div class="col-md-9" style="padding: 0px 0px 0px 0px;">
			<div class="row">
				<div class="col-lg-3 col-md-12" style="padding-left: 0px;">
					<div class="panel" style="margin-bottom: 15px;">
						<div class="panel-header">
							<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>인터페이스 배포상태</strong></h5>
						</div>
						<div class="panel-content" style="padding-top:30px;height:210px; overflow:auto;margin-bottom:4px;">
							<div class="col-md-12 col-sm-12 count-header link" style="background:#6a5a8c !important;color:white;" onclick="goIntrfcList('배포됨');">
								<div class="row">
									<div class="col-md-7 col-xs-7" style="height:60px;padding-top:5px;"><h4><strong>배포됨</strong></h4></div>
									<div class="col-md-5 col-xs-5" style="height:60px;text-align:right;padding-top:14px;"><h1><strong>${ifCount.intrfcDoneCnt}</strong></h1></div>
								</div>
							</div>
							<div class="col-md-12 col-sm-12 count-header" style="background:white;color:white;">
								<div class="row" style="height:20px;">
								</div>
							</div>
							<div class="col-md-12 col-sm-12 count-header link" style="background:#73716e !important;color:white;" onclick="goIntrfcList('개발중');">
								<div class="row">
									<div class="col-md-7 col-xs-7" style="height:60px;padding-top:5px;"><h4><strong>개발중</strong></h4></div>
									<div class="col-md-5 col-xs-5" style="height:60px;text-align:right;padding-top:14px;"><h1><strong>${ifCount.intrfcTempCnt}</strong></h1></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3" style="padding-left: 0px;">
					<div class="panel" style="margin-bottom: 15px;">
						<div class="panel-header">
							<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>인터페이스 실행상태</strong></h5>
						</div>
						<div class="panel-content" style="padding-top:30px;height:210px;overflow:auto;margin-bottom:4px;">
							<div class="col-md-12 col-sm-12 count-header link" style="background:#6a5a8c !important;color:white;" onclick="goIntrfcList('실행중');">
								<div class="row">
									<div class="col-md-7 col-xs-7" style="height:60px;padding-top:5px;"><h4><strong>실행중</strong></h4></div>
									<div class="col-md-5 col-xs-5" style="height:60px;text-align:right;padding-top:14px;"><h1><strong>${ifCount.intrfcActiveCnt}</strong></h1></div>
								</div>
							</div>
							<div class="col-md-12 col-sm-12 count-header" style="background:white;color:white;">
								<div class="row" style="height:20px;">
								</div>
							</div>
							<div class="col-md-12 col-sm-12 count-header link" style="background:#73716e !important;color:white;" onclick="goIntrfcList('중지됨');">
								<div class="row">
									<div class="col-md-7 col-xs-7" style="height:60px;padding-top:5px;"><h4><strong>중지됨</strong></h4></div>
									<div class="col-md-5 col-xs-5" style="height:60px;text-align:right;padding-top:14px;"><h1><strong>${ifCount.intrfcStopCnt}</strong></h1></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6" style="min-height: 200px; padding-left: 0px;padding-right: 0px;">
					<div class="panel" style="margin-bottom: 15px;">
						<div class="panel-header">
							<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>신규 인터페이스</strong>(최근 7일)</h5>
						</div>
						<div class="panel-content" style="padding-top: 0px; margin-bottom: 10px; height: 204px; overflow: auto;">
							<div id="mCSB_17_container" class="mCSB_container widget-news" style="position: relative; top: 0px; left: 0px;" dir="ltr">
								<c:forEach var="item" items="${ifRecentlyChList}">
									<a href="javascript:goIntrfcList('${item.intrfcId }');" class="message-item media" style="padding-top: 0px;">
										<div class="media">
											<div class="media-body">
												<div>
													<small class="pull-right f-12">${item.updtDt }</small>
													<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">${item.intrfcNm }</h6>
													<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;">${item.intrfcId }</p>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
								<c:if test="${fn:length(ifRecentlyChList) == 0}">
									<!-- <a class="message-item media" style="padding-top: 0px;"> -->
										<div class="media message-item">
											<div class="media-body" style="height:50px;">
												<div>
													<small class="pull-right f-12"></small>
													<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">조회 결과 없음</h6>
													<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;"></p>
												</div>
											</div>
										</div>
									<!-- </a> -->
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-5" style="padding-left: 0px;">
					<div class="panel" style="margin-bottom: 15px;">
						<div class="panel-header" style="padding-bottom: 0px;">
							<h5 style="margin-top: 10px; margin-bottom: 0px;"><i class="icon-pie-chart"></i> <strong>실패 유형</strong>(최근 7일)</h5>
						</div>
						<div class="panel-content" style="height: 240px; padding-top: 0px; padding-bottom: 0px;">
							<div class="col-md-12" id="errorPatternDonut" style="height: 240px;padding:  0px 0px 0px 0px;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-7" style="padding-left: 0px; padding-right: 0px;">
					<div class="panel" style="margin-bottom: 15px;">
						<div class="panel-header" style="padding-bottom: 0px;">
							<h5 style="margin-top: 10px; margin-bottom: 0px;"><i class="icon-bar-chart"></i> <strong>트랜잭션 추이</strong></h5>
						</div>
						<div class="panel-content" style="height: 240px; padding-top: 0px;">
							<div class="col-md-12" id="sevenDayChart" style="height: 240px;padding:  0px 0px 0px 0px;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-5" id="interfaceCount" style="min-height: 200px; padding-left: 0px;">
					<div class="panel" style="margin-bottom:10px;">
						<div class="panel-header">
							<h5 style="margin-top:10px;"><i class="icon-list"></i> <strong>실패 인터페이스 TOP 5</strong>(최근 7일)</h5>
						</div>
						<div class="panel-content" style="height: 160px; overflow: auto; padding-top: 0px; margin-bottom: 10px;">
							<div id="mCSB_17_container" class="mCSB_container widget-news" style="position: relative; top: 0px; left: 0px;" dir="ltr">

								<c:if test="${fn:length(ifErrorCntList) == 0}">
									<a class="message-item media" style="padding-top: 0px;">
										<div class="media">
											<div class="media-body" style="height:50px;">
												<div>
													<small class="pull-right f-12"></small>
													<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">조회 결과 없음</h6>
													<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;"></p>
												</div>
											</div>
										</div>
									</a>
								</c:if>							
								<c:forEach var="item" items="${ifErrorCntList}">
									<a href="javascript:goTransactionList(1, '${item.intrfcId }')" class="message-item media" style="padding-top: 0px;">
										<div class="media">
											<div class="media-body" style="height:50px;">
												<div>
													<small class="pull-right f-12">${item.cnt}</small>
													<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">${item.intrfcNm }</h6>
													<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;">${item.intrfcId }</p>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-7" style="padding-left: 0px; padding-right: 0px;">
					<div class="panel" style="margin-bottom:10px;">
						<div class="panel-header">
							<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>트랜잭션 변화량 TOP 5</strong></h5>
						</div>
						<div class="panel-content" style="height: 160px; padding-top: 0px; margin-bottom: 10px;overflow: auto;">
							<div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">
								<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
									<div id="mCSB_17_container" class="mCSB_container widget-news" style="position: relative; top: 0px; left: 0px;" dir="ltr">
										<h6 style="text-align: center;">증가</h6>
										<c:forEach var="item" items="${increaseList}">
											<a href="javascript:goTransactionList(2, '${item.intrfcId}')" class="message-item media" style="padding-top: 0px;">
												<div class="media">
													<div class="media-body" style="height:50px;">
														<div>
															<small class="pull-right f-12">${item.perText}%</small>
															<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">${item.intrfcNm }</h6>
															<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;">${item.intrfcId }</p>
														</div>
													</div>
												</div>
											</a>
										</c:forEach>
										<c:if test="${fn:length(increaseList) == 0}">
											<a class="message-item media" style="padding-top: 0px;">
												<div class="media">
													<div class="media-body" style="height:50px;">
														<div>
															<small class="pull-right f-12"></small>
															<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">조회 결과 없음</h6>
															<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;"></p>
														</div>
													</div>
												</div>
											</a>
										</c:if>
									</div>
								</div>
								<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
									<div id="mCSB_17_container" class="mCSB_container widget-news" style="position: relative; top: 0px; left: 0px;" dir="ltr">
										<h6 style="text-align: center;">감소</h6>
										<c:forEach var="item" items="${decreaseList}">
											<a href="javascript:goTransactionList(2, '${item.intrfcId}')" class="message-item media" style="padding-top: 0px;">
												<div class="media">
													<div class="media-body" style="height:50px;">
														<div>
															<small class="pull-right f-12">${item.perText}%</small>
															<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">${item.intrfcNm}</h6>
															<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;">${item.intrfcId}</p>
														</div>
													</div>
												</div>
											</a>
										</c:forEach>
										<c:if test="${fn:length(decreaseList) == 0 }">
											<a class="message-item media" style="padding-top: 0px;">
												<div class="media">
													<div class="media-body" style="height:50px;">
														<div>
															<small class="pull-right f-12"></small>
															<h6 class="c-dark" style="margin-top: 8px; margin-bottom: 2px;">조회 결과 없음</h6>
															<p class="f-12 c-gray" style="margin-top: 2px; margin-bottom: 5px; height: 20px;"></p>
														</div>
													</div>
												</div>
											</a>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3" style="padding-right: 0px;">
			<div class="col-md-12" style="min-height: 400px;padding-right: 0px;">
				<div class="panel" style="margin-bottom: 15px;">
					<div class="panel-header">
						<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>인터페이스 분류</strong></h5>
					</div>
					<div class="panel-content" style="padding-top: 4px; margin-bottom: 10px; height: 433px; overflow: auto;">
						<div id="mCSB_17_container" class="mCSB_container widget-news" style="position: relative; top: 0px; left: 0px;" dir="ltr">
							<c:forEach var="item" items="${ifCountBySystem}">							
								<h6><strong>${item.key}</strong></h6>
								<div class="col-lg-12" style="padding-left:20px;">
									<div class="bd-gray">
										<address>
										<c:forEach var="item" items="${item.value}">
										<a class="message-item media link" style="padding-top: 0px;" onclick="goCtgry('${item.lv1CtgrySeq}', '${item.lv2CtgrySeq}');">
											<div class="media">
												<div class="media-body" style="height:24px;">
														<small class="pull-right f-12">${item.intrfcCnt}</small>
													<div>
														<h6 class="c-dark" style="margin-top: 5px; margin-bottom: 5px;">${item.lv2CtgryNm}</h6>
													</div>
												</div>
											</div>
										</a>
										</c:forEach>
										</address>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12" style="padding-right:0px;">
				<div class="panel" style="margin-bottom:10px">
					<div class="panel-header">
						<h3><i class="icon-list"></i><strong>자료실</strong></h3>
					</div>
					<div class="panel-content" style="margin-bottom:0px;height:222px;overflow: auto;padding-top: 0px;">
						<ul class="todo-list ui-sortable">
							<li class="high">
								<span class="todo-task">사용자 매뉴얼</span>
								<div class="todo-date clearfix">
									<div class="completed-date"></div>
								</div>
								<div class="todo-tags pull-right">
									<div class="label label-success"><span onclick="download('a')">다운로드</span></div>
								</div>
							</li>
							<li class="high"><!-- class="medium" class="low" -->
								<span class="todo-task">설치확인서</span>
								<div class="todo-date clearfix">
									<div class="completed-date"></div>
								</div>
								<div class="todo-tags pull-right">
									<div class="label label-success"><span onclick="download('b')">다운로드</span></div>
								</div>
							</li>
							<li class="high"><!-- class="medium" class="low" -->
								<span class="todo-task">알람 전송 모듈 샘플</span>
								<div class="todo-date clearfix">
									<div class="completed-date"></div>
								</div>
								<div class="todo-tags pull-right">
									<div class="label label-success"><span onclick="download('c')">다운로드</span></div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- CHART -->
<script src="/assets/global/plugins/jui/lib/core.js"></script>
<script src="/assets/global/plugins/jui/lib/chart.js"></script>
<script src="/assets/global/plugins/countup/countUp.min.js"></script> <!-- Animated Counter Number -->
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script type="text/javascript">
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

	$(document).ready(function() {
		drawErrorPatternDonut();
		sevenDayChart();
	});

	var errorPatternDonut;
	function drawErrorPatternDonut() {
		var dataMap;
		dataMap = '${exceptionPattern}';
		errorPatternDonut = jui.include("chart.builder");
		errorPatternDonut("#errorPatternDonut", {
			padding : 20,
			axis : {
				data : [JSON.parse(dataMap)]
			},
			style : {
				pieTotalValueFontColor : "#000"
			},
			brush : {
				type : "donut"
				,showValue : true
				,size : 50
				,format : function(k, v) {
					return k + '(' + v + ')';
				}
				,colors : ["#FE7F2D","#FCCA46","#233D4D","#A1C181","#579C87"]
				,dx : -60 // 중앙부터 시작, -면 왼쪽으로 이동, +면 오른쪽으로 이동
			},
			widget : [
				{
					type : "legend"
					, orient : "right"
					, filter : false
					,format : function(data, dataArray) {
						return data + "(" + dataArray[0][data] + ")";
					},
					dx : -30 // orient 기준, -면 왼쪽으로 이동, +면 오른쪽으로 이동
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
			}
			]
		});
	}

	var transactionColumnChart;
	var transactionColumnChartData = [];

	function sevenDayChart() {
		transactionColumnChartData = JSON.parse('${sevenDayChart}');

		var builder = jui.include("chart.builder");
		try {
			transactionColumnChart = builder("#sevenDayChart",  {
			    axis : [{
			        x : {
			            domain : "date",
			            line : true
			        },
			        y : {
			            type : "range",
			            domain : function(data){
			            	//성공 (Y축) 값이 모두 0일때 차트 라이브러리에서 오류가 발생함. 0 이면 축의 domain 값을 1로 고정함
			            	return data.성공 == 0 ? 1 : data.성공;
			            },
			            step : 5,
			            color : "#18a689"
			        },
			        data : transactionColumnChartData
			    }, {
			        x : {
			            hide : true
			        },
			        y : {
			            type : "range",
			            domain : function(data){
			            	//실패 (Y축) 값이 모두 0일때 차트 라이브러리에서 오류가 발생함. 0 이면 축의 domain 값을 1로 고정함
			            	return data.실패 == 0 ? 1 : data.실패;
			            },
			            step : 5,
			            color : "#FF5001",
			            orient : "right"
			        },
			        extend : 0
			    }],
			    brush : [{
			        type : "line", target : "성공", axis : 0, colors : [ "#18a689" ]
			    }, {
			        type : "line", target : "실패", axis : 1, colors : [ "#FF5001" ]
			    }, {
			        type : "scatter", target : "성공", axis : 0, colors : [ "#18a689" ], symbol : "circle", size: 7
			    }, {
			        type : "scatter", target : "실패", axis : 1, colors : [ "#FF5001" ], symbol : "circle", size: 7
			    }],
			    widget : [
			        { type : "legend", brush : [ 0, 1 ] }
			        ,{ type : "tooltip", brush : [ 2, 3 ] }
			    ]
			});
		} catch (e) {

		}
	}

	function goIntrfcList(intrfcId) {
		var url = '/route/interfaceConfigList';

		$.ajax({
			url : '/xhr/route/saveIntrfcIdToSession/' + intrfcId,
			method : 'POST',
			success : function(result, resultCode) {
				document.location.href = url;
			}
		});
	}

	function goTransactionList(type, intrfcId) {
		var url = '/monitoring/transactionList';
		var searchEnd = '${searchEnd}' + ' 23:59';
		var searchStartOneDay = '${searchStartOneDay}' + ' 00:00';
		var searchStartSevenDay = '${searchStartSevenDay}' + ' 00:00';

		var form = document.createElement('form');
		form.name = "summaryForm";
		form.method = "POST";
		form.action = url;

		var iSearchStart = document.createElement('input');
		iSearchStart.name = "searchStart";
		iSearchStart.type = "hidden";

		var iSearchEnd = document.createElement('input');
		iSearchEnd.name = "searchEnd";
		iSearchEnd.type = "hidden";

		var iIntrfcId = document.createElement('input');
		iIntrfcId.name = "intrfcId";
		iIntrfcId.type = "hidden";
		iIntrfcId.value = intrfcId;

		iSearchEnd.value = searchEnd;
		if (type == 1) {
			var iProcessSttus = document.createElement('input');
			iProcessSttus.name = "processSttus";
			iProcessSttus.type = "hidden";
			iProcessSttus.value = "E";
			form.appendChild(iProcessSttus);

			iSearchStart.value = searchStartSevenDay;
		} else if (type == 2) {
			iSearchStart.value = searchStartOneDay;
		}

		form.appendChild(iSearchStart);
		form.appendChild(iSearchEnd);
		form.appendChild(iIntrfcId);
		document.body.appendChild(form);

		form.submit();
	}

	function deleteEventItem(o){
		$(o).parent().parent().remove();
	}
	
	function download(se){
		$.fileDownload('/xhr/console/download/'+se, {})
		.done(function () { alert('File download a success!'); })
		.fail(function () { alert('File download failed!'); });
	}
	
	
	function goCtgry(tabIndex, lv2CtgrySeq){
		$.getJSON('/standard/categoryManage/save/'+tabIndex, function(data, status){			
			document.location.href = '/standard/categoryManage';	
		});
	}
	
</script>
</html>