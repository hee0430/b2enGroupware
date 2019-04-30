<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.force-table-responsive {
    overflow-x: hidden;
}
th:LAST-CHILD :AFTER {
	content : ''
}

</style>
<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>사용자 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content pagination2">
				<div class="filter-left">
					<div class="list_wrap3">
					<table class="table table-hover table-dynamic table-tools-add search-icon" id="dataListTable" accesskey="regist" >
						<thead>
							<tr>
								<th class="text-center" style="width: 150px;">아이디</th>
								<th class="text-center">이름</th>
								<th class="text-center">역할</th>
								<th class="text-center">권한</th>
								<th class="text-center">알람</th>
								<th class="text-center">수정일시</th>
								<th class="text-center" style="width: 70px;">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" varStatus="idx" items="${userList}">
								<tr>
									<td class="text-center">
										<span class="link" onclick="modifyUser('${item.userSeq}','${item.id}')">${item.id}</span>
									</td>
									<td class="text-center">${item.nm}</td>
									<td class="text-center">
										<c:if test="${item.userTy eq 'A'}">관리자</c:if>
										<c:if test="${item.userTy ne 'A'}">사용자</c:if>
									</td>
									<td class="text-center">
										<c:if test="${item.userTy ne 'A'}">
											<i class="fa fa-plus link2" onclick="userAuthManage('${item.userSeq}');" data-rel="tooltip" data-placement="top" data-original-title="권한설정"></i>
										</c:if>
									</td>
									<td class="text-center">
										<i class="fa fa-plus link2" onclick="showAlarmConfigModal('${item.id}');" data-rel="tooltip" data-placement="top" data-original-title="알람설정"></i>
									</td>
									<td class="text-center"><fmt:formatDate value="${item.passwordUpdtDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<td class="text-center">
										<c:if test="${item.id ne 'admin'}">
										<button class="btn btn-sm btn-default icon-trash" style="font-size: 14px; padding: 5px 20px !important;margin-right:0px;" onclick="deleteItem('${item.id}','${item.userSeq}');" data-rel="tooltip" data-placement="top" data-original-title="삭제"></button>
										</c:if>
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
<div class="modal fade" id="userInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>사용자 정보</strong>
				</h4>
			</div>
				<div class="modal-body" v-html="message" id="userInfo-body"></div>
				<div class="modal-footer">
					<div class="col-md-12" style="padding:0px;">
						<div class="col-md-4" style="text-align: left;">
							<button type="button" class="btn btn-default btn-embossed passwordChangeButton" onclick="showPasswordChangeForm();">비밀번호 변경</button>
						</div>
						<div class="col-md-8"  style="text-align: right;padding-right: 0px;">
							<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary btn-embossed" onclick="saveUser();">저장</button>
						</div>
					</div>
				</div>
		</div>
	</div>
</div>

<div class="modal fade" id="passwordChange" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>비밀번호 변경</strong>
				</h4>
			</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary btn-embossed" onclick="savePassword();">저장</button>
				</div>
		</div>
	</div>
</div>

