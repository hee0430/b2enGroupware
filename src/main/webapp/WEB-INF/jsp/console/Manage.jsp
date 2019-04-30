<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>콘솔 통합관리</title>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.tooltip-inner {
    min-width: 70px;
}
.widget-infobox .left .circle2::before {
	margin-left : -10px;
	margin-top: -100px;
}

.circle2 {
	display: inline-block;
	height: 48px;
	margin-top: 0;
	padding-top: 12px;
	padding-left: 8px;
	width: 48px;
	border-radius: 50%;
}

.datasource {
	background: #2196F3
}

.partner {
	background: #40C4FF
}

.partner:hover {
	background: #2C89B3
}

.legacy {
	background: #F57C00
}

.activate {
	background:#4caf50;
}

.deactivate {
	background:#ff5252;
}

.component {
	position: absolute;
	width: 300px;
	background: #F9F9F9;
	float: left;
	min-width: 4em;
	min-height: 3em;
	padding: 1em;
	border: 1px solid rgb(200, 200, 200);
	border: 1px solid rgba(0, 0, 0, 0.2);
	border-radius: 16px;
	box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);
	z-index: 2;
}

.component.ds {
	width: 380px;
}

.component.mainItem {
	border-radius: 16px 16px 16px 16px;
}

.progressbarText {
	float: initial;
	font-size: 12px;
	margin-top: 4px;
	margin-left: 1px;
	position: absolute;
	padding-left: 2px;
	font-weight: 500;
}

