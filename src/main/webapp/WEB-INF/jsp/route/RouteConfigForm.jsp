<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="/assets/global/plugins/step-form-wizard/css/step-form-wizard.min.css" rel="stylesheet">
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet">
<style>
.select2-container{
	z-index: 0;
}
.component {
	border-radius: 12px;
	border: 1px solid rgb(200, 200, 200);
	box-shadow: 2px 5px 5px rgba(0,0,0,0.2);
	margin-left: 1px;
	padding-top:5px;
	padding-bottom:5px;
	height: 80px;
	width:200px;
	float: left;
	position: absolute;
}
.bg-white{
	background: white;
}

.grid{
	margin:0;
	background:-webkit-linear-gradient(#c7c7c7, transparent 1px),-webkit-linear-gradient(0, #c7c7c7, #fff 1px);
	background-size:9px 9px
}

.component :hover {
    cursor: move;
}

.route-group-item{
    background: #ffffff;
    border-radius: 0;
	height:455px;
	border-radius: 8px 8px 8px 8px;
	background:#F9F9F9;
	border: 1px solid #c0c0c0;
	box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);
	margin-left: 12px;
	margin-right: 12px;
	/* margin-top: 10px; */
	position: relative;
	float: left;
	padding-left: 0px;
}
.paletteItem{
	z-index: 10;
}
.paletteItem :hover {
    cursor: move;
}
.dropzone-hover{
	opacity: 0.8;
	background: #E5EAED !important;
    border: 1px dashed #b6bcbf;
    visibility: visible !important; */
}

.quick-link {
    float: left;
    padding: 5px 5px;
    width: 150px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    background: #F7F7F7;
    margin-bottom: 5px;
}
.quick-link .icon i::before {
    display: inline-block;
    height: 25px;
    margin-top: 0;
    padding: 8px;
    width: 25px;
    -webkit-border-radius: 50%;
    -moz-border-radius: 50%;
    border-radius: 50%;
}
.quick-link .icon i {
    color: #ffffff;
    font-size: 12px;
    padding-right: 0 !important;
    text-align: center;
    float: none !important;
}

.quick-link .text {
    color: #A3A3A3;
    font-size: 12px;
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0px;
}
.quick-link .icon {
    margin: auto;
    text-align: left;
    width: 150px;
}
</style>

