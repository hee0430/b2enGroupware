var sfw;
var routeCount = 0;
var componentCount = 0;
var routeItemList= [];
var deleteComponentItemList= [];
var oldRouteInfo = [];
var componentChainTemplate = [];

var jsplumb;
$(document).ready(function() {
	if(undefined == sfw){
		routeWizard();
	}
	document.onkeydown = fkey;
	//편집영역에서 마우스 오른쪽 이벤트 삭제
	//$('.wizard-validation').on('contextmenu', function() {
	$(document).on('contextmenu', function() {
		return false;
	});
	$(document).on('mousedown', function(event) {
		if ((event.button == 0) || (event.which == 1)) {
			var container = $('.componentContextMenu');
			if (!container.is(event.target) && container.has(event.target).length === 0) {
				container.css("display", "none");
				allWhiteStyle();
			}
		}
	});
	$('#columnPasteModal').draggable();
	
	// 허용가능 컴포넌트 조합  
	// 1 route
	
	componentChainTemplate.push("HTTP-DATABASE");
	componentChainTemplate.push("HTTP-FILE");
	componentChainTemplate.push("HTTP-HTTP-");
	
	componentChainTemplate.push("DATABASE-DATABASE");
	componentChainTemplate.push("DATABASE-HBASE");
	componentChainTemplate.push("DATABASE-HTTP");	   
	componentChainTemplate.push("DATABASE-FILE"); 
	componentChainTemplate.push("DATABASE-FTP");  // 기준디렉토리 관련 오류 발생
	
	componentChainTemplate.push("FILE-FILE");		
	componentChainTemplate.push("FILE-DATABASE"); 
	componentChainTemplate.push("FILE-HTTP");
	componentChainTemplate.push("FILE-FTP"); 
	componentChainTemplate.push("FILE-HBASE"); // 테스트는 못해봤지만 DATABASE to hbase가 되므로 FILE (고정길이와 구분자 형식) to hbase로 될것으로 생각됨 
	
	componentChainTemplate.push("FTP-DATABASE"); // 기준디렉토리 관련 오류 발생
	componentChainTemplate.push("FTP-FTP");
	componentChainTemplate.push("FTP-FILE");
	
	// 2 route	
	componentChainTemplate.push("HTTP-AGENT-AGENT-HTTP");	
	componentChainTemplate.push("FILE-AGENT-AGENT-FILE");
	componentChainTemplate.push("FILE-AGENT-AGENT-FILE-HTTP");
	
	componentChainTemplate.push("DATABASE-AGENT-AGENT-DATABASE");
	componentChainTemplate.push("DATABASE-AGENT-AGENT-DATABASE-HTTP");
	componentChainTemplate.push("DATABASE-AGENT-AGENT-DATABASE-");
	
	componentChainTemplate.push("FTP-AGENT-AGENT-FTP");
	componentChainTemplate.push("FTP-AGENT-AGENT-FTP-HTTP");	
	// TBD

});

function fkey(e) {
	e = e || window.event;
	if (e.keyCode == 27) {
		$('.contextMenuItem').css('display', 'none');
	}
}

//========================================================================================================================================================
//RouteDesign script start
jsPlumb.bind("ready", function() {
	jsplumb = window.j = jsPlumb.getInstance({
		Container : routeDesignArea
		, Connector : "Flowchart" // 꺾은선
        , ConnectionOverlays : connectionOption
	});

	if(mode == 'I'){
		addRouteGroup(mode, 0, null, null);
		addRouteAddButton();
	}
	// 라우트 추가버튼 클릭시
	$('.route-addButton-item .triggerIcon').on('click', function (event) {
		$('.route-addButton-item').hide();
		addRouteGroup('I', 0, null, null);
	});
	$('.paletteItem').draggable({
		scope: "component-area"
	});

	/*  팔레트 아이템 드래그 시작 & 드래그 종료 이벤트 */
	$('.paletteItem').on('dragstart', function (event) {
		var target = event.originalEvent.currentTarget
		var position = $(target).position();
		$(target).fadeTo(1000, 0.9);
		$(event.originalEvent.currentTarget).on('dragstop', function (dropevent) {
			$(target).css('top','0px');
		    $(target).css('left','0px');
		});
	});
});



//RouteDesign script start
var sourceEndpointOptions = {
	  endpoint:"Dot",
	  paintStyle:{fill:'#7AB02C', radius : 5, position: "absolute"},
	  isSource:true,
	  connectorStyle : { stroke:"#666", outlineStroke:true, strokeWidth:2},
	  scope : "componentEndpoint"
};

var targetEndpointOptions = {
	  endpoint:"Dot",
	  paintStyle:{fill:'transparent', radius : 5 , position: "absolute", strokeWidth:2, stroke:"#7AB02C"},
	  connectorStyle : { stroke:"#666"},
	  isTarget:true,
	  scope : "componentEndpoint"
};

var connectionOption = [
    [ "Arrow", {
        location: 1,
        visible:true,
        width:11,
        length:11,
        id:"ARROW",
        events:{
            //click:function() { alert("you clicked on the arrow overlay")}
        }
    }]
]

/**
 * 라우트 그룹 추가
 * @returns
 */

function addRouteGroup(mode, ruteSeq, components, agentId){
	routeCount = routeCount+1;
	var item ="";
	var tempRuteSeq = routeCount;
	if(routeCount > 2){
		return false;
	}
	var routeGroupId = "routeGroup_" + routeCount;
	tempRuteSeq = routeCount;

	if(mode == 'I'){
		ruteSeq = 0;
	}

	$('#routeDesignArea').append(getRouteGroupItemContent(tempRuteSeq, ruteSeq, routeGroupId));

	inputSelect();
	if(undefined == sfw){
		routeWizard();
	}
	sfw.setProportion();


	if(agentId != null){
		$('#'+routeGroupId).find('#agentId').val(agentId)
	}
	
	/* 정확하게 영역에 드랍됐을때만 동작 하는 드랍 이벤트 */
	$('#'+routeGroupId+' .component-drop-area').droppable({
		scope: "component-area",
		tolerance: "pointer",
		drop: function( event, ui ) {
			var componentType = $(ui.draggable[0]).attr('data-compnTy');
			
			// 컴포넌트 떨구는 위치 지정 : 정확하지 않음 
			var top  = ui.offset.top - 380 ;
			var left ="";
			if(tempRuteSeq == 1){
				left = ui.offset.left - 400;
			}else{
				left = ui.offset.left - 1120;	
			}			
			var position = top+'px|'+left+'px';
			
			addComponentItem(tempRuteSeq, 0, componentType, $(this), ruteSeq, 0, 'I', position, null);
    	},
    	over : function ( event, ui){
    		console.log(event);
    		console.log(ui);
    	},
    	hoverClass : "dropzone-hover"
	});

	var dropArea = $("#"+routeGroupId).find('.component-drop-area');
	// 두번째 이후로 추가되는 라우트의 경우에는 AgentComponent를 기본추가한다. 그냥 추가해버리니까 이상해짐
	/*
	if(routeCount >= 2 && mode == 'I'){
		var position = '0px|0px';
		addComponentItem(tempRuteSeq, 0, "AGENT", dropArea, ruteSeq, 0, 'I', position, null);
	}
	*/

	if(mode == 'U'){
		components.forEach(function(data, idx){
			addComponentItem(data.tempRuteSeq, data.tempCompnSeq, data.componentType, dropArea, data.ruteSeq, data.compnSeq, mode, data.componentPosition, data.componentNm);
		});
	}
}