.menuItem {
	background-color: white;
	height: 30px;
	font-size: small;
	width: 178px;
	border-bottom: 1px solid #c0c0c0;
	padding-top: 5px;
	padding-left: 5px;
	padding-right: 0px;
	cursor: pointer;
}
</style>
</head>
<div class="col-md-12" style="padding:15px;">
	<div class="col-md-3" style="padding-left:0px;">
	<div class="col-md-12" id="CONSOLE" style="top: 0px; left: 0px;padding-left:0px;">
		<div class="component-body col-md-12" style="padding-top: 10px; height: 530px; border-radius: 8px 8px 8px 8px; background: #F9F9F9; border: 1px solid #c0c0c0; box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">
			<div class="row" style="margin: 20px 0px 0px 0px;">
				<div class="widget-infobox">
					<div class="left">
						<i class="fa icon-screen-desktop activate circle2 dragHandle ui-draggable-handle"></i>
					</div>
					<div class="right">
						<div>
							<span class="c-primary pull-left mainItemName">CONSOLE</span>
						</div>
						<div class="txt" style="width: 190px; word-break: break-all;">통합관리콘솔</div>
					</div>
				</div>
			</div>
			<div class="row" style="padding-left: 20px;">
				<h6 style="margin-top: 10px; margin-bottom: 0px">
					<strong>운영상태</strong>
				</h6>
				<div class="col-lg-12">
					<div class="bd-blue">
						<address style="padding-left: 10px">						
							<table style="width: 100%; margin-top: 10px;">
								<tbody>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px;">구동시간</td>
										<td class="f-12 p-l-5">${console.upTime}</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5">운영시간</td>
										<td class="f-12 p-l-5">${console.runTime}</td>
									</tr>
								</tbody>
							</table>
						</address>
					</div>
				</div>
			</div>
			<div class="row" style="padding-left: 20px;">
				<h6 style="margin-top: 0px; margin-bottom: 0px">
					<strong>네트워크</strong>
				</h6>
				<div class="col-lg-12">
					<div class="bd-blue">
						<address style="padding-left: 10px">
							<table style="width: 100%; margin-top: 10px;">
								<tbody>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px;">IP</td>
										<td class="f-12 p-l-5">${console.ip}</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5">HTTP 포트</td>
										<td class="f-12 p-l-5">${console.httpPort}</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5">메시지 포트</td>
										<td class="f-12 p-l-5">${console.brokerPort}</td>
									</tr>
									<%-- <tr class="p-t-10">
										<td class="f-12 p-l-5">관리 포트</td>
										<td class="f-12 p-l-5">${console.jmxPort}</td>
									</tr> --%>
								</tbody>
							</table>
						</address>
					</div>
				</div>
			</div>
			<div class="row" style="padding-left: 20px;">
				<h6 style="margin-top: 0px; margin-bottom: 0px">
					<strong>레파지토리</strong>
				</h6>
				<div class="col-lg-12">
					<div class="bd-blue">
						<address style="padding-left: 10px">
							<table style="width: 100%; margin-top: 10px;">
								<tbody>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px;">Driver</td>
										<td class="f-12 p-l-5">${console.driver}</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5">Url</td>
										<td class="f-12 p-l-5">${console.url}</td>
									</tr>
								</tbody>
							</table>
						</address>
					</div>
				</div>
			</div>
			<div class="row" style="padding-left: 20px;">
				<h6 style="margin-top: 0px; margin-bottom: 0px">
					<strong>자원현황</strong>
				</h6>
				<div class="col-lg-12">
					<div class="bd-blue">
						<address style="padding-left: 10px">
							<table style="width: 100%; margin-top: 10px;">
								<tbody>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px; padding-bottom: 5px;">CPU(전체)</td>
										<td class="f-12 p-l-5" style="padding-bottom: 5px; padding-right: 10px;">
											<div class="progress" id="consolecpuSystem" style="margin-top: 0px; height: 20px; border-radius: 2px;">
												<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius: 2px; width: 0%;"></div>
												<div class="progressbarText f-8"></div>
											</div>
										</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px; padding-bottom: 5px;">CPU(VM)</td>
										<td class="f-12 p-l-5" style="padding-bottom: 5px; padding-right: 10px;">
											<div class="progress" id="consolecpuVm" style="margin-top: 0px; height: 20px; border-radius: 2px;">
												<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius: 2px; width: 0%;"></div>
												<div class="progressbarText f-8"></div>
											</div>
										</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px; padding-bottom: 5px;">메모리(전체)</td>
										<td class="f-12 p-l-5" style="padding-bottom: 5px; padding-right: 10px;">
											<div class="progress" id="consolememorySystem" style="margin-top: 0px; height: 20px; border-radius: 2px;">
												<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius: 2px; width: 0%;"></div>
												<div class="progressbarText f-8"></div>
											</div>
										</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px; padding-bottom: 5px;">메모리(VM)</td>
										<td class="f-12 p-l-5" style="padding-bottom: 5px; padding-right: 10px;">
											<div class="progress" id="consolememoryVm" style="margin-top: 0px; height: 20px; border-radius: 2px;">
												<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius: 2px; width: 0%;"></div>
												<div class="progressbarText f-8"></div>
											</div>
										</td>
									</tr>
									<tr class="p-t-10">
										<td class="f-12 p-l-5" style="width: 80px; padding-bottom: 5px;">디스크</td>
										<td class="f-12 p-l-5" style="padding-bottom: 5px; padding-right: 10px;">
											<div class="progress" id="consoledisk" style="margin-top: 0px; height: 20px; border-radius: 2px;">
												<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius: 2px; width: 0%;"></div>
												<div class="progressbarText f-8"></div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</address>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<div class="col-md-9" style="padding-left:0px;padding-right:0px;">
		<div class="nav-tabs3">
			<ul id="consoleTab" class="nav nav-tabs">
				<li><a href="#tab_1" data-toggle="tab" id="tab1">로그</a></li>
				<li><a href="#tab_2" data-toggle="tab" id="tab2">환경변수</a></li>
			</ul>
			<div class="tab-content"> 
				<div class="tab-pane fade active in" id="tab_1">
					<div class="row">
						<div class="col-md-12" style="height:460px;">
							<div class="col-md-2" style="height:600px;overflow:auto;padding-left:0px;padding-right:0px;" id="consoleTreeView">
							</div>
							<div class="col-md-10" style="padding-right:0px;">
								<div class="col-md-12" style="text-align:right;padding-right:0px;padding-left:0px;">
									<div class="col-md-6" style="text-align:left;padding-right:0px;padding-left:0px;">
										최종수정일시 : <span id="consoleLastMod"></span> / 파일 크기 : <span id="consolefileSize"></span>
									</div>
									<div class="col-md-6" style="text-align:right;padding-right:0px;">
										<span id="consoleReadPer">0</span>%
										<button id="consoleGetMoreLog" type="button" class="btn btn-sm glyphicon glyphicon-arrow-up" style="margin-right: 0px;" disabled="disabled"></button>
										<button id="consoleGetLogFile" type="button" class="btn btn-sm glyphicon glyphicon-download-alt" style="margin-right: 0px;" disabled="disabled"></button>
									</div>
								</div>
								<div class="col-md-12"  style="padding:0px;">
								<textarea id="consoleLogContent" style="width:100%;" rows="21" spellcheck="false"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="tab_2">
					<div class="row">
						<div class="col-md-12" style="height:460px;overflow-y: scroll;">
							<div class="list_wrap">
							<div class="t_line" style="padding-top:1px;"><!-- PointColor --></div>
							<table class="table table-hover" id="consolePropertyList">
								<thead>
									<tr>
										<th style="text-align:center;width:15%">key</th>
										<th style="text-align:center;width:85%">value</th>
									</tr>
								</thead>
							</table>
							</div>						
						</div>
					</div>
				</div>
			</div>
			</div>
	</div>
