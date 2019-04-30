<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-md-12" style="padding-bottom: 20px;" id="hbaseConfogContent">
<input type="hidden" name="componentType" id="componentType" value="HTTP">
<input type="hidden" name=ruteNumber id="ruteSeq" value="${ruteSeq}">
<input type="hidden" name="compnSeq" id="compnSeq" value="${compnSeq}">
<c:if test="${mode == 'I' && data == null}">
	<c:set var="fromChecked" value="checked"/>
	<c:set var="toChecked" value=""/>
</c:if>
<c:if test="${mode == 'U' || mode == 'I' && data != null}">
	<c:if test="${data.endpntSe == 'F'}">
		<c:set var="fromChecked" value="checked"/>
		<c:set var="toChecked" value=""/>
	</c:if>
	<c:if test="${data.endpntSe == 'T'}">
		<c:set var="fromChecked" value=""/>
		<c:set var="toChecked" value="checked"/>
	</c:if>
</c:if>
	<fieldset style="margin-top:10px;padding:10px;padding-top: 1px;" >
		<legend><strong>컴포넌트 구분</strong></legend>
		<div class="col-md-12" style="margin-left:0px;padding-right:15px;">
			<div class="input-group">
				<div class="icheck-inline">
					<label><input type="radio" class="endpntSeClass" name="endpntSe" id="endpntSe" ${fromChecked} value="F" data-radio="iradio_minimal-blue"> FROM</label>
					<label><input type="radio" class="endpntSeClass" name="endpntSe" id="endpntSe" ${toChecked} value="T" data-radio="iradio_minimal-blue"> TO</label>
				</div>
			</div>
		</div>
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
			<label class="col-form-label required-item">컴포넌트 설명</label>
			<input type="text" class="form-control" name="compnNm" id="compnNm" value="${data.compnNm}" maxlength="20" required="required">
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;">
		<legend><strong>연결대상</strong></legend>
		<div class="col-md-12" style="padding-right:0px;">
			<div class="form-group col-md-6" style="padding-right:0px;">
				<label class="col-form-label required-item">데이터소스</label>
				<select id="dtasrcId" name="dtasrcId" class="form-control" required="required" onchange="displayUrlSample(this);">
					<c:forEach var="item" items="${HTTP_CONFIG_LIST}">
						<option data-servermode-yn="${item.serverModeYn}" data-url-sample="${item.prtclSe}://${item.ip}:${item.port}" value="${item.dtasrcId}">${item.dtasrcNm}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-6" style="padding-right:0px;padding-top: 30px;padding-left: 30px;">
				<span id="url_sample"></span>
			</div>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;">
		<legend><strong>기본정보</strong></legend>
		<div class="col-md-12" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">URL</label>
				<input type="text" class="form-control " name="url" id="url" value="${data.url}" required="required">
			</div>
		</div>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label">METHOD</label>
				<select id="method" name="method" class="form-control">
					<option value="POST">POST</option>
					<option value="GET">GET</option>
				</select>
			</div>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;" class="toEndpntSe">
		<legend><strong>파라메터</strong><i class="fa fa-plus-circle" onclick="addKeyValueItem('#paramItemArea', 'param');" style="cursor: pointer;"></i></legend>
		<div id="dctca" style="display: none;color: #994F4F;font-style: italic;margin-top: 10px;">필수항목입니다.</div>
		<div class="col-md-12" style="padding-left:0px;padding-right:0px;">
			<div class="col-md-5" style="padding-right:0px;">
				<div class="form-group col-md-12" style="">
					<label class="col-form-label">키</label>
				</div>
			</div>
			<div class="col-md-6" style="padding-right:0px;">
				<div class="form-group col-md-12" style="">
					<label class="col-form-label">값</label>
				</div>
			</div>
			<div class="col-md-1" style="padding-right: 0px;">
				<label class="form-label">삭제</label>
			</div>
		</div>
		<div class="col-md-12" style="padding-left:0px;" id="paramItemArea">
		<c:if test="${mode eq 'U'}">
			<c:forEach var="paramItem" items="${data.queryParamtrList}">
			<div class="col-md-12" style="padding: 0px 0px 0px 0px">
				<div class="col-md-5" style="padding-right:0px;padding-bottom: 3px;">
					<input type="text" class="form-control paramKey" name="paramKey" id="paramKey" value="${paramItem.key }" required="required">
				</div>
				<div class="col-md-6" style="padding-right:0px;padding-bottom: 3px;">
					<input type="text" class="form-control paramValue" name="paramValue" id="paramValue" value="${paramItem.value }" required="required">
				</div>
				<div class="col-md-1" style="padding-right:0px;">
					<i class="fa fa-minus-circle" style="cursor: pointer;padding-top:10px;padding-left:10px;" onclick="removeKeyValueItem(this);"></i>
				</div>
			</div>
			</c:forEach>
		</c:if>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;" class="toEndpntSe">
		<legend><strong>헤더</strong><i class="fa fa-plus-circle" onclick="addKeyValueItem('#headerItemArea', 'header');" style="cursor: pointer;"></i></legend>
		<div id="dctca" style="display: none;color: #994F4F;font-style: italic;margin-top: 10px;">필수항목입니다.</div>
		<div class="col-md-12" style="padding-left:0px;padding-right:0px;">
			<div class="col-md-5" style="padding-right:0px;">
				<div class="form-group col-md-12">
					<label class="col-form-label">키</label>
				</div>
			</div>
			<div class="col-md-6" style="padding-right:0px;">
				<div class="form-group col-md-12">
					<label class="col-form-label">값</label>
				</div>
			</div>
			<div class="col-md-1" style="padding-right: 0px;">
				<label class="form-label">삭제</label>
			</div>
		</div>
		<div class="col-md-12" style="padding-left:0px;" id="headerItemArea">
		<c:if test="${mode eq 'U'}">
			<c:forEach var="headerItem" items="${data.headerList}">
			<div class="col-md-12" style="padding: 0px 0px 0px 0px">
				<div class="col-md-5" style="padding-right:0px;padding-bottom: 3px;">
					<input type="text" class="form-control headerKey" name="headerKey" id="headerKey" value="${headerItem.key }" required="required">
				</div>
				<div class="col-md-6" style="padding-right:0px;padding-bottom: 3px;">
					<input type="text" class="form-control headerValue" name="headerValue" id="headerValue" value="${headerItem.value }" required="required">
				</div>
				<div class="col-md-1" style="padding-right:0px;">
					<i class="fa fa-minus-circle" style="cursor: pointer;padding-top:10px;padding-left:10px;" onclick="removeKeyValueItem(this);"></i>
				</div>
			</div>
			</c:forEach>
		</c:if>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;">
		<legend><strong>바디</strong></legend>
		<div class="col-md-12" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<textarea class="form-control" name="bodyTmplat" id="bodyTmplat" rows="5">${data.bodyTmplat }</textarea>
			</div>
		</div>
	</fieldset>
