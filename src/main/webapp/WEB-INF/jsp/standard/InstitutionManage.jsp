<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>기관정보 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content pagination2">
				<div class="filter-left">
					<div class="list_wrap3">
					<table class="table table-hover table-dynamic table-tools-add institution search-icon" id="dataList" >
						<thead>
							<tr>
								<th class="text-center" style="width:15%;">기관명</th>
								<th class="text-center" style="width:25%;">기관약어</th>
								<th class="text-center" style="width:20%;">시스템명</th>
								<th class="text-center" style="width:10%;">시스템약어</th>
								<th class="text-center" style="width:*%;">담당자</th>
								<th class="text-center" style="width:5%;">시스템</th>
								<th class="text-center" style="width:5%;">담당자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach  var="item" items="${dataList}" >
								<tr>
									<td class="text-left"><span class="link" onclick="modifyInstitution('${item.insttSeq }')" style="cursor: pointer;padding-left: 15px;">${item.insttNm }</span></td>
									<td class="text-left"><span style="padding-left: 15px;">${item.insttEngNm }</span></td>
									<td class="text-left"><span class="link" onclick="modifySystem('${item.sysSeq }')" style="cursor: pointer;padding-left: 15px;">${item.sysNm }</span></td>
									<td class="text-left"><span style="padding-left: 15px;">${item.sysEngNm }</span></td>
									<td class="text-center">
									<c:forEach items="${fn:split(item.chargerNm, ',') }" var="chargerItem" varStatus="idx">
    									<span class="link" onclick="modifyCharger('${fn:split(chargerItem,'/')[0]}')" style="cursor: pointer;padding-left: 15px;">${fn:split(chargerItem,'/')[1]}</span>
										<c:if test="${fn:length(fn:split(item.chargerNm, ','))-1 > idx.index}">,</c:if>
									</c:forEach>
									</td>
									<td class="text-center" style="padding-top:4px;padding-bottom:4px;">
										<i class="fa fa-plus link2" onclick="showSystem(0, '${item.insttSeq }','I')" data-rel="tooltip" data-placement="top" data-original-title="시스템 추가"></i>
									</td>
									<td class="text-center" style="padding-top:4px;padding-bottom:4px;">
									<i class="fa fa-plus link2" onclick="showCharger(0, '${item.sysSeq }', '${item.insttSeq }','I')" data-rel="tooltip" data-placement="top" data-original-title="담당자 추가"></i>
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
	<!-- institution modal area -->
	<div class="modal fade" id="institutionModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-dark">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<i class="icons-office-52"></i>
					</button>
					<h4 class="modal-title">
						<strong>기관정보 설정</strong>
					</h4>
				</div>
				<div id="institutionFormDiv" class="filter-left">
					<form id="institutionForm" name="institutionForm" class="form-horizontal form-validation" enctype="multipart/form-data" method="post">
					<input type="hidden" name="insttSeq" id="insttSeq">
					<input type="hidden" name="logoImageDeleteYn" id="logoImageDeleteYn" value="N">
					<input type="hidden" name="mode" id="mode" value="I">
					<div class="modal-body">
						<div class="col-md-12" style="padding-bottom:20px;">
							<fieldset style="margin-top:10px;padding:10px;">
								<div class="col-md-12" style="padding-right:0px;">
									<div class="form-group col-md-12" style="padding-right:0px;">
										<label class="form-label required-item">기관명</label> <input class="form-control col-md-12" type="text" id="insttNm" name="insttNm" maxlength="50" required="required">
									</div>
									<div class="form-group col-md-12" style="padding-right:0px;">
										<label class="form-label">기관약어</label> <input class="form-control col-md-12" type="text" id="insttEngNm" name="insttEngNm" maxlength="100">
									</div>
									<div class="form-group col-md-12" style="padding-right:0px;">
										<label class="form-label">기관로고</label>
										<div class="fileinput fileinput-new input-group" data-provides="fileinput">
											<div class="form-control" data-trigger="fileinput">
                              					<i class="glyphicon glyphicon-file fileinput-exists"></i><span class="fileinput-filename" id="fileName"></span>
                            				</div>
                           					<span class="input-group-addon btn btn-default btn-file"><span class="fileinput-new">선택</span><span class="fileinput-exists">수정</span>
                            					<input type="file" id="logoImage" name="logoImage"">
                            				</span>
                           					<a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">삭제</a>
										</div>
									</div>
									<div class="form-group col-md-12" style="padding-right:0px;" id="imageDiv"></div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-6 pull-left" style="padding:0px;padding-left:15px;">
							<button type="button" class="btn btn-default btn-embossed deleteB" onclick="save('institution', 'D');">삭제</button>
						</div>
						<div class="col-md-6">
							<div class="row pull-right" style="padding-right:15px;">
								<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal" onclick="resetForm(this.form);">취소</button>
								<button type="button" class="btn btn-primary btn-embossed" onclick="save('institution');">저장</button>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- system modal area -->
	<div class="modal fade" id="systemModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-dark">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<i class="icons-office-52"></i>
					</button>
					<h4 class="modal-title">
						<strong>시스템정보 설정</strong>
					</h4>
				</div>
				<div id="systemFormDiv" class="filter-left">
					<form id="systemForm" name="systemForm" class="form-horizontal form-validation" onsubmit="return false;">
					<input type="hidden" name="sysSeq" id="sysSeq">
					<input type="hidden" name="mode" id="mode" value="I">
					<div class="modal-body">
						<div class="col-md-12" style="padding-bottom:20px;">
							<fieldset style="margin-top:10px;padding:10px;">
								<div class="col-md-12" style="padding-right:0px;">
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label required-item">기관명</label> <select id="insttSeq" name="insttSeq" class="form-control search-select" required="required"></select>
									</div>
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label required-item">시스템명</label> <input class="form-control col-md-12" type="text" id="sysNm" name="sysNm" maxlength="100" required="required">
									</div>
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label">시스템 약어</label> <input class="form-control col-md-12" type="text" id="sysEngNm" name="sysEngNm" maxlength="100">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-6 pull-left" style="padding:0px;padding-left:15px;">
							<button type="button" class="btn btn-default btn-embossed deleteB" onclick="save('system', 'D');">삭제</button>
						</div>
						<div class="col-md-6">
							<div class="row pull-right" style="padding-right:15px;">
								<button type="button" class="btn btn-default btn-embossed " data-dismiss="modal" onclick="resetForm(this.form);">취소</button>
								<button type="button" class="btn btn-primary btn-embossed" onclick="save('system');">저장</button>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- charger modal area -->
	<div class="modal fade" id="chargerModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-dark">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<i class="icons-office-52"></i>
					</button>
					<h4 class="modal-title">
						<strong>담당자 설정</strong>
					</h4>
				</div>
				<div id="chargerFormDiv" class="filter-left" >
					<form id="chargerForm" name="chargerForm" class="form-horizontal form-validation" onsubmit="return false;">
					<input type="hidden" name="chargerSeq" id="chargerSeq">
					<input type="hidden" name="mode" id="mode" value="I">
					<div class="modal-body">
						<div class="col-md-12" style="padding-bottom:20px;">
							<fieldset style="margin-top:10px;padding:10px;">
								<div class="col-md-12" style="padding-right:0px;">
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label required-item">시스템명</label> <select id="sysSeq" name="sysSeq" class="form-control col-md-6 search-select" required="required"></select>
									</div>
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label required-item">담당자명</label> <input class="form-control col-md-12" type="text" id="chargerNm" name="chargerNm" maxlength="50" required="required">
									</div>
									<div class="form-group col-md-12" style="padding-right: 0px;">
										<label class="form-label">부가정보</label> <textarea class="form-control col-md-6" rows="10" id="chargerCn" name="chargerCn"></textarea>
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-6 pull-left" style="padding:0px;padding-left:15px;">
							<button type="button" class="btn btn-default btn-embossed deleteB" onclick="save('charger', 'D');">삭제</button>
						</div>
						<div class="col-md-6" style="padding-right:15px;">
							<div class="row pull-right">
								<button type="button" class="btn btn-default btn-embossed " data-dismiss="modal" onclick="resetForm(this.form);">취소</button>
								<button type="button" class="btn btn-primary btn-embossed" onclick="save('charger');">저장</button>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.form.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/bootstrap/js/jasny-bootstrap.min.js"></script>
