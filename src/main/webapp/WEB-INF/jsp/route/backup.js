
function loadFromTableColumnList(ruteNumber, ruteSeq){
	$('#dctca').hide();
	$('#databaseComponentTableContentArea').html('')

	$.ajax({
		url : '/route/content/databaseComponentTableContentLoad/T/'+ruteSeq+'/'+ruteNumber+'/'+$('#intrfcId').val()+'/${isWorkItem}'
		,method :'POST'
		,success : function(result){
			$('#databaseComponentTableContentArea').append(result);

			$('.editableSpanColumn').bind('click',editableSpanCallbackColumn);
			$('.editableSpanValue').bind('click',editableSpanCallbackValue);
		}
	});
}

function loadFromTableColumnListFile(ruteNumber, ruteSeq){
	$('#dctca').hide();
	$.ajax({
		url : '/route/content/databaseComponentTableContentLoadForFile/T/'+ruteSeq+'/'+ruteNumber+'/'+$('#intrfcId').val()+'/${isWorkItem}'
		,method :'POST'
		,success : function(result){
			// 일단 구분자 형식으로 지정
			$('#fileReadTy').val('SPRTR');
			//가져온 값 할당
			$('#referMapKey').val(result.tableName);
			$('#hderColumn').val(result.columnText);
			// change 이벤트 발생
			$('#fileReadTy').trigger('change');
		}
	});
}

function loadFromTableColumnListHbase(ruteNumber, ruteSeq){
	$('#dctca').hide();
	//$('#hbaseComponentTableContentArea').html('')
	$.ajax({
		url : '/route/content/hbaseComponentTableContentLoad/T/'+ruteSeq+'/'+ruteNumber+'/'+$('#intrfcId').val()+'/${isWorkItem}'
		,method :'POST'
		,success : function(result){
			var tbody = $('#hbaseTableTbody')
			tbody.html('');

			$('#refrnKeyNm').val(result.loadConfig.refrnKeyNm);

			var ldadngColumnList = result.loadConfig.ldadngColumnList;
			for(i = 0 ; i < ldadngColumnList.length;i++){
				var item = ldadngColumnList[i];
				addHbaseColumnContentById(item.value, item.columnFamily, item.qualifier);
			}

			$('.editableSpanValue').bind('click',editableSpanCallbackValue);
			$('.editableSpanColumn').bind('click',editableSpanCallbackColumn);
			$('.editableSpanQualifier').bind('click',editableSpanCallbackQualifier);

		}
	});
}