</div>

<script>
handleiCheck();
$('.endpntSeClass').on('ifChanged', function(event){
	$('#dtasrcId').val('');
	endpntSeToggle(event.currentTarget.value);
	$('#url_sample').html("");
});
function endpntSeToggle(endpntValue){
	if(endpntValue == 'F'){
		$('.fromEndpntSe').show();
		$('.toEndpntSe').hide();
		toggleDatasource('N');
	}else{
		$('.fromEndpntSe').hide();
		$('.toEndpntSe').show();
		toggleDatasource('Y');
	}
}
function toggleDatasource(v){
	var dtasrcOb = $('#dtasrcId')[0];
	var dtasrcLength = dtasrcOb.length;
	for(var i = 0 ; i < dtasrcLength;i++ ){
		var yn = $(dtasrcOb.options[i]).data('servermodeYn');
		if(v == yn){
			$(dtasrcOb.options[i]).hide();
		}else{
			$(dtasrcOb.options[i]).show();
		}
	}
}
function displayUrlSample(o){
	var text = "";
	var options = o.options;
	for(var i = 0 ; i < options.length;i++ ){
		if(options[i].selected){
			text = $(options[i]).data('urlSample');
			break;
		}
	}
	if(text != ''){
		$('#url_sample').html(" ("+text+")");
	}

}
$('#dtasrcId').val('${data.dtasrcId}');
$('#method').val('${data.method}');
</script>
<c:if test="${mode eq 'I' && data eq null }">
<script>
endpntSeToggle('F');
</script>
</c:if>
<c:if test="${mode eq 'U' || data ne null }">
<script>
	endpntSeToggle('${data.endpntSe}' == '' ? 'F' : '${data.endpntSe}');
	displayUrlSample($('#dtasrcId')[0])
</script>
</c:if>