<div class="row">
	<div class="col-lg-12">
		<div class="title">
			<h2>인터페이스 구성</h2>
		</div>
		<div class="panel">
			<div class="panel-header">
			</div>
			<div class="panel-content" style="padding-top:10px;">
			<form class="wizard-validation" name="form01" id="form01" data-style="sky" role="form" style="padding-top:10px;">
				<fieldset class="interface" style="padding-right:10px;">
                	<legend>일반사항</legend>
					<div class="col-md-12" id="interfaceArea">
						<div class="col-md-6">
							<div class="form-group col-md-11">
								<label class="col-form-label">인터페이스 아이디</label>
								<input type="text" class="col-md-6 form-control" id="intrfcId" name="intrfcId" minlength="4" maxlength="50" required="required" regex="^[A-Za-z0-9_-]*$" value="${intrfc.intrfcId}" placeholder="인터페이스 아이디">
							</div>
							<div class="form-group col-md-11">
								<label class="col-form-label">인터페이스명</label>
								<input type="text" class="col-md-6 form-control" id="intrfcNm" name="intrfcNm" maxlength="80" required="required" value="${intrfc.intrfcNm}" placeholder="인터페이스 이름 또는 설명">
							</div>
							<input type="hidden" id="intrfcTy" name="intrfcTy" value="ROW"><!-- 사용하지 않지만 DB 처리를 위해  -->
							<c:if test="${ fn:length(cateDataList) > 0}">
							<div class="form-group col-md-11">
								<label class="col-form-label">분류체계</label>
								<div class="col-md-12">
								<ul>
								<c:forEach var="cateItem" items="${cateDataList}">
									<li>${cateItem.pathText}</li>
								</c:forEach>
								</ul>
								</div>
							</div>
							</c:if>
						</div>
						<div class="col-md-6">
							<div class="form-group col-md-12">
								<label class="col-form-label col-2">인터페이스 실행</label><br>
		                      	<label class="switch switch-green">
		                      	<c:if test="${mode eq 'U'}">
		                      	<input type="checkbox" class="switch-input" name="actvtyYn" id="actvtyYn" <c:if test="${intrfc.actvtyYn eq 'Y'}">checked="checked"</c:if> value="Y">
		                      	</c:if>
		                      	<c:if test="${mode eq 'I'}">
		                      	<input type="checkbox" class="switch-input" name="actvtyYn" id="actvtyYn" checked="checked" value="Y">
		                      	</c:if>
		                      	<span class="switch-label" data-on="On" data-off="Off"></span>
		                      	<span class="switch-handle"></span>
		                      	</label>
							</div>
							<div class="form-group col-md-12">
								<label class="col-form-label col-2">트랜잭션 로깅</label><br>
		                      	<label class="switch switch-green">
		                      	<c:if test="${mode eq 'U'}">
		                      	<input type="checkbox" class="switch-input" name="trnscLogYn" id="trnscLogYn" <c:if test="${intrfc.trnscLogYn eq 'Y'}">checked="checked"</c:if> value="Y">
		                      	</c:if>
		                      	<c:if test="${mode eq 'I'}">
		                      	<input type="checkbox" class="switch-input" name="trnscLogYn" id="trnscLogYn" checked="checked" value="Y">
		                      	</c:if>
		                      	<span class="switch-label" data-on="On" data-off="Off"></span>
		                      	<span class="switch-handle"></span>
		                      	</label>
							</div>
							<div class="form-group col-md-12">
								<label class="col-form-label col-2" style="padding-top:8px;">순차처리</label><br>
		                      	<label class="switch switch-green">
		                      	<c:if test="${mode eq 'U'}">
		                      	<input type="checkbox" class="switch-input" name="syncYn" id="syncYn" <c:if test="${intrfc.syncYn eq 'Y'}">checked="checked"</c:if> value="Y">
		                      	</c:if>
		                      	<c:if test="${mode eq 'I'}">
		                      	<input type="checkbox" class="switch-input" name="syncYn" id="syncYn" checked="checked" value="Y">
		                      	</c:if>
		                      	<span class="switch-label" data-on="On" data-off="Off"></span>
		                      	<span class="switch-handle"></span>
		                      	</label>
							</div>
						</div>
					</div>
                </fieldset>
				<fieldset class="route" style="padding-right: 10px;">
                	<legend>라우트</legend>
                	<div class="row">
					<div class="col-md-12" style="min-height:30px;">
						<div class="col-md-2">
							<div style="border-bottom: 1px black solid;height:30px;text-align: left;"><strong>컴포넌트</strong></div>
						</div>
						<div class="col-md-10"></div>
					</div>
                	<div class="col-md-12" style="margin-top:10px; min-height:450px;">
						<div class="col-md-2" id="paletteArea">
							<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="AGENT"><i class="fa fa-server"></i><span style="font-size: 14px;">AGENT</span></div>
                    		<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="DATABASE"><i class="fa fa-database"></i><span style="font-size: 14px;">DATABASE</span></div>
                    		<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="HTTP"><i class="fas fa-cloud"></i><span style="font-size: 14px;">HTTP</span></div>
                    		<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="HBASE"><i class="fas fa-archive"></i><span style="font-size: 14px;">HBASE</span></div>
                    		<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="FILE"><i class="fas fa-file"></i><span style="font-size: 14px;">FILE</span></div>
                    		<div class="col-md-12 btn btn-lg btn-block btn-default paletteItem" data-compnTy="FTP"><i class="fas fa-exchange-alt"></i><span style="font-size: 14px;">FTP</span></div>
						</div>
						<div class="col-md-10" id="routeDesignArea" style="min-height:481px;padding-right:0px;padding-left:0px;">
						</div>
					</div>
                	</div>
                </fieldset>
				<fieldset class="schedule" style="padding-right:10px;">
                	<legend>스케줄</legend>
						<div class="col-md-12" id="scheduleArea">
							<div class="col-md-6">
								<input type="hidden" class="col-md-6 form-control" id="schdulId" name="schdulId" required="required" value="${schedule.schdulId}">
								<input type="hidden" class="col-md-6 form-control" id="schdulNm" name="schdulNm" required="required" value="${schedule.schdulNm}">
								<input type="hidden" class="col-md-6 form-control switch-input" name="actvtyYn" id="actvtyYn" value="Y">
 								<div class="form-group col-md-11">
									<label class="col-form-label">실행대상</label>
									<select class="col-md-6 form-control" id="executTrgetSe" name="executTrgetSe" required="required" value="${schedule.executTrgetSe}">
										<option value="INTERFACE">인터페이스</option>
										<!-- <option value="CLASS">클래스</option> -->
									</select>
								</div>
								<input type="hidden" class="col-md-6 form-control" id="executTrgetNm" name="executTrgetNm" value="${schedule.executTrgetNm}">
								<input type="hidden" class="col-md-6 form-control" id="agentId" name="agentId" value="${schedule.agentId}">
								<div class="form-group col-md-11">
									<label class="col-form-label">실행방식</label>
									<select class="col-md-6 form-control" id="schdulExecutSe" name="schdulExecutSe" required="required" onchange="schduleExecutSection(this.value);">
										<option value="SIMPLE" <c:if test="${schedule.schdulExecutSe eq 'SIMPLE'}">selected</c:if>>단순반복 (SIMPLE)</option>
										<option value="CRON" <c:if test="${schedule.schdulExecutSe eq 'CRON'}">selected</c:if>>반복예약 (CRON)</option>
										<option value="ONLINE" <c:if test="${schedule.schdulExecutSe eq 'ONLINE'}">selected</c:if>>실시간 (ONLINE)</option>
									</select>
								</div>
							</div>
							<div class="col-md-6" id="scheduleSimple">
								<div class="form-group col-md-12" style="padding-left:0px;">
									<div class="col-md-4">
										<label class="col-form-label">단순반복</label>
										<input type="text" class="col-md-6 form-control" id="simpleSecText" name="simpleSecText" required="required" value="" placeholder="반복주기" regex="[0-9]">
									</div>
									<div class="col-md-7"  style="padding-right:0px;">
										<label class="col-form-label">　</label>
										<select class="col-md-3 form-control" id="simpleSecTextSelect" name="simpleSecTextSelect" onchange="schduleExecutSection(this.value);">
											<option value="SEC">초</option>
											<option value="MIN">분</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-md-6" id="scheduleCron" style="display:none;">
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 초(sec)</label>
									<input type="text" class="col-md-6 form-control" id="secnd" name="secnd" value="${schedule.secnd}" placeholder="0~59, - * /">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 분(min)</label>
									<input type="text" class="col-md-6 form-control" id="min" name="min" value="${schedule.min}" placeholder="0~59, - * /">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 시간(hour)</label>
									<input type="text" class="col-md-6 form-control" id="hour" name="hour" value="${schedule.hour}" placeholder="0~23, - * /">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 일(day)</label>
									<input type="text" class="col-md-6 form-control" id="de" name="de" value="${schedule.de}" placeholder="1~31, - * ? / L W">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 월(month)</label>
									<input type="text" class="col-md-6 form-control" id="mt" name="mt" value="${schedule.mt}" placeholder="1~12 or JAN-DEC, - * /">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 요일(week)</label>
									<input type="text" class="col-md-6 form-control" id="day" name="day" value="${schedule.day}" placeholder="1-7 or SUN-SAT, - * ? / L #">
								</div>
								<div class="form-group col-md-12">
									<label class="col-form-label">반복예약 - 년도(year)</label>
									<input type="text" class="col-md-6 form-control" id="yy" name="yy" value="${schedule.yy}" placeholder="1970~2099, - * /">
								</div>
							</div>
						</div>
                </fieldset>
                </form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="routeComponentInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>컴포넌트 설정</strong>
				</h4>
			</div>
			<form id="formRoute" name="formRoute" class="form-horizontal form-validation" onsubmit="return false;">
			<div class="modal-body">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary btn-embossed" onclick="tempSave();">확인</button>
			</div>
			</form>
		</div>
	</div>
