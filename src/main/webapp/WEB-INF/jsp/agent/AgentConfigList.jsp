<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.jstree-contextmenu .jstree-default-contextmenu {
	z-index: 99;
}
</style>

<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>에이전트 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-content pagination2">
				<div class="filter-left">
					<div class="list_wrap3">
					<table class="table table-hover table-dynamic table-tools-add excel-download search-icon" id="dataListTable" accesskey="regist">
						<thead>
							<tr>
								<th class="text-center" style="width: 150px;">아이디</th>
								<th class="text-center">에이전트명</th>
								<th class="text-center">에이전트구분</th>
								<th class="text-center">상태</th>
								<th class="text-center">IP</th>
								<th class="text-center">HTTP 포트</th>
								<th class="text-center">메시지 포트</th>
								<th class="text-center">관리 포트</th>
								<th class="text-center">수정일시</th>
								<th class="text-center" style="width: 70px;">테스트</th>
								<th class="text-center" style="width: 70px;">로그</th>
								<th class="text-center" style="width: 70px;">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" varStatus="idx" items="${dataList}">
								<tr>
									<td class="text-center">
										<span class="link" onclick="update('${item.agentId}','${item.agentNo}','${item.agentSe}')">
										<c:if test="${item.agentSe eq 'AGENT'}">
											${item.agentId}-${item.agentNo}
										</c:if>
										<c:if test="${item.agentSe eq 'RELAY'}">
											${item.agentId}
										</c:if>
										</span>
									</td>
									<td class="text-left">${item.agentNm}</td>
									<td class="text-center">${item.agentSe}</td>
									<td class="text-center">
										<c:if test="${item.linkStatus == true}">
											<span class="label label-success link2 ${item.agentId}-${item.agentNo}" style="cursor:pointer;" onclick="controllMessagePop('${item.agentId}','${item.agentNo}')">실행중</span>
										</c:if>
										<c:if test="${item.linkStatus == false}">
											<span class="label label-danger link2 ${item.agentId}-${item.agentNo}" style="cursor:pointer;" onclick="controllMessagePop('${item.agentId}','${item.agentNo}')">중지됨</span>
										</c:if>
									</td>
									<td class="text-center">${item.ip}</td>
									<td class="text-center">${item.httpPort}</td>
									<td class="text-center">${item.brokerPort}</td>
									<td class="text-center">${item.managePort}</td>
									<td class="text-center">
										<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.updtDt}" />
									</td>
									<td class="text-center" style="padding-top: 4px; padding-bottom: 4px;">
										<button type="button" class="btn btn-sm btn-default icon-check" style="font-size: 14px; padding: 5px 20px !important; margin-right: 0px;" onclick="agentTest('${item.agentId}','${item.agentNo}');" data-rel="tooltip" data-placement="top" data-original-title="연결테스트"></button>
									</td>
									<td class="text-center" style="padding-top: 4px; padding-bottom: 4px;">
										<button type="button" class="btn btn-sm btn-default icon-magnifier" style="font-size: 14px; padding: 5px 20px !important; margin-right: 0px;" onclick="logView('${item.agentId}','${item.agentNo}','${item.agentSe}','${item.linkStatus}');" data-rel="tooltip" data-placement="top" data-original-title="로그"></button>
									</td>
									<td class="text-center" style="padding-top: 4px; padding-bottom: 4px;">
										<button class="btn btn-sm btn-default icon-trash" style="font-size: 14px; padding: 5px 20px !important; margin-right: 0px;" onclick="deleteItem('${item.agentSeq}','${item.agentId}','${item.agentNo}','${idx.index}');" data-rel="tooltip" data-placement="top" data-original-title="삭제"></button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="form02" id="form02" action="/agent/agentConfigForm" method="POST">
		<input type="hidden" name="mode" value="U">
		<input type="hidden" name="agentId" id="agentId">
		<input type="hidden" name="agentNo" id="agentNo">
		<input type="hidden" name="agentSe" id="agentSe">
	</form>
</div>


<div class="modal fade" id="restartDiv" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" style="color:white;" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>시작/중지</strong>
				</h4>
			</div>
			<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;">
				<p id="restartContent"></p>
				<input type="hidden" name="targetAgentId" id="targetAgentId">
				<input type="hidden" name="targetAgentNo" id="targetAgentNo">
				<input type="hidden" name="operation" id="operation">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary btn-embossed" onclick="javascript:controllMessageProcess();" id="restartButton"></button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="logView" tabindex="-1" role="dialog" aria-hidden="true">