//에이전트(라우트)그룹 삭제
function removeGroup(id){
	var length = $('.route-group-item').length;
	if(length == 1){
		notification("최소 한개의 라우트는 존재해야 합니다. ");
		return false;
	}

	var deleteTarget = $('#'+id);

	var componentList = deleteTarget.find('.component');
	componentList.each(function(idx, item){
		var componentItem = $(item);
		var endPointList = jsplumb.getEndpoints(componentItem);
		endPointList.forEach(function(endpointItem, idx){
			jsplumb.deleteEndpoint(endpointItem)
		});
	});
	$('#'+id).remove();
	sfw.setProportion();
	routeCount = routeCount - 1;

	if($('.route-addButton-item').size() == 0){
		addRouteAddButton();
		$('.route-addButton-item .triggerIcon').on('click', function (event) {
			$('.route-addButton-item').hide();
			addRouteGroup('I', 0, null, null);
		});
	}
	$('.route-addButton-item').show();

}

/**
 * 컴포넌트 한개 추가
 * @param count
 * @param componentType
 * @param object
 * @param bothConnect
 * @returns
 */
var endpoint;
function addComponentItem(tempRuteSeq, tempCompnSeq, componentType, object, ruteSeq, compnSeq, mode, position, compnNm){
	componentCount++;
	//추가될 위치 설정
	var containComponentCount = $(object).find('.component').length;
	var top = containComponentCount * 10;
	var left = containComponentCount * 50;

	if(tempCompnSeq == 0){
		tempCompnSeq = containComponentCount+1;
	}

	//컴포넌트 아이템 추가
	var itemId = componentType+'_'+tempRuteSeq +'_'+ tempCompnSeq;
	object.append(getComponentItemContent(itemId, componentType, tempCompnSeq, compnSeq, tempRuteSeq, ruteSeq, compnNm));

	//위치 조정
	var component = $('#'+itemId);
	if(position != null){
		component.css('top', position.split('|')[0]);
		component.css('left', position.split('|')[1]);
	}

	//드래그 가능하게 설정
	jsplumb.draggable(component,{
		containment : object
    	, cursor: "move"
    	, grid: [ 9, 9 ]
   	});

	// 수정모드인경우 임시 저장 아이디 설정
	if('U' == mode){
		component.data('tempId', itemId);
	}

	//Anchor 추가
	var connectionCount = 1;
	
	var a = jsplumb.addEndpoint(itemId, {anchor:"LeftMiddle", uuid : 'left_anchor_' + itemId, enable:true, maxConnections : connectionCount}, targetEndpointOptions); //left anchor
	var b = jsplumb.addEndpoint(itemId, {anchor:"RightMiddle", uuid : 'right_anchor_' + itemId,  enable:true, maxConnections : connectionCount}, sourceEndpointOptions); //right anchor

	
	// contextMenu 제어
	var targetContext = "component";
	$('#'+itemId).on('mousedown', function(event) {
		if ((event.button == 2) || (event.which == 3)) {
			showMenu(targetContext);
		}else{
			toggleStyle($('#'+itemId));
		}
	});
}

function toggleStyle(ob){
	var isBlue = true;
	if(ob.hasClass('bg-white')){
		isBlue = false;
	}
	$('.component').each(function(idx,item){
		$(item).removeClass('bg-blue');
		$(item).addClass('bg-white');
	});

	if(!isBlue){
		ob.removeClass('bg-white');
		ob.addClass('bg-blue');
	}else{
		ob.removeClass('bg-blue');
		ob.addClass('bg-white');
	}
}

function allWhiteStyle(){
	$('.component').each(function(idx,item){
		$(item).removeClass('bg-blue');
		$(item).addClass('bg-white');
	});
}

function showMenu(target) {
	$('.contextMenuItem').hide();
	var event = window.event;
	var p = event.path;
	var loopCount = p.length;

	var contextObject = $('.'+target+'ContextMenu');
	for(var i = 0 ; i < loopCount ; i++){
		var item = $(p[i]);

		if(item.hasClass("component")){
			var componentType = item.attr('data-component-type');
			contextObject.find('.delete').unbind('click');
			contextObject.find('.modify').unbind('click');
			if("" != componentType){
				contextObject.find('.modify').bind('click', function(event){
					contextObject.hide();
					componentFormContent(componentType, item, isWorkItem);
				});
				contextObject.find('.delete').bind('click', function(){
					contextObject.hide();
					removeComponent(item);
				});
			}else{

			}
			break;
		}
	}
	contextObject.css('left', event.pageX);
	contextObject.css('top', event.pageY - 115);
	contextObject.show();
}


//에이전트(라우트) 그룹 디자인 템플릿
function getRouteGroupItemContent(tempRuteSeq, ruteSeq, id){
	var item = "";
	item+='<div class="route-group-item col-md-6 col-sm-12" data-temp-rute-seq="'+tempRuteSeq+'" data-rute-seq="'+ruteSeq+'" id="'+id+'" style="width:48%;">';
	item+='	<div style="height: 35px;margin-top: 10px;padding-left: 0px;">';
	item+='		<div>';
	item+='			<div class="col-md-11" style="padding-left: 15px;">';
	item+='			<select class="search-select" name="agentId" id="agentId" data-search="-1" style="width:; height:25px;">';
	for(var i = 0 ; i < agentList.length;i++){
		var agentConfig = agentList[i];
		item+='				<option value="'+agentConfig.agentId+'">'+agentConfig.agentId+'('+agentConfig.agentNm+')</option>';
	}
	item+='			</select>';
	item+='			</div>';
	item+='		</div>';
	item+='		<div class="control-btn" style="top:15px;z-index:1;">';
	item+='			<a href="javascript:removeGroup(\''+id+'\');" class="panel-close"><i class="icon-trash"></i></a>';
	item+='		</div>';
	item+='	</div>';
	item+='	<div class="component-drop-area col-md-12 grid" style="height:380px;position: absolute;margin-left: 14px;margin-top: 14px;width: 96%;">';
	item+='	</div>';
	item+='</div>';
	return item;


}


function addRouteAddButton(){
	//에이전트(라우트) 그룹 디자인 템플릿
	var item = "";
	item+='<div class="col-md-6 route-addButton-item" style="height: 455px;text-align: center;">';
	item+='	<div class="text-center" style="right:0px;padding-top:200px;">';
	item+='		<i class="fa fa-plus fa-5x triggerIcon link2" style="color:#cccccc;" data-rel="tooltip" data-placement="top" data-original-title="라우트 추가" ></i>';
	item+='	</div>';
	item+='</div>';

	$('#routeDesignArea').append(item);
	$('[data-rel="tooltip"]').tooltip();
}


