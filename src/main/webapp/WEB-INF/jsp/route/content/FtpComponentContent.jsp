<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-md-12" style="padding-bottom:20px;">
<input type="hidden" name="componentType" id="componentType" value="FTP">
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
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">데이터소스</label>
			<select id="dtasrcId" name="dtasrcId" class="form-control" required="required">
				<c:forEach var="item" items="${FTP_CONFIG_LIST}">
					<option value="${item.dtasrcId}">${item.dtasrcNm}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">전송구분</label>
			<select id="transferSe" name="transferSe" class="form-control">
					<option value="B">Binary</option>
					<option value="A">Ascii</option>
			</select>
		</div>
	</div>
</fieldset>
<fieldset style="margin-top:10px;padding:10px;" class="fromEndpntSe">
	<legend><strong>기본정보</strong></legend>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">기준 디렉토리</label>
			<input type="text" class="form-control" name="rootDrctry" id="rootDrctryFrom" value="${data.rootDrctry}" maxlength="200" tabindex="1">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">송신 대상 파일</label>
			<input type="text" class="form-control" name="fileInclsPttrn" id="fileInclsPttrn" placeholder="송신 파일 확장자 지정시(.*\.txt)" value="${data.fileInclsPttrn}" maxlength="100" tabindex="2">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">변경 감지 간격(ms)</label>
			<input type="text" class="form-control" name="readLokIntrvl" id="readLokIntrvl" placeholder="파일 크기 변화 여부 감지 간격(기본값 : 1000ms)" value="${data.readLokIntrvl}" maxlength="6"  tabindex="4" required="required">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label col-2" style="padding-bottom:5px;">빈 파일 송신</label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="etyFileSendYn" id="etyFileSendYn" checked="checked" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">송신 제외 파일</label>
			<input type="text" class="form-control" name="fileExclPttrn" id="fileExclPttrn" placeholder="송신 제외 파일 확장자 지정시(.*\.tmp)" value="${data.fileExclPttrn}"  tabindex="3">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">작업지시 파일명</label>
			<input type="text" class="form-control" name="comptFileNmFrom" id="comptFileNmFrom" placeholder="작업지시 파일은 송신 안함" value="${data.comptFileNm}" maxlength="100" data-error-position="before"  tabindex="5">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">동시처리 건수</label>
			<input type="text" class="form-control " name="parlelProcessCo" id="parlelProcessCo" placeholder="1" value="${data.parlelProcessCo}" max="10" maxlength="2" data-error-position="before"  tabindex="6">
		</div>
	</div>
</fieldset>
<fieldset style="margin-top:10px;padding:10px;" class="toEndpntSe">
	<legend><strong>기본정보</strong></legend>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
		<label class="col-form-label">기준 디렉토리</label>
		<input type="text" class="form-control" name="rootDrctryTo" id="rootDrctryTo" value="${data.rootDrctry}" maxlength="200" data-error-position="before" tabindex="1">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">하위 디렉토리</label>
			<input type="text" class="form-control" name="subDrctryPttrnTo" id="subDrctryPttrnTo"  value="${data.subDrctryPttrn}" maxlength="100" tabindex="2">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">중복 파일 처리</label>
			<select id="dplctProcessTy" name="dplctProcessTy" class="form-control ">
				<c:forEach var="item" items="${AFTERPROCESS_TYPE}">
					<c:if test="${item.value ne 'NOOP'}">
						<option value="${item.name}">${item.value}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">수신파일명</label>
			<input type="text" class="form-control" name="recptnFileNm" id="recptnFileNm" value="${data.recptnFileNm}" maxlength="100" tabindex="3">
		</div>
		<div class="form-group col-md-12 show-control-dplctProcessTy" style="padding-right:0px;display:none;">
			<label class="col-form-label">디렉토리/파일명</label>
			<input type="text" class="form-control" name="dplctFilePth" id="dplctFilePth" value="${data.dplctFilePth}" required="required" data-error-position="before"  tabindex="4">
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">작업완료 파일명</label>
			<input type="text" class="form-control" name="comptFileNmTo" id="comptFileNmTo" placeholder="" value="${data.comptFileNm}" maxlength="100" tabindex="5">
		</div>
	</div>
