<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${endpntSe eq 'F'}">
<c:if test="${fn:length(tableList) > 0}">
<c:forEach var="item" items="${tableList}">
<fieldset style="margin-top:10px;padding:10px;" id="fromTableConfig">
	<div class="panel-header">
		<div class="control-btn" style="text-align:right;">
			<i class="icon-trash" style="cursor:pointer;" onclick="removeTableContent(this);"></i>
		</div>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label required-item">매핑 참조키</label>
		<input type="text" class="form-control" name="refrnKeyNm" id="refrnKeyNm" value="${item.refrnKeyNm}" required="required" data-error-position="before">
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label"><span class="required-item">송신 데이터 선정 SQL</span><span class="label label-warning" style="margin-left:15px;padding-left:10px;padding-right:10px;cursor:pointer;" onclick="getTableMetaData(this);">쿼리생성</span><div id="getMetaError" style="display:none;color:#994F4F;font-style:italic;margin-top:10px;"></div></label>
		<textarea class="form-control" id="inqireSql" name="inqireSql" required="required" rows="5" cols="" data-error-position="before">${item.inqireSql}</textarea>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label">성공처리 SQL</label>
		<textarea class="form-control" id="succesProcessSql" name="succesProcessSql" rows="3" cols="" data-error-position="before">${item.succesProcessSql}</textarea>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label">실패처리 SQL</label>
		<textarea class="form-control" id="failrProcessSql" name="failrProcessSql" rows="3" cols="" data-error-position="before">${item.failrProcessSql}</textarea>
	</div>
</fieldset>
</c:forEach>
</c:if>
<c:if test="${fn:length(tableList) eq 0}">
<fieldset style="margin-top:10px;padding:10px;" id="fromTableConfig">
	<div class="panel-header">
		<div class="control-btn" style="text-align:right;">
			<i class="icon-trash" style="cursor: pointer;" onclick="removeTableContent(this);"></i>
		</div>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label required-item">매핑 참조키</label>
		<input type="text" class="form-control" name="refrnKeyNm" id="refrnKeyNm" required="required"  data-error-position="before">
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label required-item">송신 데이터 선정 SQL <span class="label label-warning" style="margin-left:15px;padding-left:10px;padding-right:10px;cursor:pointer;" onclick="getTableMetaData(this);">쿼리생성</span><div id="getMetaError" style="display:none;color:#994F4F;font-style:italic;margin-top:10px;">매핑 참조키(테이블명)를  확인하세요.</div></label>
		<textarea class="form-control" id="inqireSql" name="inqireSql" required="required" rows="5" cols="" data-error-position="before"></textarea>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label">성공처리 SQL</label>
		<textarea class="form-control" id="succesProcessSql" name="succesProcessSql" rows="3" cols="" data-error-position="before"></textarea>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label">실패처리 SQL</label>
		<textarea class="form-control" id="failrProcessSql" name="failrProcessSql" rows="3" cols="" data-error-position="before"></textarea>
	</div>
</fieldset>
</c:if>
</c:if>
<c:if test="${endpntSe eq 'T'}">
<c:if test="${fn:length(tableList) > 0}">
<c:forEach var="tableItem"  items="${tableList}">

<c:set var="notUserDefineItem"></c:set>
<c:set var="userDefineItem">display:none</c:set>
<c:if test="${tableItem.ldadngTy eq 'UD' }">
	<c:set var="notUserDefineItem">display:none</c:set>
	<c:set var="userDefineItem"></c:set>
</c:if>