//컴포넌트 디자인 템플릿
function getComponentItemContent(id, componentType, tempCompnSeq, compnSeq, tempRuteSeq, ruteSeq, compnNm){
	if(compnNm == null){
		compnNm = "설명";
	}

	var iconClass = "";
	if(componentType == 'AGENT'){
		iconClass = "fa fa-server";
	}else if(componentType == 'DATABASE'){
		iconClass = "fa fa-database";
	}else if(componentType == 'FILE'){
		iconClass = "fas fa-file";
	}else if(componentType == 'FTP'){
		iconClass = "fas fa-exchange-alt";
	}else if(componentType == 'HTTP'){
		iconClass = "fas fa-cloud";
	}else if(componentType == 'HBASE'){
		iconClass = "fas fa-archive";
	}

	var html = "";
	html +='<div class="component bg-white" id="'+id+'" data-component-type="'+componentType+'" data-rute-seq="'+ruteSeq+'"  data-temp-rute-seq="'+tempRuteSeq+'"  data-compn-seq="'+compnSeq+'" data-temp-compn-seq="'+tempCompnSeq+'" data-temp-id="">';
	html +='<table style="width:170px;margin-left: 14px;">';
	html +='	<tr >';
	html +='		<td style="height:35px;padding-left:5px;border-bottom:1px solid #c7c7c7;"><i class="'+iconClass+'" style="font-size: 18px;"></i><span style="padding-left: 6px;font-size: 14px;">'+componentType+'-'+tempCompnSeq+'</span> </td>';
	html +='	</tr>';
	html +='	<tr>';
	html +='		<td style="height:38px;" colspan="2"><p class="compnNm ellipsis" style="font-size: 14px;padding-top: 6px;width:170px;">'+compnNm+'</p></td>';
	html +='	</tr>';
	html +='</table>';
	html +='</div>';
	return html;
}

// 마지막 노드 찾기
function findLastComponent(){
	var lastComponentId = "";
	var findLast = false;
	jsplumb.selectEndpoints().each(function(endpoint){
		// 오른쪽 anchor에 연결된게 없는걸 마지막 노드로 본다
		if('RightMiddle' == endpoint.anchor.type){
			if(endpoint.connections.length == 0){
				findLast = true;
				lastComponentId = endpoint.elementId;
			}
		}
	});

	var top = $('#'+lastComponentId).css('top');
	var left = $('#'+lastComponentId).css('left');

	var result = {
			result : findLast
			,first : false
			,componentType : $('#'+lastComponentId).data("componentType")
			,componentId : lastComponentId
			,nextComponentId : ""
			,ruteSeq : $('#'+lastComponentId).data("ruteSeq")
		    ,compnSeq : $('#'+lastComponentId).data("compnSeq")
		    ,tempRuteSeq : $('#'+lastComponentId).data("tempRuteSeq")
		    ,tempCompnSeq :	$('#'+lastComponentId).data("tempCompnSeq")
		    ,componentPosition :  top +'|'+left
	}
	return result;
}

//입력된 노드의 이전 노드 찾기
function findPrevComponent(nextComponentId){
	var findPrev = false;
	var isFirst = false;
	var componentEndPoint = jsplumb.getEndpoints($('#'+nextComponentId));
	var componentId = "";
	var componentType = "";
	if(undefined != componentEndPoint){
		if(componentEndPoint[0].connections.length > 0){
			componentId = componentEndPoint[0].connections[0].sourceId;
			if(jsplumb.getEndpoints($('#'+componentId))[0].connections.length == 0){
				isFirst = true;
			}
			componentType = $('#'+componentId).data("componentType");
			findPrev = true;
		}
	}
	if(componentType == ''){
		findPrev = false;
	}
	var top = $('#'+componentId).css('top');
	var left = $('#'+componentId).css('left');

	var result = {
			result : findPrev
			,first : isFirst
			,componentType : componentType
			,componentId : componentId
			,nextComponentId : nextComponentId
			,ruteSeq : $('#'+componentId).data("ruteSeq")
		    ,compnSeq : $('#'+componentId).data("compnSeq")
		    ,tempRuteSeq : $('#'+componentId).data("tempRuteSeq")
		    ,tempCompnSeq :	$('#'+componentId).data("tempCompnSeq")
		    ,componentPosition :  top +'|'+left
	}
	return result;
}


//========================================================================================================================================================


/**
 * 컴포넌트 등록 폼 불러오기
 * @param compnTy
 * @param target
 * @returns
 */
function componentFormContent(compnTy, target, isWorkItem){
	var routeGroup = target.parent().parent();
	var agentId = target.parent().parent().find("#agentId").val();

	var ruteSeq = routeGroup.data("tempRuteSeq");
	var compnSeq = target.data("tempCompnSeq");

	var intrfcId = $('#intrfcId').val();
	var url = '';
	if('AGENT' == compnTy){
		url='/route/content/agentComponentContent/'+ruteSeq +'/'+compnSeq+'/'+isWorkItem;
	}else if('FILE' == compnTy){
		url='/route/content/fileComponentContent/'+ruteSeq +'/'+compnSeq+'/'+isWorkItem;
	}else if('DATABASE' == compnTy){
		url='/route/content/databaseComponentContent/'+ruteSeq +'/'+compnSeq+'/'+agentId+'/'+isWorkItem;
	}else if('HBASE' == compnTy){
		url='/route/content/hbaseComponentContent/'+ruteSeq +'/'+compnSeq+'/'+agentId+'/'+isWorkItem;
	}else if('HTTP' == compnTy){
		url='/route/content/httpComponentContent/'+ruteSeq +'/'+compnSeq+'/'+agentId+'/'+isWorkItem;
	}else if('FTP' == compnTy){
		url='/route/content/ftpComponentContent/'+ruteSeq +'/'+compnSeq+'/'+agentId+'/'+isWorkItem;
	}else{
		alert('준비중');
		return false;
	}
	var modalBody = $('#routeComponentInfo #formRoute').find('.modal-body');
	$.ajax({
		url : url
		,method :'POST'
		,data : {intrfcId:intrfcId}
		,success : function(result){
			modalBody.html(result);
			$('#routeComponentInfo').modal();
		}
	});
}

function removeComponent(item){
	var data = {
		ruteSeq : item.data("ruteSeq"),
		compnSeq : item.data("compnSeq"),
		componentType : item.data("componentType")
	}
	deleteComponentItemList.push(data);	
	jsplumb.remove(item[0].id) //el
}

/**
 * DATABASE 등록 폼에서 사용하는 table 설정 화면 불러오기 function
 * @param ruteSeq
 * @param compnSeq
 * @param endpntSe
 * @param newYn
 * @returns
 */
function addTableContent(ruteSeq, compnSeq, endpntSe, newYn, isWorkItem){
	var endpntSe = "F";
	if($('.endpntSeClass')[1].checked){
		endpntSe = "T";
	}
	if(compnSeq == ''){
		compnSeq = 0;
	}
	$('#dctca').hide();
	var interfaceId = $('#intrfcId').val();
	$.ajax({
		url : '/route/content/databaseComponentTableContent/'+ruteSeq+'/'+ compnSeq+'/'+interfaceId+'/'+endpntSe+'/'+newYn+'/' + isWorkItem
		,method :'POST'
		,success : function(result){
			if(endpntSe == 'F'){
				$('#fromDatabaseComponentTableContentArea').append(result);
			}else{
				$('#toDatabaseComponentTableContentArea').append(result);
				$('.editableSpanColumn').bind('click',editableSpanCallbackColumn);
				$('.editableSpanValue').bind('click',editableSpanCallbackValue);
				sfw.setProportion();
			}
		}
	});
}

