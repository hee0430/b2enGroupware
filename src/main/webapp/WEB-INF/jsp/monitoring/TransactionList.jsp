<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
th {
	font-size: 15px;
}
select {
	padding: 3px;
	border: 0;
	border-radius: 0;
}
</style>
<div class="row">
	<div class="col-lg-12">
		<div class="title">
			<h2>트랜잭션 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
				<!-- <div class="control-btn">
					<a href="#" class="panel-maximize"><i class="icon-size-fullscreen"></i></a>
					<a href="#" class="panel-toggle"><i class="fa fa-angle-down"></i></a>
				</div> -->
				<div>
				<form name="searchForm" id="searchForm" method="post">
				<input type="hidden" name="detailTrnscId" id= "detailTrnscId">
				<input type="hidden" name="currentPage" id= "currentPage" value="${searchModel.currentPage }">
				<input type="hidden" name="isPage" id= "isPage" value="N">
				<div class="row">
					<div class="col-md-12" style="padding-top:20px;padding-right:0px;height:auto;">
						<div class="col-md-2" style="padding-left:4px;padding-right:4px;width:250px;">
							<div class="form-group">
								<!-- <label class="form-label">트랜잭션 아이디</label> -->
								<div>
									<input type="text" name="trnscId" id="trnscId" class="form-control" placeholder="트랜잭션 아이디" value="${searchModel.trnscId }" maxlength="50">
								</div>
							</div>
						</div>
						<div class="col-md-2" style="padding-left:4px;padding-right:4px;width:250px;">
							<div class="form-group">
								<!-- <label class="form-label">인터페이스 아이디</label> -->
								<div>
									<input type="text" name="intrfcId" id="intrfcId" class="form-control" placeholder="인터페이스 아이디" value="${searchModel.intrfcId }" maxlength="50">
								</div>
							</div>
						</div>
						<div class="col-md-2" style="padding-left:4px;padding-right:4px;width:250px;">
							<div class="form-group">
								<!-- <label class="form-label">인터페이스명</label> -->
								<div>
									<input type="text" name="intrfcNm" id="intrfcNm" class="form-control" placeholder="인터페이스명" value="${searchModel.intrfcNm }" maxlength="50">
								</div>
							</div>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:150px;">
							<div class="form-group">
								<!-- <label class="form-label">FROM</label> -->
								<div>
									<select class="form-control" name="beginAgent" id="beginAgent">
										<option value="" <c:if test="${searchModel.beginAgent eq ''}">selected</c:if>>전체</option>
										<c:forEach var="item" items="${agentList}">
											<option value="${item.agentId}" <c:if test="${searchModel.beginAgent eq item.agentId}">selected</c:if>>${item.agentId}(${item.agentNm})</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:150px;">
							<div class="form-group">
								<!-- <label class="form-label">TO</label> -->
								<div>
									<select class="form-control" name="endAgent" id="endAgent">
										<option value="" <c:if test="${searchModel.endAgent eq ''}">selected</c:if>>전체</option>
										<c:forEach var="item" items="${agentList}">
											<option value="${item.agentId}" <c:if test="${searchModel.endAgent eq item.agentId}">selected</c:if>>${item.agentId}(${item.agentNm})</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px; width:100px;">
							<div class="form-group">
								<!-- <label class="form-label">처리결과</label> -->
								<div>
									<select class="form-control" name="processSttus" id="processSttus">
										<option value="">전체</option>
										<option value="S" <c:if test="${searchModel.processSttus eq 'S'}">selected</c:if>>성공</option>
										<option value="E" <c:if test="${searchModel.processSttus eq 'E'}">selected</c:if>>실패</option>
										<option value="P" <c:if test="${searchModel.processSttus eq 'P'}">selected</c:if>>처리중</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:195px;">
							<div class="form-group">
								<!-- <label class="form-label">시작일시</label> -->
								<div class="prepend-icon">
									<input type="text" name="searchStart" id="searchStart" class="form-control" placeholder="시작일시" value="${searchStart}">
									<i class="icon-calendar"></i>
								</div>
							</div>
						</div>
						<div class="col-md-3" style="padding-left:4px;padding-right:4px;width:195px;">
							<div class="form-group">
								<!-- <label class="form-label">종료일시</label> -->
								<div class="prepend-icon">
									<input type="text" name="searchEnd" id="searchEnd" class="form-control" placeholder="종료일시" value="${searchEnd}">
									<i class="icon-calendar"></i>
								</div>
							</div>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:85px;">
							<button type="button" class="dt-button btn btn-dark searchData">검색</button>
						</div>
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;">
							<button type="button" class="dt-button btn btn-white" onclick="excel();"><i class="fa fa-download"></i>다운로드</span></button>
						</div>
					</div>
				</div>
				<div class="row" style="">
					<div class="col-md-12">
						<c:if test="${fn:length(categorylv1List) > 0 }">
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:200px;">
							<div class="form-group">
								<select class="form-control" name="categoryLv1" id="categoryLv1" onchange="getCateList('2', this.value);">
									<option value="">전체</option>
									<c:forEach var="lv1Item" items="${categorylv1List }">
										<option value="${lv1Item.ctgrySeq}" <c:if test="${categoryLv1 eq lv1Item.ctgrySeq}">selected="selected"</c:if>>${lv1Item.ctgryNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</c:if>
						<c:if test="${fn:length(categorylv2List) > 0 }">
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:200px;">
							<div class="form-group">
								<select class="form-control" name="categoryLv2" id="categoryLv2" onchange="getCateList('3', this.value);">
									<option value="">전체</option>
									<c:forEach var="lv1Item" items="${categorylv2List }">
										<option value="${lv1Item.ctgrySeq}" <c:if test="${categoryLv2 eq lv1Item.ctgrySeq}">selected="selected"</c:if>>${lv1Item.ctgryNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</c:if>
						<c:if test="${fn:length(categorylv3List) > 0 }">
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:200px;">
							<div class="form-group">
								<select class="form-control" name="categoryLv3" id="categoryLv3" onchange="getCateList('4', this.value);">
									<option value="">전체</option>
									<c:forEach var="lv1Item" items="${categorylv3List }">
										<option value="${lv1Item.ctgrySeq}" <c:if test="${categoryLv3 eq lv1Item.ctgrySeq}">selected="selected"</c:if>>${lv1Item.ctgryNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</c:if>
						<c:if test="${fn:length(categorylv4List) > 0 }">
						<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:200px;">
							<div class="form-group">
								<select class="form-control" name="categoryLv4" id="categoryLv4" onchange="getCateList('5', this.value);">
									<option value="">전체</option>
									<c:forEach var="lv1Item" items="${categorylv4List }">
										<option value="${lv1Item.ctgrySeq}" <c:if test="${categoryLv4 eq lv1Item.ctgrySeq}">selected="selected"</c:if>>${lv1Item.ctgryNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</c:if>
					</div>
				</div>
				</form>
				</div>
			</div>
			<div class="panel-content" style="padding-top:0px;padding-bottom:0px;">
				<div class="filter-left">
					<div class="list_wrap">
					<div class="t_line"><!-- PointColor --></div>
					<table class="table table-hover" id="dataListTable">
						<thead>
							<tr>
							    <th class="text-center" style="width:150px;">트랜잭션 아이디</th>
							    <th class="text-center"></th>
							    <th class="text-center">인터페이스 아이디</th>
							    <th class="text-center">인터페이스명</th>
							    <th class="text-center">FROM</th>
							    <th class="text-center">TO</th>
							    <th class="text-center">결과</th>
							    <th class="text-center" style="width:140px;">목표량</th>
							    <th class="text-center" style="width:120px;">처리시간(ms)</th>
							    <th class="text-center" style="width:160px;">시작일시</th>
							    <th class="text-center" style="width:160px;">종료일시</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="item" varStatus="idx" items="${dataList}">
						<tr>
								<td><p class="ellipsis" style="width:150px;height:20px;margin-bottom:0px;" onclick="copyToClipboard('${item.trnscId}');">${item.trnscId}</p></td>
								<td style="text-align:left;"><i onclick="popTrackingList('${item.trnscId}','${item.targetQy}','${item.intrfcId}')" class="fa fa-search" style="cursor:pointer;" data-rel="tooltip" data-placement="top" data-original-title="상세보기"></i></td>
								<td style="text-align:left;">${item.intrfcId}</td>
								<td style="text-align:left;">${item.intrfcNm}</td>
								<td style="text-align:center;padding-top:4px;padding-bottom:4px;"><button type="button" class="btn btn-sm btn-default" style="width:90px;cursor:pointer;margin-right:0px;" data-rel="tooltip" data-placement="top" onclick="logView('${item.beginAgent}', '1', '${item.intrfcId}');" data-original-title="${item.beginAgentNm}">${item.beginAgent}</button></td>
								<td style="text-align:center;padding-top:4px;padding-bottom:4px;"><button type="button" class="btn btn-sm btn-default" style="width:90px;cursor:pointer;margin-right:0px;" data-rel="tooltip" data-placement="top" onclick="logView('${item.endAgent}', '1', '${item.intrfcId}');" data-original-title="${item.endAgentNm}">${item.endAgent}</button></td>
								<td style="text-align:center;padding-top:4px;padding-bottom:4px;">
									<c:if test="${item.processSttus eq 'S'}"><button type="button" class="btn btn-sm btn-success" style="cursor:default;margin-right:0px;">성공</button></c:if>
									<c:if test="${item.processSttus eq 'P'}"><button type="button" class="btn btn-sm btn-warning" style="cursor:default;margin-right:0px;">진행</button></c:if>
									<c:if test="${item.processSttus eq 'E'}"><button type="button" class="btn btn-sm btn-danger" style="cursor:default;margin-right:0px;">실패</button></c:if>
								</td>
								<td style="text-align:right;">${item.processQyText}</td>
								<td style="text-align:right;"><fmt:formatNumber pattern="#,###" value="${item.processTime}"/></td>
								<td style="text-align:center;">${item.beginDtText}</td>
								<td style="text-align:center;">${item.endDtText}</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(dataList) ==0}">
						<tr>
							<td style="text-align:center;" colspan="11">조회된 데이터가 없습니다. </td>
						</tr>
						</c:if>
						</tbody>
					</table>
					</div>
				</div>
				${pageNavigation}
			</div>
		</div>
	</div>
</div>
	<div class="modal fade" id="trackingListDiv" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-dark">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<i class="icons-office-52"></i>
					</button>
					<h4 class="modal-title">상세정보</h4>
				</div>
				<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;overflow-x:hidden;">
					<div id="basic-preview" class="preview active">
						<div class="alert alert-info media fade in">
						<p><span id="trackingListDiv_trnscId"></span></p>
						</div>
					</div>
					<div class="list_wrap">
					<div class="t_line"><!-- PointColor --></div>
					<table class="table table-hover" id="trackingListContent">
						<thead>
							<tr>
							    <th style="text-align:center;width:60px;">#</th>
							    <th style="text-align:center;width:90px;">에이전트</th>
							    <th style="text-align:center;width:200px;">일시</th>
							    <th style="text-align:center;width:120px;">이벤트</th>
							    <th style="text-align:right;width:100px;">처리량</th>
							    <th style="text-align:center;">비고</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
				<div class="modal-footer" style="padding-top:0px;">
					<button type="button" class="btn btn-primary btn-embossed confirm" onclick="javascript:$('#trackingListDiv').modal('hide')">닫기</button>
				</div>
			</div>
		</div>
	</div>
<div class="modal fade" id="logView" tabindex="-1" role="dialog" aria-hidden="true">
</div>
	<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
	<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
	<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="/assets/global/plugins/jstree/jstree.js"></script>
	<script type="text/javascript">
	$(function () {
		var option = calendarOption;
		$('#searchStart').datetimepicker(option);
		$('#searchEnd').datetimepicker(option);

		$('.searchData').bind('click', doSearch);

		document.onkeydown = fkey;

		function fkey(e) {
			e = e || window.event;
			if(e.keyCode == 13){

				var ae = document.activeElement;
				if(ae.id == 'trnscId'
						|| ae.id == 'intrfcId'
						|| ae.id == 'intrfcNm'
						|| ae.id == 'beginAgent'
						|| ae.id == 'endAgent'
						|| ae.id == 'processSttus'
						|| ae.id == 'searchStart'
						|| ae.id == 'searchEnd'
					){
					doSearch();
				}else{
					return false;
				}
			}
		}
	});

	
	function logView(agentId, agentNo, intrfcId) {
		var data = {
			operation : 'LIST',
			agentId : agentId,
			agentNo : agentNo,
			intrfcId : intrfcId
		};

		$.ajax({
			url : '/xhr/agent/agentLogView',
			method : 'POST',
			data : data,
			success : function(result, resultCode) {
				$('#logView').html(result);
				$('#logTargetAgentId').html(agentId + "-" + agentNo);				
				$('#logView').modal();				
			}
		});
	}
	
	
	function copyToClipboard(element) {
		var $temp = $('<input>');
		$('body').append($temp);
		$temp.val(element).select();
		document.execCommand('copy');
		$temp.remove();
	}

	function goDetail(trnscId){
		/* var form = $('#searchForm');
		$('#detailTrnscId').val(trnscId);
		form[0].action = "/monitoring/transactionDetail";
		form.submit(); */
	}

	function doSearch(){
		var form = $('#searchForm');
		form[0].action = "/monitoring/transactionList";
		form[0].isPage.value="N";
		form.submit();
	}

	function popTrackingList(trnscId, targetQy, intrfcId){
	 	$.ajax({
			url : '/xhr/monitoring/trackingList/'+trnscId + '/' +intrfcId,
			method :'POST',
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				if (eval('result.'+STATUS_KEY) == STATUS_VALUE_OK) {
					//result.transaction
					var table = new TABLE('#trackingListContent');
					table.removeBody();
					table.addTBody();
					var dataList = result.trackingList;

					var processQy = 0;
					for(i = 0;i <dataList.length;i++ ){
						var item = dataList[i];
						var row = table.addRow();
						var colArray = [];

						// 컬럼 텍스트, 정렬, 이벤트 callback
						colArray.push(table.columnItem(i+1, 'center', null));
						colArray.push(table.columnItem(item.agentId +'-'+ item.agentNo, 'center', null));
						colArray.push(table.columnItem(item.eventDt, 'center', null));
						colArray.push(table.columnItem(item.eventTy, 'center', null));
						colArray.push(table.columnItem(item.processQyText, 'right', null));
						colArray.push(table.columnItem(item.eventMssageText, 'center', null));

						/*
						성공/실패 정보를 표시하지 않고, 예외정보 또는 비고정보 표시로 변경

						var text = '실패';
						if(item.eventSttus == 'S'){
							text = '성공'
						}
						// 버튼표시 텍스트, class 이름, 이벤트 callback, pointer 옵션
						var button = makeButton(text, 'btn btn-sm btn-success', null, 'default');

						colArray.push(table.columnItem(button, 'center', null));
						console.log(colArray);
						*/

						// 테이블 row 객체, 데이터 array, 컬럼 갯수
						table.addColumnArray(row, colArray, 6);


						// 개별 처리량 합계 계산
						processQy+=item.processQy;
					};
					if(dataList.length == 0){
						var row = table.addRow();
						var colArray = [];
						table.addColumnArray(row, colArray, 6);
					}

					console.log(result);
					if(result.intrfcTy == 'ROW'){
						$('#trackingListDiv_trnscId').html(trnscId + " (" + processQy + " 건 / " + targetQy + "건)");
					}else{
						var processQyByte = processQy / 1024 / 1024;
						var targetQyByte = targetQy / 1024 / 1024;
						$('#trackingListDiv_trnscId').html(trnscId + " (" + processQyByte.toFixed(1) + " MB / " + targetQyByte.toFixed(1) + " MB)");
					}

					$('#trackingListDiv').modal();
					$('#trackingListDiv').draggable({handle: ".modal-header"});
				} else {

				}
			}
		});
	}

	function makeButton(value, className, eventCallback, cursor){
		var button = document.createElement('button');
		button.className = className;
		button.innerText = value;
		button.onclick = eventCallback;
		button.style.cursor = cursor;
		button.style = "margin-right:0px;";
		return button;
	}

	function getCateList(level, o){
		if(o == ""){
			var levelIndex = eval(level);
			for(levelIndex ; levelIndex <= 5 ; levelIndex++){
				$('#categoryLv'+levelIndex).parent().parent().remove();
			}
		}else{
			if(level != '5'){
				$.ajax({
					url : '/xhr/categoryManage/levelList/'+o+'/'+level,
					method :'POST',
					dataType : 'json',
					contentType: 'application/json',
					success : function(result){
						data = JSON.parse(result.dataList);
						if(data.length > 0){
							var levelIndex = eval(level);
							for(levelIndex ; levelIndex<=5 ; levelIndex++){
								$('#categoryLv'+levelIndex).parent().parent().remove();
							}
							var html = getCateListItem(level, data);
							$('#categoryLv'+(eval(level)-1)).parent().parent().parent().append(html);
						}
					}
				});
			}
		}
	}

	function getCateListItem(level, list){
		var html = '';
		html+='<div class="col-md-1" style="padding-left:4px;padding-right:4px;width:200px;">';
		html+='	<div class="form-group">';
		html+='		<select class="form-control" name="categoryLv'+level+'" id="categoryLv'+level+'"';
		if(level ){
			html+='	onchange="getCateList('+(eval(level)+1)+', this.value);"';
		}
		html+='>';
		html+='			<option value="">전체</option>';
		for(var i = 0 ; i < list.length; i++){
			var item = list[i];
			html+='				<option value="'+item.ctgrySeq+'">'+item.ctgryNm+'</option>';
		}
		html+='		</select>';
		html+='	</div>';
		html+='</div>';
		return html;
	}



	function excel(){
		var form = $('#searchForm');
		$.fileDownload('/monitoring/transactionList/excel', {
			httpMethod: 'POST'
			//,contentType:"application/json"
			//,data : JSON.stringify(form.serialize())
			,data : form.serialize()
		}).done(function() {

		}).fail(function() {

		});
	}

	</script>
</html>