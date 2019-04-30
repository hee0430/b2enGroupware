<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>패치 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content pagination2">
				<div class="filter-left">
					<div class="list_wrap3">
					<table class="table table-hover table-dynamic table-tools-patch search-icon" id="libraryTable">
						<thead>
						<tr>
							<th class="text-center" style="width:12%;">처리시간</th>
							<th class="text-center" style="width:12%;">패치번호</th>
							<th class="text-center" style="width:25%;">설명</th>
							<th class="text-center" style="width:*%;">처리결과</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="item" items="${patchHistList }">
						<tr>
							<td style="text-align: center;"><fmt:formatDate value="${item.patchDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td style="text-align: center;">
								<span class="link" onclick="getPatchDetail('${item.patchSeq}');">${item.patchSeq}</span>
								<span style="display: none;">${item.patchFile}</span>
							</td>
							<td style="text-align: left;">${item.patchCm}</td>
							<td>
							<script>
							var cnList = JSON.parse('${item.patchResultCn}');
							for(var i = 0 ; i < cnList.length ; i ++){
								var cnItem = cnList[i]
								if(cnItem.result != 'S'){
									var resultText = "label-danger";
									document.write('<span class="label label-danger " data-rel="tooltip" data-placement="top" data-original-title="'+cnItem.resultMessage+'" style="cursor:pointer;">'+cnItem.agentId + "-"+cnItem.agentNo+'</span>&nbsp;');
								}else{
									document.write('<span class="label label-success link2" data-rel="tooltip" data-placement="top" data-original-title="'+cnItem.agentId + "-"+cnItem.agentNo+' 패치 성공">'+cnItem.agentId + "-"+cnItem.agentNo+'</span>&nbsp;');
								}
							}
							</script>
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

