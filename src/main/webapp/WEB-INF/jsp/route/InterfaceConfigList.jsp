<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.intrfc-summary{
	display:none;
    width: auto;
    height: auto;
    float: left;
    position: fixed;
    z-index: 3;
    background: #F9F9F9;
    resize: both;
    overflow: auto;
}
</style>
<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>인터페이스 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content pagination2">
				<div class="filter-left">
					<div class="list_wrap3">
					<table class="table table-hover search-icon table-dynamic table-tools-add interface excel-download <c:if test="${INIT_SEARCH_VALUE ne null }">init-search</c:if> show-all-checkbox" id="dataListTable"
					accesskey="regist" <c:if test="${INIT_SEARCH_VALUE ne null }">init-search-value="${INIT_SEARCH_VALUE}"</c:if> >
						<thead>
							<tr>
								<th class="text-center" scope="col"><input type="checkbox" id="chkAll" name="chkAll"></th>
								<th class="text-center" scope="col">아이디</th>
								<th class="text-center">인터페이스명</th>
								<th class="text-center">경로</th>
								<th class="text-center" style="width:90px;">정보</th>
								<th class="text-center" style="width:200px;">상태</th>
								<th class="text-center" style="width:128px;">스케줄</th>
								<th class="text-center" style="width:144px;">수정일시</th>
								<th class="text-center" style="width:77px;">개발버전</th>
								<th class="text-center" style="width:77px;">배포상태</th>
								<th class="text-center" style="width:70px;">배포</th>
								<th class="text-center" style="width:70px;">삭제</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="item" varStatus="idx" items="${INTERFACE_LIST}">
						<tr accesskey="${item.sttus}">
							<td class="text-center"><input class="icheck-box" type="checkbox" id="chk" name="chk" value="${item.intrfcId}"></td>
							<td><span class="link" onclick="modify('${item.intrfcId}' ,'N','${item.lastDstbVer}','${item.dstbVer}');">${item.intrfcId}</span></td>
							<td><p class="ellipsis" style="width:180px;height:20px;margin-bottom:0px;">${item.intrfcNm}</p></td>
							<td class="text-center">
							${item.fromAgent}
							<i class="fas fa-caret-right" style="padding-left:6px;"></i>${item.toAgent}
							</td>
							<td class="text-center">&nbsp;<i class="icon-info link2 summary-show"  data-rel="tooltip" data-placement="top" data-original-title="요약정보"></i>
								<div class="modal-content intrfc-summary" id="${item.intrfcId}_summary">
									<div class="modal-body" style="padding-right:10px;padding-top:10px;">
										<div class="col-md-12" style="text-align:right;padding-right:0px;"><i class="icon-close link2 summary-close" style="padding-right:0px;"></i></div>
										<div class="col-md-12" style="padding:0px 0px 0px 0px;">
										<p id="content">
										패턴 : ${item.intrfcSummary.processPattern}
										<c:if test="${item.intrfcSummary.ST ne null}"><br>송신테이블 : ${item.intrfcSummary.ST}</c:if>
										<c:if test="${item.intrfcSummary.RT ne null}"><br>수신테이블 : ${item.intrfcSummary.RT}</c:if>
										<c:if test="${item.intrfcSummary.sendRootDir ne null}"><br>송신 디렉토리 : ${item.intrfcSummary.sendRootDir}</c:if>
										<c:if test="${item.intrfcSummary.sendCondition ne null}"><br>송신 조건 : ${item.intrfcSummary.sendCondition}</c:if>
										<c:if test="${item.intrfcSummary.recvRootDir ne null}"><br>수신 디렉토리 : ${item.intrfcSummary.recvRootDir}</c:if>
										<c:if test="${item.intrfcSummary.recvCondition ne null}"><br>수신 조건 : ${item.intrfcSummary.recvCondition}</c:if>
										<c:if test="${item.intrfcSummary.url ne null}"><br>URL : ${item.intrfcSummary.url}</c:if>
										</p>
										</div>
									</div>
								</div>
								<%-- item.intrfcTy --%>
							</td>
							<td class="text-center">
								<c:if test="${item.dstbVer ne 0}">
									<c:if test="${item.actvtyYn eq 'Y'}"><span class="label label-dark" data-rel="tooltip" data-placement="top" data-original-title="인터페이스 실행중">실행중</span></c:if>
									<c:if test="${item.actvtyYn eq 'N'}"><span class="label label-default" data-rel="tooltip" data-placement="top" data-original-title="인터페이스 중지됨">중지됨</span></c:if>
									<c:if test="${item.trnscLogYn eq 'Y'}"><span class="label label-dark" data-rel="tooltip" data-placement="top" data-original-title="트랜잭션로깅중">트랜잭션로깅</span></c:if>
									<c:if test="${item.syncYn eq 'Y'}"><span class="label label-dark" data-rel="tooltip" data-placement="top" data-original-title="순차전송중">순차전송</span></c:if>
								</c:if>
								<c:if test="${item.dstbVer eq 0}">
								-
								</c:if>
							</td>
							<td class="text-center">${item.schedule}</td>
							<td class="text-center">${item.updtDtText}</td>
							<td class="text-center">
								<c:if test="${item.dstbVer ne item.lastDstbVer}">
									<span class="label label-danger temp_dist_badge" data-rel="tooltip" data-placement="top" data-original-title="개발중" onclick="modify('${item.intrfcId}' ,'Y','${item.lastDstbVer}','${item.dstbVer}');" style="cursor: pointer;">
									<fmt:formatDate pattern="yyMMdd" value="${item.workUpdtDt}"/><span style="display:none;">개발중</span>
									</span>
								</c:if>
								<c:if test="${item.dstbVer eq item.lastDstbVer}">
								<span style="display:none;">배포됨</span>
								</c:if>
							</td>
							<td class="text-center">
								<span class="sttus">
									<c:if test="${item.sttus eq 'S'}">완료</c:if>
									<c:if test="${item.sttus eq 'F'}">실패</c:if>
									<c:if test="${item.sttus eq 'P' and item.dstbVer > 0}">완료</c:if>
								</span>
							</td>
							<td class="text-center" style="padding-top:4px;padding-bottom:4px;">
								<button type="button" class="btn btn-sm btn-default icon-share" style="font-size:14px;padding:5px 20px !important;margin-right:0px;" onclick="distributeItem('${item.intrfcId }', this);" data-rel="tooltip" data-placement="top" data-original-title="인터페이스 배포"></button>
							</td>
							<td class="text-center" style="padding-top:4px;padding-bottom:4px;">
								<button type="button" class="btn btn-sm btn-default icon-trash" style="font-size:14px;padding:5px 20px !important;margin-right:0px;" onclick="deleteItem('${item.intrfcId}', '${item.intrfcSeq}', '${idx.index}');" data-rel="tooltip" data-placement="top" data-original-title="삭제"></button>
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
</div>
<div class="modal fade" id="interfaceCopyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>인터페이스 복사</strong>
				</h4>
			</div>
			<form id="interfaceCopyForm" name="interfaceCopyForm" class="form-horizontal form-validation" onsubmit="return false;">
			<div class="modal-body">
				<div class="col-md-12" style="padding-bottom:20px;">
					<fieldset class="interface" style="padding-right:10px;">
					<div class="form-group col-md-12">
						<label class="col-form-label">복사대상 인터페이스</label>
						<select class="form-control search-select" name="targetIntrfcId" id="targetIntrfcId" required="required">
							<option value="">선택하세요</option>
							<c:forEach var="item" varStatus="idx" items="${INTERFACE_LIST_ORDER}">
								<option value="${item.intrfcId}">${item.intrfcNm}(${item.intrfcId})</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group col-md-12">
						<label class="col-form-label">인터페이스 아이디</label>
						<input type="text" class="col-md-6 form-control" id="intrfcId" name="intrfcId" minlength="4" maxlength="50" required="required" regex="^[A-Za-z0-9_-]*$" value="${intrfc.intrfcId}" placeholder="인터페이스 아이디">
					</div>
					<div class="form-group col-md-12">
						<label class="col-form-label">인터페이스명</label>
						<input type="text" class="col-md-6 form-control" id="intrfcNm" name="intrfcNm" required="required" value="${intrfc.intrfcNm}" placeholder="인터페이스 이름 또는 설명">
					</div>
					</fieldset>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="copyAction();">확인</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>


