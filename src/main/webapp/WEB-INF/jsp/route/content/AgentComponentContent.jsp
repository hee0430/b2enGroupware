<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-md-12" style="padding-bottom:20px;">
<input type="hidden" name="componentType" id="componentType" value="AGENT">
<input type="hidden" name=ruteSeq id="ruteSeq" value="${ruteSeq}">
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
	<legend><strong>기본정보</strong></legend>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label required-item">에이전트</label>
			<select id="referAgentId" name="referAgentId" class="form-control" required="required">
				<c:forEach var="item" items="${AGENT_LIST}">
					<option value="${item.agentId}">${item.agentId}(${item.agentNm})</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label col-2" style="padding-top:8px;">데이터 압축</label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="cmprsYn" id="cmprsYn" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label required-item">암호화 방식</label>
			<select class="col-md-6 form-control" id="encptTy" name="encptTy" required="required">
				<c:forEach var="item" items="${ENCRYPT_TYPE}">
				<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</fieldset>
</div>
<script>
handleiCheck();
</script>
<c:if test="${mode eq 'U' || data ne null }">
<script>
	if('${data.cmprsYn}' == 'Y'){
		$('#cmprsYn')[0].checked = true;
	}else{
		$('#cmprsYn')[0].checked = false;
	}

	$('#encptTy').val('${data.encptTy}');
	$('#referAgentId').val('${data.referAgentId}');
</script>
</c:if>