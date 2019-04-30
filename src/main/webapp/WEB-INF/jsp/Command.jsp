<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.message-item:FIRST-CHILD {
	border-top: 1px solid #ECEBEB;
}
</style>
<div class="row">
	<div class="col-md-12">
		<div class="panel" style="margin-bottom: 15px;">
			<div class="panel-header">
				<h5 style="margin-top: 10px;"><i class="icon-list"></i> <strong>명령 실행</strong></h5>
			</div>
			<div class="panel-content" style="height: 700px;">
				<form id="form01" name="form01" class="form-horizontal form-validation" onsubmit="return false;" enctype="multipart/form-data" method="post">
				<div class="col-md-12 form-group">
					<div class="col-md-2 form-group">
					<select class="form-control" name="targetAgent" id="targetAgent">
					<c:forEach var="item" items="${AGENT_LIST }">
						<option value="${item.agentId}-${item.agentNo}">${item.agentId}-${item.agentNo}</option>
					</c:forEach>
					</select>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<label>경로</label>
					<input type="text" class="form-control" name="path" id="path" required="required">
				</div>
				<div class="col-md-12 form-group">
					<label>명령</label>
					<input type="text" class="form-control" name="command" id="command">
				</div>
				<div class="col-md-12 form-group">
					<button type="submit" class="btn btn-embossed btn-primary" onclick="runCommand();">실행</button>
					<textarea class="form-control" style="margin-top:10px; " rows="15" cols="100%" id="resultText"></textarea>
				</div>
				<div class="col-md-12 form-group">
					<div class="col-md-6 form-group">
						<input type="text" class="col-md-11 form-control" name="fileName" id="fileName">
					</div>
					<div class="col-md-6 form-group">
						<button type="submit" class="btn btn-embossed btn-primary" onclick="download();">다운로드</button>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<div class="col-md-6 form-group">
						<input type="file" class="col-md-11 form-control" name="uploadFile" id="uploadFile">
					</div>
					<div class="col-md-6 form-group">
						<button type="submit" class="btn btn-embossed btn-primary" onclick="upload();">업로드</button>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script src="/assets/global/plugins/jquery/jquery.form.min.js"></script>

<script type="text/javascript">
function runCommand() {

	var valid = $('#form01').valid();
	if(valid){
		$.ajax({
			url : '/xhr/command/runCommand',
			method : 'POST',
			data : $('#form01').serialize(),
			//dataType : 'json',
			//contentType: 'application/json',
			success : function(result, resultCode) {
				$('#resultText').html("");
				$('#resultText').html(result.MESSAGE);
			}
		});
	}
}
function download() {

	var valid = $('#form01').valid() && $('#path').val() != ""  && $('#fileName').val() != "" ;
	if(valid){
		$.fileDownload('/xhr/command/filedownload', {
			'data' : $('#form01').serialize()
		}).done(function() {
			alert('File download a success!');
		}).fail(function() {
			alert('File download failed!');
		});
	}
}


function upload(){
	ajaxForm = $('#form01').ajaxForm({
		beforeSubmit: function (data,form,option) {
			return $('#path').val() != ""  && $('#uploadFile').val() != "";
        },
        success: function(result, status){
      		console.log(result);
        },
        error: function(){
        }
	});
	ajaxForm[0].action = '/xhr/command/fileupload';
	ajaxForm.submit();
}

</script>
</html>