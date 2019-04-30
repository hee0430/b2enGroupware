<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="form04" name="form04" class="form-horizontal form-validation" onsubmit="return false;">
<input type="hidden" name="mode" id="mode" value="${mode}">
<input type="hidden" name="userSeq" id="userSeq"  value="${userSeq}">
<input type="hidden" name="id" id="id"  value="${userId}">
<input type="hidden" name="publicKeyModulus" id="publicKeyModulus" value="${publicKeyModulus}">
<input type="hidden" name="publicKeyExponent" id="publicKeyExponent"  value="${publicKeyExponent}">
<div class="col-md-12" style="padding-bottom: 20px;">
	<fieldset style="margin-top: 10px; padding: 10px;">
		<div class="col-md-12" style="padding-right: 0px;">
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item"><c:if test="${USER_TYPE ne 'A'}">현재 </c:if><c:if test="${USER_TYPE eq 'A'}">관리자 </c:if>비밀번호</label>
				<input class="form-control col-md-6" type="password" id="oldPassword" name="oldPassword" required tabindex="1">
			</div>
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">새 비밀번호</label>
				<input class="form-control col-md-6" type="password" id="loginPassword" name="loginPassword" required tabindex="2">
			</div>
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">새 비밀번호 확인</label>
				<input class="form-control col-md-6" type="password" id="loginPasswordConfirm" name="loginPasswordConfirm" required tabindex="3">
			</div>
		</div>
	</fieldset>
</div>
</form>
