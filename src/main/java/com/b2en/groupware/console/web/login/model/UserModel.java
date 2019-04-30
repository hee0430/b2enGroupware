package com.b2en.groupware.console.web.login.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserModel implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 8654165585371363960L;
    private int userSeq;
    private String id;
    private String nm;
    private String password;
    /*사용자 구분  / A(ADMIN),U(USER) */
    private String userTy;
    private String email;
    private String moblphonNo;

    /*비고*/
    private String rm;

    private LoginResultType loginResult;

    /* 패스워드 변경 일시 */
    private Timestamp passwordUpdtDt;

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

    public String getNm() {
        return nm;
    }

    public void setNm(String nm) {
        this.nm = nm;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserTy() {
        return userTy;
    }

    public void setUserTy(String userTy) {
        this.userTy = userTy;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMoblphonNo() {
        return moblphonNo;
    }

    public void setMoblphonNo(String moblphonNo) {
        this.moblphonNo = moblphonNo;
    }

    public String getRm() {
        return rm;
    }

    public void setRm(String rm) {
        this.rm = rm;
    }

    public Timestamp getPasswordUpdtDt() {
        return passwordUpdtDt;
    }

    public void setPasswordUpdtDt(Timestamp passwordUpdtDt) {
        this.passwordUpdtDt = passwordUpdtDt;
    }

    public LoginResultType getLoginResult() {
        return loginResult;
    }

    public void setLoginResult(LoginResultType loginResult) {
        this.loginResult = loginResult;
    }

    @Override
    public String toString() {
        return "UserModel [userSeq=" + userSeq + ", id=" + id + ", nm=" + nm + ", password=" + password + ", userTy=" + userTy + ", email=" + email + ", moblphonNo=" + moblphonNo + ", rm=" + rm + ", loginResult=" + loginResult + ", passwordUpdtDt="
                + passwordUpdtDt + "]";
    }

}
