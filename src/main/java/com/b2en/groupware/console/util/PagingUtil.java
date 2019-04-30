package com.b2en.groupware.console.util;

public class PagingUtil {

    private int totalCount;
    private int countPerList;
    private int currentPage;
    private int countPerPage;
    private int totalPage;

    public PagingUtil(int _currentPage, int _totalCount, int _countPerPage, int _countPerList) {
	currentPage = _currentPage;
	countPerPage = _countPerPage;
	totalCount = _totalCount;
	countPerList = _countPerList;
    }

    public String getPage(String formName, String url) {
	int nextPage = 1;
	int prevPage = 1;
	int startPage = 1;

	//페이지 갯수 계산
	if ((this.totalCount % this.countPerList) > 0)
	    totalPage = (int) Math.floor((double)this.totalCount / (double)this.countPerList) + 1;
	else
	    totalPage = (int) Math.floor((double)this.totalCount / (double)this.countPerList);

	if (totalPage == 0)
	    totalPage = 1;

	int maxPage = 1;

	//해당 페이지의 시작 번호
	if ((this.currentPage % this.countPerPage) > 0) {
	    startPage = (int) Math.floor((double)this.currentPage / (double)this.countPerPage) * this.countPerPage + 1;
	} else {
	    startPage = (int) Math.floor((double)this.currentPage / (double)this.countPerPage) * this.countPerPage - (this.countPerPage - 1);
	}
	if (totalPage <= this.countPerPage)
	    maxPage = totalPage;
	else if (totalPage > this.countPerPage) {
	    if ((startPage + (this.countPerPage - 1)) > totalPage)
		maxPage = totalPage;
	    else {
		maxPage = startPage + (this.countPerPage - 1);
	    }
	}

	//이전, 다음 페이지
	//nextPage = (startPage + this.countPerPage);
	//prevPage = (startPage - this.countPerPage);

	nextPage = currentPage + 1;
	prevPage = currentPage - 1;
	if (prevPage <= 0)
	    prevPage = 1;
	if (nextPage > totalPage)
	    nextPage = totalPage;

	//int halfPage = maxPage - 5;
	if (currentPage > 5) {
	    maxPage = currentPage + 5;
	    startPage = currentPage - 4;
	}
	if (maxPage > totalPage) {
	    maxPage = totalPage;
	    if ((maxPage - 10) > 1) {
		startPage = maxPage - 9;
	    }
	}
	if (startPage < 1) {
	    startPage = 1;
	}

	StringBuilder sb = new StringBuilder();

	sb.append("<div class=\"row\">\n");
	sb.append("	<div class=\"col-sm-5\">\n");
	sb.append("	<div role=\"status\" aria-live=\"polite\">");
	if (currentPage * countPerList > totalCount) {
	    //sb.append("Showing " + (((currentPage - 1) * countPerList) + 1) + " to " + totalCount + " of " + totalCount + " 개중  \n");
	    sb.append("총 " + totalCount + " 개중  " + (((currentPage - 1) * countPerList) + 1) + " 부터 " + totalCount + "");

	} else {
	    //sb.append("Showing " + (((currentPage - 1) * countPerList) + 1) + " to " + (currentPage * countPerList) + " of " + totalCount + " entries \n");
	    sb.append("총 " + totalCount + " 개중  " + (((currentPage - 1) * countPerList) + 1) + " 부터 " + (currentPage * countPerList) + "");
	}
	sb.append("	</div>\n");
	sb.append("	</div>\n");
	sb.append("	<div class=\"col-sm-7 pagination2\">\n");
	sb.append("		<div class=\"dataTables_paginate paging_simple_numbers\">\n");
	sb.append("			<ul class=\"pagination\">\n");
	if (currentPage == 1) {
	    sb.append("				<li class=\"paginate_button previous\"> <a href=\"#\" >처음</a></li>\n");
	    sb.append("				<li class=\"paginate_button previous\"> <a href=\"#\" >이전</a></li>\n");
	} else {
	    sb.append("				<li class=\"paginate_button previous\"> <a href=\"javascript:goPage('1');\" >처음</a></li>\n");
	    sb.append("				<li class=\"paginate_button previous\"> <a href=\"javascript:goPage('" + prevPage + "');\" >이전</a></li>\n");
	}
	for (int i = startPage; i <= maxPage; i++) {
	    if (i == this.currentPage)
		sb.append("<li class=\"paginate_button active\"><a href=\"#\" >" + i + "</a></li>\n");
	    else
		sb.append("<li class=\"paginate_button\"><a href=\"javascript:goPage('" + i + "');\" >" + i + "</a></li>\n");
	}
	if (totalPage == currentPage) {
	    sb.append("				<li class=\"paginate_button next\"><a href=\"#\">다음</a></li>\n");
	    sb.append("				<li class=\"paginate_button next\"><a href=\"#\">마지막</a></li>\n");
	} else {
	    sb.append("				<li class=\"paginate_button next\"><a href=\"javascript:goPage('" + nextPage + "');\">다음</a></li>\n");
	    sb.append("				<li class=\"paginate_button next\"><a href=\"javascript:goPage('" + totalPage + "');\">마지막</a></li>\n");
	}

	sb.append("			</ul>\n");
	sb.append("		</div>\n");
	sb.append("	</div>\n");
	sb.append("</div>\n");
	sb.append("<script>\n");
	sb.append(" function goPage(page){\n");
	sb.append("		var form = $('#" + formName + "')[0] \n");
	sb.append("		form.currentPage.value=page; \n");
	sb.append("		form.isPage.value='Y'; \n");
	sb.append("		form.action='" + url + "'; \n");
	sb.append("		form.submit(); \n");
	sb.append(" }\n");
	sb.append("</script>\n");

	return sb.toString();
    }

    public int getTotalPage() {
	return totalPage;
    }

}
