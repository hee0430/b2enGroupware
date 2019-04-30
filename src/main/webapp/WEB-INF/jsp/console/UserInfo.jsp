<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="form01" name="form01" class="form-horizontal form-validation" onsubmit="return false;">
<input type="hidden" name="mode" id="mode" value="I">
<input type="hidden" name="userTy" id="userTy">
<input type="hidden" name="userSeq" id="userSeq">
<input type="hidden" name="publicKeyModulus" id="publicKeyModulus" value="${publicKeyModulus}">
<input type="hidden" name="publicKeyExponent" id="publicKeyExponent"  value="${publicKeyExponent}">
<div class="col-md-12" style="padding-bottom: 20px;">
	<fieldset style="margin-top: 10px; padding: 10px;">
		<div class="col-md-6" style="padding-right: 0px;">
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">사용자 아이디</label>
				<input class="form-control col-md-6" type="text" id="id" name="id" maxlength="15" required="required" tabindex="1">
			</div>
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<c:if test="${mode eq 'I' }">
				<label class="form-label required-item">비밀번호</label>
				</c:if>
				<c:if test="${mode ne 'I' }">
				<label class="form-label required-item"><c:if test="${USER_TYPE ne 'A'}"></c:if><c:if test="${USER_TYPE eq 'A'}">관리자 </c:if>비밀번호</label>
				</c:if>
				<input class="form-control col-md-6" type="password" id="loginPassword" name="loginPassword" required="required" tabindex="2">
			</div>
			<c:if test="${mode eq 'I' }">
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">비밀번호 확인</label>
				<input class="form-control col-md-6" type="password" id="loginPasswordConfirm" name="loginPasswordConfirm" required="required" tabindex="3">
			</div>
			</c:if>
		</div>
		<div class="col-md-6" style="padding-right: 0px;">
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">이름</label>
				<input class="form-control col-md-6" type="text" id="nm" name="nm" maxlength="10" tabindex="4" required="required">
			</div>
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">이메일</label>
				<input class="form-control col-md-6" type="email" id="email" name="email" maxlength="100" tabindex="5" required="required">
			</div>
			<div class="form-group col-md-12" style="padding-right: 0px;">
				<label class="form-label required-item">전화번호</label>
				<input class="form-control col-md-6" type="text" id="moblphonNo" name="moblphonNo" maxlength="30" tabindex="6" required="required">
			</div>
		</div>
		<div class="col-md-12" style="padding-right: 15px;">
			<label class="form-label">설명</label>
			<textarea class="form-control" id="rm" name="rm" maxlength="2000" rows="3" cols="3"></textarea>
		</div>
	</fieldset>
</div>
</form>
