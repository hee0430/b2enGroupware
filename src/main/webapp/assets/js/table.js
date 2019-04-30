
/**
 * Table 컨트롤 function
 * @param _tableId
 * @returns
 */
function TABLE(_tableId){
	this.tableId =_tableId;
	this.tableObject = document.querySelector(this.tableId);

	this.addTBody = function(){
		this.tableTBody = this.tableObject.createTBody();
	}

	this.addRow = function(){
		return this.tableTBody.insertRow();
	}

	this.addColumn = function(tableRowObject, style, value){
		var cell = tableRowObject.insertCell();
		cell.style.textAlign = align;
		cell.innerText = value;
	}

	this.addColumnArray = function(tableRowObject, colArray, colLength){
		var i = 0;
		if(colArray.length == 0){
			var cell = tableRowObject.insertCell();
			cell.colSpan = colLength;
			cell.style.textAlign = 'center';
			cell.innerText = '데이터가 없습니다.';
		}
		colArray.forEach(function(item){
			var cell = tableRowObject.insertCell();
			cell.style.textAlign = item.align;
			if(item.event){
				$(cell).bind('click', item.event)
			}

			if(typeof item.value == 'object'){
				cell.appendChild(item.value);
			}else{
				cell.innerText = item.value;
			}
			$(cell).css('word-break','break-all');
			i++;
		});
	}
	this.removeBody = function(){
		var body =this.tableObject.tBodies[0];
		if(body){
			this.tableObject.tBodies[0].remove();
		}
	}

	this.columnItem = function(value, align, eventCallback, button){
		var item = {
			value : value,
			align : align,
			event : eventCallback
		};
		return item;
	}
};


function tableSearch(inputId, tableId) {
	var input, filter, table, tr, td, i;
	input = document.getElementById(inputId);
	filter = input.value.toUpperCase();
	table = document.getElementById(tableId);
	var tbody = table.tBodies[0];
	tr = tbody.rows;//table.getElementsByTagName("tr");

	// Loop through all table rows, and hide those who don't match the search query
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td");
		chk = false;
		for (j = 0; j < td.length; j++) {
			if (td[j]) {
				if (td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
					chk = true;
				}
			}
		}
		if(chk){
			tr[i].style.display = "";
		}else{
			tr[i].style.display = "none";
		}
	}
}