function removeTableContent(target){
	$(target).parent().parent().parent().remove();
}

endpntSeToggle('${data.endpntSe}' == '' ? 'F' : '${data.endpntSe}');
function endpntSeToggle(endpntValue){
	if(endpntValue == 'F'){
		$('.fromEndpntSe').show();
		$('.toEndpntSe').hide();
	}else{
		$('.fromEndpntSe').hide();
		$('.toEndpntSe').show();
	}
}

function routeWizard(){
	sfw = $(".wizard-validation").stepFormWizard({
        height: "auto",
        theme: 'sea', // sea, sky, simple, circle
        rtl: $('body').hasClass('rtl') ? true : false,
        nextBtn: $('<a class="next-btn sf-right btn btn-primary" href="#">다음&nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a>'),
        prevBtn: $('<a class="prev-btn sf-left btn btn-default" href="#"><i class="fa fa-chevron-left"></i>이전</a>'),
        saveAndDistBtn: $('<button type="button" class="save-n-dist-btn sf-right btn btn-primary"><i class="fa fa-share-alt square"></i>저장&배포</button>'),
        finishBtn: $('<button type="button" class="finish-btn sf-right btn btn-primary"><i class="fa fa-save"></i>저장</button>'),
        onNext: onNextFunction,
        onFinish: onFinishFunction,
        onSaveAndDist: onSaveAndDistFunction,
        onSlideChanged : onSlideChanged
	});
}

//  라우트 설정 화면에서 다음 버튼 눌렀을때 이벤트
var sendData;
function onNextFunction(i, wizard) {

	var valid = true;
 	if(i == 0){
		valid = $('#intrfcId').valid() && $('#intrfcNm').valid();
    }
 	if(i == 1){
 		// 다음 화면으로 넘어가기 위한  검증 수행
 		var componentCount = $('.component').length
 		//1. 컴포넌트가 추가되었는지 확인
 		if(componentCount == 0){
 			if(mode == 'U'){
 				drawFlow();
 				return;
 			}else{
 				notification('컴포넌트를 추가하세요.');
 				return false;
			}
 		}
 		var chk2 = true;
 		//2. 화면에 추가된 라우트에 컴포넌트가 2개 이상인지 확인
 		$('.route-group-item').each(function(idx, data){
 			if($(data).find('.component').length < 2){
 				chk2 = false;
 			}
 		});
		if(!chk2){
			notification('컴포넌트는 단독으로 사용할 수 없습니다. 화면에 추가된 라우트에 컴포넌트를 추가하세요 ');
			return false;
		}

 		//3. 컴포넌트의 연결 상태 확인 (시작과 끝이 있는 형태로 연결되어야 함)
 		var lastnodeData = findLastComponent();
 		if(!lastnodeData.result){
 			notification('컴포넌트는 순환 형태로 연결될 수 없습니다. ');
 			return false;
 		}
 		//4. 연결되지 않은 컴포넌트가 있는지 확인
 		var componentList = makeFlowStructure(); 		
		if(componentCount != componentList.length){
			notification('연결되지 않은 컴포넌트가 있습니다.');
			return false;
		}
		//컴포넌트 연결 구성 상태가, 허용 가능한 형태인지 확인 
		if(!checkComponentChain(componentList)){
			notification('불가능한 컴포넌트 구성입니다.');
			return false;
		}
		
		
		//5.각 컴포넌트가 설정되었는지 확인
		// 컴포넌트에 tempId값 존재 확인하자
		var chk5 = true;
		var chkMessage = "";
		$('.component').each(function(idx, data){
			var tempId = $(data).data('tempId');
			var componentType = $(data).data('componentType');
			var compnSeq = $(data).data('tempCompnSeq');
			if(tempId == ""){
				if(chkMessage != ''){
					chkMessage +="<br>"
				}
				chkMessage += componentType + "-" + compnSeq  + " 컴포넌트를 설정하세요.";
				chk5 = false;
			}
		});
		if(!chk5){
			notification(chkMessage);
			return false;
		}

		return true;
 	}
	return valid;
}

function onSlideChanged(prev, now){
	
	if(prev == 0 && now == 1 && mode == 'U'){
		drawFlow();
	}
	if(prev == 2 && now == 1 && mode == 'U'){
		jsplumb.repaintEverything();
	}
	sfw.setProportion();
}

/**
 * 수정 모드일때 FLOW를 그려준다.
 * @returns
 */
function drawFlow(){	
	var tmpComponent = []; 

	if($('.route-group-item').length == 0){
		routeInfo.forEach(function(item){
			tmpComponent = tmpComponent.concat(item.componentList);
			addRouteGroup('U', item.ruteSeq, item.componentList, item.agentId);
		});

		tmpComponent.forEach(function(data, idx){
			var key = data.componentType + "_" + data.tempRuteSeq + "_" + data.tempCompnSeq;
			var nextCompnSeq = linkInfo[key];
			if(eval(nextCompnSeq) > 0){
				var source = jsplumb.getEndpoints($('#'+key))[1];
				var target = jsplumb.getEndpoints($('[data-compn-seq='+data.nextCompnSeq+']'))[0];
	
				var connectOption = {
						source : source
						,target : target
				}
				jsplumb.connect(connectOption);
			}
		});
		if($('.route-addButton-item').size() == 0 && $('.route-group-item').size() < 2){		
			addRouteAddButton()
	
			$('.route-addButton-item .triggerIcon').on('click', function (event) {
				$('.route-addButton-item').hide();
				addRouteGroup('I', 0, null, null);
			});
		}
	
		sfw.setProportion();
	}
}

//COMPONENT FLOW의 구조 생성
function makeFlowStructure(){
	var componentList = [];
	var lastnodeData = findLastComponent();
	var lastNode = lastnodeData.componentId;
	componentList.push(lastnodeData);
	while(true){
		var prevItem = findPrevComponent(lastNode);
		if(prevItem.result){
			componentList.push(prevItem);
		}
		if(prevItem.result && !prevItem.first){
			lastNode = prevItem.componentId;
		}else{
			break;
		}
	}
	return componentList;
}

function checkComponentChain(componentList){
	var result = false;
	
	var componentChainText = '';
	
	// 반대로 되어있으니 뒤집어~ 
	componentList.reverse();

	componentList.forEach(function(item, idx){
		var text = item.componentType;		
		if(componentChainText == ''){
			componentChainText = text;
		}else{
			componentChainText = componentChainText +"-" +text;
		}		
	});
	
	console.log(componentChainText);
	for(i = 0 ; i < componentChainTemplate.length; i++){
		if(componentChainText == componentChainTemplate[i]){
			result = true;
			break;
		}		
	}
	return result;
}



//저장 & 배포 버튼
function onSaveAndDistFunction(){
	if(scheduleProcess()){
		saveConfig("Y");
	}
}

//저장 버튼
function onFinishFunction (i, wizard) {
	if(scheduleProcess()){
		saveConfig("N");
	}
}

