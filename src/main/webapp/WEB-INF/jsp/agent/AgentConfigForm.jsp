<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<link href="/assets/global/plugins/jstree/src/themes/default/style.min.css" rel="stylesheet"><head>
<title>에이전트 구성</title>
<style>
.tooltip-inner {
    min-width: 40px;
}
.chartItem{
	z-index: 2;
}

.circle {
	display: inline-block;
	height: 48px;
	width: 48px;
	padding-top: 2px;
	border-radius: 50%;
}

.context-down {
	float: right;
    position: relative;
    top: 25px;
    z-index: 4;
    left: -4px;
    cursor: pointer;
    color: #c0c0c0;
}

.context-down-main {
	float: right;
    position: relative;
    top: -5px;
    z-index: 4;
    left: 10px;
    cursor: pointer;
    color: #c0c0c0;
}

.activate {
	background: #4caf50;
}

.deactivate {
	background: #ff5252;
}

.progressbarText {
	float: initial;
	font-size: 12px;
	margin-left: 1px;
	position: absolute;
	font-weight: 600;
	margin-top:3px;
	padding-left:10px;
}

.dragHandle:HOVER {
	cursor: pointer;
}

.main-item{
	position: absolute;
	width:320px;
	z-index: 2;
}

.child-item{
	position: absolute;
	width:260px;
	z-index: 2;
	height:;
}

.component-header{
	position:relative;
	top: 1px;
	z-index: 4;
}

.component-body{
	z-index: 3;
}

.component-header .left{
	width:60%;
	height:25px;
	float: left;
}

.component-header .center{
	width:38%;
	height:25px;
	border-radius: 8px 8px 0px 0px;
	border-top: 1px  solid #c0c0c0;
	background: #F9F9F9;
	border-right: 1px  solid #c0c0c0;
	border-left: 1px  solid #c0c0c0;
	float: left;
	margin-left: 10px;
}

.component-header .right{
	width:2%;
	height:25px;
	padding:0px;
	float: left;
}

.component-header .right .control{
	width:100%;
	margin-top:3px;
}

.control .item{
	float: left;
	color: #cccccc !important;
	padding-left:7px;
	position:relative;
	top:5px;
}
.widget-infobox{
	margin-top: -10px;
}

.widget-infobox .left i::before {
    padding: 10px;
}
</style>
</head>
<body>

<ul class="vakata-context jstree-contextmenu jstree-default-contextmenu mainContextMenu contextMenuItem" style="display: none;">
	<c:if test="${agentSe eq 'AGENT'}">
	<li class="" onclick="partnerAgentAddModal();">
		<a href="#" rel="0"><i class="fa fa-server"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>에이전트</a>
	</li>
	<li class="" onclick="partnerDatasourceAddModal();">
		<a href="#" rel="1"><i class="fa fa-database"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>데이터베이스</a>
	</li>
	<li class="" onclick="partnerHttpAddModal();">
		<a href="#" rel="1"><i class="fas fa-cloud"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>HTTP</a>
	</li>
	<li class="" onclick="partnerFtpAddModal();">
		<a href="#" rel="1"><i class="fas fa-exchange-alt"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>FTP</a>
	</li>
	<li class="" onclick="partnerHbaseAddModal();">
		<a href="#" rel="2"><i class="fas fa-archive"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>Apache HBase</a>
	</li>
	</c:if>
	<c:if test="${agentSe eq 'RELAY'}">
	<li class="" onclick="proxyAddModal();">
		<a href="#" rel="0"><i class="fa fa-server"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>PROXY</a>
	</li>
	</c:if>
</ul>

<ul class="vakata-context jstree-contextmenu jstree-default-contextmenu partnerContextMenu contextMenuItem" style="display:none ;">
	<li class="delete" onclick="">
		<a href="#" rel="0"><i class="icon-trash"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>삭제</a>
	</li>
</ul>

<ul class="vakata-context jstree-contextmenu jstree-default-contextmenu resourceContextMenu contextMenuItem" style="display:none ;">
	<li class="modify" onclick="">
		<a href="#" rel="0"><i class="icon-note"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>수정</a>
	</li>
	<li class="delete" onclick="">
		<a href="#" rel="1"><i class="icon-trash"></i>
			<span class="vakata-contextmenu-sep">&nbsp;</span>삭제</a>
	</li>
</ul>

<div class="row">
	<div class="col-md-12">
		<div class="title">
			<h2>에이전트 환경구성</h2>
		</div>
		<div class="panel" style="height: inherit;">
			<div class="panel-content" style="height: 718px;">
				<div class="col-md-12" id="agentItemDrawArea" style="height: 718px;"></div>
			</div>
		</div>
	</div>

</div>

<!-- main agent config modal -->
<div class="modal fade" id="agentInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>에이전트 설정</strong></h4>
			</div>
			<form id="form01" name="form01" class="form-horizontal form-validation" onsubmit="return false;">
				<input type="hidden" name="mode" id="mode" value="${mode}">
				<input type="hidden" name="agentSeq" id="agentSeq" value="${agentData.agentSeq}">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">에이전트 구분</label>
									<select class="form-control col-md-6" onchange="changeAgentSe(this.value)" id="agentSe" name="agentSe">
										<option value="AGENT">에이전트</option>
										<option value="RELAY">릴레이</option>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">에이전트 아이디</label>
									<input class="form-control col-md-6" type="text" id="agentId" name="agentId" maxlength="20" regex="^[A-Z]*$" value="${agentData.agentId}" required <c:if test="${mode ne 'I'}">readonly</c:if>>
								</div>
<%-- 								<div class="form-group col-md-12" style="padding-right: 0px;display:none;">
									<label class="form-label required-item">노드번호</label>
									<input class="form-control col-md-6" type="text" id="agentNo" name="agentNo" maxlength="3" regex="^[0-9]{1,3}$" value="${agentData.agentNo}" required <c:if test="${mode ne 'I'}">readonly</c:if>>
								</div> --%>
								<input type="hidden" id="agentNo" name="agentNo" value="1">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">에이전트 설명</label>
									<input class="form-control col-md-6" type="text" id="agentNm" name="agentNm" value="${agentData.agentNm}" required="required" maxlength="40">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">릴레이 에이전트</label>
									<select class="form-control col-md-6" id="relayAgentId" name="relayAgentId">
										<option value="NO-RELAY" <c:if test="${'NO-RELAY' eq agentData.relayAgentId}">selected="selected"</c:if>>사용안함</option>
										<c:forEach var="item" items="${relayListAll}">
											<option value="${item.agentId }" <c:if test="${agentData.relayAgentId eq item.agentId}">selected="selected"</c:if>>${item.agentId }</option>
										</c:forEach>
									</select>

								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">IP</label>
									<input class="form-control col-md-6" type="text" id="agent-ip" name="ip" value="${agentData.ip}" regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" required="required">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">HTTP포트</label>
									<input class="form-control col-md-6" type="text" id="httpPort" name="httpPort" regex="^[0-9]{4,5}$" value="${agentData.httpPort}" placeholder="예) 6667" minlength="4" maxlength="5" required="required">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">메시지포트</label>
									<input class="form-control col-md-6" type="text" id="brokerPort" name="brokerPort" regex="^[0-9]{4,5}$" value="${agentData.brokerPort}" placeholder="예) 6666"  minlength="4" maxlength="5" required="required">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">관리포트</label>
									<input class="form-control col-md-6" type="text" id="managePort" name="managePort" regex="^[0-9]{4,5}$" value="${agentData.managePort}" placeholder="예) 6664" minlength="4" maxlength="5" required="required">
								</div>
							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<div class="modal-footer">
						<div class="col-md-12" style="padding:0px;">
							<div class="col-md-4" style="text-align: left;">
								<c:if test="${USER_TYPE eq 'A'}">
								<button type="button" class="btn btn-default btn-embossed" onclick="licensePushPop();">라이선스 배포</button>
								</c:if>
							</div>
							<div class="col-md-8"  style="text-align: right;padding-right: 0px;">				
								<button type="button" class="btn btn-default btn-embossed cancel" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary btn-embossed" onclick="setAgentContent();">저장</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- datasource configuration modal -->
<div class="modal fade" id="datasourceInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>데이터베이스 설정</strong></h4>
			</div>
			<form id="form02" name="form02" class="form-horizontal form-validation" onsubmit="return false;">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">데이터소스 아이디</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 식별자" id="rdbms-dtasrcId" name="dtasrcId" required="required" maxlength="20" regex="^[A-Za-z0-9_-]*$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>데이터베이스 타입</label>
									<select class="form-control required-item" name="databaseTy" id="databaseTy" data-minimum-results-for-search="Infinity">
										<c:forEach var="item" items="${DATABASE_TYPE}">
											<option value="${item.value}">${item.value}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">드라이버 클래스</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터베이스 타입 선택 시 자동입력" id="driverClass" name="driverClass" required="required"  maxlength="100">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">설명</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 역할 또는 설명" id="rdbms-dtasrcNm" name="dtasrcNm" required="required"  maxlength="100">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">캐릭터셋</label>
									<input class="form-control col-md-6" type="text" placeholder="UTF-8 등" id="charcrSet" name="charcrSet"  maxlength="30">
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">URL</label>
									<input class="form-control col-md-6" type="text" placeholder="JDBC 연결 URL" id="url" name="url" required="required" maxlength="500">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">아이디</label>
									<input class="form-control col-md-6" type="text" placeholder="접속 아이디" id="rdbms-id" name="id" required="required" maxlength="20">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">비밀번호</label>
									<input class="form-control col-md-6" type="password" placeholder="접속 비밀번호" id="rdbms-password" name="password" required="required" maxlength="100">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">최대연결갯수(기본값 : 10개)</label>
									<input class="form-control col-md-6" type="text" placeholder="10" id="maxCnncCnt" name="maxCnncCnt" value="10"  regex="^[0-9]{1,2}$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">최대연결대기시간(기본값 : 10초)</label>
									<input class="form-control col-md-6" type="text" placeholder="10000" id="cnncWaitTime" name="cnncWaitTime" value="10000" regex="^[0-9]{4,5}$">
								</div>
							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="setDatasourceContent();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- partner agent configuration modal -->
<div class="modal fade" id="partnerAgentInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>파트너 에이전트 설정</strong></h4>
			</div>
			<form id="form03" name="form03" class="form-horizontal form-validation" onsubmit="return false;">
				<input type="hidden" id="mode" name="mode" value="I">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
					<fieldset style="margin-top:10px;padding:10px;">
						<div class="col-md-12 partner-select" style="padding-right:0px;">
							<div class="form-group col-md-12" style="padding-right:0px;">
								<label class="col-form-label">파트너에이전트</label>
								<select class="form-control" name="partnIdSelect" id="partnIdSelect" onchange="changeRelayAgentSelect(this.value);">
								</select>
							</div>
							<div class="form-group col-md-12" style="padding-right:0px;">
							</div>
						</div>					
						<div class="col-md-12" style="padding-right:0px;padding-left: 0px;">
							<div class="col-md-3" style="padding-right:0px;top:7px;padding-left: 0px;">
								<input type="hidden" name="agentId" id="form03agentId">
								<p class="text-center agentId-text">${agentId}</p>
							</div>
							<div class="col-md-1" style="padding-right:0px;top:7px;">
								<i class="fas fa-arrow-right"></i>
							</div>
							<div class="col-md-4" style="padding-right:0px;">
								<select class="form-control" name="partnRelay" id="partnRelay"  onchange="partnRelayChange(this.value);">
									<option value="">선택하세요</option>
								</select>
							</div>
							<div class="col-md-1" style="padding-right:0px;top:7px;">
								<i class="fas fa-arrow-right"></i>
							</div>
							<div class="col-md-3" style="padding-right:0px;top:7px;">
								<input type="hidden" name="partnId" id="partnId">
								<p class="text-center partnId-text"></p>
							</div>
						</div>
						<div class="col-md-12" style="padding-right:0px;padding-left: 0px;top:7px;">
							<div class="col-md-3" style="padding-right:0px;padding-left: 0px;top:7px;">
								<p class="text-center partnId-text"></p>
							</div>
							<div class="col-md-1" style="padding-right:0px;top:7px;">
								<i class="fas fa-arrow-right"></i>
							</div>
							<div class="col-md-4" style="padding-right:0px;">
								<select class="form-control" name="agentRelay" id="agentRelay" onchange="agentRelayChange(this.value);">
									<option value="NO-RELAY">사용안함</option>
									<c:forEach var="item" items="${relayList}">
										<option value="${item.agentId}">${item.agentId}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-1" style="padding-right:0px;top:7px;">
								<i class="fas fa-arrow-right"></i>
							</div>
							<div class="col-md-3" style="padding-right:0px;">
								<p class="text-center agentId-text">${agentId}</p>
							</div>
						</div>
					</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="setPartnerAgent();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- hbase configuration modal -->