</div>


<div class="modal fade" id="columnPasteModal"  tabindex="-1" role="dialog" aria-hidden="true" >
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>컬럼 배치 입력</strong>
				</h4>
			</div>
			<form id="form10" name="form10" class="form-horizontal form-validation" onsubmit="return false;">
			<div class="modal-body">
				엔터로 구분하여 입력하세요.
				<textarea rows="4" cols="78" id="columnData"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" onclick="$('#columnPasteModal').modal('hide');">취소</button>
				<button type="button" class="btn btn-primary btn-embossed" id="BTN_OK">확인</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="componentSelectModal" tabindex="-1" role="dialog" aria-hidden="true" >
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title">
					<strong>컴포넌트 선택</strong>
				</h4>
			</div>
			<div class="modal-body" style="min-height:50px;">
				<div class="col-md-12">
				<select class="form-control" id="componentSelect"></select>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary btn-embossed" onclick="loadFromTableColumnList('Y');" >확인</button>
			</div>
		</div>
	</div>
</div>

<ul class="vakata-context jstree-contextmenu jstree-default-contextmenu componentContextMenu contextMenuItem">
	<li class="modify" onclick="">
		<a href="#" rel="0"><i class="icon-note"></i>
		<span class="vakata-contextmenu-sep">&nbsp;</span>편집</a>
	</li>
	<li class="delete" onclick="">
		<a href="#" rel="0"><i class="icon-trash"></i>
		<span class="vakata-contextmenu-sep">&nbsp;</span>삭제</a>
	</li>
</ul>

<script>
	var agentList = JSON.parse('${AGENT_LIST}');
	var routeInfo = [];
	var linkInfo = [];
	var schdulExecutSe = '${schedule.schdulExecutSe}';
	var scheduleSecnd = '${schedule.secnd}';
	var mode = '${mode}';
	var isWorkItem = '${isWorkItem}';
	if(mode == 'U'){
		routeInfo = JSON.parse('${route}');
		linkInfo = JSON.parse('${linkInfo}');
	}
</script>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/assets/global/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="/assets/global/plugins/step-form-wizard/js/step-form-wizard.js"></script> <!-- Step Form Validation -->
<script src="/assets/global/plugins/jsplumb/jsplumb.js"></script>
<script src="/assets/js/routeForm.js"></script>
<script>
$(document).ready(function() {
	if('I' == mode){
		//$('#scheduleSetYn')[0].checked=false;
	}else{
		oldRouteInfo = routeInfo;
		schduleExecutSection(schdulExecutSe);
		if(schdulExecutSe == 'SIMPLE'){
			$('#simpleSecText').val(scheduleSecnd);
		}
		$('#intrfcId').attr('readonly','readonly');
	}
});
</script>