<fieldset style="margin-top:10px;padding: 10px;" id="toTableConfig">
	<div class="panel-header">
		<div class="control-btn" style="text-align:right;">
			<i class="icon-trash" style="cursor: pointer;" onclick="removeTableContent(this);"></i>
		</div>
	</div>
	<div class="col-md-6" style="padding-left:0px;padding-right:0px;">
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
			<label class="col-form-label required-item">매핑 참조 키</label>
			<input type="text" class="form-control" name="refrnKeyNm" id="refrnKeyNm" value="${tableItem.refrnKeyNm}" required="required">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label required-item">저장방식</label>
			<select id="ldadngTy" name="ldadngTy" class="form-control" required="required" onchange="toggleSqlOrColumn(this);">
				<c:forEach var="item" items="${LOADING_TYPE}">
				<option value="${item.name}" <c:if test="${item.name eq tableItem.ldadngTy}">selected="selected"</c:if>>${item.value}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-left:0px;padding-right:0px;">
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12 notUserDefineItem" style="padding-right:0px;${notUserDefineItem}">
			<label class="col-form-label required-item">수신테이블</label>
			<input type="text" class="form-control" name="ldadngTableNm" id="ldadngTableNm" value="${tableItem.ldadngTableNm}" required="required">
		</div>
	</div>
	<div class="form-group col-md-12 notUserDefineItem" style="margin-left:0px;padding-right:15px;${notUserDefineItem}">
		<label class="col-form-label">송수신 매핑</label>
		&nbsp;<i class="fa fa-plus-circle" onclick="addColumnContent(this)" style="cursor: pointer;"></i>
		<div class="col-md-12" style="padding:0px;">
			<table class="table table-hover">
				<thead>
				<tr>
					<th class="col-md-1">번호</th>
					<th class="col-md-4">송신컬럼&nbsp;<i class="fa fa-edit" style="cursor: pointer;" onclick="showColumnPasteModal(this, 'value');"></th>
					<th class="col-md-1"></th>
					<th class="col-md-4">수신컬럼&nbsp;<i class="fa fa-edit" style="cursor: pointer;" onclick="showColumnPasteModal(this, 'column');"></th>
					<th class="col-md-1">기본키</th>
					<th class="col-md-1">삭제</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="columnItem" items="${tableItem.ldadngColumnList }" varStatus="idx">
					<tr>
						<td style="text-align:center">${idx.count }</td>
						<td style="text-align:left"><span id="value" name="value" class="editableSpanValue">${columnItem.value}</span></td>
						<td style="text-align:center"><i class="fa fa-long-arrow-right"></i></td>
						<td style="text-align:left"><span id="column" name="column" class="editableSpanColumn">${columnItem.column}</span></td>
						<td style="text-align:center"><input id="isPrimaryKey" class="icheck-box" type="checkbox" data-checkbox="icheckbox_square-blue" <c:if test="${columnItem.keyColumnYn eq 'Y'}">checked</c:if>></td>
						<td style="text-align:center"><i class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeRow(this);"></i></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;${userDefineItem}" id="isUD">
		<label class="col-form-label required-item">수신 쿼리</label>
		<textarea class="form-control" id="inqireSql" name="inqireSql" required="required" rows="5" cols="">${tableItem.inqireSql}</textarea>
	</div>
</fieldset>
</c:forEach>
</c:if>
<c:if test="${fn:length(tableList) eq 0}">
<fieldset style="margin-top:10px;padding:10px;" id="toTableConfig">
	<div class="panel-header">
		<div class="control-btn" style="text-align:right;">
			<i class="icon-trash" style="cursor: pointer;" onclick="removeTableContent(this);"></i>
		</div>
	</div>
	<div class="col-md-6" style="padding-left:0px;padding-right:0px;">
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
			<label class="col-form-label required-item">매핑 참조 키</label>
			<input type="text" class="form-control " name="refrnKeyNm" id="refrnKeyNm" value="${item.refrnKeyNm}" required="required">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label required-item">저장방식</label>
			<select id="ldadngTy" name="ldadngTy" class="form-control" required="required" onchange="toggleSqlOrColumn(this);">
				<c:forEach var="item" items="${LOADING_TYPE}">
				<option value="${ item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-left:0px;padding-right:0px;">
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
		</div>
	</div>
	<div class="col-md-6 notUserDefineItem" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label required-item">수신테이블</label>
			<input type="text" class="form-control " name="ldadngTableNm" id="ldadngTableNm" value="${item.ldadngTableNm}" required="required">
		</div>
	</div>
	<div class="form-group col-md-12 notUserDefineItem" style="margin-left:0px;padding-right:15px;">
		<label class="col-form-label">송수신 매핑</label>
		&nbsp;<i class="fa fa-plus-circle" onclick="addColumnContent(this)" style="cursor: pointer;"></i>
		<div class="row" style="display: none;" id="columnEditArea"><textarea rows="3" cols="30"> </textarea></div>
		<div class="col-md-12" style="padding:0px;">
			<table class="table table-hover">
				<thead>
				<tr>
					<th class="col-md-1">번호</th>
					<th class="col-md-4">송신컬럼&nbsp;<i class="fa fa-edit" style="cursor: pointer;" onclick="showColumnPasteModal(this, 'value');"></th>
					<th class="col-md-1"></th>
					<th class="col-md-4">수신컬럼&nbsp;<i class="fa fa-edit" style="cursor: pointer;" onclick="showColumnPasteModal(this, 'column');"></th>
					<th class="col-md-1">기본키</th>
					<th class="col-md-1">삭제</th>
				</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;display:none;" id="isUD">
		<label class="col-form-label required-item">수신 쿼리</label>
		<textarea class="form-control" id="inqireSql" name="inqireSql" required="required" rows="5" cols="">${item.inqireSql}</textarea>
	</div>


</fieldset>
</c:if>
</c:if>

<c:if test="${mode eq 'U' || data ne null }">
${tableItem}
<script>
	$('#ldadngTy')[0].value= '${tableItem.ldadngTy}';

</script>
</c:if>
<script>
$('.icheck-box').iCheck({
    checkboxClass: 'icheckbox_minimal'
});



</script>