</fieldset>
<fieldset style="margin-top:10px;padding:10px;" class="fromEndpntSe">
	<legend><strong>서브 디렉토리</strong></legend>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label col-2" style="padding-bottom:5px;">송신</label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="subDrctrySendYn" id="subDrctrySendYn" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
		<div class="form-group col-md-12 show-control-subDir" style="padding-right:0px;display:none;">
			<label class="col-form-label">시작 위치</label>
			<input type="text" class="form-control " name="subDrctryMnmmDp" id="subDrctryMnmmDp" placeholder="1" value="${data.subDrctryMnmmDp}" max="10" maxlength="2" data-error-position="before"  tabindex="8">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-subDir" style="padding-right:0px;display:none;">
			<label class="col-form-label">디렉토리 패턴</label>
			<input type="text" class="form-control " name="subDrctryPttrnFrom" id="subDrctryPttrnFrom" placeholder="" value="${data.subDrctryPttrn}" maxlength="100" data-error-position="before" tabindex="7">
		</div>
		<div class="form-group col-md-12 show-control-subDir" style="padding-right:0px;display:none;">
			<label class="col-form-label">종료 위치</label>
			<input type="text" class="form-control " name="subDrctryMxmmDp" id="subDrctryMxmmDp" placeholder="1" value="${data.subDrctryMxmmDp}" max="10" maxlength="2" data-error-position="before"  tabindex="9">
		</div>
	</div>
</fieldset>
<fieldset style="margin-top:10px;padding:10px;" class="fromEndpntSe">
	<legend><strong>중복처리</strong></legend>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label col-2" style="padding-bottom:5px;">중복 파일 송신 제외</label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="eqltyDataDetectYn" id="eqltyDataDetectYn" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-eqltyData" style="padding-right:0px;display:none;">
			<label class="col-form-label">검증방식</label>
			<select id="eqltyDataDetectPttrn" name="eqltyDataDetectPttrn" class="form-control" required="required" data-error-position="before">
				<option value="">선택하세요</option>
				<option value="S">파일명+파일크기</option>
				<option value="M">파일명+최종수정시간</option>
				<option value="SM">파일명+파일크기+최종수정시간</option>
			</select>
		</div>
	</div>
</fieldset>
<fieldset style="margin-top: 10px;padding: 10px;" class="fromEndpntSe">
	<legend><strong>결과처리</strong></legend>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-6" style="padding-right:0px;">
			<label class="col-form-label">성공시</label>
			<select id="succesProcessTy" name="succesProcessTy" class="form-control ">
				<c:forEach var="item" items="${AFTERPROCESS_TYPE}">
					<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-6 show-control-succesProcessTy" style="margin-left:15px;padding-right:0px;display:none;">
			<label class="col-form-label">디렉토리/파일명</label>
			<input type="text" class="form-control" name="succesFilePth" id="succesFilePth" placeholder="상대/절대경로, 패턴 지정 가능" value="${data.succesFilePth}" required="required" maxlength="100" data-error-position="before">
		</div>
	</div>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-6" style="padding-right:0px;">
			<label class="col-form-label">실패시</label>
			<select id="errorProcessTy" name="errorProcessTy" class="form-control ">
				<c:forEach var="item" items="${AFTERPROCESS_TYPE}">
					<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-6 show-control-errorProcessTy" style="margin-left:15px;margin-right:0px;padding-right:0px;display:none;">
			<label class="col-form-label">디렉토리/파일명</label>
			<input type="text" class="form-control" name="errorFilePth" id="errorFilePth" placeholder="상대/절대경로, 패턴 지정 가능" value="${data.errorFilePth}" required="required" maxlength="100" data-error-position="before">
		</div>
	</div>
