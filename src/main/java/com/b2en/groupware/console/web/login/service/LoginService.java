package com.b2en.groupware.console.web.login.service;

import com.b2en.groupware.console.web.login.model.UserModel;

public interface LoginService {

    public UserModel selectUserManage(UserModel model) throws Exception;
}
