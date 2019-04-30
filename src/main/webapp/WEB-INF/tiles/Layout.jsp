<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="admin-themes-lab">
<meta name="author" content="themes-lab">
<link rel="shortcut icon" href="/assets/global/images/favicon.png" type="image/png">
<title>SFLOW</title>
<link href="/assets/global/plugins/datatables/dataTables.min.css" rel="stylesheet">
<link href="/assets/global/css/style.css" rel="stylesheet">
<link href="/assets/global/css/theme.css" rel="stylesheet">
<link href="/assets/global/css/ui.css" rel="stylesheet">
<link href="/assets/css/layout.css" rel="stylesheet">
<link href="/assets/css/custom.css" rel="stylesheet">
<script type="text/javascript">
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

	if ('' != '${AUTH_MESSAGE}') {
		history.back();
	}
</script>
<style>
.topbar .header-right .header-menu .dropdown-menu:after {
    display: none;
}
.scroll {
    height: auto;
    overflow: auto;
    overflow: hidden;
}
</style>
</head>
<!-- BEGIN BODY -->
<body class="sidebar-top fixed-topbar fixed-sidebar theme-sdtl color-default jui" style="height: 94%;overflow-x: auto;min-width:1910px">
	<!--[if lt IE 7]>
    <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
	<section>
		<!-- BEGIN SIDEBAR -->
		<div class="sidebar">
			<div class="logopanel" style="width: 250px;">
				<h1><a href="/summary"></a></h1>
			</div>
			<div class="sidebar-inner">
				<ul class="nav nav-sidebar">
					<c:forEach var="menu" items="${MENU_LIST}">
						<c:if test="${fn:length(menu.subMenuList)==0}">
							<c:if test="${MENU_CODE eq menu.menuCode}">
								<c:set var="className" value="active"></c:set>
							</c:if>
							<c:if test="${MENU_CODE ne menu.menuCode}">
								<c:set var="className" value=""></c:set>
							</c:if>
						</c:if>
						<c:if test="${fn:length(menu.subMenuList) > 0}">
							<c:if test="${UPPER_MENU_CODE eq menu.upperMenuCode}">
								<c:set var="className" value="active"></c:set>
							</c:if>
							<c:if test="${UPPER_MENU_CODE ne menu.upperMenuCode}">
								<c:set var="className" value=""></c:set>
							</c:if>
						</c:if>
						<c:if test="${fn:length(menu.subMenuList)==0}">
							<li class="${className}">
								<a href="${menu.menuUrl}" <c:if test="${menu.menuTy eq 'P'}">target="${menu.menuCode}"</c:if>><i class="${menu.menuIcon }"></i>
									<span>${menu.menuNm}</span></a>
							</li>
						</c:if>
						<c:if test="${fn:length(menu.subMenuList)>0}">
							<li class="nav-parent ${className}">
								<a href="#"><i class="${menu.menuIcon }"></i>
									<span>${menu.menuNm}</span></a>
								<ul class="children collapse">
									<c:forEach var="subMenu" items="${menu.subMenuList}">
										<c:if test="${MENU_CODE eq subMenu.menuCode}">
											<c:set var="subClassName" value="active"></c:set>
										</c:if>
										<c:if test="${MENU_CODE ne subMenu.menuCode}">
											<c:set var="subClassName" value=""></c:set>
										</c:if>
										<li class="${subClassName}">
											<a href="${subMenu.menuUrl }"> ${subMenu.menuNm}</a>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<div class="sidebar-footer clearfix">
					<a class="pull-left footer-settings" href="javascript:modifyUserMain('${USER_SEQ} ','${USER_ID}');" data-rel="tooltip" data-placement="top" data-original-title="계정 설정"> <i class="icon-settings"></i></a>
					<a class="pull-left btn-effect" href="javascript:logoutProcess();" data-modal="modal-1" data-rel="tooltip" data-placement="top" data-original-title="로그아웃"> <i class="icon-power"></i></a>
				</div>
			</div>
		</div>
		<!-- END SIDEBAR -->
		<div class="main-content">
			<!-- BEGIN TOPBAR -->
			<div class="topbar" style="left: 250px;">
				<div class="header-left">
					<div class="topnav">
						<a class="menutoggle" href="#" data-toggle="sidebar-collapsed"><span class="menu__handle">
								<span>Menu</span>
							</span></a>
						<!--               <ul class="nav nav-icons">
                <li><a href="#" class="toggle-sidebar-top"><span class="icon-user-following"></span></a></li>
                <li><a href="mailbox.html"><span class="octicon octicon-mail-read"></span></a></li>
                <li><a href="#"><span class="octicon octicon-flame"></span></a></li>
                <li><a href="builder-page.html"><span class="octicon octicon-rocket"></span></a></li>
              </ul> -->
					</div>
				</div>
				<div class="header-right">
					<ul class="header-menu nav navbar-nav">
						<!-- BEGIN NOTIFICATION DROPDOWN -->
						<li class="dropdown" id="notifications-header">
                			<a href="#" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                				<i class="icon-bell" data-rel="tooltip" data-placement="bottom" data-original-title="알림 보기"></i>
                					<span class="badge badge-danger badge-header bellAlarmCount">0</span>
                			</a>
			                <ul class="dropdown-menu" style="max-width: 990px !important;width: 380px;top:38px;left: -350px;">
								<li>
									<ul class="dropdown-menu-list scroll bellAlarmArea" data-height="220"></ul>
								</li>
			                </ul>
			              </li>
						<!-- END NOTIFICATION DROPDOWN -->
						<!-- BEGIN USER DROPDOWN -->
						<li class="dropdown" id="user-header">
							<a href="#" data-toggle="dropdown" data-hover="dropdown" data-close-others="true"> <span class="fa fa-user" style="padding-right: 5px;"></span> <span class="username">${USER_NAME}</span>
							</a>
							<ul class="dropdown-menu">
								<li>
									<a href="javascript:modifyUserMain('${USER_SEQ} ','${USER_ID}');"><i class="icon-settings"></i>
										<span>계정 설정</span></a>
								</li>
								<c:if test="${USER_TYPE == 'A'}">
								<li>
									<a href="javascript:consoleManage();"><i class="fa fa-desktop"></i>
										<span>콘솔 관리</span></a>
								</li>
								</c:if>
								<li>
									<a href="javascript:logoutProcess();"><i class="icon-logout"></i>
										<span>로그아웃</span></a>
								</li>
								
							</ul>
						</li>
						<!-- END USER DROPDOWN -->
						<!-- CHAT BAR ICON -->
					</ul>
				</div>
				<!-- header-right -->
			</div>
			<!-- END TOPBAR -->
			<!-- BEGIN PAGE CONTENT -->
			<div class="page-content">
				<tiles:insertAttribute name="content" />
				<tiles:insertAttribute name="footer" />
			</div>
			<!-- END PAGE CONTENT -->
		</div>
		<!-- END MAIN CONTENT -->
		<div class="modal fade" id="notificationDiv" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false" style="z-index: 3000">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-dark">
						<button type="button" class="close" style="color: white;" data-dismiss="modal" aria-hidden="true">
							<i class="icons-office-52"></i>
						</button>
						<h4 class="modal-title"><strong>알림</strong></h4>
					</div>
					<div class="modal-body" style="padding-top: 20px; padding-left: 20px; padding-right: 20px; padding-bottom: 0px; margin-bottom: 0px;">
						<p id="notiContent"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-embossed confirm" onclick="javascript:$('#notificationDiv').modal('hide')">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="confirmDiv" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false" style="z-index: 3000">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-dark">
						<button type="button" class="close" style="color: white;" data-dismiss="modal" aria-hidden="true">
							<i class="icons-office-52"></i>
						</button>
						<h4 class="modal-title"><strong>알림</strong></h4>
					</div>
					<div class="modal-body" style="padding-top: 20px; padding-left: 20px; padding-right: 20px; padding-bottom: 0px; margin-bottom: 0px;">
						<p id="confirmContent"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-gray btn-embossed" onclick="javascript:$('#confirmDiv').modal('hide')">취소</button>
						<button type="button" class="btn btn-primary btn-embossed confirm">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="userInfoMain" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-dark">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
						</button>
						<h4 class="modal-title">
							<strong>사용자 정보</strong>
						</h4>
					</div>
						<div class="modal-body">
						</div>
						<div class="modal-footer">
							<div class="modal-footer">
								<div class="col-md-12" style="padding:0px;">
									<div class="col-md-4" style="text-align: left;">
										<button type="button" class="btn btn-default btn-embossed passwordChangeButtonMain" onclick="showPasswordChangeFormMain();">비밀번호 변경</button>
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
		</div>
		<div class="modal fade" id="passwordChangeMain" tabindex="-1" role="dialog" aria-hidden="true">
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
							<button type="submit" class="btn btn-primary btn-embossed" onclick="savePasswordMain();">저장</button>
						</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="consoleManage" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false">
			<div class="modal-dialog modal-full">
				<div class="modal-content">
					<div class="modal-header bg-dark">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
						</button>
						<h4 class="modal-title">
							<strong>콘솔 관리</strong>
						</h4>
					</div>
						<div class="modal-body">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary btn-embossed" data-dismiss="modal">닫기</button>							
						</div>
				</div>
			</div>
		</div>
	</section>
	<!-- BEGIN PRELOADER -->
	<!-- 	<div class="loader-overlay">
      <div class="spinner">
        <div class="bounce1"></div>
        <div class="bounce2"></div>
        <div class="bounce3"></div>
      </div>
    </div> -->
	<!-- END PRELOADER -->
	
	<script src="/assets/global/plugins/modernizr/modernizr-2.6.2-respond-1.1.0.min.js"></script>
	<script src="/assets/global/plugins/jquery/jquery-migrate-3.0.0.min.js"></script>
	<script src="/assets/global/plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="/assets/global/plugins/bootstrap/js/bootstrap.js"></script>
	<script src="/assets/global/plugins/jquery-cookies/jquery.cookies.min.js"></script>
	<script src="/assets/global/plugins/jquery-block-ui/jquery.blockUI.min.js"></script>
	<script src="/assets/global/plugins/mcustom-scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="/assets/global/plugins/timepicker/jquery-ui-timepicker-addon.js"></script>
	<script src="/assets/global/plugins/jquery-validation/jquery.validate.js"></script>
	<!-- language -->
	<script src="/assets/global/plugins/jquery-validation/src/localization/messages_ko.js"></script>

	<script src="/assets/global/plugins/bootbox/bootbox.min.js"></script>

	<script src="/assets/global/plugins/icheck/icheck.min.js"></script>
	<script src="/assets/global/js/application.js"></script>
	<script src="/assets/global/js/plugins.js"></script>
	<script src="/assets/global/js/layout.js"></script>
	<script src="/assets/global/plugins/select2/dist/js/select2.full.js"></script>
	

	<!-- Select Inputs -->
	<!-- CUSTOM SCRIPTS -->
	<script src="/assets/js/websocket/sockjs.js"></script>
	<script src="/assets/js/websocket/stomp.js"></script>
	<script src="/assets/global/js/custom.js"></script>
	<script src="/assets/js/table.js"></script>
	<script src="/assets/js/common.js"></script>
	<!-- 암호화 -->
	<script src="/assets/global/plugins/crypto/jsbn.js"></script>
	<script src="/assets/global/plugins/crypto/rsa.js"></script>
	<script src="/assets/global/plugins/crypto/prng4.js"></script>
	<script src="/assets/global/plugins/crypto/rng.js"></script>
	<script type="text/javascript">

	var socket;
	var stompClient;
	var wsUrl = '/${WS_SERVICE_NAME}';
	var request = '${WS_REQUEST}/console';
	var response = '${WS_RESPONSE}/console';
	var sub1;
	$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
	$.fn.modal.Constructor.prototype.enforceFocus = function() {};

	$(function() {
		connectWebSocket();
	});

	function connectWebSocket() {
		try{
			socket = new SockJS(wsUrl);
			stompClient = Stomp.over(socket);
			stompClient.connect('', '', function(frame) {
				sub1 = stompClient.subscribe(response+'/bellAlarm', bellAlarmCallback, {});
				stompClient.send(request+'/bellAlarm', {}, {});
			});
		}catch(e){
			alert('서버 연결 실패');
		}
	}

	function bellAlarmCallback(message){
		var data = JSON.parse(message.body)
		var target = $('.bellAlarmArea');
		$('.bellAlarmCount').html(data.length);
 		target.html('');
		data.forEach(function(item){
			target.append(getBellAlarmContent("[" + item.agentId + "-" +  item.agentNo +"] " + item.message, item.eventTimeText, item.notificationType));
		});
		//target.mCustomScrollbar("destroy");
       	var scroll_height = target.data('height') ? target.data('height') : 'auto';
        var data_padding = target.data('padding') ? target.data('padding') : 0;
        if (target.data('height') == 'window') {
            thisHeight = target.height();
            windowHeight = $(window).height() - data_padding - 50;
            if (thisHeight < windowHeight) scroll_height = thisHeight;
            else scroll_height = windowHeight;
        }
        target.mCustomScrollbar({
            scrollButtons: {
                enable: false
            },
            autoHideScrollbar: true,
            scrollInertia: 150,
            theme: "dark-thick",
            set_height: scroll_height,
            advanced: {
                updateOnContentResize: true
            }
        });
	}

	function getBellAlarmContent(content, time, icon){
		var stop = "far fa-stop-circle c-gray";
		var start = "fas fa-heart c-red";
		var license = "fas fa-exclamation-circle c-red";

		var iconText ='';
		if("AGENT_STOP" == icon){
			iconText = stop;
		}else if("AGENT_START" == icon){
			iconText = start;
		}else if("LICENSE" == icon){
			iconText = license;
		}
		
		var html="";
		html+='<li>';
		html+='    <a href="#"><i class="p-r-10 f-18 '+iconText+'"></i>'+content+'<span class="dropdown-time">'+time+'</span></a>';
		html+='</li>';
		return html;
	}

	var calendarOption = {
		currentText : "현재",
		closeText : '완료',
		timeText : '시간',
		hourText : '시',
		minuteText : '분',
		timeFormat : 'HH:mm',
		dateFormat : 'yy-mm-dd',
		prevText : "<",
		nextText:">",
		monthNames : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		dayNamesMin : ["일", "월", "화", "수", "목", "금", "토"],
		showMonthAfterYear : true
	}

	function confirm(message, callback) {
		if (message == '' || message == null) {
			message = '처리완료되었습니다.';
		}
		$('#confirmContent').html(message);
		$('#confirmDiv').find('.confirm').unbind('click');
		$('#confirmDiv').find('.confirm').click(callback);
		$('#confirmDiv').modal();
	}

	function confirmUnbind() {
		$('#confirmDiv').find('.confirm').unbind('click');
	}

	function confirmClose() {
		$('#notiContent').html('');
		$('#notificationDiv').modal('hide');
	}

	function notification(message) {
		if (message == '' || message == null) {
			message = '처리완료되었습니다.';
		}
		$('#notiContent').html(message);
		$('#notificationDiv').modal();

	}

	function notificationCallback(message, callback) {
		if (message == '' || message == null) {
			message = '처리완료되었습니다.';
		}

		$('#notiContent').html(message);
		$('#notificationDiv').find('.confirm').unbind('click');
		$('#notificationDiv').find('.confirm').click(callback);
		$('#notificationDiv').modal();
	}

	function logoutProcess() {
		var sendData = {
			id : '${ID}'
		}

		$.ajax({
			url : '/xhr/loginProcess/logout',
			method : 'POST',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType : 'application/json',
			success : function(result) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					document.location.href = result.redirect;
				}
			}
		});

	}

	function modifyUserMain(userSeq, id){
		var sendData = {
			id : id,
			userSeq : userSeq
		};
	 	$.ajax({
			url : '/console/userInfo',
			method :'POST',
			success : function(result){
				$('#userInfoMain .modal-body').html(result);
			 	$.ajax({
					url : '/xhr/console/userInfo',
					method :'POST',
					data : JSON.stringify(sendData),
					dataType : 'json',
					contentType: 'application/json',
					success : function(result){
						$('#userInfoMain #form01 #id').attr("readonly","readonly");
						$('#userInfoMain #form01 #id').attr("disabled","disabled");

						$('#userInfoMain #form01 #userSeq').val(result.data.userSeq);
						$('#userInfoMain #form01 #userTy').val(result.data.userTy);
						$('#userInfoMain #form01 #id').val(result.data.id);
						$('#userInfoMain #form01 #nm').val(result.data.nm);
						//$('#userInfoMain #form01 #password').val(result.data.password);
						$('#userInfoMain #form01 #email').val(result.data.email);
						$('#userInfoMain #form01 #moblphonNo').val(result.data.moblphonNo);
						$('#userInfoMain #form01 #rm').html(result.data.rm);

						$('#userInfoMain #form01 #mode').val("U");
						$('#userInfoMain').modal();

						$('#userInfoMain .btn-primary').removeAttr('onClick');
						$('#userInfoMain .btn-primary').bind('click', saveUserMain);

						$('#userInfoMain').draggable({handle: ".modal-header"});
					}
				});
			}
		});
	}

	function saveUserMain(){
		if($('#userInfoMain #form01').valid()){

			var planeId = $('#userInfoMain #form01 #id').val();
			var planePw = $('#userInfoMain #form01 #loginPassword').val();

			//브라우저-서버 구간 암호화 적용
			var publicKeyModulus = $('#userInfoMain #form01 #publicKeyModulus').val();
			var publicKeyExponent = $('#userInfoMain #form01 #publicKeyExponent').val();

	        var rsa = new RSAKey();
	        rsa.setPublic(publicKeyModulus, publicKeyExponent);

	        var securedUsername = rsa.encrypt(planeId);
	        var securedPassword = rsa.encrypt(planePw);

	    	var sendData = {
				id: securedUsername,
	    		password: securedPassword
	        }

		 	$.ajax({
				url : '/xhr/console/passwordCheck',
				method :'POST',
				data : JSON.stringify(sendData),
				dataType : 'json',
				contentType: 'application/json',
				success : function(result){
					$('#userInfoMain').modal('hide');
					if(result.loginResult){
						var sendData = {
							id : securedUsername,
							nm : $('#userInfoMain #form01 #nm').val(),
							password : securedPassword,
							email : $('#userInfoMain #form01 #email').val(),
							moblphonNo : $('#userInfoMain #form01 #moblphonNo').val(),
							userTy : 'U',
							rm : $('#userInfoMain #form01 #rm').val(),
							userSeq : $('#userInfoMain #form01 #userSeq').val()
						};

						var mode = $('#userInfoMain #form01 #mode').val();
					 	$.ajax({
							url : '/xhr/console/userInfoProcess/U',
							method :'POST',
							data : JSON.stringify(sendData),
							dataType : 'json',
							contentType: 'application/json',
							success : function(result){
								if(eval('result.'+STATUS_KEY)==STATUS_VALUE_OK){
									$('#userInfoMain ').modal('hide');
								}else{
									notification('<strong>['+id+']</strong> 아이디 저장 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
								}
							}
						});
					}else{
						notification('비밀번호 검증에 실패하였습니다. ');
					}
				}
			});
		}
	}

	function showPasswordChangeFormMain(){
		$('#userInfoMain').modal('hide');

		var userSeq = $('#userInfoMain #form01 #userSeq').val();
		var id = $('#userInfoMain #form01 #id').val();

		$('#userInfoMain .modal-body').html('');
		var sendData =  {mode : 'P', userSeq : userSeq, id: id};
	 	$.ajax({
			url : '/console/passwordChange',
			data : sendData,
			method :'POST',
			success : function(result){
				$('#passwordChangeMain .modal-body').html(result);
				$('#passwordChangeMain').modal();
			}
		});
	}

	function savePasswordMain(){
		formValidation();
		var form = $('#passwordChangeMain #form04');
		if(form.valid()){
			var planeId = form.find('#id').val();
			var planeOldPassword =  form.find('#oldPassword').val();
			var planeLoginPassword =  form.find('#loginPassword').val();

			//브라우저-서버 구간 암호화 적용
			var publicKeyModulus = form.find('#publicKeyModulus').val();
			var publicKeyExponent = form.find('#publicKeyExponent').val();

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
				    		userSeq : form.find('#userSeq').val(),
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
									notificationCallback('비밀번호가 변경되었습니다. 다시 로그인 하세요', function(){
										logoutProcess();
									});
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
	
	function consoleManage(){
	 	$.ajax({
			url : '/xhr/console/manage',
			method :'POST',
			success : function(result){
				$('#consoleManage').find('.modal-body').html(result);				
				$('#consoleManage').modal();
				
			}
		}); 	
	}

	</script>
</body>
</html>