</fieldset>
<fieldset style="margin-top: 10px;padding: 10px;">
	<legend><strong>파일유형</strong>
	<%-- <span class="label label-warning toEndpntSe" style="padding-left:10px;padding-right:10px;cursor:pointer;display:none;" onclick="loadFromTableColumnListFile('${ruteNumber}','0')">자동채우기</span> --%>
	</legend>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">파일형식</label>
			<select id="fileReadTy" name="fileReadTy" class="form-control">
				<c:forEach var="item" items="${FILEREAD_TYPE}">
					<c:if test="${item.value ne 'XML' and item.value ne 'EXCEL'}">
					<option value="${item.name}">${item.value}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-fileReadTy" style="padding-right:0px;display:none;">
			<label class="col-form-label">매핑키</label>
			<input type="text" class="form-control" name="referMapKey" id="referMapKey" value="${data.referMapKey}" required="required" data-error-position="before">
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-fileReadTy" style="padding-right:0px;display:none;">
			<label class="col-form-label">인코딩</label>
			<select id="charcrSet" name="charcrSet" class="form-control ">
				<option value="UTF-8">UTF-8</option>
				<option value="EUC-KR">EUC-KR</option>
				<option value="MS949">MS949</option>
			</select>
		</div>
	</div>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-fileReadTy" style="padding-right:0px;display:none;">
			<label class="col-form-label">컬럼목록</label>
			<input type="text" class="form-control " name="hderColumn" id="hderColumn" placeholder="콤마 구분" value="${data.hderColumn}" required="required" maxlength="3500" data-error-position="before">
		</div>
	</div>
	<div class="col-md-12" style="padding-right:0px;">
		<div class="form-group col-md-12 show-control-fileReadTy FXLT" style="padding-right:0px;display:none;">
			<label class="col-form-label">컬럼길이(byte)</label>
			<input type="text" class="form-control " name="hderColumnLt" id="hderColumnLt" placeholder="콤마 구분" value="${data.hderColumnLt}" required="required" maxlength="3500" data-error-position="before">
		</div>
	</div>
	<div class="col-md-12" style="padding-left:0px;padding-right:0px;">
		<div class="form-group col-md-4 show-control-fileReadTy SPRTR" style="margin-left:0px;margin-right:0px;display:none;">
			<label class="col-form-label">행 구분자</label>
			<select id="lineSprtr" name="lineSprtr" class="form-control ">
				<c:forEach var="item" items="${FILELINESEPARATOR_TYPE}">
					<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-4 show-control-fileReadTy SPRTR" style="margin-left:0px;margin-right:0px;display:none;">
			<label class="col-form-label">컬럼 구분자</label>
			<select id="columnSprtr" name="columnSprtr" class="form-control ">
				<c:forEach var="item" items="${FILECOLUMNSEPARATOR_TYPE}">
					<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-4 show-control-fileReadTy" style="margin-left:0px;margin-right:0px;display:none;">
			<label class="col-form-label">공백 문자</label>
			<select id="blankCharcr" name="blankCharcr" class="form-control ">
				<c:forEach var="item" items="${FILEPADDING_TYPE}">
					<option value="${item.name}">${item.value}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group col-md-4 show-control-fileReadTy" style="margin-left:0px;margin-right:0px;display:none;">
			<label class="col-form-label">첫번째 행 헤더 <span class="fromEndpntSe">여부</span><span class="toEndpntSe">생성</span>  </label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="hderSkipYn" id="hderSkipYn" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
	</div>
</fieldset>
<fieldset style="margin-top: 10px;padding: 10px;display:none;">
	<legend><strong>기타</strong></legend>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">파일 분할 크기</label>
			<input type="text" id="partitnSize" name="partitnSize"  value="SIZE_1M">
<%-- 			<select id="partitnSize" name="partitnSize" class="form-control ">
				<c:forEach var="item" items="${FILEPARTITION_TYPE}">
					<option value="${ item.name}">${item.value}</option>
				</c:forEach>
			</select> --%>
		</div>
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label">파일 정렬 기준</label>
			<select id="sortSe" name="sortSe" class="form-control ">
				<option value="F" selected="selected">파일명</option>
				<option value="M">수정시간</option>
			</select>
		</div>
	</div>
	<div class="col-md-6" style="padding-right:0px;">
		<div class="form-group col-md-12" style="padding-right:0px;">
			<label class="col-form-label col-2" style="padding-top:8px;">압축 여부</label><br>
			<label class="switch switch-green">
			<input type="checkbox" class="switch-input" name="cmprsYn" id="cmprsYn" value="Y">
			<span class="switch-label" data-on="On" data-off="Off"></span>
			<span class="switch-handle"></span>
			</label>
		</div>
	</div>
</fieldset>

<c:if test="${ data.endpntSe eq 'T'}">
<input type="hidden" name="subDrctrySendYn" id="subDrctrySendYn" value="N">
<input type="hidden" name="sortSe" id="sortSe" value="M">
<input type="hidden" name="readLokIntrvl" id="readLokIntrvl" value="500">
<input type="hidden" name="etyFileSendYn" id="etyFileSendYn" value="Y">
<input type="hidden" name="eqltyDataDetectYn" id="eqltyDataDetectYn" value="N">
<input type="hidden" name="partitnSize" id="partitnSize" value="SIZE_512K">
<input type="hidden" name="parlelProcessCo" id="parlelProcessCo" value="0">
<input type="hidden" name="cmprsYn" id="cmprsYn" value="N">
<input type="hidden" name="fileInclsPttrn" id="fileInclsPttrn" value="*">
<input type="hidden" name="succesProcessTy" id="succesProcessTy" value="N">
<input type="hidden" name="errorProcessTy" id="errorProcessTy" value="N">
</c:if>
</div>