<script type="text/javascript">
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

	$(document).ready(function() {
		$('#chkAll').on('ifChanged', function(){
			var bChk = true;
			if($('#chkAll')[0].checked){
				bChk = true;
			}else{
				bChk = false;
			}

			var size = $('[id=chk]').length;
			for(i = 0 ; i < size ; i ++){
				var param = 'check';
				if(!bChk){
					param = 'uncheck';
				}
				$($('[id=chk]')[i]).iCheck(param);
			}
		});

	});

	function deleteItem(intrfcId, intrfcSeq, index) {
		var sendData = {
			"interfaceConfig" : {
				"intrfcId" : intrfcId,
				"intrfcSeq" : intrfcSeq
			},
		};
		confirm('<strong>['+intrfcId+']</strong> 인터페이스를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			$.ajax({
				url : '/xhr/route/routeConfigProcess/D',
				method : 'POST',
				data : JSON.stringify(sendData),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						;
					} else {
						notificationCallback('<strong>['+intrfcId+']</strong> 인터페이스 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE, function(){
							document.location.href="/route/interfaceConfigList"
						});
					}
				}
			});
		});

	}

	function distributeItem(intrfcId, o) {
		var sttus = o.parentNode.parentNode.accessKey;

		confirm('<strong>['+intrfcId+']</strong> 인터페이스를 배포하시겠습니까?', function() {
			$('#confirmDiv').modal('hide');
			$.ajax({
				url : '/xhr/route/routeDistributeProcess/' + intrfcId,
				method : 'POST',
				dataType : 'json',
				contentType : 'application/json',
				success : function(result) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						document.location.href="/route/interfaceConfigList";
					}else{
						notification(result.MESSAGE);
					}
				}
			});
		});
	}

	function regist() {
		document.location.href = "/route/routeConfigForm";
	}

	function modify(intrfcId, isWorkItem, lastdistVer, distVer) {
		if(distVer == '0' && isWorkItem == 'N'){
			notification('<strong>['+intrfcId+']</strong> 인터페이스는 배포버전이 없습니다.<br>개발버전을 선택하세요.');
			return false;
		}

		var form = document.createElement('form');
		form.action = "/route/routeConfigForm";
		form.method = "POST";

		var input1 = document.createElement('input');
		input1.name = "intrfcId";
		input1.value = intrfcId;
		input1.type = "hidden";

		var modeInput = document.createElement('input');
		modeInput.name = "mode";
		modeInput.value = "U";
		modeInput.type = "hidden";

		var workItemInput = document.createElement('input');
		workItemInput.name = "isWorkItem";
		workItemInput.value = isWorkItem;
		workItemInput.type = "hidden";

		form.appendChild(input1);
		form.appendChild(modeInput);
		form.appendChild(workItemInput);
		document.body.appendChild(form);
		form.submit();
	}

	function if_activate() {
		var list = getChedkedList();
		if (list.length == 0) {
			notification('시작 대상 인터페이스가 없습니다.<br>인터페이스를 선택한 후 다시 시도하세요.');
			return false;
		}
		confirm('선택한 인터페이스를 모두 시작하시겠습니까?', function() {
			routeActiveStatus('Y')
		});
	}
	function if_deactivate() {
		var list = getChedkedList();
		if (list.length == 0) {
			notification('중지 대상 인터페이스가 없습니다.<br>인터페이스를 선택한 후 다시 시도하세요.');
			return false;
		}
		confirm('선택한 인터페이스를 모두 중지하시겠습니까?', function() {
			routeActiveStatus('N')
		});
	}

	function routeActiveStatus(action) {
		$('#confirmDiv').modal('hide');
		var list = getChedkedList();

		$.ajax({
			url : '/xhr/route/routeActiveStatusProcess/' + action,
			method : 'POST',
			//dataType : 'json',
			data : {
				ifId : list
			},
			traditional : true,
			//contentType: 'application/json',
			success : function(result) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					document.location.reload();
				} else {
					notification('인터페이스 시작/중지 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}
	function getChedkedList() {
		var ifIdText = "";
		var list = [];
		var size = $('[id=chk]').length;
		for (i = 0; i < size; i++) {
			if ($('[id=chk]')[i].checked) {
				list.push($('[id=chk]')[i].value);
				ifIdText += $('[id=chk]')[i].value + "!#!";
			}
		}
		return list;
	}

	function excel(param) {
		$.fileDownload('/route/interfaceConfigList/excel', {}).done(function() {
		}).fail(function() {
		});
	}

	function copyModal() {
		$('#interfaceCopyForm')[0].reset()
		$('#interfaceCopyModal').modal();
	}

	function copyAction() {
		var valid = $('#interfaceCopyForm').valid();
		if (valid) {
			$('#interfaceCopyModal').modal('hide');
			$.ajax({
				url : '/xhr//route/interfaceCopyProcess',
				method : 'POST',
				data : $('#interfaceCopyForm').serialize(),
				//dataType : 'json',
				//contentType: 'application/json',
				success : function(result) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						modify($('#interfaceCopyForm').find('[id=intrfcId]').val(),'Y');
					} else {
						notification('인터페이스 복사 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}
	var z;

	$('.summary-show').on('click', function(e){
		z = e;
		$('.intrfc-summary').hide();
		id = $(e.target.parentElement).find('.intrfc-summary')[0].id
		var y = e.clientX;
		var x = e.clientY;

		$('#'+id).css('top',x);
		$('#'+id).css('left',y);
		$('#'+id).show();
	});

	$('.summary-close').on('click', function(e){
		id = e.target.parentElement.parentElement.parentElement.id;
		$('#'+id).hide();
	});

</script>