</div>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/jstree/jstree.js"></script>
<script type="text/javascript">

	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

	function deleteItem(agentSeq, agentId, agentNo, index) {
		confirm("<strong>["+agentId+"-"+agentNo+"]</strong> 에이전트 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.", function() {
			$('#confirmDiv').modal('hide');
			var data = {
				agentSeq : agentSeq,
				agentId : agentId,
				agentNo : agentNo
			};
			$.ajax({
				url : '/xhr/agent/agentConfigProcess/D',
				method : 'POST',
				data : JSON.stringify(data),
				//dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						var table = $('#dataListTable').dataTable();
						table.fnDeleteRow(index);
						confirmUnbind();
					} else {
						notification('<strong>['+agentId+']</strong> 에이전트 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		});
	}

	function controllMessagePop(agentId, agentNo){
		var sendData = {
			agentId : agentId,
			agentNo : agentNo
		}
		$.ajax({
			url : '/xhr/agent/agentLinkCheck',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					$('#restartDiv #restartContent').html("<strong>["+agentId +"-"+ agentNo+"]</strong> 에이전트를 중지하시겠습니까?");
					$('#restartDiv #restartButton').html("중지");
					$('#restartDiv .modal-body input[name=operation]').val('2');
				} else {
					$('#restartDiv #restartContent').html("<strong>["+agentId +"-"+ agentNo+"]</strong> 에이전트를 시작하시겠습니까?");
					$('#restartDiv #restartButton').html("시작");
					$('#restartDiv .modal-body input[name=operation]').val('1');
				}
				$('#restartDiv .modal-body input[name=targetAgentId]').val(agentId)
				$('#restartDiv .modal-body input[name=targetAgentNo]').val(agentNo)
				$('#restartDiv').modal();
			}
		});
	}

	function controllMessageProcess(){
		var agentId = $('#restartDiv .modal-body input[name=targetAgentId]').val();
		var agentNo = $('#restartDiv .modal-body input[name=targetAgentNo]').val();
		var operation = $('#restartDiv .modal-body input[name=operation]').val();

		$('#restartDiv').modal('hide');
		$.ajax({
			url : '/xhr/agent/controll/'+ agentId+'/'+agentNo+'/'+operation,
			method : 'POST',
			success : function(result, resultCode) {
				document.location.href="/agent/agentConfigList";
			}
		});
	}

	function regist() {
		document.location.href = "/agent/agentConfigForm"
	}

	function update(agentId, agentNo, agentSe) {
		$('#form02 #agentId').val(agentId);
		$('#form02 #agentNo').val(agentNo);
		$('#form02 #agentSe').val(agentSe);
		$('#form02')[0].action = "/agent/agentConfigForm";
		$('#form02').submit();
	}

	function logView(agentId, agentNo, agentSe, linkStatus) {
		if(linkStatus == 'false'){
			notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트와 연결할 수 없어 로그를 가져올 수 없습니다.<br>에이전트 실행상태 및 네트워크를 확인하세요.');
			return false;
		}

		var data = {
			operation : 'LIST',
			agentId : agentId,
			agentNo : agentNo
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



	function agentTest(agentId, agentNo) {
		var sendData = {
			agentId : agentId,
			agentNo : agentNo
		}

		$.ajax({
			url : '/xhr/agent/agentLinkCheck',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트와 통신 테스트를 성공했습니다.');
					$('.label.label-danger.link2.'+agentId+'-'+agentNo+'').removeClass('label-danger').addClass('label-success');
					$('.label.label-success.link2.'+agentId+'-'+agentNo+'').html('실행중');
				} else {
					notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트와 통신 테스트를 실패했습니다.<br>에이전트 실행상태 및 네트워크를 확인하세요.');
					$('.label.label-success.link2.'+agentId+'-'+agentNo+'').removeClass('label-success').addClass('label-danger');
					$('.label.label-danger.link2.'+agentId+'-'+agentNo+'').html('중지됨');
				}
			}
		});
	}

	function excel(param){
		$.fileDownload('/agentConfigList/excel', {}).done(function() {
		}).fail(function() {
		});
	}

	$(document).ready(function() {

	});
</script>
</html>