<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>패치</strong></h4>
			</div>
			<input type="hidden" name="mode" id="mode" value="${mode}">
			<input type="hidden" name="agentSeq" id="agentSeq" value="${agentData.agentSeq}">
			<div class="modal-body">
				<div class="col-md-12" style="padding-bottom:20px;">
					<fieldset style="margin-top:10px; padding:10px;">
						<legend><strong>패치 방식</strong></legend>
						<div style="padding-left:14px;">
							<div class="icheck-inline">
								<label><input type="radio" id="patchType" name="patchType" class="form-control" data-radio="iradio_minimal-blue" style="margin-left:20px;" checked="checked"> 이전 패치에서 선택</label>
								<label><input type="radio" id="patchType" name="patchType" class="form-control" data-radio="iradio_minimal-blue"> 신규 패치 파일 업로드</label>
							</div>

							<div class="col-md-12" id="uploadSection" style="display:none;padding-right:0px;padding-left:0px;padding-top:5px;">
								<form class="form-validation" id="uploadForm" action="/library/upload" enctype="multipart/form-data" method="POST">
								<div class="form-group col-md-12" style="padding-left:0px;margin-bottom:0px;">
									<div class="fileinput fileinput-new input-group" data-provides="fileinput">
										<div class="form-control" data-trigger="fileinput">
											<i class="glyphicon glyphicon-file fileinput-exists"></i><span class="fileinput-filename" id="fileName"></span>
					                    </div>
					                    <span class="form-group input-group-addon btn btn-default btn-file">
					                    	<span class="fileinput-new">선택</span>
					                    	<input type="file" id="libraryFile" name="libraryFile" multiple="multiple" onchange="diplayFileName();" accept=".jar">
					                    </span>
									</div>
								</div>
								<div class="form-group col-md-12" style="padding-left:0px;">
									<input type="text" id="patchCm" name="patchCm" class="form-control" placeholder="패치 설명을 입력하세요.">
								</div>
								</form>
							</div>
							<form id="patchForm" method="POST">
							<div class="col-md-12" id="librarySection" style="padding-left:0px;padding-top:5px;">
								<select id="patchSeq" name="patchSeq" class="form-control col-md-6 search-select"></select>
							</div>
						</div>
					</fieldset>
					<fieldset style="margin-top:10px;padding:10px 10px 0px 10px;">
						<legend><strong>대상 에이전트</strong></legend>
						<div class="col-md-12">
							<div class="row" style="padding-bottom:10px;">
								<div class="col-md-12">
									<input type="checkbox" class="icheck-box checkAll" data-checkbox="icheckbox_minimal-blue">전체
								</div>
							</div>
							<div class="row">
							<c:forEach var="item" items="${agentList}" varStatus="idx">
								<div class="col-md-3" style="padding-bottom:10px;"><input type="checkbox" class="icheck-box agentChkItem" id="agentId" data-checkbox="icheckbox_minimal-blue" value="${item.agentId}|${item.agentNo}">${item.agentId}-${item.agentNo}</div>
								<c:if test="${(idx.index+1 % 4) == 0}"></div><div class="row"></c:if>
							</c:forEach>
							</div>
						</div>
					</fieldset>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="doUpload();">실행</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="patchDetail" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>패치  상세 내용 </strong>
				</h4>
			</div>
			<div class="modal-body">
				<div class="col-md-12" id="patchDetailContent">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.form.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script type="text/javascript">
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';


	$(document).ready(function() {
		$('#patchType').on('ifChanged', function(event){
    		if($('#patchType')[0].checked){
    			$('#librarySection').show();
    			$('#uploadSection').hide();
    		}else{
    			$('#librarySection').hide();
    			$('#uploadSection').show();
    		}
		});
	});

	function uploadModal(dt){
		$('#patchSeq').select2("val", "0");
		var chkList = $('#patchForm #agentId');
		chkList.each(function(index,form){
			$(form).iCheck('uncheck');
		});

		$.ajax({
			url : '/xhr/patch/library',
			method : 'POST',
			success : function(result, resultCode) {
				$('#patchSeq').html('');
				$('#patchSeq').append('<option value="0" selected>선택하세요</option>');
				for(var i = 0 ; i < result.dataList.length ; i ++){
					var item = result.dataList[i];
					$('#patchSeq').append('<option value="'+item.patchSeq+'">'+item.patchSeq+'('+item.patchCm+')</option>');
				}

				$('.checkAll').on('ifChanged', function(event){
		    		if($('.checkAll')[0].checked){
		    			$('.agentChkItem').iCheck('check');
		    		}else{
		    			$('.agentChkItem').iCheck('uncheck');
		    		}
				});
				$('.checkAll').iCheck('uncheck');
				$('#uploadModal').modal();
				$('#uploadModal').draggable({handle: ".modal-header"});
			}
		});
	}


	function getPatchDetail(seq){
		$.ajax({
			url : '/xhr/patch/library/'+seq,
			method : 'POST',
			success : function(result, resultCode) {
				var list = result.data.infoList;
				var target = $('#patchDetailContent');
				target.html('');
				var html = '<table class="table table-hover">';
				html += '<thead>';
				html += '<tr>';
				html += '<th style="text-align:center;">파일명</th>';
				html += '<th style="text-align:center;">크기</th>';
				html += '<th style="text-align:center;">다운로드</th>';
				html += '</tr>';
				html += '</thead>';
				html += '<tbody>';
				for(var i = 0 ; i < list.length ;i++){
					var item = list[i];
					html += '<tr>';
					html += '<td>'+item.FILE_NAME+'</td>';
					html += '<td>'+numberWithCommas(item.FILE_SIZE)+' byte</td>';
					html += '<td style="text-align:center;"><i class="fas fa-download link2" onclick="fileDownload(\''+seq+'\',\''+item.FILE_NAME+'\');"></i></td>';
					html += '</tr>';

				}
				if(list.length == 0){
					html += '<tr>';
					html += '<td colspan="3">패치 파일이 없습니다. </td>';
					html += '</tr>';
				}
				html += '</tbody>';
				html += '</table>';
				target.html(html);

				$('#patchDetail').modal();

			}
		});
	}

	function fileDownload(seq, fileName){
		console.log(seq)
		console.log(fileName)

		var data = {
			seq : seq,
			fileName : fileName
		};

		$.fileDownload('/xhr/patch/libraryDownload', {
			'data' : data
		}).done(function() {
			alert('Excel file download succeeded.');
		}).fail(function() {
			alert('Excel file download failed.');
		});
	}

	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}


	function diplayFileName(){
		$('#fileName').html('');
		var files = $('#libraryFile')[0].files;

		if(files.length > 11){
			notification("패치 파일의 최대 업로드 개수(10개)를 초과했습니다.<br>최대 개수에 맞게 파일을 다시 선택하세요.");
			uploadFormClear();
			return false;
		}else{
			var fileNames = '';
			for(var i = 0 ; i < files.length ;i++){
				fileNames += files[i].name + ',';
			}
			if(files.length > 0){
				fileNames = fileNames.substring(0, fileNames.length -1);
			}

			$('#fileName').html(fileNames);
			$('#fileName').css('display','');
			$('patchSeq').val('0')
		}
	}

	function uploadFormClear(){
		$('#fileName').html('');
		$('#uploadForm')[0].reset();
	}

	function doUpload(){
		var isFileAttach = "" == $('#libraryFile').val() ? false:true;
		var isLibrarySelected = "0" == $('#patchSeq').val() ? false:true;

		if($('#patchType')[0].checked){
			if(!isLibrarySelected){
				notification("패치번호가 지정되지 않았습니다.<br>이전 목록에서 패치번호를 선택하세요.");
				return false;
			}
		}else{
			if(!isFileAttach){
				notification("업로드한 패치 파일이 없습니다.<br>선택버튼을 눌러 패치할 파일을 업로드하세요.");
				return false;
			}
		}

		var chkCount = 0;
		var chkList = $('.agentChkItem');
		chkList.each(function(index,form){
			if(form.checked){
				chkCount++;
			}
		});
		if(chkCount == 0){
			notification("패치 대상 에이전트가 없습니다.<br>에이전트 목록에서 패치를 수행할 에이전트를 선택하세요.");
			return false;
		}

		//파일이 첨부된 경우
		if(isFileAttach){
			ajaxForm = $('#uploadForm').ajaxForm({
				beforeSubmit: function (data,form,option) {
					$('#patchCm').attr('required','required');
					return $('#patchCm').valid();
		        },
		        success: function(result,status){
		        	// 업로드가 성공하면 선택된 에이전트를 대상으로 패치 처리를 진행한다.
					if(result.patchSeq != '0'){
						console.log(result)
						uploadFormClear();
						doPatch(result.patchSeq, chkList);
						$('#uploadModal').modal('hide');
					}else{
						notification('패치 파일 업로드 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}

		        },
		        error: function(){
		        }
			});

			ajaxForm[0].action = '/xhr/patch/upload';
			ajaxForm.submit();
		}else{
			// 선택된 에이전트와 패치번호를 가지고 패치를 수행한다.
			doPatch($('#patchSeq').val(), chkList);
		}
	}

	function doPatch(patchSeq, chkList){

		console.log(chkList)
		var agentListText = "";
		chkList.each(function(index,form){
			if(form.checked){
				agentListText += form.value + ',';
			}
		});
		if(chkList.length > 0){
			agentListText = agentListText.substring(0, agentListText.length-1);
		}

		$('#uploadModal').modal('hide');
		var data = {
			patchSeq : patchSeq,
			patchTrget : agentListText
		}

		$.ajax({
			url : '/xhr/patch/do',
			method : 'POST',
			data : JSON.stringify(data),
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) != STATUS_VALUE_OK) {
					notification('패치 실행 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				} else {
					document.location.href="/patch";
				}
			}
		});
	}

</script>
</html>