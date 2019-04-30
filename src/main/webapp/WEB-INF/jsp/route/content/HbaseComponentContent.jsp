<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-md-12" style="padding-bottom: 20px;" id="hbaseConfogContent">
<input type="hidden" name="componentType" id="componentType" value="HBASE">
<input type="hidden" name=ruteNumber id="ruteSeq" value="${ruteSeq}">
<input type="hidden" name="compnSeq" id="compnSeq" value="${compnSeq}">
<c:set var="toChecked" value="checked"/>
	<fieldset style="margin-top:10px;padding:10px;padding-top: 1px;" >
		<legend><strong>컴포넌트 구분</strong></legend>
		<div class="col-md-12" style="margin-left:0px;padding-right:15px;">
		<div class="input-group">
			<div class="icheck-inline">
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
				<label class="col-form-label">데이터소스</label>
				<select id="dtasrcId" name="dtasrcId" class="form-control">
				<c:forEach var="item" items="${DATASOURCE_LIST}">
					<option value="${item.dtasrcId}">${item.dtasrcId}(${item.dtasrcNm})</option>
				</c:forEach>
				</select>
			</div>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;">
		<legend><strong>수신정보</strong>
			<%-- <span class="label label-warning" style="margin-left:15px;padding-left:10px;padding-right:10px;cursor:pointer;" onclick="loadFromTableColumnListHbase('${ruteNumber}','0')">자동채우기</span> --%>
		</legend>
		<div id="dctca" style="display: none;color: #994F4F;font-style: italic;margin-top: 10px;">필수항목입니다.</div>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">매핑 참조 키</label>
				<input type="text" class="form-control " name="refrnKeyNm" id="refrnKeyNm" value="${data.refrnKeyNm}" required="required">
			</div>
		</div>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">HBase 테이블</label>
				<input type="text" class="form-control " name="ldadngTableNm" id="ldadngTableNm" value="${data.ldadngTableNm}" required="required">
			</div>
		</div>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
			</div>
		</div>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">로우 키</label>
				<input type="text" class="form-control" name="rowKey" id="rowKey" value="${data.rowKey}" required="required">
			</div>
		</div>
		<div class="col-md-12" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label">송수신 매핑</label>
				&nbsp;<i class="fa fa-plus-circle" onclick="addHbaseColumnContent(this)" style="cursor: pointer;"></i>
				<div class="col-md-12" style="padding:0px;">
					<table class="table table-hover" id="trList">
						<thead>
						<tr>
							<th class="col-md-1">번호</th>
							<th class="col-md-3">송신컬럼</th>
							<th class="col-md-1"></th>
							<th class="col-md-3">컬럼 패밀리(Family)</th>
							<th class="col-md-3">컬럼 한정자(Qualifier)</th>
							<th class="col-md-1">삭제</th>
						</tr>
						</thead>
						<tbody id="hbaseTableTbody">
						<c:forEach var="columnItem" items="${data.ldadngColumnList}" varStatus="idx">
							<tr>
								<td style="text-align:center">${idx.count}</td>
								<td style="text-align:left"><span id="value" name="value" class="editableSpanValue">${columnItem.value}</span></td>
								<td style="text-align:center"><i class="fa fa-long-arrow-right"></i></td>
								<td style="text-align:left"><span id="column" name="column" class="editableSpanColumn">${columnItem.columnFamily}</span></td>
								<td style="text-align:left"><span id="qualifier" name="qualifier" class="editableSpanQualifier">${columnItem.qualifier}</span></td>
								<td style="text-align:center"><i class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeRow(this);"></i></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</fieldset>
</div>
<script>
handleiCheck();
</script>
<c:if test="${mode eq 'U' || data ne null }">
<script>
	$('#dtasrcId').val('${data.dtasrcId}');
	$('.editableSpanValue').bind('click',editableSpanCallbackValue);
	$('.editableSpanColumn').bind('click',editableSpanCallbackColumn);
	$('.editableSpanQualifier').bind('click',editableSpanCallbackQualifier);

</script>
</c:if>