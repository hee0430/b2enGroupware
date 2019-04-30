<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<!-- <link href="/assets/global/plugins/multiSelect/multi.min.css" rel="stylesheet"> -->
<!-- <link href="/assets/global/plugins/dual-list-box/bootstrap.min.css" rel="stylesheet"> -->
<style>
li .tooltip-inner {
    min-width:100px;
}
.jstree-default .jstree-clicked {
	background: #77b0ec;
}

.jstree-contextmenu .jstree-default-contextmenu {
	z-index: 99;
}

.dd {
	max-width: 100%;
}
</style>
<div class="row">
	<div class="col-lg-12 portlets">
		<div class="title">
			<h2>분류체계 관리</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content" style="height:718px;">
				<div class="nav-tabs3">
					<ul id="ctgryTab" class="nav nav-tabs">
						<c:forEach var="item" items="${list}" varStatus="idx">
							<li <c:if test="${idx.index == 0}">class="active"</c:if>>
								<a href="#tab_${item.ctgrySeq}" data-toggle="tab" id="${item.ctgrySeq}">${item.ctgryNm}</a>
							</li>
						</c:forEach>
						<li>
							<a href="#tab_default" data-toggle="tab" data-rel="tooltip" data-placement="top" data-original-title="분류체계추가">+</a>
						</li>
					</ul>
					<div class="tab-content">
						<c:forEach var="item" items="${list}" varStatus="idx">
							<div class="tab-pane fade <c:if test="${ idx.index == 0}">active in</c:if>" id="tab_${item.ctgrySeq}">
								<div class="row">
									<div class="col-md-12" style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
										<div class="col-md-3">
											<div class="col-md-12" style="text-align: right;">
												<span class="label label-default" style="cursor: pointer;" onclick="javascript:openNode('${item.ctgrySeq}');" data-rel="tooltip" data-placement="left" data-original-title="전체열기"><strong>+</strong></span>&nbsp;
												<span class="label label-default" style="cursor: pointer;" onclick="javascript:closeNode('${item.ctgrySeq}');" data-rel="tooltip" data-placement="left" data-original-title="전체닫기"><strong>-</strong></span>
											</div>
											<div class="col-md-12" id="treeView_${item.ctgrySeq}" style="height:590px;overflow-y:auto;overflow-x:hidden; "></div>
										</div>
										<!-- right panel -->
										<div class="col-md-9" style="margin:0px 0px 0px 0px;padding-left:0px;">
											<div class="col-lg-12 portlets" style="padding-left:0px;padding-right:0px;">
												<div class="panel" style="margin-bottom:0px">
													<div class="panel-content" style="height:612px;padding:0px;">
														<div class="col-md-12" style="padding:20px 15px 0px 0px;" >
															<div class="col-md-3 prepend-icon" style="z-index:1000">
																<input type="text" class="form-control" id="searchText_${item.ctgrySeq}" style="height:30px;">
    															<i class="fas fa-search" style="padding-left: 25px;"></i>
															</div>
															<div class="col-md-9" style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
															<a class="dt-button btn btn-white pull-right" onclick="categoryExcel('${item.ctgrySeq}')"><span><i class="fa fa-download"></i>다운로드</span></a>
															</div>
														</div>
														<div class="col-md-12" style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
															<div id="content_${item.ctgrySeq}" class="col-md-12" style="height:520px; overflow-y: auto; overflow-x: hidden; background: #FFF; padding-top: 10px;"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="tab-pane fade" id="tab_default">
							<p>분류체계를 추가하세요.</p>
							<div class="row">
								<div class="col-md-3">
									<input type="text" id="categotyName" name="categotyName" class="form-control form-white" maxlength="30">
								</div>
								<div class="col-md-3">
									<button type="button" class="btn btn-primary btn-embossed" onclick="addCategoty();">저장</button>
								</div>
								<div class="col-md-6"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="intrfcAddModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" style="color: white;" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>인터페이스 추가</strong></h4>
			</div>
			<div class="modal-body" style="padding-bottom:5px;">
				<div class="row" style="padding-top:0px;padding-left:15px;padding-right:15px;padding-bottom:0px;">
					<div class="col-md-12" style="padding-bottom:0px;">
					<form name="form01" id="form01">
						<input type="hidden" name="ctgrySeq" id="ctgrySeq">
						<input type="hidden" name="ctgryLevel" id="ctgryLevel">
						<fieldset style="margin-top:10px;padding:10px;">
							<div class="col-md-12" id="intrfcSelectArea"></div>
						</fieldset>
					</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="setIntrfcCtgry();">저장</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="ctgryConfigModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" style="color:white;" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>분류 추가</strong></h4>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="padding-bottom:20px;">
					<fieldset style="margin-top:10px;padding:10px;">
						<div class="col-md-12" style="padding-right:0px;padding-left:0px;">
							<div class="form-group col-md-12" style="padding-right:15px;">
								<form name="form02" id="form02" method="POST" onsubmit="addCategotyItem();">
								<input type="hidden" name="upperCtgrySeq" id="upperCtgrySeq">
								<input type="hidden" name="ctgrySeq" id="ctgrySeq">
								<input type="hidden" name="ctgryLevel" id="ctgryLevel">
								<input type="hidden" name="mode" id="mode">
								<label class="form-label">분류명</label> <input class="form-control col-md-12" type="text" id="ctgryNm" name="ctgryNm" maxlength="30" required="required">
								</form>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" tabindex="2" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary btn-embossed" tabindex="1" onclick="addCategotyItem();">저장</button>
			</div>
		</div>
	</div>