<div class="modal fade" id="userMenuAuth" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>사용자별 메뉴 권한</strong>
				</h4>
			</div>
			<form id="form02" name="form02" class="form-horizontal form-validation" onsubmit="return false;">
			<input type="hidden" name="userSeq2" id="userSeq2">
			<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;overflow-x:hidden;">
				<div class="col-md-12" style="padding:0px;">
					<fieldset style="margin-top:0px;padding:10px;">
						<c:forEach var="item" items="${menuList}">
							<c:if test="${item.menuCode ne 'USER00' && item.menuCode ne 'MTDT00' && item.menuCode ne 'LIBR00'}"> <!-- 사용자, 기준정보, 패치 메뉴는 권한 부여 불가 -->
							<div class="row">
								<div class="col-md-12"><input type="checkbox" id="${item.menuCode}All" name="${item.menuCode}All" value="${item.menuCode}">${item.menuNm}</div>
								<c:if test="${fn:length(item.subMenuList) > 0}">
								<c:forEach var="subItem" items="${item.subMenuList}">
								<div class="row">
							 		<div class="col-md-1"></div>
							 		<div class="col-md-11"><input type="checkbox" id="${item.menuCode}_${subItem.menuCode}" name="${item.menuCode}_${subItem.menuCode}" value="${subItem.menuCode}">${subItem.menuNm}</div>
							 	</div>
								</c:forEach>
								</c:if>
							</div>
							</c:if>
						</c:forEach>
					</fieldset>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="saveAuth();">저장</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="alarmManage" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>알람 설정<span id="userIdText"></span></strong>
				</h4>
			</div>
			<form id="form03" name="form03" class="form-horizontal form-validation" onsubmit="return false;">
			<input type="hidden" name="userId" id="userId">
			<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;overflow-x:hidden;">
				<div class="col-md-12">
				<fieldset style="height:90px;margin-top: 10px;">
					<legend><strong>알람 설정 추가</strong></legend>
					<div class="form-group col-md-12" style="padding-right:0px;">
						<div class="col-md-2" style="padding-left:0px;">
							<select class="search-select" name="alarmSe" id="alarmSe" style="width: 100%" data-search="-1">
								<option value="I">인터페이스</option>
								<option value="R">자원</option>
							</select>
						</div>
						<div class="col-md-6 alarm-config-group-interface" style="padding-left:0px;">
						<select class="search-select" name="alarmTargetInterface" id="alarmTargetInterface">
							<c:forEach var="item" items="${interfaceList}">
							<option value="${item.intrfcId}">${item.intrfcNm}</option>
							</c:forEach>
						</select>
						</div>
						<div class="col-md-2 alarm-config-group-interface" style="padding-left:0px;">
						<select class="search-select" name="alarmValueInterface" id="alarmValueInterface" data-search="-1">
							<option value="S">성공</option>
							<option value="E">실패</option>
							<option value="A">수행됨</option>
						</select>
						</div>
						<div class="col-md-4 alarm-config-group-resource" style="display:none;padding-left:0px;">
						<select class="search-select" name="alarmTargetResourceAdd" id="alarmTargetResourceAdd">
							<c:forEach var="item" items="${agentList}">
							<option value="${item.agentId}-${item.agentNo}">${item.agentNm}(${item.agentId}-${item.agentNo})</option>
							</c:forEach>
						</select>
						</div>
						<div class="col-md-3 alarm-config-group-resource" style="display:none;padding-left:0px;">
						<select class="search-select" name="alarmTargetResource" id="alarmTargetResource" data-search="-1">
							<option value="CPU" selected="selected">CPU 사용율</option>
							<option value="MEMORY">메모리 사용율</option>
							<option value="DISK">디스크 사용율</option>
						</select>
						</div>
						<div class="col-md-2 alarm-config-group-resource" style="display:none;padding-left:0px;">
						<select class="search-select" name="alarmValueResource" id="alarmValueResource" data-search="-1">
							<option value="50">50% 초과</option>
							<option value="60">60% 초과</option>
							<option value="70" selected>70% 초과</option>
							<option value="80">80% 초과</option>
							<option value="90">90% 초과</option>
						</select>
						</div>
						<div class="col-md-1" style="padding-left:0px;">
							<button type="button" class="btn btn-primary btn-embossed" onclick="alarmConfigAdd();">추가</button>
						</div>
					</div>
				</fieldset>
				</div>
				<div class="col-md-12">
						<div class="form-group col-md-12" style="padding-left: 15px;height:400px;margin-top: 20px;">
							<div class="list_wrap" style="width:830px;height:400px;">
							<div class="t_line"><!-- PointColor --></div>
								<table class="table">
									<thead>
										<tr>
											<th class="text-center" style="width:120px;">구분</th>
											<th class="text-center">대상</th>
											<th class="text-center" style="width:250px;">조건</th>
											<th class="text-center" style="width:80px;">관리</th>
										</tr>
									</thead>
									<tbody id="alarmConfigListArea">
									</tbody>
								</table>
		              		</div>
						</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">닫기</button>
			</div>
			</form>
		</div>
	</div>
