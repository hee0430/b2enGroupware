package com.b2en.groupware.console.web.login.service.impl;

import org.springframework.stereotype.Service;

import com.b2en.groupware.console.util.aria.AriaDataFormat;
import com.b2en.groupware.console.web.login.model.LoginResultType;
import com.b2en.groupware.console.web.login.model.UserModel;
import com.b2en.groupware.console.web.login.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {


    @Override
    public UserModel selectUserManage(UserModel param) throws Exception {

        AriaDataFormat af = new AriaDataFormat();
        UserModel user = null;// dao.selectUserManageInfo(param);

        if (user != null) {
            // 패스워드 암호화 적용
            if (param.getPassword().equals(af.decStr(user.getPassword()))) {
                //if (param.getPassword().equals(user.getPassword())) {
                user.setLoginResult(LoginResultType.SUCCESS);
            } else {
                user.setLoginResult(LoginResultType.PASSWORD);
            }
        } else {
            user = new UserModel();
            user.setId(param.getId());
            user.setLoginResult(LoginResultType.NO_ID);
        }

        return user;
    }
}
