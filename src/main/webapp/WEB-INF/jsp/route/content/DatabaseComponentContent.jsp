<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.intrfc-summary{
	display:none;
    width: 150px;
    height: auto;
    float: left;
    position: fixed;
    z-index: 2001;
    background: #F9F9F9;
    resize: none;
    overflow: auto;
}
</style>

<div class="col-md-12" style="padding-bottom:20px;">
<input type="hidden" name="componentType" id="componentType" value="DATABASE">
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
					<label><input type="radio" class="endpntSeClass" name="endpntSe" id="endpntSe" ${fromChecked} value="F" data-radio="iradio_minimal-blue"required="required"> FROM</label>
					<label><input type="radio" class="endpntSeClass" name="endpntSe" id="endpntSe" ${toChecked} value="T" data-radio="iradio_minimal-blue"required="required"> TO</label>
				</div>
			</div>
        </div>
		<div class="form-group col-md-12" style="margin-left:0px;padding-right:15px;">
			<label class="col-form-label required-item">컴포넌트 설명</label>
			<input type="text" class="form-control" name="compnNm" id="compnNm" value="${data.compnNm}" maxlength="20" required="required">
		</div>
	</fieldset>
	<!-- FROM 설정 시작  -->
	<fieldset style="margin-top:10px;padding:10px;">
		<legend><strong>기본정보</strong></legend>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">데이터소스</label>
				<select id="dtasrcId" name="dtasrcId" class="form-control">
				<c:forEach var="item" items="${DATASOURCE_LIST}">
					<option value="${item.dtasrcId}">${item.dtasrcId}(${item.dtasrcNm})</option>
				</c:forEach>
				</select>
			</div>
		</div>
		<div class="col-md-6 fromEndpntSe" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">SQL 파라미터 입력 구분</label>
				<select id="paramtrInputSe" name="paramtrInputSe" class="form-control" required="required" data-error-position="before">
					<option value="M">응용시스템</option>
					<option value="A">연계시스템</option>
				</select>
			</div>
		</div>
		<div class="col-md-12" style="padding-right:0px;">
			<div class="form-group col-md-12 show-control-sqlParamtr" style="padding-right:0px;display:none;">
				<label class="col-form-label">SQL 파라미터(JSON)</label>
				<textarea class="form-control" name="sqlParamtr" id="sqlParamtr" rows="1" maxlength="3000" data-error-position="before">${data.sqlParamtr}</textarea>
			</div>
		</div>
		<div class="col-md-12 fromEndpntSe" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">자동 재처리 방식</label>
				<select id="atmcRehndlSe" name="atmcRehndlSe" class="form-control" required="required">
					<option value="N">재처리안함</option>
					<option value="C">공통재처리</option>
					<option value="S">단독재처리</option>
				</select>
			</div>
		</div>
	</fieldset>
	<fieldset style="margin-top:10px;padding:10px;display:none;" class="fromEndpntSe">
		<legend><strong>송신정보</strong>
			<span class="label label-warning" style="margin-left:15px;padding-left:10px;padding-right:10px;cursor:pointer;" onclick="addTableContent('${ruteSeq}','${compnSeq}', 'F', 'Y', '${isWorkItem}')">추가</span>
		</legend>
		<div class="form-group col-md-12" style="margin:0px 0px;padding:0px 0px;" id="fromDatabaseComponentTableContentArea">
		<c:forEach var="item" items="${tableList}">
		</c:forEach>
		<div id="dctca" style="display:none;color:#994F4F;font-style:italic;margin-top:10px;">필수항목입니다.</div>
		</div>
	</fieldset>
	<!-- FROM 설정 끝 -->
	<!-- TO 설정 시작  -->
	<%-- <fieldset style="margin-top:10px;padding:10px;display:none;">
		<legend><strong>기본정보</strong></legend>
		<div class="col-md-6" style="padding-right:0px;">
			<div class="form-group col-md-12" style="padding-right:0px;">
				<label class="col-form-label required-item">데이터소스</label>
				<select id="dtasrcId" name="dtasrcId" class="form-control">
				<c:forEach var="item" items="${DATASOURCE_LIST}">
					<option value="${item.dtasrcId}">${item.dtasrcId}(${item.dtasrcNm})</option>
				</c:forEach>
				</select>
			</div>
		</div>
	</fieldset> --%>
	<fieldset style="margin-top: 10px;padding: 10px;display:none;" class="toEndpntSe">
		<legend><strong>수신정보</strong>
			<span class="label label-warning" style="margin-left:15px;padding-left:10px;padding-right:10px;cursor:pointer;" onclick="addTableContent('${ruteSeq}','${data.compnSeq}','T','Y', '${isWorkItem}')">추가</span>
			<span class="label label-warning" style="padding-left:10px;padding-right:10px;cursor:pointer;" onclick="loadFromTableComponentList()">자동채우기</span>
		</legend>
		<div id="dctca" style="display:none;color:#994F4F;font-style:italic;margin-top: 10px;">필수항목입니다. </div>
		<div class="form-group col-md-12" style="margin: 0px 0px;padding:0px 0px;" id="toDatabaseComponentTableContentArea">
		</div>
	</fieldset>
	<!-- TO 설정 끝 -->
</div>
<div class="intrfc-summary">
	<div class="col-md-12" style="text-align: right;padding-right:0px;"><i class="icons-office-52 link2 summary-close"></i></div>
	<div class="col-md-12" style="padding:0px 0px 0px 0px;">
		<p id="content"></p>
	</div>
</div>
<script>
	handleiCheck();
	$('.endpntSeClass').on('ifChanged', function(event){
		endpntSeToggle(event.currentTarget.value);
	});
	endpntSeToggle('${data.endpntSe}' == '' ? 'F' : '${data.endpntSe}');
</script>
<c:if test="${mode eq 'U' || data ne null}">
<script>
	endpntSeToggle('${data.endpntSe}');
	$('#paramtrInputSe').val('${data.paramtrInputSe}');
	$('#dtasrcId').val('${data.dtasrcId}');
	$('#atmcRehndlSe').val('${data.atmcRehndlSe}');
	if('${data.endpntSe}' == 'F'){
		if('${data.atmcRehndlSe}' == 'Y'){
			$('#atmcRehndlSe')[0].checked = true;
		}else{
			$('#atmcRehndlSe')[0].checked = false;
		}
	}

	if('${data.paramtrInputSe}' == 'A'){
		$('.show-control-sqlParamtr').show();
	}
	addTableContent('${ruteSeq}','${data.compnSeq}','${data.endpntSe}', 'N', '${isWorkItem}');
</script>
</c:if>
<script>
	$('#paramtrInputSe').on('change',function(){
		var value = $('#paramtrInputSe').val();

		if(value == 'A'){
			$('.show-control-sqlParamtr').show();
		}else{
			$('.show-control-sqlParamtr').hide();
		}
	});

  	function toggleSqlOrColumn(target){
  		var value = target.value;
		var parent = $(target).parent().parent().parent();
  		if("UD" == value){
  			var column ="";
  			parent.find('#isUD').show();
			parent.find('.notUserDefineItem').hide();
			$.each($('.editableSpanColumn'), function(e, data){
				column+= $(data).html() + ',';

			});
			column = column.substr(0, column.length-1);
			$('#inqireSql').val(column);

  		}else{
			parent.find('#isUD').hide();
			parent.find('.notUserDefineItem').show();
  		}
  	}


</script>