<div class="modal fade" id="hbaseInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>Apache HBase 설정</strong></h4>
			</div>
			<form id="form04" name="form04" class="form-horizontal form-validation" onsubmit="return false;">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">데이터소스 아이디</label>
									<input class="form-control" type="text" placeholder="데이터소스 식별자" id="hbase-dtasrcId" name="dtasrcId" required="required" maxlength="20" regex="^[A-Za-z0-9_-]*$" tabindex="1">
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">아이피</label>
									<input class="form-control" type="text" placeholder="아이피" id="hbase-ip" name="hbaseIp" regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" required="required"  tabindex="3">
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">설명</label>
									<input class="form-control" type="text" placeholder="데이터소스 역할 또는 설명" id="hbase-dtasrcNm" name="dtasrcNm" required="required" maxlength="100"  tabindex="2">
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">포트</label>
									<input class="form-control" type="text" placeholder="포트" id="hbase-port" name="port" regex="^[0-9]{4,5}$" required="required"  tabindex="4">
								</div>
							</div>
						</fieldset>
						<fieldset style="margin-top: 10px; padding: 10px;">
							<legend>
								<strong>옵션</strong> &nbsp;
								<i class="fa fa-plus-circle" onclick="addHbaseOptionRow('','');" style="cursor: pointer;"></i>
							</legend>
							<div id="dctca" style="display: none; color: #994F4F; font-style: italic; margin-top: 10px;">필수항목입니다.</div>
							<div class="form-group col-md-12" style="padding-right: 0px; margin-bottom: 0px;">
								<div class="col-md-4" style="padding-right: 0px;">
									<div class="form-group col-md-12" style="padding-right: 0px; margin-bottom: 0px;">
										<label class="form-label required-item">식별키</label>
									</div>
								</div>
								<div class="col-md-7" style="padding-right: 0px;">
									<div class="form-group col-md-12" style="padding-right: 0px; margin-bottom: 0px;">
										<label class="form-label required-item">값</label>
									</div>
								</div>
								<div class="col-md-1 text-center" style="padding-right: 0px;">
									<label class="form-label">삭제</label>
								</div>
							</div>
							<div class="form-group col-md-12" style="padding-right: 0px;" id="hbaseInfoOptionArea"></div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="saveHbaseContent();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- http configuration modal -->
<div class="modal fade" id="httpInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>HTTP 설정</strong></h4>
			</div>
			<form id=form05 name="form05" class="form-horizontal form-validation" onsubmit="return false;">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">데이터소스 아이디</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 식별자" id="http-dtasrcId" name="dtasrcId" required="required" maxlength="20" regex="^[A-Za-z0-9_-]*$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">설명</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 역할 또는 설명" id="http-dtasrcNm" name="dtasrcNm" required="required" maxlength="40">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>프로토콜</label>
									<select class="form-control" name="prtclSe" id="http-prtclSe" data-minimum-results-for-search="Infinity">
											<option value="http">http</option>
											<option value="https">https</option>
									</select>
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">서버모드</label>
									<select class="form-control" name="serverModeYn" id="serverModeYn" data-minimum-results-for-search="Infinity">
										<option value="N">아니오</option>
										<option value="Y">예</option>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">아이피</label>
									<input class="form-control col-md-6" type="text" placeholder="아이피" id="http-ip" name="ip" regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" required="required" >
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">포트</label>
									<input class="form-control col-md-6" type="text" placeholder="포트" id="http-port" name="port" regex="^[0-9]{4,5}$" required="required">
								</div>
							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="setHttpConfig();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- ftp configuration modal -->
<div class="modal fade" id="ftpInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>FTP 설정</strong></h4>
			</div>
			<form id="form06" name="form06" class="form-horizontal form-validation" onsubmit="return false;">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">데이터소스 아이디</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 식별자" id="ftp-dtasrcId" name="dtasrcId" maxlength="20"  regex="^[A-Za-z0-9_-]*$" required="required">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">설명</label>
									<input class="form-control col-md-6" type="text" placeholder="데이터소스 역할 또는 설명" id="ftp-dtasrcNm" name="dtasrcNm" maxlength="40" required="required">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">아이피</label>
									<input class="form-control col-md-6" type="text" placeholder="아이피" id="ftp-ip" name="ip" required regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">포트</label>
									<input class="form-control col-md-6" type="text" placeholder="포트" id="ftp-port" name="port" maxlength="5" required="required" regex="^[0-9]{2,5}$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">아이디</label>
									<input class="form-control col-md-6" type="text" placeholder="접속 아이디" id="username" name="username" required="required" maxlength="20">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label required-item">비밀번호</label>
									<input class="form-control col-md-6" type="password" placeholder="접속 비밀번호" id="ftp-password" name="password" required="required" maxlength="100">
								</div>
							</div>
							<div class="col-md-6" style="padding-right: 0px;">
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>프로토콜</label>
									<select class="form-control" name="prtclSe" id="ftp-prtclSe" data-minimum-results-for-search="Infinity" required="required">
										<option value="FTP">FTP</option>
										<option value="SFTP">SFTP</option>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">타임아웃</label>
									<input class="form-control col-md-6" type="text" placeholder="3000" id="soTimeout" name="soTimeout" value="3000" regex="^[0-9]{4,5}$">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label class="form-label">최대 재연결 시도</label>
									<input class="form-control col-md-6" type="text" placeholder="0" id="mxmmReconnect" name="mxmmReconnect" value="0" regex="^[0-9]{1}$" maxlength="1">
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>전송모드</label>
									<select class="form-control" name="transferModeSe" id="transferModeSe" data-minimum-results-for-search="Infinity" required="required">
										<option value="ACTIVE">ACTIVE</option>
										<option value="PASSIVE">PASSIVE</option>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>전송후연결종료</label>
									<select class="form-control" name="disconnectYn" id="disconnectYn" data-minimum-results-for-search="Infinity" required="required">
										<option value="Y">예</option>
										<option value="N">아니오</option>
									</select>
								</div>
								<div class="form-group col-md-12" style="padding-right: 0px;">
									<label>보안프로토콜</label>
									<select class="form-control" name="ftpSecrtyPrtclSe" id="ftpSecrtyPrtclSe" data-minimum-results-for-search="Infinity" required="required">
										<option value="NONE">NONE</option>
										<option value="SSL">SSL</option>
										<option value="TLS">TLS</option>
									</select>
								</div>
							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="setFtpConfig();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="modal fade" id="proxyInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>릴레이 설정</strong></h4>
			</div>
			<form id="form07" name="form07" class="form-horizontal form-validation" onsubmit="return false;">
				<input type="hidden" name="mode" id="mode" value="I">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<legend><strong>기본정보</strong></legend>
							<div class="col-md-12" style="padding-right:0px;">
								<div class="form-group col-md-6" >
									<label class="form-label">적용 대상 </label>
									<select class="form-control col-md-6" id="targtAgentId" name="targtAgentId" onchange="getRelayContent(this.value);" required="required">
										<option value="">선택하세요</option>
										<option value="CONSOLE">CONSOLE</option>
										<c:forEach var="item" items="${agentList}">
										<option value="${item.agentId}-${item.agentNo}">${item.agentId}-${item.agentNo}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-6" style="padding-right:0px;margin-left: 15px;">
									<label class="form-label">설명</label>
									<input class="form-control col-md-6" type="text" placeholder="" id="name" name="name" maxlength="20" required="required">
								</div>
							</div>
						</fieldset>
						<fieldset style="margin-top: 10px; padding: 10px;">
							<legend><strong>PROXY 설정</strong>
								<span class="label label-warning" style="padding-left:10px;padding-right:10px;cursor:pointer;" onclick="addProxyConfigForm('new');">추가</span>
							</legend>
							<div class="col-md-12" style="padding-right:0px;">
								<div class="form-group col-md-2" style="padding-right: 0px;margin-bottom: 0px;">
									<label class="form-label">포트 구분</label>
								</div>
								<div class="form-group col-md-3" style="padding-right: 0px;margin-left: 15px;margin-bottom: 0px;">
									<label class="form-label">수신 아이피</label>
								</div>
								<div class="form-group col-md-2" style="padding-right: 0px;margin-left: 15px;margin-bottom: 0px;">
									<label class="form-label">수신 포트</label>
								</div>
								<div class="form-group col-md-3" style="padding-right: 0px;margin-left: 15px;margin-bottom: 0px;">
									<label class="form-label">릴레이 아이피</label>
								</div>
								<div class="form-group col-md-2" style="padding-right: 0px;margin-left: 15px;margin-bottom: 0px;">
									<label class="form-label">릴레이 포트</label>
								</div>
							</div>
							<div class="col-md-12" style="padding-right:0px;" id="configArea">

							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed" data-dismiss="modal">취소</button>
					<c:if test="${liveYn eq 'Y'}">
					<button type="submit" class="btn btn-primary btn-embossed" onclick="setProxyContent();">저장</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- environment variable modal -->
<div class="modal fade" id="property" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-full">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>시스템 환경변수</strong></h4>
			</div>
			<div class="modal-body" style="padding-top: 20px; padding-left: 20px; padding-right: 20px; padding-bottom: 0px; margin-bottom: 0px; overflow-x: hidden;">
				<table class="table table-hover" id="propertyList">
					<thead>
						<tr>
							<th style="text-align: center; width: 15%">key</th>
							<th style="text-align: center; width: 85%">value</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-embossed" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="licensePushPop" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<i class="icons-office-52"></i>
				</button>
				<h4 class="modal-title"><strong>라이선스 배포</strong></h4>
			</div>
			<form id="form08" name="form08" class="form-horizontal form-validation" onsubmit="return false;">
				<input type="hidden" name="mode" id="mode" value="I">
				<div class="modal-body">
					<div class="col-md-12" style="padding-bottom: 20px;">
						<fieldset style="margin-top: 10px; padding: 10px;">
							<div class="col-md-12" style="padding-right:0px;">
							<label class="form-label">라이선스 키</label>
								<input class="form-control col-md-6" type="text" placeholder="라이선스 키를 입력하세요" id="licenseKey" name="licenseKey" regex="(.{8}\s){5}(.{3}){1}$" required="required">	
							</div>
						</fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-embossed cancel" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary btn-embossed" onclick="licensePush();">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>

</body>
<form id="reloadForm" name="reloadForm" action="/agent/agentConfigForm" method="POST">
	<input type="hidden" name="mode" value="U">
</form>
<script src="/assets/global/plugins/jquery/jquery-3.1.0.min.js"></script>
<script src="/assets/global/plugins/jquery/jqSimpleConnect.js"></script>
<script src="/assets/global/plugins/datatables/jquery.dataTables.min.js"></script>