</div>

<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script src="/assets/global/plugins/jstree/jstree.js"></script>

<script type="text/javascript">
	var intervalId;

	var socketConsolePop;
	var stompClientConsolePop;
	var subConsolePop;

	$(document).ready(function() {
		connectConsolePop();
		$('#consoleTab a[href="#tab_1"]').tab('show');
		
		// 탭 클릭했을때
		$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
			var target = $(e.target).attr("id") // activated tab
			if(target == 'tab1'){
				consoleLogView();
			}
			if(target == 'tab2'){
				getProperty();
			}			
		});

		$('#consoleManage').on('hidden.bs.modal', function () {
			clearInterval(intervalId);
			$('#consoleManage').unbind('hidden.bs.modal');
		});		
		
	});

	function connectConsolePop() {
		try{
			socket1 = new SockJS('/console-ws');
			stompClientConsolePop = Stomp.over(socket1);
			stompClientConsolePop.connect('', '', function(frame) {
				intervalId = setInterval(consoleResourceRequest, 5000);
				subConsolePop = stompClientConsolePop.subscribe('/console/response/console/resource', consoleResourceCallback);
				consoleResourceRequest();
			});
		}catch(e){
			alert('서버 연결 실패');
		}
	}

	function consoleResourceRequest(){
		stompClientConsolePop.send('/console/request/console/resource', {}, {});
	}

	function consoleResourceCallback(message){
		var result = JSON.parse(message.body);
		if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
			$('.resource-error-area').hide();
			var rd = result.data;
			moveProgressChart($('#consolecpuSystem'), rd.cpuSystem, rd.cpuSystem+'%');
			moveProgressChart($('#consolecpuVm'), rd.cpuUser, rd.cpuUser+'%');

			var usedSystemMemory = rd.memorySystemTotal- rd.memorySystemAvailable;
			var memorySystemPer = (usedSystemMemory/rd.memorySystemTotal) * 100;
			var memorySystemText = usedSystemMemory+' MB/'+rd.memorySystemTotal + ' MB'
			moveProgressChart($('#consolememorySystem'), memorySystemPer, memorySystemText);

			var usedHeapMemory = rd.memoryHeapTotal - rd.memoryHeapAvailable;
			var memoryVmPer = (usedHeapMemory/rd.memoryHeapTotal) * 100;
			var memoryVmText = usedHeapMemory+' MB/'+rd.memoryHeapTotal+' MB';
			moveProgressChart($('#consolememoryVm'), memoryVmPer, memoryVmText);

			var diskPer = (rd.diskUse/rd.diskTotal ) * 100;
			var diskText = rd.diskUse+'G/'+rd.diskTotal+'G';
			moveProgressChart($('#consoledisk'), diskPer, diskText);
		}else{
			$('.resource-error-area').show();
		}
	}

	function moveProgressChart(target, percentage, value){
		target.find('.progress-bar').css('width',percentage+'%');
		var targetItem = target.find('.progress-bar')
		target.find('.progressbarText').html(value);

		if(percentage <70){
			targetItem.removeClass('progress-bar-warning');
			targetItem.removeClass('progress-bar-danger');
			targetItem.addClass('progress-bar-success');
		}else if(percentage >= 70){
			targetItem.addClass('progress-bar-warning');
			targetItem.removeClass('progress-bar-success');
			targetItem.removeClass('progress-bar-danger');
		}else if(percentage >= 90){
			targetItem.addClass('progress-bar-danger');
			targetItem.removeClass('progress-bar-success');
			targetItem.removeClass('progress-bar-warning');
		}
	}

	function getProperty(){
		$.ajax({
			url : '/xhr/console/property',
			method :'POST',
			success : function(result, resultCode){
				var table = new TABLE('#consolePropertyList');
				table.removeBody();
				table.addTBody();
				var dataList = result.data;

				for(i = 0;i <dataList.length;i++ ){
					var item = dataList[i];
					var row = table.addRow();
					var colArray = [];

					// 컬럼 텍스트, 정렬, 이벤트 callback
					colArray.push(table.columnItem(item.key, 'left', null));
					colArray.push(table.columnItem(item.value, 'left', null));
					// 테이블 row 객체, 데이터 array, 컬럼 갯수
					table.addColumnArray(row, colArray, 2);
				};
				if(dataList.length == 0){
					var row = table.addRow();
					var colArray = [];
					table.addColumnArray(row, colArray, 2);
				}
			}
		});
	}

	function consoleLogView(){
		$('#consoleLogContent').html('');
		$('#logTargetAgentId').html('');
		var data = {
			operation : 'LIST'
		};

		$.ajax({
			url : '/xhr/console/log',
			method :'POST',
			data : data,
			success : function(result, resultCode){
				if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
					drawConsoleTree(result);
					$('#consoleLastMod').html("");
				}else{
					notification('응답이 없습니다. ');
				}
			}
		});
	}

	var consoleTree;
	function drawConsoleTree(result){
		consoleTree = undefined;
		if(consoleTree != undefined){
			$('#consoleTreeView').jstree().destroy();
		}
		var data = result.data

		for(i=0;i < data.length;i++){
			if(data[i].TYPE =='F'){
				data[i].icon = 'icon-doc';
			}
		}
		consoleTree = $('#consoleTreeView').jstree(
			{
				"core" : {"data" : data}
				//,"contextmenu":{}
			}
		).bind("select_node.jstree", function (event, data) {			
			var type = data.node.original.TYPE;
			if(type == 'F'){
				var fileFullPath = data.node.original.PATH;
				var fileName = data.node.original.NAME;
				getConsoleLogContent(fileFullPath, fileName);
			}
		});
	}

	function getConsoleLogContent(path, fileName, endPos){
		if(endPos == undefined){
			endPos = -1;
		}
		var data = {
			operation : 'CONTENT'
			,filePath : path
			,endPos : endPos
		};

		$.ajax({
			url : '/xhr/console/log',
			method :'POST',
			data : data,
			success : function(result, resultCode){
				$('#getLogFile').attr('disabled', 'disabled');

				var end = result.end;
				var length = result.length;
				var start = result.start;

				if(length == 0){
					$('#consoleReadPer').html("100");
				}else{
					var per = ((length-start) / length) * 100;
					$('#consoleReadPer').html(Math.round(per));
				}
				
				$('#consoleLastMod').html(result.LAST_MOD);
				$('#consolefileSize').html(new Intl.NumberFormat().format(result.length));
				
				if(start > 0){
					$('#consoleGetMoreLog').unbind('click');
					$('#consoleGetMoreLog').removeAttr('disabled');
					$('#consoleGetMoreLog').bind('click', function(){
						var area = $('#consoleLogContent');
						var message = area.html();
						var length = area.html().length;
						var totalByte = 0;
						for(var i =0; i < length; i++) {
							var currentByte = message.charCodeAt(i);
							// 한글은 2자, 그외는 1자를 추가해준다
							if(currentByte > 128) totalByte += 2;
							else totalByte++;
						}
						if(totalByte > 3145728){
							notification('3MB 이상은 미리보기 할수 없습니다. 로그 파일을 다운받아 확인하세요.');
							return false;
						}	
						getConsoleLogContent(path, fileName, start);
					});
				}else{
					$('#consoleGetMoreLog').attr('disabled', 'disabled');
					$('#consoleGetMoreLog').unbind('click');
				}
				if(endPos== -1){
					$('#consoleLogContent').html(result.data);
				}else{
					$('#consoleLogContent').html(result.data + $('#consoleLogContent').html());
				}

				if($('#consoleLogContent').html().length){
					$('#consoleGetLogFile').unbind('click');
					$('#consoleGetLogFile').removeAttr('disabled');
					$('#consoleGetLogFile').bind('click', function(){
						getConsoleLogDownload(path, fileName);
					});
				}
			}
		});
	}

	function getConsoleLogDownload(path, fileName){
		var data = {
			filePath : path
			,fileName : fileName
		};

		$.fileDownload('/xhr/console/logDownload/', {'data' : data})
			.done(function () { alert('File download a success!'); })
    		.fail(function () { alert('File download failed!'); });
	}

	</script>
</html>