<script>
	handleiCheck();
	$('.endpntSeClass').on('ifChanged', function(event){
		endpntSeToggle(event.currentTarget.value);
	});
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
	if('${mode}' == 'I' && '${data}' == ''){
		$('#readLokIntrvl').val('1000');
	}

	/* 서브 디렉토리 송신 여부값 변경 체크*/
	$('#subDrctrySendYn').on('click', function () {
		 if($('#subDrctrySendYn')[0].checked){
			 $('.show-control-subDir').show();
		 }else{
			 $('.show-control-subDir').hide();
		 }
	});

	/* 중복처리 */
	$('#eqltyDataDetectYn').on('click', function () {
		 if($('#eqltyDataDetectYn')[0].checked){
			 $('.show-control-eqltyData').show();
		 }else{
			 $('.show-control-eqltyData').hide();
		 }
	});
	/* 성공시 처리*/
	$('#succesProcessTy').on('change', function () {
		if($('#succesProcessTy').val() == 'M'){
			$('.show-control-succesProcessTy').show();
		}else{
			$('.show-control-succesProcessTy').hide();
		}
	});
	/* 실패시 처리*/
	$('#errorProcessTy').on('change', function () {
		if($('#errorProcessTy').val() == 'M'){
			$('.show-control-errorProcessTy').show();
		}else{
			$('.show-control-errorProcessTy').hide();
		}
	});

	$('#fileReadTy').on('change', function () {
		var value = $('#fileReadTy').val();
		if(value == 'XML' || value == 'EXCEL'){
			alert('준비중입니다.');
		}else{
			fileReadTyControl(value);
		}
	});


	function fileReadTyControl(value){
		if(value == 'BYTE'){
			$('.show-control-fileReadTy').hide();
		}else if(value == 'SPRTR'){
			$('.show-control-fileReadTy').show();
			$('.SPRTR').show();
			$('.FXLT').hide();
		}else if(value == 'FXLT'){
			$('.show-control-fileReadTy').show();
			$('.SPRTR').hide();
			$('.FXLT').show();
		}
	}
	$('#dplctProcessTy').on('change', function () {
		if($('#dplctProcessTy').val() == 'M'){
			$('.show-control-dplctProcessTy').show();
		}else{
			$('.show-control-dplctProcessTy').hide();
		}
	});

</script>
<c:if test="${mode eq 'U' || data ne null}">

	<script>
		if('${data.etyFileSendYn}' == 'Y'){
			$('#etyFileSendYn')[0].checked = true;
		}else{
			$('#etyFileSendYn')[0].checked = false;
		}
		if('${data.subDrctrySendYn}' == 'Y'){
			$('#subDrctrySendYn')[0].checked = true;
			$('.show-control-subDir').show();
		}else{
			$('#subDrctrySendYn')[0].checked = false;
			$('.show-control-subDir').hide();
		}
		if('${data.eqltyDataDetectYn}' == 'Y'){
			$('#eqltyDataDetectYn')[0].checked = true;
			 $('.show-control-eqltyData').show();
		}else{
			$('#eqltyDataDetectYn')[0].checked = false;
			 $('.show-control-eqltyData').hide();
		}
		if('${data.succesProcessTy}' == 'M'){
			$('.show-control-succesProcessTy').show();
		}else{
			$('.show-control-succesProcessTy').hide();
		}
		if('${data.errorProcessTy}' == 'M'){
			$('.show-control-errorProcessTy').show();
		}else{
			$('.show-control-errorProcessTy').hide();
		}

		if('${data.fileReadTy}' == 'XML' || '${data.fileReadTy}' == 'EXCEL'){
			//TODO
		}else{
			fileReadTyControl('${data.fileReadTy}');
		}

		$('#succesProcessTy').val('${data.succesProcessTy}');
		$('#errorProcessTy').val('${data.errorProcessTy}');
		$('#fileReadTy').val('${data.fileReadTy}');
		$('#charcrSet').val('${data.charcrSet}');
		$('#eqltyDataDetectPttrn').val('${data.eqltyDataDetectPttrn}');
		$('#lineSprtr').val('${data.lineSprtr}');
		$('#columnSprtr').val('${data.columnSprtr}');
		$('#blankCharcr').val('${data.blankCharcr}');

		$('#dplctProcessTy').val('${data.dplctProcessTy}');

		if($('${data.dplctProcessTy}').val() == 'M'){
			$('.show-control-dplctProcessTy').show();
		}else{
			$('.show-control-dplctProcessTy').hide();
		}
	</script>
	<c:if test="${ data.endpntSe eq 'F'}">
		<script>
		if('${data.hderSkipYn}' == 'Y'){
			$('#hderSkipYn')[0].checked = true;
		}else{
			$('#hderSkipYn')[0].checked = false;
		}
		</script>
	</c:if>
	<c:if test="${ data.endpntSe eq 'T'}">
		<script>
		if('${data.hderSkipYn}' == 'N'){
			$('#hderSkipYn')[0].checked = true;
		}else{
			$('#hderSkipYn')[0].checked = false;
		}
		</script>
	</c:if>
</c:if>