<!-- WEBSOCKET -->
<script src="/assets/js/websocket/sockjs.js"></script>
<script src="/assets/js/websocket/stomp.js"></script>
<script src="/assets/js/common.js"></script>
<!-- CHART -->
<script src="/assets/global/plugins/jui/lib/core.js"></script>
<script src="/assets/global/plugins/jui/lib/chart.js"></script>
<script type="text/javascript">
	var sub1;
	var socket1;
	var stompClient1;
	var resultValue;
	var STATUS_KEY = '${REQUEST_PROCESS_STATUS_KEY}';
	var STATUS_VALUE_OK = '${REQUEST_PROCESS_STATUS_VALUE_OK}';
	var STATUS_VALUE_FAIL = '${REQUEST_PROCESS_STATUS_VALUE_FAIL}';
	var database;
	var windowAgentId = "${agentId}";
	var windowAgentNo = "${agentNo}";
	var windowAgentSe = "${agentSe}";
	var intervalId;

	var itemPosition  = ('${positionCn}') != '' ? JSON.parse('${positionCn}'): new Object();


	var wsUrl = '/console-ws';
	var serviceName = '/console/request/agent/resource' + '/' + windowAgentId + '/' + windowAgentNo;


	document.onkeydown = fkey;

	function fkey(e) {
		e = e || window.event;
		// F5 이벤트
		if (e.keyCode == 116) {
			var mainAgentLength = $('.main-item').length;
			if (mainAgentLength > 0) {
				var agentIdInput = document.createElement('input');
				agentIdInput.name = "agentId";
				agentIdInput.type = "hidden";
				agentIdInput.value = windowAgentId;
				var agentNoInput = document.createElement('input');
				agentNoInput.name = "agentNo";
				agentNoInput.type = "hidden";
				agentNoInput.value = windowAgentNo;
				var agentSeInput = document.createElement('input');
				agentSeInput.name = "agentSe";
				agentSeInput.type = "hidden";
				agentSeInput.value = windowAgentSe;

				$('#reloadForm').append(agentIdInput);
				$('#reloadForm').append(agentNoInput);
				$('#reloadForm').append(agentSeInput);
				$('#reloadForm').submit();
			} else {
				document.location.href = "/agent/agentConfigForm";
			}
			return false;
		}
		//ESC 이벤트
		if (e.keyCode == 27) {
			if('${mode}'== 'I'){
				document.location.href = "/agent/agentConfigList";
			}else{
				$('.contextMenuItem').css('display', 'none');
			}

		}


	}

	$(document).ready(function() {
		$('#agentItemDrawArea').on('contextmenu', function() {
  			return false;
		});

		if ('I' == '${mode}') {
			$('#agentInfo').modal();
		}

		database = JSON.parse('${databaseType}');

		$('#agentInfo .close').bind('click', function() {
			$('#form01 .form-group input').removeClass('form-success');
			$('#form01').validate().resetForm();
		});

		$('#agentInfo').draggable({
			obstacle : ".obstacle",
			preventCollision : true
		});

		$('#databaseTy').bind('change', function(e) {
			var databaseTy = $('#databaseTy').val();

			var form = $(e.target.parentElement.parentElement.parentElement);
			var url = eval('database.' + databaseTy).url;
			var driver = eval('database.' + databaseTy).driver;
			form.find('#url').val(url);
			form.find('#driverClass').val(driver);
		});


		if ('U' == '${mode}') {
			modifyDrawChart('${agentId}', '${agentNo}', '${agentSe}');

			if ('${liveYn}' == 'Y') {
				//agentTest('${agentId}', '${agentNo}');
				connect1();
			} else {
				notification('<strong>[${agentId}-${agentNo}]</strong> 에이전트와 연결하지 못했습니다.<br>에이전트 실행상태 및 네트워크를 확인하세요.');

			}
		}else{
			$('#form01 .cancel').bind('click', function(){
				document.location.href="/agent/agentConfigList";
			})
		}

		$('.modal.fade').draggable();


		$('#agentInfo').on('hidden.bs.modal', function () {
			$('#agentInfo form')[0].reset();
		});

		$('#form05 #serverModeYn').on('change', function(e){
			var value = $('#form05 #serverModeYn').val();
			if("Y" == value){
				$('#form05 #http-ip').val('0.0.0.0');
				$('#form05 #http-ip').attr('readonly', 'readonly');
				$('#form05 #http-ip').css('cursor', 'not-allowed');
			}else{
				$('#form05 #http-ip').val('');
				$('#form05 #http-ip').removeAttr('readonly');
				$('#form05 #http-ip').css('cursor', '');
			}
		});
	});


	//자원정보 수신용 웹소켓 연결
	function connect1() {
		try {
			socket1 = new SockJS(wsUrl);
			stompClient1 = Stomp.over(socket1);
			stompClient1.connect('', '', function(frame) {
				sub1 = stompClient1.subscribe('/console/response/agent/resource/'+ windowAgentId + '/'+windowAgentNo, getAgentResourceCallback);
				agentResourceRequest();
				intervalId = setInterval(agentResourceRequest, 10000);
			});
		} catch (e) {
			alert('자원정보 수신용 웹소켓 연결에 실패했습니다.\n관리자에게 문의하세요.');
		}
	}

	//에이전트 자원 정보 요청
	function agentResourceRequest() {
		stompClient1.send(serviceName, {}, {});
	}

	//에이전트 자원 요청 콜백
	function getAgentResourceCallback(message) {
		var result = JSON.parse(message.body);

		if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
			$('.resource-error-area').hide();
			var rd = result.resource;

			if (rd == undefined) {
				$('.resource-error-area').show();
			} else {
				moveProgressChart($('#cpuSystem'), rd.sysCpuPt, rd.sysCpuPt + '%');
				moveProgressChart($('#cpuVm'), rd.vmCpuPt, rd.vmCpuPt + '%');

				//var usedSystemMemory = rd.sysMemory - rd.useSysMemory;
				var memorySystemPer = (rd.useSysMemory / rd.sysMemory) * 100;
				var memorySystemText = rd.useSysMemory + ' MB/' + rd.sysMemory + ' MB'
				moveProgressChart($('#memorySystem'), memorySystemPer, memorySystemText);

				//var usedHeapMemory = rd.vmMemory - rd.useVmMemory;
				var memoryVmPer = (rd.useVmMemory / rd.vmMemory) * 100;
				var memoryVmText = rd.useVmMemory + ' MB/' + rd.vmMemory + ' MB';
				moveProgressChart($('#memoryVm'), memoryVmPer, memoryVmText);

				var diskPer = (rd.useDisk / rd.disk) * 100;
				var diskText = rd.useDisk + ' GB/' + rd.disk + ' GB';
				moveProgressChart($('#disk'), diskPer, diskText);
			}
		} else {
			$('.resource-error-area').show();
		}
	}


	function changeAgentSe(value){
		if(value == 'RELAY'){
			$('#form01 #agentNo').val("1");
			$('#form01 #agentNo').attr('readonly', 'readonly');
			$('#form01 #agentNo').css('cursor', 'not-allowed');
		}else{
			$('#form01 #agentNo').val('');
			$('#form01 #agentNo').removeAttr('readonly');
			$('#form01 #agentNo').css('cursor', 'text');
		}
	}
	function modifyDrawChart(agentId, agentNo, agentSe) {
		// 화면 데이터 요청 및 화면 그리기
		$.ajax({
			url : '/xhr/agent/chartData/' + agentId + '/' + agentNo + '/' + agentSe,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : onSuccessDrawChart,
			error : onError
		});
	}
	var parentAgentItemId;
	var tmp;
	// 등록모드- 에이전트 추가 / 수정모드시 화면 그리기
	function onSuccessDrawChart(result, readyState) {
		$('.btn.btn-success.baseInfo').remove();
		$('.btn.btn-success.datasource').show();
		$('.btn.btn-success.partner').show();
		$('.btn.btn-success.legacy').show();

		$('#agentItemDrawArea').html('');

		$('#agentItemDrawArea').append(getAgentItem(result.agentData));
		var parent = result.agentData.agentId+"-"+result.agentData.agentNo;
		parentAgentItemId=parent;
		var area = $('#agentItemDrawArea')
		var left = (area.width() / 2) - 185;
		var top = 0;

		if(itemPosition.hasOwnProperty(parent)){
			setItemPosition(parent, itemPosition[parent]);
		}else{
			setItemPosition(parent);
		}

		$('#' + parent).draggable({
			containment : "parent",
			obstacle : ".obstacle",
			preventCollision : true,
			drag : function(event, ui) {
				var lineCount = $('.child-item').length;
				for(var i = 0 ; i < lineCount; i++){
					jqSimpleConnect.repaintConnection('jqSimpleConnect_'+i);
				}
			},
			handle : '.dragHandle'
		});

		jqSimpleConnect.removeAll();

		var count = 0;
		var datasourceList = result.datasourceData;
		if(result.agentData.agentSe == 'AGENT'){
			if(datasourceList != undefined){
				datasourceList.forEach(function(ds) {
					$('#agentItemDrawArea').append(getDatasourceItem(ds));
					if(itemPosition.hasOwnProperty(ds.dtasrcId)){
						setItemPosition(ds.dtasrcId, itemPosition[ds.dtasrcId]);
					}else{
						setItemPosition(ds.dtasrcId);
					}
					contextMenuEventBind(ds.dtasrcId, 'datasource');
	
					linkItem(ds.dtasrcId, parent);
					changeByStatus(!ds.linkStatus, ds.dtasrcId);
				});
			}

			var partnerAgentList = result.partnerAgentData;
			if(partnerAgentList != undefined){
				partnerAgentList.forEach(function(pa) {
					$('#agentItemDrawArea').append(getParnerAgentItem(pa));
					var divId = pa.agentId + '-' + pa.agentNo;
	
					if(itemPosition.hasOwnProperty(divId)){
						setItemPosition(divId, itemPosition[divId]);
					}else{
						setItemPosition(divId);
					}
					contextMenuEventBind(divId, 'partner');
	
					linkItem(divId, parent);
					changeByStatus(!pa.linkStatus, divId);
				});
			}

			var hbaseDatasourceList = result.hbaseDatasourceList;
			if(hbaseDatasourceList != undefined){
				hbaseDatasourceList.forEach(function(hds) {
					$('#agentItemDrawArea').append(getHbaseDatasourceItem(hds));
					var divId = hds.dtasrcId + "-HBASE";
					if(itemPosition.hasOwnProperty(divId)){
						setItemPosition(divId, itemPosition[divId]);
					}else{
						setItemPosition(divId);
					}
					contextMenuEventBind(divId, 'hbase');
					linkItem(hds.dtasrcId + "-HBASE", parent);
					changeByStatus(!hds.linkStatus, hds.dtasrcId + "-HBASE");
	
				});
			}

			var httpList = result.httpList;
			if(httpList != undefined){
				httpList.forEach(function(hds) {
					$('#agentItemDrawArea').append(getHttpItem(hds));
					var divId = hds.dtasrcId + "-HTTP";
					if(itemPosition.hasOwnProperty(divId)){
						setItemPosition(divId, itemPosition[divId]);
					}else{
						setItemPosition(divId);
					}
					contextMenuEventBind(divId, 'http');
					linkItem(hds.dtasrcId + "-HTTP", parent);
	
					changeByStatus(!hds.linkStatus, hds.dtasrcId + "-HTTP");
				});
				}

			var ftpList =  result.ftpList;
			if(ftpList != undefined){
				ftpList.forEach(function(hds) {
					$('#agentItemDrawArea').append(getFtpItem(hds));
					var divId = hds.dtasrcId + "-FTP";
					if(itemPosition.hasOwnProperty(divId)){
						setItemPosition(divId, itemPosition[divId]);
					}else{
						setItemPosition(divId);
					}
					contextMenuEventBind(divId, 'ftp');
					linkItem(hds.dtasrcId + "-FTP", parent);
	
					changeByStatus(!hds.linkStatus, hds.dtasrcId + "-FTP");
				});
			}
		}else{
	 		var proxyList = result.proxyList;

 	 		proxyList.forEach(function(ds) {
				var targtAgentId = ds.targtAgentId;
				 $('#agentItemDrawArea').append(getProxyItem(ds));
				var id = "RELAY_" + ds.targtAgentId;
				if(itemPosition.hasOwnProperty(id)){
					setItemPosition(id, itemPosition[id]);
				}else{
					setItemPosition(id);
				}
				contextMenuEventBind(id, 'proxy');
				linkItem(id, parent);
				//changeByStatus(!ds.linkStatus, id);
			});
		}

		$('#agentInfo .close').click();
		$('#datasourceInfo .close').click();

		$('[data-rel="tooltip"]').tooltip();

		// 드래그 후 정지했을때 이벤트
		$('.main-item, .child-item').on('dragstop',function(event){
			storeItemPosition(event);
		});



		// 메인 아이템의 ContextMenu 제어 스크립트
		$('#'+parent+"_LINK .context-down-main").on('mousedown', function(event) {
			if ((event.button == 2) || (event.which == 3)) {
				var container = $('.mainContextMenu');

				if (!container.is(event.target) && container.has(event.target).length === 0) {
					container.css("display", "none");
				}
			}else if ((event.button == 0) || (event.which == 1)) {
				showMenu('main');
			}
		});


		// 아이템 그려지는 영역  클릭했을때 이벤트
		$('#agentItemDrawArea').on('mousedown', function(event) {
			if ((event.button == 0) || (event.which == 1)) {
				var container = $('.contextMenuItem');

				if (!container.is(event.target) && container.has(event.target).length === 0 && !$(event.target).hasClass('fa-angle-down') ) {
					container.css("display", "none");
				}
			}
		});

		//메인 에이전트가 동작중이 아닐때 모든 circle class deactivate 시킴
		if ('${liveYn}' == 'N') {
			$('.circle').removeClass('activate').addClass('deactivate');
		}
	}

	//화면 구성 항목들 위치 저장
	function storeItemPosition(event){
		itemPosition = {};
		$('.main-item, .child-item').each(function(index, event){
			var id = event.id;
			var top = event.offsetTop;
			var left = event.offsetLeft;
			itemPosition[id] = {
				top : top
				,left : left
			};
		});

		var data = {
			agentId : windowAgentId
			,agentNo : windowAgentNo
			,cn : JSON.stringify(itemPosition)
		}
			$.ajax({
			url : '/xhr/agent/config/position',
			method : 'POST',
			data :data,
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {

				} else {
					//notification(result.MESSAGE);
				}
			}
		});
	}
	

	function changeByStatus(status, id){
		if(status){
			$('#'+id+' .circle').css('background', '#ff5252');
			jqSimpleConnect.changeConnectLineStyle($('#'+id)[0].accessKey, 'red', 'dotted');
		}

	}

	// 컨텍스트 메뉴 이벤트 바인드
	function contextMenuEventBind(id, target){
		target = 'resource'
		$('#'+id+' .context-down').on('mousedown', function(event) {
			if ((event.button == 2) || (event.which == 3)) {
				var container = $('.'+target+'ContextMenu');
				if (!container.is(event.target) && container.has(event.target).length === 0) {
					container.css("display", "none");
				}
			}else if ((event.button == 0) || (event.which == 1)) {
				showMenu(target);
			}
		});
	}

	// 등록모드  - 에이전트 추가
	function setAgentContent() {
		if ($('#form01').valid()) {

			var body = $('#form01').serializeJSON();
			var mode = $('[id=mode]').val();

			body.agentSe = $('#form01 #agentSe').val();
			var agentId = body.agentId + "-" + body.agentNo;

			if(body.relayAgentId != 'NO-RELAY'){
				$.getJSON('/xhr/agent/relayConfigInfoList/'+agentId + '/' + body.relayAgentId, function(data, status){
					if(data.http != null && data.jms != null && data.manage != null){
						callBackAgentConfigProcess(mode, body)
					}else{
						notification('릴레이 에이전트['+body.relayAgentId+']에 ['+agentId+']에이전트 정보가 설정되어 있지 않습니다.');
					}
				});
			}else{
				callBackAgentConfigProcess(mode, body)
			}
		}
	}


	function callBackAgentConfigProcess(mode, body){
		$.ajax({
			url : '/xhr/agent/agentConfigProcess/' + mode,
			method : 'POST',
			contentType : 'application/json',
			data : JSON.stringify(body),
			success : drawChart
		});
	}

	// 등록모드 - 에이전트 추가 콜백 함수
	function drawChart(result, readyState) {
		if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {

			$('[id=mode]').val('U');
			$('.baseInfo').remove();
			windowAgentId = result.data.agentId;
			windowAgentNo = result.data.agentNo;
			windowAgentSe = result.data.agentSe;
			agentId = result.data.agentId;
			agentNo = result.data.agentNo;
			agentSe = result.data.agentSe;
			if (!agentNo || agentNo == undefined) {
				agentNo = windowAgentNo;
			}
			$('#form01 .cancel').unbind();
			modifyDrawChart(agentId, agentNo, agentSe);
		} else {
			notification(result.MESSAGE);
		}
	}

	//파트너 에이전트 추가
	function setPartnerAgent() {
		var mode = $('#form03 #mode').val();

		var agentId = $('#form03 #form03agentId').val();
		var agentRelay = $('#form03 #agentRelay').val();
		var partnId = $('#form03 #partnId').val();
		var partnRelay = $('#form03 #partnRelay').val();

		if($('#partnIdSelect').val() == ''){
			notification('파트너 에이전트를 선택하세요');
			return false;
		}

		// 둘다 릴레이를 사용하지 않음  : OK
		// 둘중 하나만 사용함 : FAIL
		// 둘다 사용함 : OK
		var a = false;
		var b = false;
		if(agentRelay == 'NO-RELAY'){
			a = true;
		}
		if(partnRelay == 'NO-RELAY'){
			b = true;
		}
		if(a != b ){
			notification('릴레이 에이전트를 사용하려면  에이전트와 파트너 에이전트 모두가 사용해야 합니다. ');
			return false;
		}

		$.ajax({
			url : '/xhr/agent/partnerAgentProcess/' + mode + '/' + agentId + '/' + agentRelay + '/' + partnId + '/' + partnRelay,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					if(mode == 'I'){
						partnerAgentAdd(result);									
					}else{
						$('#partnerAgentInfo .close').click();
					}
				} else {
					notification('에이전트 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			}
		});
	}

	// 아이템들 제자리에 위치시킴(값이 없으면 0, 0)
	function setItemPosition(id, pos) {
		var target = $('#' + id);
		if (pos) {
			target.css(pos);
		} else {
			target.css('top', '0px')
			target.css('left', '0px')
		}
	}

	// 데이터 소스 한개 추가
	function setDatasourceContent() {
		if ($('#form02').valid()) {
			var body = $('#form02').serializeJSON();
			body.agentId = windowAgentId;
			$('#datasourceInfo').modal('hide');
			$.ajax({
				url : '/xhr/agent/datasourceConfigProcess/${mode}',
				method : 'POST',
				data : JSON.stringify(body),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						$('#datasourceInfo .close').click();
						var dtasrcId = result.data.dtasrcId;
						datasourceItemAdd(dtasrcId, result);
					} else {
						notification('데이터베이스 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}

	// 데이터소스 항목 추가/수정
	function datasourceItemAdd(dtasrcId, result) {
		var accessKey = '';
		if ($('#' + dtasrcId).length == 1) {
			var top = $('#' + dtasrcId).css('top');
			var left = $('#' + dtasrcId).css('left');
			accessKey = $('#' + dtasrcId)[0].accessKey;
			jqSimpleConnect.removeConnection(accessKey);
			$('#' + dtasrcId).remove();
		}

		$('#agentItemDrawArea').append(getDatasourceItem(result.data));

		if ($('#' + dtasrcId).length == 1) {
			$('#' + dtasrcId).css({
				'top' : top,
				'left' : left
			});
		} else {
			setItemPosition(dtasrcId);
		}
		linkItem(dtasrcId, parentAgentItemId);
		contextMenuEventBind(dtasrcId, 'datasource');
		
 		// 드래그 후 정지했을때 이벤트
		$('#'+dtasrcId).on('dragstop',function(event){
			storeItemPosition(event);
		});		
		
	}

	// HTTP 설정 추가
	function setHttpConfig() {
		if ($('#form05').valid()) {
			var body = $('#form05').serializeJSON();
			body.dtasrcId=$('#form05 #http-dtasrcId').val();
			body.dtasrcNm=$('#form05 #http-dtasrcNm').val();
			body.prtclSe=$('#form05 #http-prtclSe').val();
			body.ip=$('#form05 #http-ip').val();
			body.port=$('#form05 #http-port').val();
			body.agentId = windowAgentId;
			$('#httpInfo').modal('hide');
			$.ajax({
				url : '/xhr/agent/httpConfigProcess/${mode}',
				method : 'POST',
				data : JSON.stringify(body),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						$('#httpInfo .close').click();
						var dtasrcId = result.data.dtasrcId +'-HTTP';
						httpItemAdd(dtasrcId, result);
					} else {
						notification('HTTP 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}

	// HTTP 항목 추가/수정
	function httpItemAdd(dtasrcId, result) {
		var accessKey = '';
		if ($('#' + dtasrcId).length == 1) {
			var top = $('#' + dtasrcId).css('top');
			var left = $('#' + dtasrcId).css('left');
			accessKey = $('#' + dtasrcId)[0].accessKey;
			jqSimpleConnect.removeConnection(accessKey);
			$('#' + dtasrcId).remove();
		}

		$('#agentItemDrawArea').append(getHttpItem(result.data));

		if ($('#' + dtasrcId).length == 1) {
			$('#' + dtasrcId).css({
				'top' : top,
				'left' : left
			});
		} else {
			setItemPosition(dtasrcId);
		}
		linkItem(dtasrcId, parentAgentItemId);
		contextMenuEventBind(dtasrcId, 'http');
		
 		// 드래그 후 정지했을때 이벤트
		$('#'+dtasrcId).on('dragstop',function(event){
			storeItemPosition(event);
		});	
	}

	// FTP 설정 추가
	function setFtpConfig() {
		if ($('#form06').valid()) {
			var body = $('#form06').serializeJSON();
			body.agentId = windowAgentId;
			$('#ftpInfo').modal('hide');
			$.ajax({
				url : '/xhr/agent/ftpConfigProcess/${mode}',
				method : 'POST',
				data : JSON.stringify(body),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						$('#ftpInfo .close').click();
						var dtasrcId = result.data.dtasrcId +'-FTP';
						ftpItemAdd(dtasrcId, result);
					} else {
						notification('FTP 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}

	// 데이터소스 항목 추가/수정
	function ftpItemAdd(dtasrcId, result) {
		var accessKey = '';
		if ($('#' + dtasrcId).length == 1) {
			var top = $('#' + dtasrcId).css('top');
			var left = $('#' + dtasrcId).css('left');
			accessKey = $('#' + dtasrcId)[0].accessKey;
			jqSimpleConnect.removeConnection(accessKey);
			$('#' + dtasrcId).remove();
		}

		$('#agentItemDrawArea').append(getFtpItem(result.data));

		if ($('#' + dtasrcId).length == 1) {
			$('#' + dtasrcId).css({
				'top' : top,
				'left' : left
			});
		} else {
			setItemPosition(dtasrcId);
		}
		linkItem(dtasrcId, parentAgentItemId);
		contextMenuEventBind(dtasrcId, 'ftp');
		
 		// 드래그 후 정지했을때 이벤트
		$('#'+dtasrcId).on('dragstop',function(event){
			storeItemPosition(event);
		});	
	}

	// HBASE 데이터소스 항목 추가/수정
	function hbaseItemAdd(dtasrcId, result) {
		var accessKey = '';
		if ($('#' + dtasrcId).length == 1) {
			var top = $('#' + dtasrcId).css('top');
			var left = $('#' + dtasrcId).css('left');
			accessKey = $('#' + dtasrcId)[0].accessKey;
			jqSimpleConnect.removeConnection(accessKey);
			$('#' + dtasrcId).remove();
		}

		$('#agentItemDrawArea').append(getHbaseDatasourceItem(result.data));

		if ($('#' + dtasrcId).length == 1) {
			$('#' + dtasrcId).css({
				'top' : top,
				'left' : left
			});
		} else {
			setItemPosition(dtasrcId);
		}
		linkItem(dtasrcId, parentAgentItemId);
		contextMenuEventBind(dtasrcId, 'hbase');
		
 		// 드래그 후 정지했을때 이벤트
		$('#'+dtasrcId).on('dragstop',function(event){
			storeItemPosition(event);
		});	
	}

	var linkIdMap = [];
	// 항목을 메인 에이전트와 선으로 연결한다.
	function linkItem(id, parentId) {
		var color = "gray";
		var main = '#' + parentId+'_LINK';
		var sub = '#' + id;

		var connectId = jqSimpleConnect.connect(main, sub, {radius: 2, color: color});
		linkIdMap.push({
			id : id,
			connectId : connectId
		});

		$(sub)[0].accessKey = connectId;

		$('#' + id).draggable({
			containment : "parent",
			obstacle : ".obstacle",
			preventCollision : true,
			drag : function(event, ui) {
				var tId = ui.helper[0].accessKey;
				jqSimpleConnect.repaintConnection(tId);
			},
			handle : '.dragHandle'
		});
		return connectId;
	}

	function getLinkId(id) {
		var connectId = "";
		for (i = 0; i < linkIdMap.length; i++) {
			if (linkIdMap[i].id == id) {
				connectId = linkIdMap[i].connectId;
				break;
			}
		}
		return connectId;
	}

	//파트너 항목 추가
	function partnerAgentAdd(result) {
		result.data.forEach(function(item) {
			$('#agentItemDrawArea').append(getParnerAgentItem(item));
			var id = item.agentId + '-' + item.agentNo;
			setItemPosition(id);
			linkItem(id, parentAgentItemId);
			contextMenuEventBind(id, 'partner');
			
	 		// 드래그 후 정지했을때 이벤트
			$('#'+id).on('dragstop',function(event){
				storeItemPosition(event);
			});			
		});

		$('#partnerAgentInfo .close').click();
	}

	// 성공시 콜백 function
	function onSuccess(result, readyState) {
		$('#agentItemDrawArea').append(getAgentItem(result.data));
		$('#agentInfo .close').click();
	}

	//실패시 콜백 function
	function onError(readyState, status) {
		notification('처리 실패');
	}

	function agentModify(agentId, agentNo) {		
		$.ajax({
			url : '/xhr/agent/agentConfigInfo/' + agentId + '/' + agentNo,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				document.form01.agentSeq.value = result.data.agentSeq;
				document.form01.agentId.value = result.data.agentId;
				document.form01.agentNo.value = result.data.agentNo;
				document.form01.agentSe.value = result.data.agentSe;
				document.form01.agentNm.value = result.data.agentNm;
				document.form01.ip.value = result.data.ip;
				document.form01.brokerPort.value = result.data.brokerPort;
				document.form01.httpPort.value = result.data.httpPort;
				//document.form01.jmxPort.value = result.data.jmxPort;
				document.form01.managePort.value = result.data.managePort;
				document.form01.relayAgentId.value = result.data.relayAgentId;
				var readonlyTarget1 = $(document.form01.agentId)
				readonlyTarget1.attr('readonly', 'readonly');
				readonlyTarget1.css('cursor', 'not-allowed');

				var readonlyTarget2 = $(document.form01.agentNo)
				readonlyTarget2.attr('readonly', 'readonly');
				readonlyTarget2.css('cursor', 'not-allowed');

				var readonlyTarget3 = $(document.form01.agentSe)
				readonlyTarget3.attr('disabled', 'disabled');
				readonlyTarget3.css('cursor', 'not-allowed');

				$('#agentInfo').modal();

			},
			error : function(z, x, v) {
				notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트 정보 조회에 실패했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		});
	}

	function proxyAddModal() {
		$('.contextMenuItem').hide();
		$('#form07')[0].reset();
		$('#form07 #mode').val('I');
		$('#form07 #configArea').html('')

		$('#proxyInfo').modal();
	}

	/* PROXY
	*/
	function setProxyContent() {
		if ($('#form07').valid()) {
			var body = $('#form07').serialize();
			var mode = $('#form07 #mode').val();
			body += "&agentId="+windowAgentId;
 			$.ajax({
				url : '/xhr/agent/relayConfigProcess/'+ mode,
				method : 'POST',
				data : body,
		/* 		dataType : 'json',
				contentType : 'application/json', */
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						$('#proxyInfo .close').click();
						var dtasrcId = "RELAY_" + result.targtAgentId;
						proxyItemAdd(dtasrcId, result);
					} else {
						notification('릴레이 설정 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}

	//PROXY 항목 추가/수정
	function proxyItemAdd(dtasrcId, result) {
		var accessKey = '';
		if ($('#' + dtasrcId).length == 1) {
			var top = $('#' + dtasrcId).css('top');
			var left = $('#' + dtasrcId).css('left');
			accessKey = $('#' + dtasrcId)[0].accessKey;
			jqSimpleConnect.removeConnection(accessKey);
			$('#' + dtasrcId).remove();
		}

		$('#agentItemDrawArea').append(getProxyItem(result));

		if ($('#' + dtasrcId).length == 1) {
			$('#' + dtasrcId).css({
				'top' : top,
				'left' : left
			});
		} else {
			setItemPosition(dtasrcId);
		}
		linkItem(dtasrcId, parentAgentItemId);
		contextMenuEventBind(dtasrcId, 'proxy');

		// 드래그 후 정지했을때 이벤트
		$('#'+dtasrcId).on('dragstop',function(event){
			storeItemPosition(event);
		});
	}

	function partnerDatasourceAddModal() {
		$('.contextMenuItem').hide();
		var readonlyTarget = $(document.form02.dtasrcId);
		readonlyTarget.removeAttr('readonly');
		readonlyTarget.css('cursor', 'auto');
		document.form02.reset();
		$('#datasourceInfo').modal();
	}


	function partnerHttpAddModal() {
		$('.contextMenuItem').hide();
		var readonlyTarget = $(document.form05.dtasrcId);
		readonlyTarget.removeAttr('readonly');
		readonlyTarget.css('cursor', 'auto');

		$('#form05 #http-ip').val('');
		$('#form05 #http-ip').removeAttr('readonly');
		$('#form05 #http-ip').css('cursor', '');

		document.form05.reset();
		$('#httpInfo').modal();
	}


	function partnerFtpAddModal() {
		$('.contextMenuItem').hide();
		var readonlyTarget = $(document.form06.dtasrcId);
		readonlyTarget.removeAttr('readonly');
		readonlyTarget.css('cursor', 'auto');
		document.form06.reset();
		$('#ftpInfo').modal();
	}

	function partnerHbaseAddModal() {
		$('.contextMenuItem').hide();
		var readonlyTarget = $(document.form04.dtasrcId);
		readonlyTarget.removeAttr('readonly');
		readonlyTarget.css('cursor', 'auto');
		$('#hbaseInfoOptionArea').html('');
		addHbaseOptionRow('', '');
		document.form04.reset();
		$('#hbaseInfo').modal();
	}

	function datasourceModify(agentId, dtasrcId) {
		$.ajax({
			url : '/xhr/agent/datasourceConfigInfo/' + agentId + '/' + dtasrcId,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				$('#form02 #rdbms-dtasrcId').val(result.data.dtasrcId);
				$('#form02 #rdbms-dtasrcNm').val(result.data.dtasrcNm);
				$('#form02 #rdbms-id').val(result.data.id);
				$('#form02 #rdbms-password').val(result.data.password);

				$('#form02 #databaseTy').val(result.data.databaseTy);
				$('#form02 #driverClass').val(result.data.driverClass);
				$('#form02 #url').val(result.data.url);

				$('#form02 #charcrSet').val(result.data.charcrSet);
				$('#form02 #maxCnncCnt').val(result.data.maxCnncCnt);
				$('#form02 #cnncWaitTime').val(result.data.cnncWaitTime);

				var readonlyTarget = $(document.form02.dtasrcId)
				readonlyTarget.attr('readonly', 'readonly');
				readonlyTarget.css('cursor', 'not-allowed');
				$('#datasourceInfo').modal();
			},
			error : function(z, x, v) {
				notification('<strong>['+dtasrcId+']</strong> 데이터베이스 정보 조회에 실패했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		});
	}

	function hbaseModify(agentId, dtasrcId) {
		$.ajax({
			url : '/xhr/agent/hbaseConfigInfo/' + agentId + '/' + dtasrcId,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				$('#form04 #hbase-dtasrcId').val(result.data.dtasrcId);
				$('#form04 #hbase-dtasrcNm').val(result.data.dtasrcNm);
				$('#form04 #hbase-ip').val(result.data.ip);
				$('#form04 #hbase-port').val(result.data.port);

				var readonlyTarget = $(document.form04.dtasrcId)
				readonlyTarget.attr('readonly', 'readonly');
				readonlyTarget.css('cursor', 'not-allowed');

				var optionList = result.data.optnList;
				var area = $('#hbaseInfoOptionArea');
				area.html('');
				for (i = 0; i < optionList.length; i++) {
					var item = optionList[i]
					addHbaseOptionRow(item.key, item.value);
				}

				$('#hbaseInfo').modal();
			},
			error : function(z, x, v) {
				notification('<strong>['+dtasrcId+']</strong> Hbase 정보 조회에 실패했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		});
	}

	function httpModify(agentId, dtasrcId) {
		$.ajax({
			url : '/xhr/agent/httpConfigInfo/' + agentId + '/' + dtasrcId,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {

				$('#form05 #http-dtasrcId').val(result.data.dtasrcId);
				$('#form05 #http-dtasrcNm').val(result.data.dtasrcNm);
				$('#form05 #http-ip').val(result.data.ip);
				$('#form05 #http-port').val(result.data.port);
				$('#form05 #http-prtclSe').val(result.data.prtclSe);
				$('#form05 #serverModeYn').val(result.data.serverModeYn);

				if(result.data.serverModeYn){
					$('#form05 #http-ip').attr('readonly', 'readonly');
					$('#form05 #http-ip').css('cursor', 'not-allowed');
				}

				var readonlyTarget = $('#form05 #http-dtasrcId');
				readonlyTarget.attr('readonly', 'readonly');
				readonlyTarget.css('cursor', 'not-allowed');

				$('#httpInfo').modal();
			},
			error : function(z, x, v) {
				notification('<strong>['+dtasrcId+']</strong> HTTP 정보 조회에 실패했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		});
	}

	function ftpModify(agentId, dtasrcId) {
		$.ajax({
			url : '/xhr/agent/ftpConfigInfo/' + agentId + '/' + dtasrcId,
			method : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			success : function(result, resultCode) {
				$('#form06 #ftp-dtasrcId').val(result.data.dtasrcId);
				$('#form06 #ftp-dtasrcNm').val(result.data.dtasrcNm);
				$('#form06 #ftp-ip').val(result.data.ip);
				$('#form06 #ftp-port').val(result.data.port);
				$('#form06 #username').val(result.data.username);
				$('#form06 #ftp-password').val(result.data.password);
				$('#form06 #ftp-prtclSe').val(result.data.prtclSe);
				$('#form06 #ftpsoTimeout').val(result.data.prtclSe);
				$('#form06 #ftpmxmmReconnect').val(result.data.ftpmxmmReconnect);
				$('#form06 #disconnectYn').val(result.data.disconnectYn);
				$('#form06 #transferModeSe').val(result.data.transferModeSe);
				$('#form06 #ftpSecrtyPrtclSe').val(result.data.ftpSecrtyPrtclSe);

				var readonlyTarget = $(document.form06.dtasrcId)
				readonlyTarget.attr('readonly', 'readonly');
				readonlyTarget.css('cursor', 'not-allowed');

				$('#ftpInfo').modal();
			},
			error : function(z, x, v) {
				notification('<strong>['+dtasrcId+']</strong> FTP 정보 조회에 실패했습니다.<br>시스템 관리자에게 문의하세요.');
			}
		});
	}

	function proxyModify(agentId, dtasrcId) {
		$('#proxyInfo').modal();
		$('#form07 #targtAgentId').val(dtasrcId);
		getRelayContent(dtasrcId);
	}

	function proxyDelete(agentId, targetAgentId) {
		confirm('<strong>['+targetAgentId+']</strong> 릴레이 설정 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = 'agentId='+agentId+'&targtAgentId='+targetAgentId;
			var tmpArray = targetAgentId.split('-');
			var url = "";
			if(tmpArray.length > 1){
				url = '/xhr/agent/relayConfigUseCheck/'+agentId+'/'+tmpArray[0];
			}else{
				url = '/xhr/agent/relayConfigUseCheck/'+agentId+'/'+targetAgentId
			}
			$.getJSON(url, function(result1, status){
				if(result1.useYn == 'N'){
		 			$.ajax({
						url : '/xhr/agent/relayConfigProcess/D',
						method : 'POST',
						//dataType : 'json',
						data : data,
						//contentType : 'application/json',
						success : function(result, resultCode) {							
							if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
								if (result.result = false) {
									notification('<strong>['+targetAgentId+']</strong> 릴레이 설정 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
								}else{
									jqSimpleConnect.removeConnection($('#RELAY_' + targetAgentId )[0].accessKey);
									$('#RELAY_' + targetAgentId).remove();
									confirmUnbind();
								}
							} else {
								notification('<strong>['+targetAgentId+']</strong> 릴레이 설정 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
							}
						}
					});
				}else{
					notification('['+data.config.partnId + '] 에이전트와의  파트너 연결에서 설정을 사용중입니다. ');
				}
			});
		});
	}

	function proxyDeleteOne( portSe, localPort) {
		var agentId = windowAgentId;
		var targetAgentId=$('#form07 #targtAgentId').val();

		confirm('<strong>['+targetAgentId+']</strong> PROXY 설정 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');

			var data = 'agentId='+agentId+'&targtAgentId='+targetAgentId+'&portSe='+portSe+'&localPort='+localPort

 			$.ajax({
				url : '/xhr/agent/relayConfigProcess/D',
				method : 'POST',
				data : data,
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+targetAgentId+']</strong> PROXY 설정 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}else{
							// 지운 항목 찾아서 화면에서 삭제
							var target = $('#configArea').find('[data-local-port='+localPort+']');
							target.remove();
							confirmUnbind();
							if($('#configArea .proxyItem').length == 0){
								document.location.reload();
							}
						}
					} else {
						notification('<strong>['+targetAgentId+']</strong> PROXY 설정 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});

		});
	}

	function agentDelete(agentId, agentNo, agentSeq) {
		confirm('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				'agentSeq' : agentSeq,
				'agentNo' : agentNo,
				'agentId' : agentId
			};
			$.ajax({
				url : '/xhr/agent/agentConfigProcess/D',
				method : 'POST',
				dataType : 'json',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						} else {
							confirmUnbind();
							document.location.href = '/agent/agentConfigList';
						}
					} else {
						notification('<strong>['+agentId+'-'+agentNo+']</strong> 에이전트 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		});
	}

	function partnerAgentDelete(agentId, agentNo) {
		if('${liveYn}' == 'N'){
			notification('에이전트에 연결하지 못한 상태 에서는 파트너 에이전트를 삭제 할 수 없습니다. ');
		}else{
			confirm('<strong>['+agentId+']</strong> 파트너 에이전트를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
				$('#confirmDiv').modal('hide');

				var agentSe = $('#'+agentId+'-'+agentNo).data('agentSe');
				$.ajax({
					url : '/xhr/agent/partnerAgentProcess/D/' + windowAgentId + '/A/' + agentId + '/A',
					method : 'POST',
					dataType : 'json',
					contentType : 'application/json',
					success : function(result, resultCode) {
						if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
							if (result.result = false) {
								notification('<strong>['+agentId+']</strong> 파트너 에이전트 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
							}else{
								jqSimpleConnect.removeConnection($('[id*=' + result.agentId + ']')[0].accessKey);
								$('[id*=' + result.agentId + ']').remove();
								confirmUnbind();
							}
						} else {
							notification('<strong>['+agentId+']</strong> 파트너 에이전트 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}
					}
				});
			});
		}
	}

	function datasourceDelete(agentId, dtasrcId) {
		confirm('<strong>['+dtasrcId+']</strong> 데이터베이스 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				'agentId' : agentId,
				'dtasrcId' : dtasrcId
			};

			$.ajax({
				url : '/xhr/agent/datasourceConfigProcess/D/',
				method : 'POST',
				dataType : 'json',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+agentId+']</strong> 데이터베이스 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}else{
							jqSimpleConnect.removeConnection($('#' + dtasrcId)[0].accessKey);
							$('#' + dtasrcId).remove();
							confirmUnbind();
						}
					} else {
						notification('<strong>['+dtasrcId+']</strong> 데이터베이스 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});

		});
	}

	function hbaseDelete(agentId, dtasrcId) {
		confirm('<strong>['+dtasrcId+']</strong> HBase 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				'agentId' : agentId,
				'dtasrcId' : dtasrcId
			};

			$.ajax({
				url : '/xhr/agent/hbaseDatasourceConfigProcess/D/',
				method : 'POST',
				dataType : 'json',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+agentId+']</strong> HBase 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}else{
							jqSimpleConnect.removeConnection($('#' + dtasrcId + '-HBASE')[0].accessKey);
							$('#' + dtasrcId + '-HBASE').remove();
							confirmUnbind();
						}
					} else {
						notification('<strong>['+dtasrcId+']</strong> HBase 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});

		});
	}


	function httpDelete(agentId, dtasrcId) {
		confirm('<strong>['+dtasrcId+']</strong> HTTP 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				'agentId' : agentId,
				'dtasrcId' : dtasrcId
			};

			$.ajax({
				url : '/xhr/agent/httpConfigProcess/D/',
				method : 'POST',
				dataType : 'json',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+agentId+']</strong> HTTP 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}else{
							jqSimpleConnect.removeConnection($('#' + dtasrcId + '-HTTP')[0].accessKey);
							$('#' + dtasrcId + '-HTTP').remove();
							confirmUnbind();
						}
					} else {
						notification('<strong>['+dtasrcId+']</strong> HTTP 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});

		});
	}

	function ftpDelete(agentId, dtasrcId) {
		confirm('<strong>['+dtasrcId+']</strong> FTP 정보를 삭제하시겠습니까?<br>삭제 후에는 취소가 불가능하니 주의하세요.', function() {
			$('#confirmDiv').modal('hide');
			var data = {
				'agentId' : agentId,
				'dtasrcId' : dtasrcId
			};

			$.ajax({
				url : '/xhr/agent/ftpConfigProcess/D/',
				method : 'POST',
				dataType : 'json',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(result, resultCode) {
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						if (result.result = false) {
							notification('<strong>['+agentId+']</strong> FTP 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
						}else{
							jqSimpleConnect.removeConnection($('#' + dtasrcId + '-FTP')[0].accessKey);
							$('#' + dtasrcId + '-FTP').remove();
							confirmUnbind();
						}
					} else {
						notification('<strong>['+dtasrcId+']</strong> FTP 정보 삭제 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});

		});
	}

	/*
	* 파트너 에이전트 추가 모달
	*/
	function partnerAgentAddModal(modalDivId) {
		$('.contextMenuItem').hide();
		var mainAgentLength = $('.main-item').length;
		var agentId = $('.main-item').attr('id').split('-')[0];

		var sendData = {
			agentId : agentId
		}

		$.ajax({
			url : '/xhr/agent/agentList',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				var remainAgentSize = result.AGENT_LIST.length;
				if (remainAgentSize > 0) {
					var select = $('#form03 #partnIdSelect')[0];
					select.innerHTML=""
					var defaultOption = document.createElement('option');
					defaultOption.value = "";
					defaultOption.innerHTML = "선택하세요";
					select.append(defaultOption);
					for (i = 0; i < result.AGENT_LIST.length; i++) {
						var item = result.AGENT_LIST[i];
						var option = document.createElement('option');
						option.value = item.agentId;
						option.innerHTML = item.agentId + "(" + item.agentNm + ")";
						select.append(option);
					}
					$('#form03')[0].reset();
					$('#form03 #mode').val('I');
					$('.partner-select').show();
					$('#form03 .partnId-text').html('선택하세요');
					$('#partnerAgentInfo').modal();
					$('#form03 #form03agentId').val(windowAgentId);

				} else {
					notification('모든 에이전트와 연결되어 있어 더 이상 등록할 수 있는 에이전트가 없습니다.');
				}
			}
		});
	}
	/*
	* 파트너 에이전트 수정 모달
	*/

	function partnerAgentModifyModal(partnAgentId, partnAgentNo) {
		$('.contextMenuItem').hide();

		$.getJSON('/xhr/agent/partnerInfo/' + windowAgentId + '/' + partnAgentId + '/' + partnAgentNo , function(result){

			var partnRelay =  result.data.relayAgentId;
			var agentRelay =  result.data2.relayAgentId;

			var select = $('#form03 #partnIdSelect')[0];
			select.innerHTML=""
			var defaultOption = document.createElement('option');
			defaultOption.value = result.data.agentId;
			defaultOption.innerHTML = result.data.agentId;
			select.append(defaultOption);
			changeRelayAgentSelect(result.data.agentId, partnRelay);

			$('.partnId-text').html(partnAgentId);
			$('#form03 #mode').val('U');
			$('#form03 #agentRelay').val(agentRelay);
			$('.partner-select').hide();

			$('#form03 #form03agentId').val(windowAgentId);
			$('#form03 #partnId').val(partnAgentId);

			$('#partnerAgentInfo').modal();
		});
	}

	function getAgentItem(item) {
		var agentSeq = item.agentSeq;
		var agentId = item.agentId ;
		var agentNo = item.agentNo;
		var agentSe = item.agentSe;
		var agentNm = item.agentNm;
		var ip = item.ip;
		var httpPort = item.httpPort;
		var brokerPort = item.brokerPort;
		//var jmxPort = item.jmxPort;
		var managePort = item.managePort;
		var licenseAlertYnText = '${licenseAlertYn}' == 'Y' ? 'style="color:#c14444;font-weight:bold"':'';

		var item ="";
		item+='<div class="col-md-6 main-item" id="'+agentId+ "-" + agentNo +'">';
		item+='	<div class="component-header">';
		item+='		<div class="center">';
		item+='			<div class="control">';
		item+='				<a href="#" class="item" data-rel="tooltip" data-placement="top" data-original-title="환경변수" onclick="getAgentProperty(\'' + agentId + '\',\'' + agentNo + '\');"><i class="icon-info"></i></a>';
		item+='				<a href="#" class="item" data-rel="tooltip" data-placement="top" data-original-title="연결테스트" onclick="agentTest(\'' + agentId + '\',\'' + agentNo + '\');"><i class="icon-check"></i></a>';
		item+='				<a href="#" class="item" data-rel="tooltip" data-placement="top" data-original-title="수정" onclick="agentModify(\'' + agentId + '\',\'' + agentNo + '\');"><i class="icon-note"></i></a>';
		item+='				<a href="#" class="item" data-rel="tooltip" data-placement="top" data-original-title="삭제" onclick="agentDelete(\'' + agentId + '\',\'' + agentNo + '\',\'' + agentSeq + '\');"><i class="icon-trash"></i></a>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='	<div id="'+agentId+ '-' + agentNo +'_LINK" class="component-body col-md-12" style="padding-top:10px;height:475px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='<div class="context-down-main"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		if(agentSe == 'AGENT'){
			item+='					<i class="fa fa-server activate circle dragHandle"></i>';
		}else{
			item+='					<i class="fas fa-code-branch activate circle dragHandle"></i>';
		}
		item+='				</div>';
		item+='				<div class="right">';
		if(agentSe == 'AGENT'){
			item+='					<div><span class="c-primary pull-left mainItemName">' + agentId+ '-' + agentNo + '</span></div>';
		}else{
			item+='					<div><span class="c-primary pull-left mainItemName">' + agentId + '</span></div>';
		}
		item+='					<div class="txt" style="width:190px;word-break: break-all;">'+ agentNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='<div class="row" style="padding-left:20px;">';
		item+='	<h6 style="margin-top:10px;margin-bottom:0px"><strong>운영상태</strong></h6>';
		item+='	<div class="col-lg-12">';
		item+='		<div class="bd-blue">';
		item+='		<address style="padding-left:10px">';
		item+='			<table style="width:100%; margin-top: 10px;">';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width: 80px;">구동시간</td>';
		item+='					<td class="f-12 p-l-5">${startTime}</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5">운영시간</td>';
		item+='					<td class="f-12 p-l-5">${upTime}</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5">라이선스만료</td>';
		item+='					<td class="f-12 p-l-5 licenseAlertYnText" '+licenseAlertYnText+'>${licenseEndDate}</td>';
		item+='				</tr>';
		item+='			</table>';
		item+='		</address>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';
		item+='<div class="row" style="padding-left:20px;">';
		item+='	<h6 style="margin-top:0px;margin-bottom:0px"><strong>네트워크</strong></h6>';
		item+='	<div class="col-lg-12">';
		item+='		<div class="bd-blue">';
		item+='		<address style="padding-left:10px">';
		item+='			<table style="width:100%; margin-top:10px;">';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width: 80px;">IP</td>';
		item+='					<td class="f-12 p-l-5">'+ ip + '</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5">HTTP 포트</td>';
		item+='					<td class="f-12 p-l-5">'+ httpPort + '</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5">메시지 포트</td>';
		item+='					<td class="f-12 p-l-5">'+ brokerPort + '</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5">관리 포트</td>';
		item+='					<td class="f-12 p-l-5">'+ managePort + '</td>';
		item+='				</tr>';
		item+='			</table>';
		item+='		</address>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';
		item+='<div class="row" style="padding-left:20px;">';
		item+='	<h6 style="margin-top:0px;margin-bottom:0px"><strong>자원현황</strong></h6>';
		item+='	<div class="col-lg-12">';
		item+='		<div class="bd-blue">';
		item+='		<address style="padding-left:10px">';
		item+='			<table style="width:100%; margin-top:10px;">';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width:80px;padding-bottom:5px;">CPU(전체)</td>';
		item+='					<td class="f-12 p-l-5" style="padding-bottom:5px;padding-right:10px;">';
		item+='						<div class="progress" id="cpuSystem" style="margin-top:0px;height:20px;border-radius:2px;">';
		item+='							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius:2px;"></div>';
		item+='							<div class="progressbarText f-8">0</div>';
		item+='						</div>';
		item+='					</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width:80px;padding-bottom:5px;">CPU(VM)</td>';
		item+='					<td class="f-12 p-l-5" style="padding-bottom:5px;padding-right:10px;">';
		item+='						<div class="progress" id="cpuVm" style="margin-top:0px;height:20px;border-radius:2px;">';
		item+='							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius:2px;"></div>';
		item+='							<div class="progressbarText f-8">0</div>';
		item+='						</div>';
		item+='					</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width:80px;padding-bottom:5px;">메모리(전체)</td>';
		item+='					<td class="f-12 p-l-5" style="padding-bottom:5px;padding-right:10px;">';
		item+='						<div class="progress" id="memorySystem" style="margin-top:0px;height:20px;border-radius:2px;">';
		item+='							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius:2px;"></div>';
		item+='							<div class="progressbarText f-8">0</div>';
		item+='						</div>';
		item+='					</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width:80px;padding-bottom:5px;">메모리(VM)</td>';
		item+='					<td class="f-12 p-l-5" style="padding-bottom:5px;padding-right:10px;">';
		item+='						<div class="progress" id="memoryVm" style="margin-top:0px;height:20px;border-radius:2px;">';
		item+='							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius:2px;"></div>';
		item+='							<div class="progressbarText f-8">0</div>';
		item+='						</div>';
		item+='					</td>';
		item+='				</tr>';
		item+='				<tr class="p-t-10">';
		item+='					<td class="f-12 p-l-5" style="width:80px;padding-bottom:5px;">디스크</td>';
		item+='					<td class="f-12 p-l-5" style="padding-bottom:5px;padding-right:10px;">';
		item+='						<div class="progress" id="disk" style="margin-top:0px;height:20px;border-radius:2px;">';
		item+='							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="border-radius:2px;"></div>';
		item+='							<div class="progressbarText f-8">0</div>';
		item+='						</div>';
		item+='					</td>';
		item+='				</tr>';
		item+='			</table>';
		item+='		</address>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';
		item+='</div>';

		return item;
	}

	function getParnerAgentItem(item) {
		var relayAgentId = item.relayAgentId;

		var partnSeText = relayAgentId == 'NO-RELAY' ? "" : "("+relayAgentId+")";
		var agentId = item.agentId;
		var agentNo = item.agentNo;
		var agentNm = item.agentNm;
		var ip = item.ip;
		var httpPort = item.httpPort;
		var brokerPort = item.brokerPort;
		var managePort = item.managePort;
		var dstbSttusText = "c-primary";
		var activateText = "activate";

		var item ="";
		item+='<div class="col-md-6 child-item draggable" id="'+agentId+'-'+agentNo+'" data-control-id="'+agentId+'-'+agentNo+'#!#PARTNER">';
		item+='<div class="context-down"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+agentId+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fa fa-server ' + activateText +' circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="'+dstbSttusText+' pull-left f-16">' + agentId + '-' + agentNo +'</span><span  class="f-6">'+ partnSeText+ '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">' + agentNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';
		return item;
	}

	function getDatasourceItem(item) {
		var url = item.url;
		var agentId = item.agentId;
		var databaseTy = item.databaseTy;
		var dtasrcId = item.dtasrcId;
		var dtasrcNm = item.dtasrcNm;
		var driverClass = item.driverClass;
		var id = item.id;
		var dstbSttus = item.dstbSttus;
		var dstbSttusText = "c-primary";
		var activateText = "activate";
		// 배포상태
		if (dstbSttus == 'F') {
			dstbSttusText = "c-orange";
			acctivateText = "deactivate";
		}

		var item ="";
		item+='<div class="col-md-6 child-item draggable" id="'+dtasrcId+'" data-control-id="'+dtasrcId+'#!#DATASOURCE">';
		item+='<div class="context-down"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+dtasrcId+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fa fa-database ' + activateText +' circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="'+dstbSttusText+' pull-left f-16">' + dtasrcId+ '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">' + dtasrcNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';

		return item;
	}

	/* HBASE 아이템 */
	function getHbaseDatasourceItem(item) {
		var url = item.url;
		var agentId = item.agentId;
		var dtasrcId = item.dtasrcId;
		var dtasrcNm = item.dtasrcNm;
		var ip = item.ip;
		var port = item.port;
		var dstbSttusText = "c-primary";
		var activateText = "activate";
		var dstbSttus = item.dstbSttus;
		// 배포상태
		if (dstbSttus == 'F') {
			dstbSttusText = "c-orange";
			acctivateText = "deactivate";
		}

		var item ="";
		item+='<div class="col-md-6 child-item  draggable" id="'+dtasrcId+'-HBASE"  data-control-id="'+dtasrcId+'#!#HBASE">';
		item+='<div class="context-down"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+dtasrcId+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fas fa-archive ' + activateText +' circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="'+dstbSttusText+' pull-left f-16">' + dtasrcId+ '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">' + dtasrcNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';

		return item;
	}

	/* HTTP 아이템 */
	function getHttpItem(item) {
		var url = item.url;
		var agentId = item.agentId;
		var dtasrcId = item.dtasrcId;
		var dtasrcNm = item.dtasrcNm;
		var ip = item.ip;
		var port = item.port;
		var dstbSttusText = "c-primary";
		var activateText = "activate";
		var dstbSttus = item.dstbSttus;
		// 배포상태
		if (dstbSttus == 'F') {
			dstbSttusText = "c-orange";
			acctivateText = "deactivate";
		}

		var item ="";
		item+='<div class="col-md-6 child-item  draggable" id="'+dtasrcId+'-HTTP"  data-control-id="'+dtasrcId+'#!#HTTP">';
		item+='<div class="context-down"><i class="fa fa-angle-down"  data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+dtasrcId+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fas fa-cloud ' + activateText +' circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="'+dstbSttusText+' pull-left f-16">' + dtasrcId+ '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">' + dtasrcNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';

		return item;
	}

	/* FTP 아이템 */
	function getFtpItem(item) {
		var url = item.url;
		var agentId = item.agentId;
		var dtasrcId = item.dtasrcId;
		var dtasrcNm = item.dtasrcNm;
		var ip = item.ip;
		var port = item.port;
		var dstbSttusText = "c-primary";
		var activateText = "activate";
		var dstbSttus = item.dstbSttus;
		// 배포상태
		if (dstbSttus == 'F') {
			dstbSttusText = "c-orange";
			acctivateText = "deactivate";
		}

		var item ="";
		item+='<div class="col-md-6 child-item  draggable" id="'+dtasrcId+'-FTP"  data-control-id="'+dtasrcId+'#!#FTP">';
		item+='<div class="context-down"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+dtasrcId+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fas fa-exchange-alt ' + activateText +' circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="'+dstbSttusText+' pull-left f-16">' + dtasrcId+ '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">' + dtasrcNm + '</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';

		return item;
	}

	/* PROXY ITEM */
	function getProxyItem(item) {
		var id = 'RELAY_'+item.targtAgentId;
		var showId = item.targtAgentId;
		var name = item.name;

		var dstbSttusText = "c-primary";
		var activateText = "activate";
		var item ="";
		item+='<div class="col-md-6 child-item draggable" id="'+id+'" data-control-id="'+showId+'#!#PROXY">';
		item+='<div class="context-down"><i class="fa fa-angle-down" data-rel="tooltip" data-placement="top" data-original-title="메뉴보기"></i></div>';
		item+='	<div id="'+id+'_LINK" class="component-body col-md-12" style="height:70px;border-radius: 8px 8px 8px 8px;background:#F9F9F9;border: 1px solid #c0c0c0;box-shadow: 2px 3px 3px rgba(0, 0, 0, 0.2);">';
		item+='		<div class="row" style="margin:20px 0px 0px 0px;">';
		item+='			<div class="widget-infobox">';
		item+='				<div class="left">';
		item+='					<i class="fa fa-server activate circle dragHandle"></i>';
		item+='				</div>';
		item+='				<div class="right" style="padding-top:4px;">';
		item+='					<div><span class="c-primary pull-left f-16">' + showId + '</span></div>';
		item+='					<div class="txt f-11" style="width:130px;word-break:break-all;">'+ name +'</div>';
		item+='				</div>';
		item+='			</div>';
		item+='		</div>';
		item+='	</div>';
		item+='</div>';

		return item;
	}

	function getAgentProperty(agentId, agentNo) {

		var sendData = {
			agentId : agentId,
			agentNo : agentNo
		}

		$.ajax({
			url : '/xhr/agent/property',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				var table = new TABLE('#propertyList');
				table.removeBody();
				table.addTBody();
				var dataList = result.data;
				if (dataList) {
					for (i = 0; i < dataList.length; i++) {
						var item = dataList[i];
						var row = table.addRow();
						var colArray = [];

						// 컬럼 텍스트, 정렬, 이벤트 callback
						colArray.push(table.columnItem(item.key, 'left', null));
						colArray.push(table.columnItem(item.value, 'left', null));
						// 테이블 row 객체, 데이터 array, 컬럼 갯수
						table.addColumnArray(row, colArray, 2);
					};
					if (dataList.length == 0) {
						var row = table.addRow();
						var colArray = [];
						table.addColumnArray(row, colArray, 2);
					}
					$('#property').modal();
				}
			}
		});
	}

	function getAgentResource() {

		var sendData = {
			agentId : windowAgentId,
			agentNo : windowAgentNo
		}

		$.ajax({
			url : '/xhr/agent/resource',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
					var rd = result.data;
					moveProgressChart($('#cpuSystem'), rd.cpuSystem, rd.cpuSystem + '%');
					moveProgressChart($('#cpuVm'), rd.cpuUser, rd.cpuUser + '%');

					var usedSystemMemory = rd.memorySystemTotal - rd.memorySystemAvailable;
					var memorySystemPer = (usedSystemMemory / rd.memorySystemTotal) * 100;
					var memorySystemText = usedSystemMemory + ' MB/' + rd.memorySystemTotal + ' MB'
					moveProgressChart($('#memorySystem'), memorySystemPer, memorySystemText);

					var usedHeapMemory = rd.memoryHeapTotal - rd.memoryHeapAvailable;
					var memoryVmPer = (usedHeapMemory / rd.memoryHeapTotal) * 100;
					var memoryVmText = usedHeapMemory + ' MB/' + rd.memoryHeapTotal + ' MB';
					moveProgressChart($('#memoryVm'), memoryVmPer, memoryVmText);

					var diskPer = (rd.diskUse / rd.diskTotal) * 100;
					var diskText = rd.diskUse + ' GB/' + rd.diskTotal + ' GB';
					moveProgressChart($('#disk'), diskPer, diskText);
				} else {

				}
			}
		});
	}

	function moveProgressChart(target, percentage, value) {
		target.find('.progress-bar').css('width', percentage + '%');
		var targetItem = target.find('.progress-bar')
		target.find('.progressbarText').html(value);

		if (percentage < 70) {
			targetItem.removeClass('progress-bar-warning');
			targetItem.removeClass('progress-bar-danger');
			targetItem.addClass('progress-bar-success');
		} else if (percentage >= 70) {
			targetItem.addClass('progress-bar-warning');
			targetItem.removeClass('progress-bar-success');
			targetItem.removeClass('progress-bar-danger');
		} else if (percentage >= 90) {
			targetItem.addClass('progress-bar-danger');
			targetItem.removeClass('progress-bar-success');
			targetItem.removeClass('progress-bar-warning');
		}
	}

	function agentTest(agentId, agentNo) {
		var sendData = {
			agentId : agentId,
			agentNo : agentNo
		}

		$.ajax({
			url : '/xhr/agent/linkVaildCheck',
			method : 'POST',
			data : sendData,
			success : function(result, resultCode) {
				var list = result.linkData;
				if (list != undefined && result.STATUS != 'FAIL') {
					//$('.mainItemName').removeClass('c-red');
					//$('.mainItemName').addClass('c-primary');

					for (i = 0; i < list.length; i++) {
						var item = list[i];

						if (item == null) {
							$('.circle').removeClass('activate').addClass('deactivate');
							notification('에이전트에 연결하지 못했습니다.');
							break;
						}

						var key = '#' + item.id;
						if (item.type == 'HBASE') {
							key = key + '-HBASE';
						}
						if ($(key)[0]) {
							var accessKey = $(key)[0].accessKey;
							if (item.result < 0) {
								jqSimpleConnect.changeConnectLineStyle(accessKey, 'red', 'dotted');
								$(key + ' .circle').css('background', '#ff5252');
							} else {
								//jqSimpleConnect.changeConnectLineStyle(accessKey, 'gray', 'solid');
								$(key + ' .circle').css('background', '#4caf50');
							}
						}
					}
				} else {
					$('.circle').removeClass('activate').addClass('deactivate');
					var childList = $('.child-item');
					for (j = 0; j < childList.length; j++) {
						var item = childList[j];
						jqSimpleConnect.changeConnectLineStyle(item.accessKey, 'red', 'dotted');
					}
					$('.child-item .circle').css('background', '#ff5252');
					//$('.mainItemName').removeClass('c-primary');
					//$('.mainItemName').addClass('c-red');
				}
			},error : function(result, resultCode) {
				var childList = $('.child-item');
				for (j = 0; j < childList.length; j++) {
					var item = childList[j];
					jqSimpleConnect.changeConnectLineStyle(item.accessKey, 'red', 'dotted');
				}
				$('.child-item .circle').css('background', '#ff5252');
				$('.mainItemName').removeClass('c-primary');
				$('.mainItemName').addClass('c-red');
			}
		});
	}
	function showMenu(target) {
			$('.contextMenuItem').hide();
			var event = window.event;

			var contextObject = $('.'+target+'ContextMenu');
			var item = $(event.target.parentElement.parentElement);
			if(item.hasClass("child-item")){
				var data_control_id = item.data('controlId');
				var id = data_control_id.split('#!#')[0];
				var type = data_control_id.split('#!#')[1];

				contextObject.find('.delete').unbind('click');
				contextObject.find('.modify').unbind('click');

				if("PARTNER" == type){
					var partnerAgentId = id.split('-')[0];
					var partnerAgentNo = id.split('-')[1];

					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
						partnerAgentModifyModal(partnerAgentId, partnerAgentNo);
					});

					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						partnerAgentDelete(partnerAgentId, partnerAgentNo);
					});
				}else if("DATASOURCE" == type){
					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
						datasourceModify(windowAgentId, id);
					});

					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						datasourceDelete(windowAgentId, id);
					});
				}else if("HBASE" == type){
					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
						hbaseModify(windowAgentId, id);
					});
					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						hbaseDelete(windowAgentId, id);
					});
				}else if("HTTP" == type){
					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
						httpModify(windowAgentId, id);
					});
					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						httpDelete(windowAgentId, id);
					});
				}else if("FTP" == type){
					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
						ftpModify(windowAgentId, id);
					});
					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						ftpDelete(windowAgentId, id);
					});
				}else if("PROXY" == type){
					contextObject.find('.modify').bind('click', function(){
						contextObject.hide();
 						proxyModify(windowAgentId, id);
					});
					contextObject.find('.delete').bind('click', function(){
						contextObject.hide();
						proxyDelete(windowAgentId, id);
					});
				}
			}

			contextObject.css('left', event.pageX);
			contextObject.css('top', event.pageY - 115);
			contextObject.show();
	}

	function addHbaseOptionRow(key, value) {
		var area = $('#hbaseInfoOptionArea');
		var html = '<div class="col-md-12 optionItem" style="padding:0px 0px 0px 0px;">';
		html += '	<div class="col-md-4" style="padding-right:0px;">';
		html += '			<div class="form-group col-md-12" style="padding-right:0px;">';
		html += '				<input class="form-control" type="text" id="key" name="key" value="'+key+'" required="required" maxlength="100">';
		html += '			</div>';
		html += '		</div>';
		html += '		<div class="col-md-7" style="padding-right:0px;">';
		html += '			<div class="form-group col-md-12" style="padding-right:0px;">';
		html += '			<input class="form-control" type="text" id="value" name="value" value="'+value+'" required="required" maxlength="100">';
		html += '			</div>';
		html += '		</div>';
		html += '		<div class="col-md-1" style="padding-right:0px;">';
		html += '			<i class="fa fa-minus-circle" style="cursor: pointer;padding-top:10px;padding-left:10px;" onclick="removeHbaseOptionRow(this);"></i>';
		html += '		</div>';
		html += '	</div>';
		area.append(html);
	}

	function removeHbaseOptionRow(row) {
		row.parentNode.parentNode.remove();
	}

	function saveHbaseContent() {
		var validChk = true;
		var sendData = {};
		sendData.agentId = windowAgentId;
		sendData.dtasrcId = $('#hbase-dtasrcId').val();
		sendData.dtasrcNm = $('#hbase-dtasrcNm').val();
		sendData.ip = $('#form04 #hbase-ip').val();
		sendData.port = $('#form04 #hbase-port').val();
		var optnCnList = [];

		if (sendData.dtasrcId == '') {
			$('#hbase-dtasrcId').addClass('form-error');
			validChk = false;
		}
		if (sendData.dtasrcNm == '') {
			$('#hbase-dtasrcNm').addClass('form-error');
			validChk = false;
		}

		var optionSize = $('.optionItem').length;

		for (i = 0; i < optionSize; i++) {
			var optionItemOb = $($('.optionItem')[i]);
			var key = optionItemOb.find('[id=key]').val();
			var value = optionItemOb.find('[id=value]').val();

			if (key != '' && value != '') {
				var optionItem = {
					key : key,
					value : value
				}
				optnCnList.push(optionItem);
			} else {
				if (key == '') {
					optionItemOb.find('[id=key]').addClass('form-error');
				}
				if (value == '') {
					optionItemOb.find('[id=value]').addClass('form-error');
				}
// 				validChk = false
			}
		}

		sendData.optnCn = JSON.stringify(optnCnList);

		if (validChk && $('#form04').valid()) {
			$('#hbaseInfo').modal('hide');
			$.ajax({
				url : '/xhr/agent/hbaseDatasourceConfigProcess/${mode}',
				method : 'POST',
				data : JSON.stringify(sendData),
				dataType : 'json',
				contentType : 'application/json',
				success : function(result, resultCode) {
					var hds = result.data;
					if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {
						var dtasrcId = hds.dtasrcId + '-HBASE';
						hbaseItemAdd(dtasrcId, result);
					} else {
						notification('HBase 정보 추가 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
					}
				}
			});
		}
	}

	function getRelayContent(agentId){
		var relayAgentId = windowAgentId;
		$.getJSON('/xhr/agent/relayConfigInfoList/'+agentId + '/' + relayAgentId , function(data, status){
			var configArea = $('#form07 #configArea');
			$('#form07 #name').val('');
			var nameWrite = false;
			configArea.html('');
			if(data.http != null){
				if(!nameWrite){
					$('#form07 #name').val(data.http.name);
					nameWrite = true;
				}
				configArea.append(getRelayConfigForm('HTTP', data.http.listenHost, data.http.localPort, data.http.forwardHost, data.http.forwardPort));
			}
			if(data.jms != null){
				if(!nameWrite){
					$('#form07 #name').val(data.http.name);
					nameWrite = true;
				}
				configArea.append(getRelayConfigForm('JMS', data.jms.listenHost, data.jms.localPort, data.jms.forwardHost, data.jms.forwardPort));
			}
			if(data.manage != null){
				if(!nameWrite){
					$('#form07 #name').val(data.http.name);
					nameWrite = true;
				}
				configArea.append(getRelayConfigForm('MANAGE', data.manage.listenHost, data.manage.localPort, data.manage.forwardHost, data.manage.forwardPort));
			}

			if(data.etc != null){
				data.etc.forEach(function(etcItem){
					if(!nameWrite){
						$('#form07 #name').val(etcItem.name);
						nameWrite = true;
					}
					configArea.append(getRelayConfigForm('ETC', etcItem.listenHost, etcItem.localPort, etcItem.forwardHost, etcItem.forwardPort));
				});

			}
		});
	}

	function getRelayConfigForm(portSe, listenHost, localPort, forwardHost, forwardPort, addType){

		var selectText = 'selected="selected"';

		var isRequired = "required";
		if("ETC" == portSe){
			isRequired = "";
		}

		var html = '';
		html+='<div class="col-md-12 proxyItem" style="padding-left:0px;padding-right:0px;" data-local-port="'+localPort+'">';
		html+='<div class="form-group col-md-2" style="padding-right: 0px;">';
		html+='	<input class="form-control col-md-12" type="text" placeholder="포트구분" id="portSe" name="portSe" value="'+portSe+'" "'+isRequired+'" readonly="readonly">';
		html+='</div>';
		html+='<div class="form-group col-md-3" style="padding-right: 0px;margin-left: 15px;">';
		html+='	<input class="form-control col-md-12" type="text" placeholder="수신 아이피" id="listenHost" name="listenHost" value="'+listenHost+'" "'+isRequired+'" regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$">';
		html+='</div>';
		html+='<div class="form-group col-md-2" style="padding-right: 0px;margin-left: 15px;">';
		html+='	<input class="form-control col-md-12" type="text" placeholder="수신 포트" id="localPort" name="localPort" value="'+localPort+'" "'+isRequired+'" regex="^[0-9]{2,5}$">';
		html+='</div>';
		html+='<div class="form-group col-md-3" style="padding-right: 0px;margin-left: 15px;">';
		html+='	<input class="form-control col-md-12" type="text" placeholder="릴레이 아이피" id="forwardHost" name="forwardHost" value="'+forwardHost+'" "'+isRequired+'" regex="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$">';
		html+='</div>';
		html+='<div class="form-group col-md-2" style="padding-right: 0px;margin-left: 15px;">';
		html+='	<input class="form-control col-md-12" type="text" placeholder="릴레이 포트" id="forwardPort" name="forwardPort" value="'+forwardPort+'" "'+isRequired+'" regex="^[0-9]{2,5}$">';
		if("ETC" == portSe && "new" != addType){
			html+='	<i class="icon-trash" style="cursor:pointer;position: absolute;top: 10px;" onclick="proxyDeleteOne(\''+portSe+'\',\''+localPort+'\');"></i>';
		}
		html+='</div>';

		html+='</div>';
		return html;
	}

	function addProxyConfigForm(addType){
		var configArea = $('#form07 #configArea');

		var targtAgentId = $('#form07 #targtAgentId').val();

		if(targtAgentId == ''){
			$('#form07').valid();
			return false;
		}
		if(targtAgentId == 'CONSOLE'){
			configArea.append(getRelayConfigForm('ETC','','','','', addType));
		}else{
			// 콘솔이 아닌경우에는
			var existProxyConfig = $('.proxyItem').find('[name=portSe]');

			var chkHttp = false;
			var chkJms= false;
			var chkManage = false;
			existProxyConfig.each(function(idx, item){
				if($(item).val() == 'HTTP'){
					chkHttp = true;
				}
				if($(item).val() == 'JMS'){
					chkJms = true;
				}
				if($(item).val() == 'MANAGE'){
					chkJms = true;
				}
			});

			if(!chkHttp && !chkJms && !chkJms ){
				$.getJSON('/xhr/agent/relayConfigInfoList/'+targtAgentId + '/' + windowAgentId , function(data, status){
					var configArea = $('#form07 #configArea');

					if(data.http == null){
						configArea.append(getRelayConfigForm('HTTP', '', '', data.agent.ip, data.agent.httpPort));
					}else{
						configArea.append(getRelayConfigForm('HTTP', data.http.listenHost, data.http.localPort, data.http.forwardHost, data.http.forwardPort));
					}
					if(data.jms == null){
						configArea.append(getRelayConfigForm('JMS', '', '', data.agent.ip, data.agent.brokerPort));
					}else{
						configArea.append(getRelayConfigForm('JMS', data.jms.listenHost, data.jms.localPort, data.jms.forwardHost, data.jms.forwardPort));
					}
					if(data.manage == null){
						configArea.append(getRelayConfigForm('MANAGE', '', '', data.agent.ip, data.agent.managePort));
					}else{
						configArea.append(getRelayConfigForm('MANAGE', data.manage.listenHost, data.manage.localPort, data.manage.forwardHost, data.manage.forwardPort));
					}
				});
			}else{
				configArea.append(getRelayConfigForm('ETC','','','','', addType));
			}
		}


	}

	function changeRelayAgentSelect(agentId, value){
		$.getJSON('/xhr/agent/relayConfigGroupList/'+agentId, function(data, status){

			var select = $('#form03 #partnRelay')[0];
			select.innerHTML=""
			var defaultOption = document.createElement('option');
			defaultOption.value = "NO-RELAY";
			defaultOption.innerHTML = "사용안함";
			select.append(defaultOption);
			for (i = 0; i < data.relayList.length; i++) {
				var item = data.relayList[i];
				var option = document.createElement('option');
				option.value = item.agentId;
				option.innerHTML = item.agentId;
				select.append(option);
			}
			if(value){
				select.value = value;
			}
			$('#form03 .partnId-text').html(agentId);
			$('#form03 #partnId').val(agentId);

		});
	}

	function agentRelayChange(value){
		if(value == 'NO-RELAY'){
			$('#form03 #partnRelay').val(value);
		}

	}

	function partnRelayChange(value){
		if(value == 'NO-RELAY'){
			$('#form03 #agentRelay').val(value);
		}
	}
	
	function licensePushPop(){
		$('#agentInfo').modal('hide');
		$('#form08 #licenseKey').val('');
		$('#licensePushPop').modal();
	}
	
	
	function licensePush(){
		validator = formValidation();
		if($('#form08').valid()){			
			var licenseKey = $('#form08 #licenseKey').val();
			var data = {
					
				agentId : windowAgentId,
				agentNo : windowAgentNo,
				licenseKey : licenseKey	
			}
			$.getJSON('/xhr/agent/licensePush',data, function(result, status){
				if (eval('result.' + STATUS_KEY) == STATUS_VALUE_OK) {					
					notification('라이선스 배포가 완료 되었습니다.');
					$('.licenseAlertYnText').html(result.licenseEndDate);// 바뀐 라이선스로 적용 
					$('#licensePushPop').modal('hide');
				} else {
					notification('라이선스 배포 과정에 오류가 발생했습니다.<br>' + result.MESSAGE);
				}
			});
		}
	}	

</script>
</html>