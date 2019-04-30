<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-md-12" style="padding-bottom:0px;">
	<fieldset style="margin-top:10px;margin-bottom:20px;padding-top:10px;padding-left:25px;padding-right:25px;padding-bottom:10px;">
		<div id="dual-list-box" class="form-group row">
			<select id="intrfcSelect" multiple="multiple" data-title="인터페이스" data-value="index" data-text="name">
				<c:forEach var="item" varStatus="seq" items="${INTERFACE_LIST}">
				<option <c:if test="${item.dspyOrder ne 0}">selected="selected"</c:if> value="${item.seq}">${item.nm}(${item.id})</option>
				</c:forEach>
			</select>
		</div>
	</fieldset>
</div>

<script>
var count = 0;
$(function () {

	var option = {
              title: 'intrfcId'
              ,titleText: '인터페이스'
              ,text : 'intrfcNm'
              ,value : 'intrfcId'
              ,element : $('#intrfcSelect')
              //,dataList : result.intrfcList
              ,json : false
	}
	$('#intrfcSelect').DualListBox(option, null);

	//multi( $('#intrfcSelect')[0] );
	var isLogin = '${isLogin}';
	if(isLogin == 'false'){
		document.location.href="/login";
	}
	//setCount();
});

/*

function setDspyOrder(idx){
	var isChecked = $('[id=intrfcSeq]')[idx].checked;
	if (isChecked == true) {
		if((count+1) > MAX_ITEM_COUNT){
			alert(MAX_ITEM_COUNT+'개 이하로 설정 가능합니다. ');
			$('[id=intrfcSeq]')[idx].checked = false;
		}else{
			count++;
			$('[id=dspyOrderTd]')[idx].innerHTML = '<input type="hidden" name="dspyOrder" value="'+count+'">' +count;
		}
	}else{
		var value = $($('[id=dspyOrderTd]')[idx]).find('[name=dspyOrder]').val();
		$('[id=dspyOrderTd]')[idx].innerHTML = '';

		var targetList = $('[id=intrfcSeq]');
		for(i = 0; i < targetList.length ; i ++){
			var item = targetList[i];
			if(item.checked){
				var targetValue = $($('[id=dspyOrderTd]')[i]).find('[name=dspyOrder]').val();
				if(eval(value) < eval(targetValue)){
					targetValue = eval(targetValue-1);
					$('[id=dspyOrderTd]')[i].innerHTML = '<input type="hidden" name="dspyOrder" value="'+targetValue+'">' +targetValue;
				}
			}

		}
		count--;
	}
}

function setCount(){
	var list = $('[id=intrfcSeq]');
	for(i = 0; i< list.length; i++){
		if(list[i].checked){
			count++;
		}
	}
} */
</script>