<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="/assets/global/css/style.css" rel="stylesheet">
<link href="/assets/global/css/theme.css" rel="stylesheet">
<link href="/assets/global/css/ui.css" rel="stylesheet">
<link href="/assets/css/layout.css" rel="stylesheet">
<link href="/assets/css/custom.css" rel="stylesheet">


<div class="modal fade" id="confirmDiv" tabindex="-1" role="dialog" aria-hidden="true" data-close-others="false" style="display:none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" style="color:white;" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>알림</strong>
				</h4>
			</div>
			<div class="modal-body" style="padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:0px;margin-bottom:0px;">
				<p id="confirmContent">현재 계정은 해당 메뉴에 대한 접근권한이 없습니다.<br>시스템 관리자에게 접근권한을 요청하세요.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-embossed confirm">확인</button>
			</div>
		</div>
	</div>
</div>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="/assets/global/plugins/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$('.confirm').bind('click', function(){
			document.location.href ='${prevUrl}';
		});
		$('#confirmDiv').on("hidden.bs.modal", function () {
    		document.location.href ='${prevUrl}';
		});

		$('#confirmDiv').modal();
	});
</script>
</html>