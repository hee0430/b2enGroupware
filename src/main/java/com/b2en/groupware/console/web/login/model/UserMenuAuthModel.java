package com.b2en.groupware.console.web.login.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserMenuAuthModel implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 8654165585371363960L;
    /* 사용자 번호 */
    private int userSeq;
    /* 아이디 */
    private String id;
    /* 메뉴코드 */
    private String menuCode;
    /* 메뉴이름 */
    private String menuNm;
    /* 권한 */
    private String author;
    /* 화면 처리용 변수*/
    private String menuCodeParam;

    public String getMenuNm() {
        return menuNm;
    }

    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    public int getUserSeq() {
	return userSeq;
    }

    public void setUserSeq(int userSeq) {
	this.userSeq = userSeq;
    }

    public String getId() {
	return id;
    }

    public void setId(String id) {
	this.id = id;
    }

    public String getMenuCode() {
	return menuCode;
    }

    public void setMenuCode(String menuCode) {
	this.menuCode = menuCode;
    }

    public String getAuthor() {
	return author;
    }

    public void setAuthor(String author) {
	this.author = author;
    }

    @Override
    public String toString() {
	return "UserMenuAuthModel [userSeq=" + userSeq + ", id=" + id + ", menuCode=" + menuCode + ", author=" + author + "]";
    }

    public String getMenuCodeParam() {
	return menuCodeParam;
    }

    public void setMenuCodeParam(String menuCodeParam) {
	this.menuCodeParam = menuCodeParam;
    }

}