<script src="/assets/global/plugins/jstree/jstree.js"></script>
<script type="text/javascript">
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';
	var defaultContent = '';

	$(document).ready(function() {

		//drawTable();
		defaultContent+='1) 전화번호 : \n';
		defaultContent+='2) 이메일 : \n';
		defaultContent+='3) 비고 : ';

		$('.fileDelete').bind('click' ,function(){
			confirm('기관로고를 삭제하시겠습니까?' , function(){
				$('#confirmDiv').modal('hide');
				$('#existFile').hide();
				$('#imageDiv').html('');
				$('#logoImageDeleteYn').val('Y');
			});
		});

		$('.deleteB').hide();
	});

	function save(type, mode){
		var ajaxForm;
		var validChk = true;
		var message = "정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.";
		if(mode != 'D'){
			mode = $('#'+type+'Form').find('[id=mode]').val();
			validChk = $('#'+type+'Form').valid();
		}

		if(validChk){
			if(mode != 'D'){
				process(type, mode);
			}else{
				if (type == 'institution') {
					message = '기관 ' + message;
				} else if (type == 'system') {
					message = '시스템 ' + message;
				} else if(type == 'charger') {
					message = '담당자 ' + message;
				}

				confirm(message,function(){
					process(type, mode);
				});
			}
		}
	}

	function process(type, mode){
		$('#confirmDiv').modal('hide');
		if(type == 'institution'){
			ajaxForm = $('#'+type+'Form').ajaxForm({
				beforeSubmit: function (data,form,option) {
	                return true;
	            },
	            success: function(result,status){
					if(eval('result.'+STATUS_KEY) != STATUS_VALUE_OK){

						notification('처리과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}else{
						$('#'+type+'Modal').modal('hide');
						drawTable();
					}
	            },
	            error: function(){
	            }
	        });


			ajaxForm[0].action = '/xhr/'+type+'/process/'+mode;
			if(mode == 'I'){
				ajaxForm[0].insttSeq.value = "0";
			}
			ajaxForm.submit();
		}else if(type == 'system'){
			ajaxForm = {
				insttSeq : $('#'+type+'Form').find('[id=insttSeq]').val(),
				sysNm : $('#'+type+'Form').find('[id=sysNm]').val(),
				sysEngNm : $('#'+type+'Form').find('[id=sysEngNm]').val(),
				sysSeq : $('#'+type+'Form').find('[id=sysSeq]').val()
			}
		}else if(type == 'charger'){
			ajaxForm = {
				sysSeq : $('#'+type+'Form').find('[id=sysSeq]').val(),
				chargerNm : $('#'+type+'Form').find('[id=chargerNm]').val(),
				chargerCn : $('#'+type+'Form').find('[id=chargerCn]').val(),
				chargerSeq : $('#'+type+'Form').find('[id=chargerSeq]').val()
			}
		}
		if(type != 'institution'){
	 	 	$.ajax({
				url : '/xhr/'+type+'/process/'+mode,
				data : JSON.stringify(ajaxForm),
				method :'POST',
				dataType : 'json',
				contentType: 'application/json',
				success : function(result, resultCode){
					if(eval('result.'+STATUS_KEY) != STATUS_VALUE_OK){
						notification('처리과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}else{
						$('#'+type+'Modal').modal('hide');
						drawTable();
					}
				}
			});
		}
		$('input').removeClass('form-success')
		$('#existFile').hide();
		$('#fileName').html('');
		$('#logoImageDeleteYn').val('N');
	}

	function resetForm(form){
		$(form).find('input').removeClass('form-success');
		form.reset();
	}

	function showInstitution(seq, selectSysSeq){
		if(!selectSysSeq){
			$('#existFile').hide();
			$('#fileName').html('');
			$('#imageDiv').html('');
			$('#institutionForm')[0].reset();
			$('#institutionForm')[0].mode.value = 'I';
		}else{
			$('#institutionForm')[0].mode.value = 'U';
		}

		if($('#institutionForm')[0].mode.value == 'U'){
			$('.deleteB').show();
		}else{
			$('.deleteB').hide();
		}

		$('#institutionModal').modal();
		$('#institutionModal').draggable({handle: ".modal-header"});
	}

	function showSystem(seq, selectSysSeq, mode){
		$('#systemForm')[0].mode.value = mode;
		if(mode=='I'){
			$('#systemForm')[0].reset();
		}
		if(mode == 'U'){
			$('.deleteB').show();
		}else{
			$('.deleteB').hide();
		}

	 	$.ajax({
			url : '/xhr/standard/InstitutionList/'+seq,
			method :'POST',
			success : function(result, resultCode){
				var list = result.data;
				$('#systemForm').find('[id=insttSeq]').html('');
				$('#systemForm').find('[id=insttSeq]').append('<option value="">선택하세요</option>');
				list.forEach(function( item){
					$('#systemForm').find('[id=insttSeq]').append('<option value="'+item.insttSeq+'">'+item.insttNm+'('+item.insttEngNm+')</option>');
				});
				if(selectSysSeq){
					$('#systemForm').find('[id=insttSeq]').val(selectSysSeq).trigger('change');
				}
				$('#systemModal').modal();
				$('#systemModal').draggable({handle: ".modal-header"});
			}
		});
	}
	function showCharger(seq, selectSysSeq, insttSeq, mode){
		$('#chargerForm')[0].mode.value = mode;
		if(mode == 'I'){
			$('#chargerForm')[0].reset();
			$('#chargerForm').find('[id=chargerCn]').html(defaultContent);
		}

		if(mode == 'U'){
			$('.deleteB').show();
		}else{
			$('.deleteB').hide();
		}

	 	$.ajax({
			url : '/xhr/standard/SystemList/'+seq + '/' + insttSeq,
			method :'POST',
			success : function(result, resultCode){
				var list = result.data;
				$('#chargerForm').find('[id=sysSeq]').html('');
				$('#chargerForm').find('[id=sysSeq]').append('<option value="">선택하세요</option>');
				list.forEach(function( item){
					$('#chargerForm').find('[id=sysSeq]').append('<option value="'+item.sysSeq+'">'+item.sysNm+'('+item.insttNm+')</option>');
				});

				if(selectSysSeq){
					$('#chargerForm').find('[id=sysSeq]').val(selectSysSeq).trigger('change');
				}

				$('#chargerModal').modal();
				$('#chargerModal').draggable({handle: ".modal-header"});
			}
		});
	}

	function drawTable(){
	 	$.ajax({
			url : '/xhr/institution/list',
			method :'POST',
			success : function(result, resultCode){
				document.location.href="/standard/institutionManage";
			}
		});
	}

	function nullToTxt(data){
		if(data == null)
			return "";
		else
			return data
	}

	function modifyInstitution(seq){
		$('#existFile').hide();
	 	$.ajax({
			url : '/xhr/standard/InstitutionList/'+seq,
			method :'POST',
			success : function(result, resultCode){
				var dataList = result.data;
				if(dataList.length > 0){
					var item = dataList[0];
				 	$('#institutionForm').find('[id=insttNm]').val(item.insttNm);
					$('#institutionForm').find('[id=insttEngNm]').val(item.insttEngNm);
					$('#institutionForm').find('[id=insttSeq]').val(item.insttSeq);
					$('#institutionForm').find('[id=mode]').val('U');
					if(item.logoImageFileNm != null){
						$('#fileName').html(item.logoImageFileNm);
						$('#existFile').show();
						$('#imageDiv').html('<img src="/xhr/institution/image/'+item.insttSeq+'"></img>');
					}else{
						$('#imageDiv').html('');
					}
					showInstitution(0, item.insttSeq);
				}
			}
		});
	}

	function modifySystem(seq){
	 	$.ajax({
			url : '/xhr/standard/SystemList/'+seq + '/0',
			method :'POST',
			success : function(result, resultCode){
				var dataList = result.data;
				if(dataList.length > 0){
					var item = dataList[0];
		 			$('#systemForm').find('[id=sysNm]').val(item.sysNm);
		 			$('#systemForm').find('[id=sysEngNm]').val(item.sysEngNm);
					$('#systemForm').find('[id=sysSeq]').val(item.sysSeq);
					$('#systemForm').find('[id=insttSeq]').val(item.insttSeq);
					$('#systemForm').find('[id=mode]').val('U');
					showSystem(0, item.insttSeq,'U');
				}
			}
		});
	}

	function modifyCharger(seq){
	 	$.ajax({
			url : '/xhr/standard/ChargerList/'+seq,
			method :'POST',
			success : function(result, resultCode){
				var dataList = result.data;
				if(dataList.length > 0){
					var item = dataList[0];
					$('#chargerForm').find('[id=chargerNm]').val(item.chargerNm);
					$('#chargerForm').find('[id=chargerCn]').html(item.chargerCn);
					$('#chargerForm').find('[id=chargerSeq]').val(item.chargerSeq);
					$('#chargerForm').find('[id=mode]').val('U');
					showCharger(0, item.sysSeq, 0,'U');
				}
			}
		});
	}

</script>
</html>