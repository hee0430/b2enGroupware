package com.b2en.groupware.console.web.login.model;

public enum LoginResultType {
    SUCCESS("SUCCESS"), PASSWORD("PASSWORD"), NO_ID("NO_ID");

    private final String value;

    LoginResultType(String _value) {
        value = _value;
    }

    public String getValue() {
        return value;
    }

}