</div>
<form name="goWebPage" method="post" target="aster" action="/monitoring/transactionList">
	<input type="hidden" id="intrfcNm" name="intrfcNm">
</form>

<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jquery.fileDownload.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/jstree/jstree.js"></script>
<!-- <script src="/assets/global/plugins/multiSelect/multi.min.js"></script> -->
<script src="/assets/global/plugins/dual-list-box/dual-list-box.js"></script>
<script type="text/javascript">
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';
	var TAB_INDEX =  '${ctgrySeq}';

	function openNode(seq){
		$('#treeView_'+seq).jstree('open_all');
		//$('#treeView_'+seq).jstree('open_node', $('#treeView_'+seq).jstree("get_selected")[0], function(e, data) {})
	}

	function closeNode(seq){
		$('#treeView_'+seq).jstree('close_all');
		$('#treeView_'+seq).jstree("deselect_all");
		$('#treeView_'+seq).jstree('select_node', "F_"+seq+"_anchor");

		//$('#treeView_'+seq).jstree('close_node', $('#treeView_'+seq).jstree("get_selected")[0], function(e, data) {})
	}

	function getTabContent(target, level) {
		$.ajax({
			url : '/xhr/categoryManage/' + target + '/' + level + '/N',
			method : 'POST',
			success : function(result, resultCode) {				
				drawTree(JSON.parse(result.dataList), target);
			}
		});
	}

	var selectedDataList;
	function getMappingContent(target, level ,childExist) {
		$.ajax({
			url : '/xhr/categoryManage/' + target + '/' + level + '/N',
			method : 'POST',
			success : function(result, resultCode) {
				selectedDataList = result.mappingList;
				drawMappingArea(result.mappingList, TAB_INDEX, target, level, childExist);
			}
		});
	}

	function getInterfaceListContent(target, level) {
		var select = '<div id="dual-list-box" class="form-group row">';
		select += '<select id="intrfcId" multiple="multiple" data-title="인터페이스" data-value="index" data-text="name"></select>';
		select += '</div>';
		$('#intrfcSelectArea').html("");
		$('#intrfcSelectArea').html(select)
		$('#form01 #ctgrySeq').val(target);
		$('#form01 #ctgryLevel').val(eval(level)+1);

		$.ajax({
			url : '/xhr/categoryManage/intrfcList/' + TAB_INDEX + '/' + level,
			method : 'POST',
			success : function(result, resultCode) {

				var option = {
		               title: 'intrfcId'
					   ,titleText: '인터페이스'
		               ,text : 'intrfcNmId'
		               ,value : 'intrfcId'
		               ,element : $('#intrfcId')
		               ,dataList : result.intrfcList
		               //,json : true
				}
				$('#intrfcId').DualListBox(option, selectedDataList);
				$('#intrfcAddModal').modal();
				$('#intrfcAddModal').draggable({handle: ".modal-header"});
			}
		});
	}

	function setIntrfcCtgry(){
		var ctgrySeq = $('#form01 #ctgrySeq').val();
		var ctgryLevel = $('#form01 #ctgryLevel').val();

		var sss = $('.selected option');
		var intrfcId = '';
		for(var i = 0; i < sss.length; i++){
			var text = sss[i].value;
			intrfcId  += text + ',';
		}

		intrfcId = intrfcId.substring(0, intrfcId.length-1);
		var data = {
			ctgrySeq : ctgrySeq
			,ctgryLevel : ctgryLevel
			,intrfcId : intrfcId
		}
		$.ajax({
			url : '/xhr/categoryManage/process/II',
			method : 'POST',
			data : JSON.stringify(data),
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
 				if (eval('result.' + STATUS_KEY) != STATUS_VALUE_OK) {
					notification(result.MESSAGE);
				} else {
					$('#intrfcAddModal').modal('hide');
					getTabContent(TAB_INDEX, '0')
					getMappingContent(ctgrySeq, eval(ctgryLevel)-1);
				}
			}
		});
	}

	function drawMappingArea(data, target, seq, level, childExist) {
		$('#content_' + target).html("");
		var level = eval(level);
		var upperCategory = "";

		if(data != undefined){
			for (var i = 0; i < data.length; i++) {
				var item = data[i];
				var deletable = false;
				if(eval(item.ctgryLevel)-1 == level){
					deletable = true;
				}
				//$('#content_' + target).append(item.pathText + item.intrfcId + '(' + item.intrfcNm + ')<span class="label label-danger" onclick="deleteCategotyItem(\''+item.upperCtgrySeq+'\',\''+item.ctgrySeq+'\',\''+level+'\');">X</span><br>');
				$('#content_' + target).append(getItemForm(item.pathText, item.intrfcId, item.intrfcNm, item.upperCtgrySeq,item.ctgrySeq,level ,deletable));
				upperCategory = item.upperCtgrySeq;
			}
		}
		if(!childExist){
			$('#content_' + target).append(getItemAddForm(seq, eval(level)));
		}
	}

	function getItemForm(path, ifId, ifNm,upperCtgrySeq,ctgrySeq,level,deletable ){
		var html = "";
			html+='<div id="ctgryItem" style="width:316px;height:80px;border-radius: 5px;border:1px solid #c0c0c0;padding:3px;position: relative;display:inline-block;margin-right:3px;">';
			html+='		<div class="col-md-10 link" style="font-size:14px;font-weight:bold;padding-left:4px;pdding-right:0px;" id="ifNm" onclick="goTransaction(\''+ifNm+'\')">'+ifNm+'</div>';
			html+='		<div class="col-md-2" style="padding-right:3px;">';
			if(deletable){
				html+='			<div class="pull-right"><span class="icons-office-52" style="cursor:pointer;font-size: 10px;" onclick="deleteCategotyItem(\''+upperCtgrySeq+'\',\''+ctgrySeq+'\',\''+level+'\');"></span></div>';
			}else{
				html+='			<div class="pull-right"><span class="icons-office-52" style="cursor:pointer;font-size: 10px;" onclick="notification(\'현재 분류에서는 인터페이스를 삭제할 수 없습니다. <br>최하위 분류로 이동한 후에 다시 시도하세요.\');"></span></div>';
			}
			html+='		</div>';
			html+='		<div class="col-md-12" style="font-size:12px;padding-left:4px;padding-right:2px;" id="ifText">'+ifId+'</div>';
			html+='		<div class="col-md-12" style="font-size:8px;text-align:right;margin-top:25px;position: absolute;top:35px;padding-left: 5px;" id="pathText">'+path+'</div>';
			html+='	</div>';
		return html;
	}

	function getItemAddForm(ctgrySeq, level){
		var html = "";
			html+='<div id="ctgryItem" style="width:316px;height:80px;border-radius: 5px;border:1px solid #c0c0c0;padding:3px;position: relative;display:inline-block;margin-right:3px;">';
			html+='		<div class="col-md-10" style="font-size:14px;font-weight:bold;" id="ifNm"></div>';
			html+='		<div class="col-md-2" style="padding-right:3px;">';
			html+='			<div class="pull-right"></div>';
			html+='		</div>';
			html+='		<div class="col-md-12" style="font-size:12px;" id="ifText">';
			html+='		<div class="text-center" style="right:0px;">';
			html+='		<a href="javascript:getInterfaceListContent('+ctgrySeq+','+level+');"><i class="fa fa-plus fa-3x" style="color:#cccccc;padding-top:18px;"></i></a>';
			html+='		</div>';
			html+='		</div>';
			html+='	</div>';
		return html;
	}

	function goTransaction(nm){
		goWebPage.intrfcNm.value=nm;
	    window.open("", "aster");
	    goWebPage.submit();
	}

	var tmp;
	var tree;
	function drawTree(data, seq) {
		if (data != "") {			
			if (tree != undefined) {
				if ($('#treeView_' + seq).jstree())
					$('#treeView_' + seq).jstree().destroy();
			}

			tree = $('#treeView_' + seq).jstree({
				"core" : {
					"data" : data
				},
				"state" : { "key" : "ctgry" },
				"plugins" : ["contextmenu","state","types"],
				"contextmenu" : {
					"items" : function($node) {
						var tree = $("#tree").jstree(true);

						return {
							"Add" : {
								"separator_before" : false,
								"separator_after" : false,
								"label" : "추가",
								"action" : function(obj) {
									var level = $node.original.level;
									if(eval(level) >= 4){
										notification("더 이상 하위 분류를 추가할 수 없습니다.<br>하나의 분류체계는 4단계까지만 하위 분류를 허용합니다.");
									}else{
										$.ajax({
											url : '/xhr/categoryManage/' + $node.original.ctgrySeq + '/' + $node.original.level + '/Y',
											method : 'POST',
											success : function(result, resultCode) {
												var count = result.mappingList.length;
												if(count == 0){
													$('#form02')[0].reset();
													$('#form02 #upperCtgrySeq').val($node.original.ctgrySeq);
													$('#form02 #ctgryLevel').val(eval(level)+1);
													$('#form02 #mode').val("I");
													$('#ctgryConfigModal .modal-title').html("<strong>분류 추가</strong>") ;
													$('#ctgryConfigModal').modal();
												}else{
													notification("등록된 인터페이스가 있기 때문에 하위 분류를 추가할 수 없습니다.<br>인터페이스를 삭제 후 다시 시도하세요.");
												}
											}
										});
									}
								}
							},
							"Rename" : {
								"separator_before" : false,
								"separator_after" : false,
								"label" : "수정",
								"action" : function(obj) {
									var seq = $node.original.ctgrySeq;
									$.getJSON('/xhr/categoryManage/item/'+seq, function(result, status){										
										$('#form02')[0].reset();
										$('#form02 #ctgrySeq').val($node.original.ctgrySeq);
										$('#form02 #ctgryLevel').val($node.original.level);
										$('#form02 #ctgryNm').val(result.item.ctgryNm);
										$('#form02 #mode').val("U");
										$('#ctgryConfigModal .modal-title').html("<strong>분류 수정</strong>") ;
										$('#ctgryConfigModal').modal();										
									});

								}
							},
							"Remove" : {
								"separator_before" : false,
								"separator_after" : false,
								"label" : "삭제",
								"action" : function(obj) {
									console.log('읭....')
								}
							}
						};

					}
				},
		        'types' : {
		            'default' : {
		                'icon' : ''
		            },
		            'f-open' : {
		                'icon' : ''
		            },
		            'f-closed' : {
		                'icon' : ''
		            }
		        }
			}).bind("select_node.jstree", function(event, data) {
				var obj = data.node.original;
				var childExist = false;
				if (data.node.children.length > 0) {
					childExist = true;
				}
				getMappingContent(obj.ctgrySeq, obj.level, childExist);

				$('#searchText_'+TAB_INDEX).val("");
			});


			$('#treeView_' + seq).on('open_node.jstree', function (event, data) {
				//data.instance.set_type(data.node,'f-open');
			});
			$('#treeView_' + seq).on('close_node.jstree', function (event, data) {
// 				tmp = data;
	    		data.instance.set_type(data.node,'f-closed');
			});
			
			tree.jstree('open_all');
		}
	}

	function addCategoty() {
		var data = {
			ctgryNm : $('#categotyName').val()
			,ctgryLevel : '1'
			,upperCtgrySeq : '0'
			,ctgrySe : 'F'
		};
		addCateRequest(data, 'I', 'R');
	}

	function addCategotyItem(){
		var upperCtgrySeq = $('#form02 #upperCtgrySeq').val();
		var ctgrySeq = $('#form02 #ctgrySeq').val();
		var ctgryLevel = $('#form02 #ctgryLevel').val();
		var ctgryNm = $('#form02 #ctgryNm').val();
		var mode = $('#form02 #mode').val();

		var data = {
			ctgryNm : ctgryNm
			,ctgryLevel : ctgryLevel
			,upperCtgrySeq : upperCtgrySeq
			,ctgrySeq : ctgrySeq
			,ctgrySe : 'F'
			,tabIndex : TAB_INDEX
		};
		addCateRequest(data, mode);
	}

	function addCateRequest(data, mode, reload){
		$.ajax({
			url : '/xhr/categoryManage/process/'+mode,
			method : 'POST',
			data : JSON.stringify(data),
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					if("R" == reload){
						document.location.href = "/standard/categoryManage";
					}else{
						getTabContent(TAB_INDEX, '0')
						$('#ctgryConfigModal').modal('hide');
					}
				} else {
					notification('분류체계 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}

	function deleteCategoty(ctgryNm, ctgrySeq, ctgryLevel) {
		confirm('<strong>['+ctgryNm+']</strong> 분류를 삭제하시겠습니까?', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				ctgrySeq : ctgrySeq
				,ctgryLevel : ctgryLevel
			};
			$.ajax({
				url : '/xhr/categoryManage/process/D',
				method : 'POST',
				data : JSON.stringify(data),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if(1== ctgryLevel){
							document.location.href = "/standard/categoryManage";
						}else{
							getTabContent(TAB_INDEX, '0')
						}
					} else {
						notification('<strong>['+ctgryNm+']</strong> 분류체계 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		});
	}

	/*
	* 인터페이스 항목 삭제
	*/
	function deleteCategotyItem(upperCtgrySeq, ctgrySeq, level) {
		$('#confirmDiv').modal('hide');
		var data = {
			ctgrySeq : ctgrySeq,
			ctgryLevel : eval(level)+1
		};

 		$.ajax({
			url : '/xhr/categoryManage/process/D',
			method : 'POST',
			data : JSON.stringify(data),
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				getTabContent(TAB_INDEX, '0')
				getMappingContent(upperCtgrySeq, eval(level)-1, false)
			}
		});
	}

	function categoryExcel(seq){
		$.fileDownload('/categoryManage/excel/'+seq , {
		}).done(function() {
			alert('Excel file download succeeded.');
		}).fail(function() {
			alert('Excel file download failed.');
		});
	}

	$(document).ready(function() {
		searchEvent(TAB_INDEX);
		// 최초 화면 로딩
		if(eval(TAB_INDEX) != undefined){
			getTabContent(eval(TAB_INDEX), '0');
			$('#ctgryTab a[href="#tab_' + TAB_INDEX + '"]').tab('show');
			//tree.find('#F_1546').find('a').click()
			
		}

		// 탭 클릭했을때
		$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
			var target = $(e.target).attr("id") // activated tab
			if (target != undefined) {
				TAB_INDEX = target;

				// 마지막으로 클릭했던 항목 기억하려고 쿠키에 기록함
				$.getJSON('/standard/categoryManage/save/'+TAB_INDEX, function(){
					getTabContent(eval(target), '0');
					searchEvent(TAB_INDEX);	
				});

			}
		});

		$('input[id="ctgryNm"]').keydown(function() {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		});
	});


	function searchEvent(tabIndex){
		//검색
		$('#searchText_'+tabIndex).on('keyup',function(e){
			var text = $('#searchText_'+tabIndex).val();
			//$("#content_"+TAB_INDEX+" #ctgryItem").css("border", "1px solid #c0c0c0" );

			if(text != ''){
				$("#content_"+TAB_INDEX+" #ctgryItem").css("display", "none" );
				$("#content_"+TAB_INDEX+" #ctgryItem:contains('"+text+"')").css("display", "inline-block" );
			}else{
				$("#content_"+TAB_INDEX+" #ctgryItem").css("display", "inline-block" );
			}

		});
	}
</script>
