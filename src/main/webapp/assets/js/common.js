// jquery 확장
jQuery.fn.serializeJSON = function() {
	var obj = null;
	try {
		// this[0].tagName이 form tag일 경우
		if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
			var arr = this.serializeArray();
			if (arr) {
				obj = {};
				jQuery.each(arr, function() {
					// obj의 key값은 arr의 name, obj의 value는 value값
					obj[this.name] = this.value;
				});
			}
		} else {
			obj = {};
			$
					.each(
							$(this).find(':input'),
							function() {
								if (this.type == 'radio') {
									if (this.checked == true) {
										obj[encodeURIComponent(this.name)] = encodeURIComponent(this.value);
									}
								} else {
									obj[encodeURIComponent(this.name)] = encodeURIComponent($(
											this).val());
								}
							});

		}
	} catch (e) {
		alert(e.message);
	} finally {
	}
	return obj;
};

/**
 * form Object serialize
 *
 * @param form
 * @returns
 */
function serialize(form) {
	if (!form || form.nodeName !== "FORM") {
		return;
	}
	var i, j, q = [];
	for (i = form.elements.length - 1; i >= 0; i = i - 1) {
		if (form.elements[i].name === "") {
			continue;
		}
		switch (form.elements[i].nodeName) {
		case 'INPUT':
			switch (form.elements[i].type) {
			case 'text':
			case 'hidden':
			case 'password':
			case 'button':
			case 'reset':
			case 'submit':
				q.push(form.elements[i].name + "="
						+ encodeURIComponent(form.elements[i].value));
				break;
			case 'checkbox':
			case 'radio':
				if (form.elements[i].checked) {
					q.push(form.elements[i].name + "="
							+ encodeURIComponent(form.elements[i].value));
				}
				break;
			}
			break;
		case 'file':
			break;
		case 'TEXTAREA':
			q.push(form.elements[i].name + "="
					+ encodeURIComponent(form.elements[i].value));
			break;
		case 'SELECT':
			switch (form.elements[i].type) {
			case 'select-one':
				q.push(form.elements[i].name + "="
						+ encodeURIComponent(form.elements[i].value));
				break;
			case 'select-multiple':
				for (j = form.elements[i].options.length - 1; j >= 0; j = j - 1) {
					if (form.elements[i].options[j].selected) {
						q
								.push(form.elements[i].name
										+ "="
										+ encodeURIComponent(form.elements[i].options[j].value));
					}
				}
				break;
			}
			break;
		case 'BUTTON':
			switch (form.elements[i].type) {
			case 'reset':
			case 'submit':
			case 'button':
				q.push(form.elements[i].name + "="
						+ encodeURIComponent(form.elements[i].value));
				break;
			}
			break;
		}
	}
	return q.join("&");
}
