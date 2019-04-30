<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<div class="modal-dialog modal-full">
	<div class="modal-content">
		<div class="modal-header bg-dark">
			<button type="button" class="close" style="color: white;" data-dismiss="modal" aria-hidden="true">
				<i class="icons-office-52"></i>
			</button>
			<h4 class="modal-title"><strong>로그 조회 [<span id="logTargetAgentId"></span>]
			</strong></h4>
		</div>
		<div class="modal-body jui" style="padding-top: 20px; padding-left: 20px; padding-right: 20px; padding-bottom: 0px; margin-bottom: 0px; overflow-x: hidden;">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-2" style="height: 640px; overflow: auto; padding-left: 0px; padding-right: 0px;" id="treeView"></div>
					<div class="col-md-10" style="padding-right: 0px;">
						<div class="col-md-12" style="text-align: right; padding-right: 0px; padding-left: 0px;">
							<div class="col-md-6" style="text-align: left; padding-right: 0px; padding-left: 0px;">
								최종수정일시 : <span id="lastMod"></span>  / 파일 크기 : <span id="fileSize"></span>
							</div>
							<div class="col-md-6" style="text-align: right; padding-right: 0px;">
								<span id="readPer">0</span>
								%
								<button id="getMoreLog" type="button" class="btn btn-sm glyphicon glyphicon-arrow-up" style="margin-right: 0px;" disabled="disabled"></button>
								<button id="getLogFile" type="button" class="btn btn-sm glyphicon glyphicon-download-alt" style="margin-right: 0px;" disabled="disabled"></button>
							</div>
						</div>
						<div class="col-md-12" style="padding: 0px;">
							<textarea id="logContent" style="width: 100%;" rows="30" spellcheck="false"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary btn-embossed" data-dismiss="modal">닫기</button>
		</div>
	</div>
</div>
<script>


load();
function load() {
	var intrfcId = '${intrfcId}';
	var data = {
		operation : 'LIST',
		agentId : '${agentId}',
		agentNo : '${agentNo}'
	};

	$.ajax({
		url : '/xhr/agent/agentLog',
		method : 'POST',
		data : data,
		success : function(result, resultCode) {
			if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {				 
				drawTree(result);
				if("________" != intrfcId){
					tree.find('a:contains("'+intrfcId+'")').click();
				}
	 		} else {
	 			//$('#logView').modal('hide');
				notification('<strong>['+data.agentId+'-'+data.agentNo+']</strong> 에이전트의 로그 조회 과정에 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		}
	});
}

var tree;	
function drawTree(result) {
	tree = undefined;
	if (tree != undefined) {
		$('#treeView').jstree().destroy();
	}
	var data = result.data, agentId = result.agentId, agentNo = result.agentNo, agentSe = result.agentSe;
	for(i=0;i < data.length;i++){
		if(data[i].TYPE =='F'){
			data[i].icon = 'icon-doc';
		}else{
			data[i].icon = '';
		}
	}

	tree = $('#treeView').jstree({
		"core" : {
			"data" : data
		},
		"plugins" : ["contextmenu"],
		"contextmenu" : {
			"items" : function($node) {
				return {
					"Remove" : {
						"separator_before" : false,
						"separator_after" : false,
						"label" : "삭제",
						"action" : function(obj) {
							console.log('-----')
						}
					}
				};

			}
		}
	}).bind("select_node.jstree", function(event, data) {
		var type = data.node.original.TYPE;
		if (type == 'F') {
			var fileFullPath = data.node.original.PATH;
			var fileName = data.node.original.NAME;
			getLogContent(fileFullPath, agentId, agentNo, fileName);
		}
	});
}

function getLogContent(path, agentId, agentNo, fileName, endPos) {
	if (endPos == undefined) {
		endPos = -1;
	}
	var data = {
		agentId : agentId,
		agentNo : agentNo,
		operation : 'CONTENT',
		filePath : path,
		endPos : endPos
	};

	$.ajax({
		url : '/xhr/agent/agentLog',
		method : 'POST',
		data : data,
		success : function(result, resultCode) {
			$('#getLogFile').attr('disabled', 'disabled');

			var end = result.end;
			var length = result.length;
			var start = result.start;
			var content = result.data;

			if (length == 0) {
				$('#readPer').html("100");
			} else {
				var per = ((length - start) / length) * 100;
				$('#readPer').html(Math.round(per));
			}
			
			$('#lastMod').html(result.LAST_MOD);
			$('#fileSize').html(new Intl.NumberFormat().format(result.length));

			if (start > 0) {
				$('#getMoreLog').unbind('click');
				$('#getMoreLog').removeAttr('disabled');
				$('#getMoreLog').bind('click', function() {
					
					var area = $('#logContent');
					var message = area.html();
					var length = area.html().length;
					var totalByte = 0;
					for(var i =0; i < length; i++) {
						var currentByte = message.charCodeAt(i);
						// 한글은 2자, 그외는 1자를 추가해준다
						if(currentByte > 128) totalByte += 2;
						else totalByte++;
					}
					if(totalByte > 3145728){
						notification('3MB 이상은 미리보기 할수 없습니다. 로그 파일을 다운받아 확인하세요.');
						return false;
					}	
					
					
					getLogContent(path, agentId, agentNo, fileName, start);
				});
			} else {
				$('#getMoreLog').attr('disabled', 'disabled');
				$('#getMoreLog').unbind('click');
			}
			if (endPos == -1) {
				$('#logContent').html(content);
			} else {
				$('#logContent').html(result.data + $('#logContent').html());
			}

			if ($('#logContent').html().length) {
				$('#getLogFile').unbind('click');
				$('#getLogFile').removeAttr('disabled');
				$('#getLogFile').bind('click', function() {
					getLogDownload(path, agentId, agentNo, fileName);
				});
			}
		}
	});
}

function getLogDownload(path, agentId, agentNo, fileName) {
	var data = {
		agentId : agentId,
		agentNo : agentNo,
		filePath : path,
		fileName : fileName
	};

	$.fileDownload('/xhr/agent/agentLogDownload/', {
		'data' : data
	}).done(function() {
		alert('File download a success!');
	}).fail(function() {
		alert('File download failed!');
	});
}

</script>