</div>

<script src="/assets/global/plugins/vue/vue.js"></script>
<script src="/assets/global/plugins/axios/axios.js"></script>
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

	$(document).ready(function() {

		/*
		1단계 메뉴의 체크박스에 변화가 있을때
		*/
		$("input[name$=All]").on('ifChanged', function(){
			var target = this;
			var targetObject = $(this);
			var child = $('input[name^='+target.value+']');

			child.each(function(a,b){
				if(target.checked){
					$(b).iCheck('check');
				}else{
					$(b).iCheck('uncheck');
				}
			});
		});

		/*
		2단계 체크박스에 변화가 있을때
		 - 내 친구들 모두 체크가 안되어있으면 부모도 체크를 없앤다
		 - 내가 체크되면 부모도 체크한다.
		*/
		$("input[name*=_]").on('ifChanged', function(){
			var target = this;
			var targetObject = $(this);

			var parent = target.id.split("_")[0];
			var child = $('input[name^='+parent+']');
			var length = child.length;
			var count = 0;
			if(!target.checked){
				child.each(function(a,b){
					if(b.checked){
						count++;
					}
				});

				if(count == 1){
					$("#"+parent+"All").iCheck('uncheck');
				}
			}else{
				child.each(function(a,b){
					if(b.checked){
						count++;
					}
				});
				if(count == length-1){
					$("#"+parent+"All").iCheck('check');
				}
			}
		});

		$('#alarmSe').on('select2:select', function (e) {
			value = e.target.value;
			if(value == 'R'){
				$('.alarm-config-group-resource').show()
				$('.alarm-config-group-interface').hide()
			}else{
				$('.alarm-config-group-interface').show()
				$('.alarm-config-group-resource').hide()
			}
		});

/*
		$("#alarmSe").bind("change", function toggleAlarmConfig(e){
			value = e.originalEvent.target.value;
			if(value == 'R'){
				$('.alarm-config-group-resource').show()
				$('.alarm-config-group-interface').hide()
			}else{
				$('.alarm-config-group-interface').show()
				$('.alarm-config-group-resource').hide()
			}
		}); */
	});

	var t;
	function regist(){
		axios.post('/console/userInfo',{mode : 'I'}).then((result)=>{
			var app = new Vue({
				el : "#userInfo-body",
				data : {
					message : result.data
				}
			});
			
			//$('#userInfo').draggable({handle: ".modal-header"});
			$('#form01 #mode').val("I");
			$('#form01 #userSeq').val("");
			$('#form01 #id').removeAttr("readonly");
			$('#form01 #id').removeAttr("disabled");

			$('.passwordChangeButton').hide();
			
			$('#userInfo').modal();
			formValidation();			
			
		});
		
/* 	 	$.ajax({
			url : '/console/userInfo',
			data : {mode : 'I'},
			method :'POST',
			success : function(result){				
				$('#userInfo .modal-body').html(result);
				$('#userInfo').draggable({handle: ".modal-header"});
				$('#form01 #mode').val("I");
				$('#form01 #userSeq').val("");
				$('#form01 #id').removeAttr("readonly");
				$('#form01 #id').removeAttr("disabled");

				$('.passwordChangeButton').hide();
				
				$('#userInfo').modal();
				formValidation();
			}
		}); */
	}

	function deleteItem(id, userSeq){
		if("admin" == id){
			notification("최상위 관리자(admin)는 삭제할 수 없습니다.");
			return false;
		}else{
			confirm('<strong>['+id+']</strong> 아이디를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function(){
				var sendData = {
					id : id,
					userSeq : userSeq
				};
				$('#confirmDiv').modal('hide');
			 	$.ajax({
					url : '/xhr/console/userInfoProcess/D',
					method :'POST',
					data : JSON.stringify(sendData),
					dataType : 'json',
					contentType: 'application/json',
					success : function(result){
						if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
							//notificationCallback("삭제되었습니다.", function(){document.location.reload();});
							document.location.reload();
						}else{
							notification('<strong>['+id+']</strong> 아이디 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}
					}
				});
			});
		}
	}

	function saveUser(){
		if($('#form01').valid()){
			var sendData = {
				nm : $('#form01 #nm').val(),
				email : $('#form01 #email').val(),
				moblphonNo : $('#form01 #moblphonNo').val(),
				userTy : $('#form01 #userTy').val(),
				rm : $('#form01 #rm').val(),
				userSeq : $('#form01 #userSeq').val()
			};

			var mode = $('#form01 #mode').val();
			$('#userInfo').modal('hide');

			var planeId = $('#form01 #id').val();
			var planePw = $('#form01 #loginPassword').val();

			//브라우저-서버 구간 암호화 적용
			var publicKeyModulus = $('#form01 #publicKeyModulus').val();
			var publicKeyExponent = $('#form01 #publicKeyExponent').val();

	        var rsa = new RSAKey();
	        rsa.setPublic(publicKeyModulus, publicKeyExponent);

	        var securedUsername = rsa.encrypt(planeId);
	        var securedPassword = rsa.encrypt(planePw);

	    	var pwChkData = {
				id: securedUsername,
	    		password: securedPassword
	        }

			if(mode == 'U'){
			 	$.ajax({
					url : '/xhr/console/passwordCheck',
					method :'POST',
					data : JSON.stringify(pwChkData),
					dataType : 'json',
					contentType: 'application/json',
					success : function(result){
						if(result.loginResult){
							sendData.id= securedUsername;
							sendData.password= securedPassword;
						 	$.ajax({
								url : '/xhr/console/userInfoProcess/U',
								method :'POST',
								data : JSON.stringify(sendData),
								dataType : 'json',
								contentType: 'application/json',
								success : function(result){
									if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
										$('#userInfo').modal('hide');
									}else{
										notification('<strong>['+planeId+']</strong> 사용자 저장 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
									}
								}
							});
						}else{
							notification('비밀번호 검증에 실패하였습니다. ');
						}
					}
			 	});
			}else{
				sendData.id = securedUsername;
				sendData.password = securedPassword;
				saveuserProcess(mode, sendData, sendData.id, planeId);
			}
		}

	}

	function saveuserProcess(mode, sendData, id, planeId){
	 	$.ajax({
			url : '/xhr/console/userInfoProcess/' + mode,
			method :'POST',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
					document.location.reload();
				}else{
					notification('<strong>['+planeId+']</strong> 사용자 저장 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}



	function modifyUser(userSeq, id){
		var sendData = {
			id : id,
			userSeq : userSeq
		};
	 	$.ajax({
			url : '/console/userInfo',
			data : {mode : 'U'},
			method :'POST',
			success : function(result){
				$('#userInfo .modal-body').html(result);
			 	$.ajax({
					url : '/xhr/console/userInfo',
					method :'POST',
					data : JSON.stringify(sendData),
					dataType : 'json',
					contentType: 'application/json',
					success : function(result){
						$('#form01 #id').attr("readonly","readonly");
						$('#form01 #id').attr("disabled","disabled");

						$('#form01 #userSeq').val(result.data.userSeq);
						$('#form01 #userTy').val(result.data.userTy);
						$('#form01 #id').val(result.data.id);
						$('#form01 #nm').val(result.data.nm);
						//$('#form01 #password').val(result.data.password);
						$('#form01 #email').val(result.data.email);
						$('#form01 #moblphonNo').val(result.data.moblphonNo);
						$('#form01 #rm').html(result.data.rm);
						$('#form01 #mode').val("U");
						formValidation();

						/* if('${ID}' != id){
							$('.passwordChangeButton').hide();
						}else{
							$('.passwordChangeButton').show();
						} */
						$('.passwordChangeButton').show();
						$('#userInfo').modal();
						//$('#userInfo').draggable({handle: ".modal-header"});
					}
				});
			}
		});
	}

	function userAuthManage(userSeq){
		$('#form02 input').each(function(a, b){
			$(b).iCheck('uncheck');
		});

		var sendData = {
			userSeq : userSeq
		};

	 	$.ajax({
			url : '/xhr/console/userMenuAuth',
			method :'POST',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				$('#form02 #userSeq2').val(userSeq)

				var dataList = result.data;
				for(var i = 0 ; i < dataList.length; i++){
					var item = dataList[i];
					var menuCode = item.menuCode;
					if(item.author == 'RW'){
						if(menuCode.substring(4,6) == "00"){
							var tLentgh =  $("input[name^="+menuCode+"_]").length;
							if(tLentgh == 0){
								$("input[name="+menuCode+"All]").iCheck('check');
							}
						}else{
							$("input[name$="+menuCode+"]").iCheck('check');
						}
					}
				}
				$('#userMenuAuth').modal();
			}
		});
	}

	function saveAuth(){
		var target = "";
		$('#form02 input').each(function(a,b){
			if(b.checked){
				target+=b.value+",";
			}
		});

		target = target.substring(0, target.length-1);
		var userSeq = $('#form02 #userSeq2').val();
		var sendData = {
			menuCodeParam : target,
			userSeq :userSeq
		};

 	 	$.ajax({
			url : '/xhr/console/userMenuAuthProcess',
			method :'POST',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
					$('#userMenuAuth').modal('hide');
					//notification("처리완료되었습니다.");
				}else{
					notification('메뉴 권한 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}

	function showAlarmConfigModal(id){
		var isAlarmSend = '${isAlarmSend}';
		
		if(isAlarmSend == 'true'){
		 	$.ajax({
				url : '/xhr/console/alarmConfigList/'+id,
				method :'POST',
				success : function(result){
					if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
						$('#form03 #userId').val(id)
						$('#userIdText').html("["+id+"]");
	 					$('#alarmConfigListArea').html('');
						for(var i = 0 ; i <result.data.length;i++){
							alarmConfigListAreaContent('I', result.data[i]);
						}
	
						$('#alarmManage').modal();
					}else{
						notification('오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}else{
			notification("알람 전송 설정이 되어있지 않습니다.  <br> 알람을 설정하시려면 property.xml의 'alarm.send.enable' 항목의 값을 true로 변경하세요.");
		}
	}

	function alarmConfigAdd(){
		var userId = $('#form03 #userId').val();
		var alarmSe = $('#form03 #alarmSe').val();
		var alarmTarget = "";
		var alarmValue = "";
		var alarmText = "";
		if(alarmSe == "I"){
			alarmTarget = $('#form03 #alarmTargetInterface').val();
			alarmValue = $('#form03 #alarmValueInterface').val();
			alarmText = $($('#form03 #alarmTargetInterface')[0].selectedOptions).html();
		}else{
			var agentInfo = $('#form03 #alarmTargetResourceAdd').val();
			alarmTarget = agentInfo + '|' +$('#form03 #alarmTargetResource').val();
			alarmValue = $('#form03 #alarmValueResource').val();
		}

		var data = {
				userId : userId
				,alarmSe : alarmSe
				,alarmTarget : alarmTarget
				,alarmValue : alarmValue
				,alarmText : alarmText
		}
		alarmConfigProcess(data, 'I', alarmConfigListAreaContent);
	}


	function alarmConfigListAreaContent(mode, data){
		console.log(data);
		var area = $('#alarmConfigListArea');
		if(mode == 'I'){
			var se = "";
			var ifid = "";
			var condition = "";
			var intrfcNm="";
			if(data.alarmSe == 'I'){
				se = '인터페이스';
				//ifid = data.alarmTarget+'('+data.intrfcNm+')';
				ifid = data.intrfcNm;
				condition = (data.alarmValue == 'S' ? '성공시' : data.alarmValue == 'E' ? '실패시':'수행시')
			}else{
				se = '자원';
				var sp = data.alarmTarget.split('|');
				var agent = sp[0]
				var target = sp[1]
				ifid = agent;
				condition = target +' 사용율 ' + data.alarmValue +'% 초과시';
			}
			var html = '';
			html += '<tr>';
			html += '<td>'+se+'</td>';
			html += '   <td>'+ifid+'</td>';
			html += '   <td>'+condition+'</td>';
			html += '   <td class="text-center" style="width:80px;">';
			
			/* <span class="label label-danger link2" id="alarmSeq'+data.alarmSeq+'" style="padding-left:5px;" onclick="alarmConfigDelete(\''+data.alarmSeq+'\')">x</span> */
			
			html += '   <button class="btn btn-sm btn-default icon-trash" id="alarmSeq'+data.alarmSeq+'" style="font-size: 14px; padding: 5px 20px !important;margin-right:0px;" onclick="alarmConfigDelete(\''+data.alarmSeq+'\');" data-rel="tooltip" data-placement="top" data-original-title="삭제"></button>';
			
			html += '</td>';
						
			
			html += '</tr>';

			area.append(html);

		}else if(mode == 'D'){
			$('#alarmSeq'+data.alarmSeq).parent().parent().remove()
		}
	}

	function alarmConfigDelete(alarmSeq){
		var data = {
			alarmSeq : alarmSeq
			,alarmText : ''
		}
		alarmConfigProcess(data, 'D', alarmConfigListAreaContent);
	}

	function alarmConfigProcess(data, mode, callback){
	 	$.ajax({
			url : '/xhr/console/alarmConfigProcess/'+mode,
			method :'POST',
			data : JSON.stringify(data),
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
					result.data.intrfcNm = data.alarmText;
					callback(mode, result.data)
				}else{
					notification('알람 설정 등록 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}


	function showPasswordChangeForm(){
		$('#userInfo').modal('hide');

		var userSeq = $('#userInfo #form01 #userSeq').val();
		var id = $('#userInfo #form01 #id').val();

		$('#userInfo .modal-body').html('');
		var sendData =  {mode : 'P', userSeq : userSeq, id: id};
	 	$.ajax({
			url : '/console/passwordChange',
			data : sendData,
			method :'POST',
			success : function(result){
				$('#passwordChange .modal-body').html(result);
				$('#passwordChange').modal();
			}
		});
	}

	function savePassword(){
		formValidation();
		var form = $('#passwordChange #form04');
		if(form.valid()){
			var planeId = form.find('#id').val();
			var planeOldPassword =  form.find('#oldPassword').val();
			var planeLoginPassword =  form.find('#loginPassword').val();

			//브라우저-서버 구간 암호화 적용
			var publicKeyModulus = $('#form04 #publicKeyModulus').val();
			var publicKeyExponent = $('#form04 #publicKeyExponent').val();

	        var rsa = new RSAKey();
	        rsa.setPublic(publicKeyModulus, publicKeyExponent);

	        var securedUsername = rsa.encrypt(planeId);
	        var securedOldPassword = rsa.encrypt(planeOldPassword);
	        var securedNewPassword = rsa.encrypt(planeLoginPassword);

	    	var pwChkData = {
				id: securedUsername,
	    		password: securedOldPassword
	        }
 
	    	$.ajax({
				url : '/xhr/console/passwordCheck',
				method :'POST',
				data : JSON.stringify(pwChkData),
				dataType : 'json',
				contentType: 'application/json', 
				success : function(result){
					if(result.loginResult){
				    	var sendData = {
				    		userSeq : $('#form04 #userSeq').val(),
							id: securedUsername,
							password: securedNewPassword
				        }
					 	$.ajax({
							url : '/xhr/console/userInfoProcess/P',
							method :'POST',
							data : JSON.stringify(sendData),
							dataType : 'json',
							contentType: 'application/json',
							success : function(result){
								$('#passwordChange').modal('hide');
								if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){									
									if(planeId == '${ID}'){
										notificationCallback('비밀번호가 변경되었습니다. 다시 로그인 하세요', function(){
											logoutProcess();
										});
									}else{
										$('#passwordChange').modal('hide');
									}
								}else{
									notification('<strong>['+id+']</strong> 비밀번호 변경 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
								}
							}
						});
					}else{
						notification('현재 비밀번호가 잘못되었습니다.');
					}
				}
		 	});
		}
	}


</script>

</html>