//저장!
function saveConfig(distributeYn){
	console.log(distributeYn)
	var interfaceConfigJSON;
	var scheduleConfigJSON;
	var routeArray = [];
	var scheduleSetYn = 'Y';

	//인터페이스
	var interfaceInputList = $('#interfaceArea').find('input');
	var ifForm = document.createElement('form');
	for(i=0;i<interfaceInputList.length;i++){
		var input = document.createElement('input');
		var itemName = interfaceInputList[i].name;
		input.name = itemName;
		if(itemName == 'syncYn' || itemName == 'trnscLogYn' || itemName == 'actvtyYn'){
			if(interfaceInputList[i].checked){
				input.value = 'Y'
			}else{
				input.value = 'N'
			}
		}else{
			input.value = interfaceInputList[i].value;
		}
		ifForm.appendChild(input);
	}

	var interfaceSelectList = $('#interfaceArea').find('select');
	for(i=0;i<interfaceSelectList.length;i++){
		var input = document.createElement('input');
		input.name = interfaceSelectList[i].name;
		input.value = interfaceSelectList[i].value;
		ifForm.appendChild(input);
	}
	interfaceConfigJSON = $(ifForm).serializeJSON();
	//라우트정보
	var firstAgentId = "";
	var routeDivArray = $('.route-group-item');
	for(var i=0;i<routeDivArray.length;i++){

		var ruteSeq = $(routeDivArray[i]).data("ruteSeq");
		var ruteOrder = i+1;
		var agentId = $(routeDivArray[i]).find('#agentId').val();
		var routeConfigItem = {
				ruteSeq : ruteSeq,
				ruteOrder : ruteOrder,
				agentId : agentId
		};
		routeArray.push(routeConfigItem);
	}

	//스케줄
	scheduleSetYn = 'Y';
	var scheduleInputList = $('#scheduleArea').find('input');
	var shForm = document.createElement('form');
	for(i=0;i<scheduleInputList.length;i++){
		var input = document.createElement('input');
		input.name = scheduleInputList[i].name;
		input.value = scheduleInputList[i].value;
		shForm.appendChild(input);
	}
	var scheduleSelectList = $('#scheduleArea').find('select');
	for(i=0;i<scheduleSelectList.length;i++){
		var input = document.createElement('input');
		input.name = scheduleSelectList[i].name;
		input.value = scheduleSelectList[i].value;
		shForm.appendChild(input);
	}
	firstAgentId = $($('.route-group-item')[0]).find('#agentId').val();
	shForm.agentId.value = firstAgentId;
	shForm.executTrgetNm.value = ifForm.intrfcId.value;

	if(shForm.schdulExecutSe.value == 'SIMPLE'){
		var value;
		if(shForm.simpleSecTextSelect.value == 'MIN'){
			value = shForm.simpleSecText.value * 60;
		}else{
			value = shForm.simpleSecText.value;
		}
 		shForm.secnd.value = value;
	}else if(shForm.schdulExecutSe.value == 'ONLINE'){
 		shForm.secnd.value = 0;
	}
	scheduleConfigJSON = $(shForm).serializeJSON();
	var flowConfigJSON = makeFlowStructure();

	var sendData = {
		interfaceConfig : interfaceConfigJSON
		,routeConfig : routeArray
		,scheduleConfig : scheduleConfigJSON
		,oldRouteInfo : oldRouteInfo
		,distributeYn : distributeYn
		,scheduleSetYn : scheduleSetYn
		,flowConfig : flowConfigJSON
		,deleteComponent : deleteComponentItemList
	};

 	$.ajax({
		url : '/xhr/route/routeConfigProcess/'+mode,
		method :'POST',
		data : JSON.stringify(sendData),
		dataType : 'json',
		contentType: 'application/json',
		success : function(result){
			if(eval('result.'+STATUS_KEY) == STATUS_VALUE_OK ){
				notificationCallback(result.MESSAGE, function(){
					document.location.href="/route/interfaceConfigList";
				});
			}else{
				notification('인터페이스 저장 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
			}
		}
	});
}
function tempSave(){
	
	
	var form = $('#formRoute')[0];
	var endpntSe = form.endpntSe.value;
	var compnTy = form.componentType.value;
	var compnSeq = form.compnSeq.value;
	var ruteSeq = form.ruteSeq.value;
	var compnNm = form.compnNm.value;

	var intrfcId = $('#intrfcId').val();
	
	var valid = $('#formRoute').valid();
	if(valid){
		var data;
		if('DATABASE' == compnTy){
			var tableList = $('#formRoute [id=refrnKeyNm]')
			if(tableList.length == 0){
				$('#dctca').show();
				return false;
			}
			data = makeDatabaseTempData(endpntSe);
			if(data.error == true){
				notification(data.errorMsg);
				return false;
			}else{
				data.componentType = compnTy;
				data.compnNm = compnNm;
			}
		}else if('HBASE' == compnTy){
			var tableList = $('#formRoute [id=refrnKeyNm]')
			if(tableList.length == 0){
				$('#dctca').show();
				return false;
			}
			data = makeHbaseTempData(endpntSe);
			data.componentType = compnTy;
			data.compnNm = compnNm;
		}else if('HTTP' == compnTy){
			data = makeHttpTempData(endpntSe);
			data.componentType = compnTy;
			data.compnNm = compnNm;
		}else if('FILE' == compnTy){
			data = $(form).serializeJSON();
			var bhderSkip = $(form).find('[id=hderSkipYn]')[0].checked;
			if(data.endpntSe == 'F'){
				data.rootDrctry = $(form).find('[id=rootDrctryFrom]').val()
				data.comptFileNm = $(form).find('[id=comptFileNmFrom]').val()
				data.subDrctryPttrn = $(form).find('[id=subDrctryPttrnFrom]').val()
				data.hderSkipYn = bhderSkip ? 'Y' : 'N';				
			}else{
				data.rootDrctry = $(form).find('[id=rootDrctryTo]').val()
				data.comptFileNm = $(form).find('[id=comptFileNmTo]').val()
				data.subDrctryPttrn = $(form).find('[id=subDrctryPttrnTo]').val()
				data.hderSkipYn = bhderSkip ? 'N' : 'Y';
			}

			// 필요없는 항목은 삭제
			delete data["rootDrctryFrom"];
			delete data["comptFileNmFrom"];
			delete data["subDrctryPttrnFrom"];
			delete data["rootDrctryTo"];
			delete data["comptFileNmTo"];
			delete data["subDrctryPttrnTo"];
			
		}else{
			data = $(form).serializeJSON();
		}

		var sendData = {
			intrfcId : intrfcId
			,storageMode : 'COMPONENT'
			,key : compnTy + "_" + ruteSeq + "_" + compnSeq
			,text : JSON.stringify(data)
		}

 		if($('#formRoute').find('.form-error').length == 0){
			$.ajax({
				url : '/route/routeConfigTempStorage'
				,method :'POST'
				,data : sendData
				,success : function(result){
					$("#"+compnTy+"_" + ruteSeq + "_" + compnSeq).data("tempId", result.id);
					$("#"+compnTy+"_" + ruteSeq + "_" + compnSeq + ' .compnNm').html(compnNm);
					$('#routeComponentInfo').modal('hide');
				}
			});
		}
	}
}


function makeHttpTempData(endpntSe){
	var data = {};
	data.dtasrcId = $('#formRoute #dtasrcId').val();
	data.endpntSe = endpntSe;
	data.compnSeq = $('#formRoute #compnSeq').val();
	data.compnOrder = $('#formRoute #compnOrder').val();
	data.url = $('#formRoute #url').val();
	data.method = $('#formRoute #method').val();
	if('T' == endpntSe){
		var paramLength = $('.paramKey').length;
		var headerLength = $('.headerKey').length;
		var paramList = [];
		for(var i = 0 ; i < paramLength ; i ++){
			var item = {};
			item.key = $($('.paramKey')[i]).val();
			item.value = $($('.paramValue')[i]).val();
			paramList.push(item);
		}
		data.queryParamtrList = paramList;
		var headerList = [];
		for(var j = 0 ; j < headerLength ; j ++){
			var item = {};
			item.key = $($('.headerKey')[j]).val();
			item.value = $($('.headerValue')[j]).val();
			headerList.push(item);
		}
		data.headerList = headerList;
	}
	data.bodyTmplat = $('#formRoute #bodyTmplat').val();

	return data;
}

function makeDatabaseTempData(endpntSe){
	var data = {};
	data.dtasrcId = $('#formRoute #dtasrcId').val();
	data.endpntSe = endpntSe;
	data.compnSeq = $('#formRoute #compnSeq').val();
	data.compnOrder = $('#formRoute #compnOrder').val();
	if('F' == endpntSe){
		data.paramtrInputSe = $('#formRoute #paramtrInputSe').val();
		data.sqlParamtr = $('#formRoute #sqlParamtr').val();
		data.atmcRehndlSe = $('#formRoute #atmcRehndlSe').val();
		var tableNameList = $('#formRoute #fromTableConfig');
		var sqlList = $('#formRoute [id=inqireSql]');
		var succesProcessSql = $('#formRoute [id=succesProcessSql]');
		var failrProcessSql = $('#formRoute [id=failrProcessSql]');
		var databaseConponentTableArray = [];
		var allResult = true;
		var allResultMessage = '';
		for(i = 0 ; i < tableNameList.length ; i++){
			var tableItem = {};

			tableItem.tableOrder = (i+1);
			tableItem.endpntSe = endpntSe;
			tableItem.refrnKeyNm = $(tableNameList[i]).find('#refrnKeyNm').val();

			tableItem.inqireSql = sqlList[i].value;
			chkQuery(tableItem.inqireSql, sqlList[i], 'S');

			tableItem.succesProcessSql = succesProcessSql[i].value;
			chkQuery(tableItem.succesProcessSql, succesProcessSql[i], 'U');

			tableItem.failrProcessSql = failrProcessSql[i].value;
			chkQuery(tableItem.failrProcessSql, failrProcessSql[i], 'U');

			databaseConponentTableArray.push(tableItem);
		}
		data.table = databaseConponentTableArray;
	}else{
		var recvTable = $('#toDatabaseComponentTableContentArea').find('fieldset');
		var length = recvTable.length;
		var tableArray = [];
		data.paramtrInputSe = 'M';
		data.atmcRehndlSe = 'N';
		for(i=0 ; i<length ; i++ ){
			var tableObject = $(recvTable[i]);
			var tableItem = {};
			tableItem.tableOrder = (i+1);
			tableItem.endpntSe = endpntSe;
			tableItem.ldadngTableNm = tableObject.find('#ldadngTableNm').val();
			tableItem.refrnKeyNm = tableObject.find('#refrnKeyNm').val();
			tableItem.ldadngTy = tableObject.find('#ldadngTy').val();

			var ldadngTy = tableObject.find('#ldadngTy').val();

			var trList = tableObject.find('table tbody tr');
			if("UD" != ldadngTy){
				var keyExist = false;
				var mappingArray = [];
				var keyText = "";
				for(j=0 ; j < trList.length ; j++ ){
					var mappingItem = {};
					var tr = trList[j];
					var errorItem = $(tr).find('input#value');

					if(errorItem.length > 0){
						if(errorItem.val() == ''){
							errorItem.addClass('form-error');
						}else{
							editableCallbackReverse(errorItem, 'value', errorItem.val());
						}
					}

					var errorItem = $(tr).find('input#column');
					if(errorItem.length > 0){
						if(errorItem.val() == ''){
							errorItem.addClass('form-error');
						}else{
							editableCallbackReverse(errorItem, 'column', errorItem.val());
						}
					}
					mappingItem.column = $(tr).find('#column').html();
					mappingItem.value = $(tr).find('#value').html();

					var isKey = $(tr).find('#isPrimaryKey')[0].checked;
					if(isKey){
						mappingItem.keyColumnYn = 'Y';
						keyText += mappingItem.value + ',';
						keyExist = true;
					}else{
						mappingItem.keyColumnYn = 'N';
					}
					mappingArray.push(mappingItem);
				}
				tableItem.ldadngColumnList = mappingArray;
				if(keyText.length > 0){
					keyText = keyText.substr(0, keyText.length-1);
				}
				tableItem.ldadngKeyColumn = keyText;

				if("UI" == ldadngTy && keyExist == false){
					data.error = true;
					data.errorMsg = "수신방식이 UPDATE-INSERT인 경우에는 기본키를 설정해야 합니다.";
				}
			}else{
				tableItem.inqireSql = tableObject.find('#inqireSql').val();
				chkQuery(tableItem.inqireSql, tableObject.find('#inqireSql'), 'U');
			}
			tableArray.push(tableItem);
		}
		data.table = tableArray;
	}
	return data;
}

function makeHbaseTempData(endpntSe){
	var data = {};
	data.dtasrcId = $('#formRoute #dtasrcId').val();
	data.compnSeq = $('#formRoute #compnSeq').val();
	data.compnOrder = $('#formRoute #compnOrder').val();
	data.endpntSe = endpntSe;
	data.ldadngTableNm = $('#ldadngTableNm').val();
	data.refrnKeyNm = $('#refrnKeyNm').val();
	data.rowKey = $('#rowKey').val();

	var trList = $('#trList tbody tr');

	var mappingArray = [];
	var keyText = "";
	for(j=0 ; j < trList.length ; j++ ){
		var mappingItem = {};
		var tr = trList[j];
		var errorItem1 = $(tr).find('input#value');
		if(errorItem1.length > 0){
			if(errorItem1.val() == ''){
				errorItem1.addClass('form-error');
			}else{
				editableCallbackReverse(errorItem1, 'value', errorItem1.val());
			}
		}
		var errorItem2 = $(tr).find('input#column');
		if(errorItem2.length > 0){
			if(errorItem2.val() == ''){
				errorItem2.addClass('form-error');
			}else{
				editableCallbackReverse(errorItem2, 'column', errorItem2.val());
			}
		}
		var errorItem3 = $(tr).find('input#qualifier');
		if(errorItem3.length > 0){
			if(errorItem3.val() == ''){
				errorItem3.addClass('form-error');
			}else{
				editableCallbackReverse(errorItem3, 'qualifier', errorItem3.val());
			}
		}


		mappingItem.value = $(tr).find('#value').html();
		mappingItem.columnFamily = $(tr).find('#column').html();
		mappingItem.qualifier = $(tr).find('#qualifier').html();

		mappingArray.push(mappingItem);
	}
	data.ldadngColumnList = mappingArray;
	return data;
}


function chkQuery(query, target, se){
	 $.ajax({
		url : '/route/queryValidCheck/'+se
		,method :'POST'
		,async : false
		,data : {sql : query}
		,success : function(result){
			if(!result){
				$(target).removeClass('form-success');
				$(target).addClass('form-error');
			}else{
				$(target).removeClass('form-error');
				$(target).addClass('form-success');
			}
		}
	});
}





//스케줄 설정화면 관련
function schduleExecutSection(type){
	if('CRON' == type){
		$('#simpleSecText').removeAttr('required');
		$('#scheduleSimple').hide();
		$('#scheduleCron').show();
		sfw.setProportion();
	}else if('SIMPLE' == type){
		$('#simpleSecText').attr('required','required');
		$('#scheduleSimple').show();
		$('#scheduleCron').hide();
		sfw.setProportion();
	}else if('ONLINE' == type){
		$('#simpleSecText').removeAttr('required');
		$('#scheduleSimple').hide();
		$('#scheduleCron').hide();
		sfw.setProportion();
	}
}


function scheduleProcess(){
	var valid = false;
	$('#schdulId').val('SC_'+$('#intrfcId').val());
	$('#schdulNm').val($('#intrfcNm').val() + ' 스케줄');
	var schdulExecutSe = $('#schdulExecutSe').val();
	valid = $('#schdulId').valid() && $('#schdulNm').valid() &&  $('#secnd').valid();
	if(schdulExecutSe == 'SIMPLE'){
		$('#secnd').val('');
		$('#min').val('');
		$('#hour').val('');
		$('#de').val('');
		$('#mt').val('');
		$('#day').val('');
		$('#yy').val('');
		valid = valid && $('#simpleSecText').valid();
	} else if(schdulExecutSe == 'CRON'){
		if("" == $('#secnd').val() && "" == $('#min').val() && "" == $('#hour').val() && "" == $('#de').val() &&"" == $('#mt').val() &&"" == $('#day').val() &&"" == $('#yy').val()){
			valid = false;
			$('#secnd').addClass('form-error');
		}
	} else if(schdulExecutSe == 'ONLINE'){
		valid = true;	
	}

	return valid;
}


function addColumnContent(event){
	var html = '';

	var div = $(event.parentElement)
 	var tbody = div.find('table tbody');
	var count = tbody.find('tr').length
	html+='<tr>';
	html+='	<td style="text-align: center">'+(count+1)+'</td>';
	var id1 = 'check1_' + new Date().getTime();
	html+='	<td style="text-align: left"><input type="text" name="value" id="value" class="form-control" style="width:90%;">&nbsp;<i id="'+id1+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i></td>';
	html+='	<td style="text-align: center"><i class="fa fa-long-arrow-right"></i></td>';
	var id2 = 'check2_' + new Date().getTime();
	html+='	<td style="text-align: left"><input type="text" name="column" id="column"  class="form-control" style="width:90%;">&nbsp;<i id="'+id2+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i></td>';
	html+='	<td style="text-align: center"><input id="isPrimaryKey" class="icheck-box" type="checkbox" data-checkbox="icheckbox_square-blue"></td>';
	html+=' <td style="text-align: center"><i class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeRow(this);"></i></td>';
	html+='</tr>';
	tbody.append(html) ;

	// checkbox 예쁘게 만들기
	$(tbody).find('.icheck-box').iCheck({
    	checkboxClass: 'icheckbox_minimal'
	});
	$('#'+id1).bind('click',editableCallbackReverseValue);
	$('#'+id2).bind('click',editableCallbackReverseColumn);

}

function addHbaseColumnContent(event){
	var div = $(event.parentElement)
 	var tbody = div.find('table tbody');
	var count = tbody.find('tr').length;

	var html = '';
	html+='<tr>';
	html+='	<td style="text-align: center">'+(count+1)+'</td>';
	var id1 = 'check1_' + new Date().getTime();
	html+='	<td style="text-align: left"><input type="text" name="value" id="value" class="form-control" style="width:90%;">&nbsp;<i id="'+id1+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i></td>';
	html+='	<td style="text-align: center"><i class="fa fa-long-arrow-right"></i></td>';
	var id2 = 'check2_' + new Date().getTime();
	html+='	<td style="text-align: left"><input type="text" name="column" id="column"  class="form-control" style="width:90%;">&nbsp;<i id="'+id2+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i></td>';
	var id3 = 'check3_' + new Date().getTime();
	html+='	<td style="text-align: left"><input type="text" name="qualifier" id="qualifier"  class="form-control" style="width:90%;">&nbsp;<i id="'+id3+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i></td>';
	html+=' <td style="text-align: center"><i class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeRow(this);"></i></td>';
	html+='</tr>';

	tbody.append(html) ;

	$('#'+id1).bind('click', editableCallbackReverseValue);
	$('#'+id2).bind('click', editableCallbackReverseColumn);
	$('#'+id3).bind('click', editableCallbackReverseQualifier);
}

function addHbaseColumnContentById(value, columnFamily, qualifier){
	var tbody = $('#hbaseTableTbody')
	var count = tbody.find('tr').length;

	var html = '';
	html+='<tr>';
	html+='	<td style="text-align: center">'+(count+1)+'</td>';
	html+='	<td style="text-align: left"><span id="value" name="value" class="editableSpanValue">'+value+'</span></td>';
	html+='	<td style="text-align: center"><i class="fa fa-long-arrow-right"></i></td>';
	html+='	<td style="text-align: left"><span id="column" name="column" class="editableSpanColumn">'+columnFamily+'</span></td>';
	html+='	<td style="text-align: left"><span id="qualifier" name="qualifier" class="editableSpanQualifier">'+qualifier+'</span></td>';
	html+='	<td style="text-align: center"><i class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeRow(this);"></i></td>';
	html+='</tr>';
	tbody.append(html) ;
}

function removeRow(row){
	var target = $(row);
	var tbody = target.parent().parent().parent();
	target.parent().parent().remove();
	var trList = tbody.find('tr');
	for(i=0;i<trList.length;i++){
		var oneItem = trList[i];
		$(oneItem).find('td')[0].innerHTML = (i+1);
	}
}

function editableSpanCallbackColumn(event){
	editableCallbackCommon(event, 'column');
}

function editableSpanCallbackValue(event){
	editableCallbackCommon(event, 'value');
}

function editableSpanCallbackQualifier(event){
	editableCallbackCommon(event, 'qualifier');
}

function editableCallbackCommon(event, target){
	var value = event.target.innerHTML;
	editableCallback(event.target, target, value);
}

function editableCallback(parent, target, value){
	var checkId = 'check_' + new Date().getTime();
	$(parent).parent().html('<input type="text" name="'+target+'" id="'+target+'" class="form-control" style="width:90%;" value="'+value+'">&nbsp;<i id="'+checkId+'" class="fa fa-check-circle" style="cursor: pointer;vertical-align: middle;"></i>');
	if(target == 'column'){
		$('#'+checkId).bind('click',editableCallbackReverseColumn);
	}else if(target == 'value'){
		$('#'+checkId).bind('click',editableCallbackReverseValue);
	}else{
		$('#'+checkId).bind('click',editableCallbackReverseQualifier);
	}
}

function editableCallbackReverseColumn(event){
	editableCallbackReverseCommon(event, 'column');
}

function editableCallbackReverseValue(event){
	editableCallbackReverseCommon(event, 'value');
}
function editableCallbackReverseQualifier(event){
	editableCallbackReverseCommon(event, 'qualifier');
}

function editableCallbackReverseCommon(event, target){
	var chValue = $(event.target).parent().find('[id='+target+']').val();
	if(chValue == ''){
		return false;
	}
	editableCallbackReverse(event.target, target, chValue);
}

function editableCallbackReverse(parent, target, chValue){
 	var checkId = 'check_' + new Date().getTime();
	$(parent).parent().html('<span name="'+target+'" id="'+target+'" class = "'+checkId+'">'+chValue+'</span>');
	if(target == 'column'){
		$('.'+checkId).bind('click',editableSpanCallbackColumn);
	}else if(target == 'value'){
		$('.'+checkId).bind('click',editableSpanCallbackValue);
	}else{
		$('.'+checkId).bind('click',editableSpanCallbackQualifier);
	}
}


function showColumnPasteModal(object, target){
	var areaDiv = object.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;

	var targetDiv = object.parentNode.parentNode.parentNode.parentNode;
	var form = $('#form10');

	$('#form10 .modal-footer #BTN_OK').unbind('click');
	$('#form10 .modal-footer #BTN_OK').bind('click', function(){
		var trLength =  $(targetDiv).find('tbody tr #'+target ).length;
		var columnDataText = $('#form10 #columnData').val();
		var splitColumnData;
		if(columnDataText != ''){
			splitColumnData = columnDataText.split('\n');
			var itemDataLength = splitColumnData.length;
			if(trLength < itemDataLength ){
				var addCount = itemDataLength - trLength;

				for(j = 0 ; j < addCount;j++){
					addColumnContent(areaDiv);
				}
			}

			for(i = 0 ; i < splitColumnData.length;i++){
				var cellTarget =  $(targetDiv).find('tbody tr #'+target );
				var itemData = splitColumnData[i];

				if(target == 'value'){
					itemData = ":" + itemData;
				}
				if('SPAN' == cellTarget[i].tagName){
					editableCallback(cellTarget[i], target, itemData);
				}else{
					$(cellTarget[i]).val(itemData);
				}
			}
		}
		$('#form10 #columnData').val('');
		$('#columnPasteModal').modal('hide');
		//$('#columnPasteModal').hide();
	});

	$('#form10 #columnData').val('');
	$('#columnPasteModal').modal({modalOver : true});
	//$('#columnPasteModal').show();
}

function loadFromTableComponentList(){
	var intrfcId = $('#intrfcId').val();

	$.getJSON('/route/content/databaseComponentListLoad/'+intrfcId, '',  function(data, result, object){
		var componentList = data.data;
		$('#componentSelectModal #componentSelect').html('');

		if(componentList.length == 1){
			loadFromTableColumnList('N', componentList[0].compnKey);
		}else{
			for(var i = 0 ; i < componentList.length ; i++ ){
				var item = componentList[i];
				var nm = item.compnNm;
				if(nm == ''){
					nm = "컴포넌트";
				}
				$('#componentSelectModal #componentSelect').append('<option data-interface-id="'+intrfcId+'" value="'+item.compnKey+'">'+item.componentType +"-"+ nm +'</option>');
			}
			$('#componentSelectModal').css('top', '300px')
			$('#componentSelectModal').modal({modalOver : true});
		}
	});
}

// to table 수신정보 자동 완성
function loadFromTableColumnList(multiYn, key){

	var intrfcId = $('#intrfcId').val();

	$('#dctca').hide();
	$('#toDatabaseComponentTableContentArea').html('')

	if(multiYn == 'Y'){
		key = $('#componentSelect').val();
	}

	$.ajax({
		url : '/route/content/databaseComponentTableContentLoad/' + intrfcId + '/' + key
		,method :'POST'
		,success : function(result){
			$('#componentSelectModal').modal('hide');
			$('#toDatabaseComponentTableContentArea').append(result);
			$('.editableSpanColumn').bind('click',editableSpanCallbackColumn);
			$('.editableSpanValue').bind('click',editableSpanCallbackValue);
		}
	});
}

var g;
function getTableMetaData(o){
	g = o;
	$('#getMetaError').hide();
	var errorNotiObject = $(g.parentNode).find('[id=getMetaError]');
	var agentId = $('#agentId').val();
	var dtasrcId = $('#dtasrcId').val();
	var refrnKeyNm = $(o.parentNode.parentNode.parentNode).find('[id=refrnKeyNm]').val();
/*	if(refrnKeyNm == '' || dtasrcId == ''  || agentId == '' ){
		return false;
	}*/
	if(dtasrcId == '' || dtasrcId == null){
		errorNotiObject.html('데이터소스를 선택하세요');
		errorNotiObject.show();
		return false;
	}
	if(refrnKeyNm == '' ){
		errorNotiObject.html('매핑 참조키를 입력하세요');
		errorNotiObject.show();
		return false;
	}
  	$.ajax({
		url : '/xhr/route/routeActiveStatusProcess/' + agentId + '/' + dtasrcId + '/' + refrnKeyNm,
		method :'POST',
		dataType : 'json',
		contentType: 'application/json',
		success : function(result){
			if(result.RESULT_CODE == 0){
				$('#getMetaError').html('');
				$('#getMetaError').hide();
				var text = result.COLUMN_TEXT;
				var target = $(o.parentNode.parentNode.parentNode).find('[id=inqireSql]');
				target.val(text);
			}else{
				var message = "";
				if(result.RESULT_CODE == -1){
					message="매핑 참조키(테이블명)를 확인하세요.";
				}else if(result.RESULT_CODE == -3){
					message="에이전트 실행상태를 확인하세요.";
				}
				errorNotiObject.html(message);
				errorNotiObject.show();
			}
		}
	});
}


function addKeyValueItem(id, type){
	var ob = $(id);
	var html = '';
	html+='<div class="col-md-12" style="padding: 0px 0px 0px 0px">';
	html+='		<div class="col-md-5" style="padding-right:0px;padding-bottom: 3px;">';
	html+='			<input type="text" class="form-control '+type+'Key" name="'+type+'Key" id="'+type+'Key" required="required">';
	html+='		</div>';
	html+='		<div class="col-md-6" style="padding-right:0px;padding-bottom: 3px;">';
	html+='			<input type="text" class="form-control '+type+'Value" name="'+type+'Value" id="'+type+'Value" required="required">';
	html+='		</div>';
	html+='		<div class="col-md-1" style="padding-right:0px;">';
	html+='			<i class="fa fa-minus-circle" style="cursor: pointer;padding-top:10px;padding-left:10px;" onclick="removeKeyValueItem(this);"></i>';
	html+='		</div>';
	html+='</div>';
	ob.append(html);
}

function removeKeyValueItem(ob){
	$(ob.parentElement.parentElement).remove();
}

function endpntSeMouseDownCallback(componentType, endpntSe, ruteSeq, compnSeq){
	
}

