<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <title>B2EN Data Integration Solution</title>
        <link rel="shortcut icon" href="/assets/global/images/favicon.png">
        <link href="/assets/global/css/style.css" rel="stylesheet">
        <link href="/assets/global/css/ui.css" rel="stylesheet">
        <link href="/assets/global/plugins/bootstrap-loading/lada.min.css" rel="stylesheet">
    </head>
    <body class="sidebar-top account2" data-page="login">
        <!-- BEGIN LOGIN BOX -->
        <div class="container" id="login-block">
            <i class="user-img icons-faces-users-03"></i>
            <div class="account-info" style="width:53%;">
				<!-- <h2><strong>SFLOW</strong></h2> -->
				<img src="/assets/images/logo/logo-login.png" style="padding-top:20px;">
                <h3>Smart Data Collection & Integration</h3>
                <ul>
                    <li><i class="icon-layers"></i> 다양한 유형의 데이터 통합</li>
                    <li><i class="icon-arrow-right"></i> 안정성과 신뢰성 보장</li>
                    <li><i class="icon-magic-wand"></i> 설정기반 연계환경 구성</li>
                    <li><i class="icon-bar-chart"></i> 실시간 통합 모니터링</li>
                </ul>
            </div>
            <div class="account-form" style="width: 345px;">
                <form id="form01" class="form01" class="form-validation">
                    <h3><strong><spring:message code="login.title" text="로그인"></spring:message></strong></h3>
                    <div class="append-icon">
                        <input type="text" name="name" id="name" class="form-control form-white username" placeholder="아이디" value="" required>
                        <i class="icon-user"></i>
                    </div>
                    <div class="append-icon m-b-20">
                        <input type="password" id="password"  name="password" class="form-control form-white password" placeholder="비밀번호" value="" required onkeydown="keycheck();">
                        <i class="icon-lock"></i>
                    </div>
                    <button type="button" id="submit-form" class="btn btn-lg btn-dark btn-rounded" onclick="loginProcess();">로그인</button>
                    <div class="form-footer">
                        <div class="social-btn">
                            <button type="button" class="btn-fb btn btn-lg btn-block btn-square" onclick="pop('1')">${loginButtenName}</button>
                            <button type="button" class="btn btn-lg btn-block btn-blue btn-square" onclick="pop('2')">B2EN Homepage</button>
                        </div>
                        <div class="clearfix">

                        </div>
                    </div>
                </form>
            </div>
        </div>
		<div class="modal fade" id="notificationDiv" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-dark">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<i class="icons-office-52"></i>
						</button>
						<h4 class="modal-title">
							<strong>알림</strong>
						</h4>
					</div>
					<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;">
						<p id="notiContent"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-embossed confirm" onclick="javascript:$('#notificationDiv').modal('hide')">확인</button>
					</div>
				</div>
			</div>
		</div>
        <!-- END LOCKSCREEN BOX -->
        <p class="account-copyright">
				<span>Copyright <span class="copyright"></span> 2019. </span>
                <span>B2EN</span>.
                <span>All rights reserved.</span>
        </p>
        <script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
        <script src="/assets/global/plugins/jquery/jquery-migrate-3.0.0.min.js"></script>
        <script src="/assets/global/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="/assets/global/plugins/bootstrap-loading/lada.min.js"></script>
		<script src="/assets/global/plugins/jquery-validation/jquery.validate.js"></script>
		<script src="/assets/global/plugins/jquery-validation/src/localization/messages_ko.js"></script>
		<script src="/assets/global/plugins/crypto/jsbn.js"></script>
		<script src="/assets/global/plugins/crypto/rsa.js"></script>
		<script src="/assets/global/plugins/crypto/prng4.js"></script>
		<script src="/assets/global/plugins/crypto/rng.js"></script>
    </body>

    <script>
    //var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;

	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';

	document.onkeydown = aaaa;
	document.onkeyup = bbbb;

	var isCtrl = false;
	var isShift = false;
	function pop(num){
		// referrer 삭제
		var meta = document.createElement('meta');
		meta.name = "referrer";
		meta.content = "no-referrer";
		document.getElementsByTagName('head')[0].appendChild(meta);

		var url ='';
		if(num == '1'){
			url = '${loginButtenLink}';
		}else{
			url = 'http://www.b2en.com';
		}
		var newWindow = window.open("about:blank");
		newWindow.location.href = url;

	}

	function aaaa(e){
		if(e.keyCode == 16){
			isShift = true;
		}

		if(e.keyCode == 17){
			isCtrl = true;
		}

		if(e.keyCode == 65 && isShift && isCtrl){
		}
	}
	function bbbb(e){
		isCtrl = false;
		isShift = false;
	}

	function keycheck(e){
		e = e || window.event;
		if (e.keyCode == 13) {
			loginProcess();
		}
	}
    function loginProcess(){
    	var res = $('#form01').valid();
    	if(!res){
    		return false;
    	}

        var publicKeyModulus = '${publicKeyModulus}';
        var publicKeyExponent = '${publicKeyExponent}';
        var rsa = new RSAKey();
        rsa.setPublic(publicKeyModulus, publicKeyExponent);

        var securedUsername = rsa.encrypt($('#name').val());
        var securedPassword = rsa.encrypt($('#password').val());

    	var sendData = {
			id: securedUsername,
			password: securedPassword
    	}

     	$.ajax({
			url : '/xhr/loginProcess/login',
			method :'POST',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType: 'application/json',
			success : function(result){
				if(eval('result.'+STATUS_KEY) == STATUS_VALUE_OK ){
					if(result.result == true ){
						document.location.href=result.redirect;
					}else{
						notification(result.MESSAGE);
					}
				}else{
					notification('로그인 처리 과정에 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.');
				}
			}
		});

    }

    function notification(message){
		$('#notiContent').html(message);
		$('#notificationDiv').modal();
	}


    </script>
</html>
