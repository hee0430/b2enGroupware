package com.b2en.groupware.console.web.login.service.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.b2en.groupware.console.Const;

@Repository("loginServiceDAO")
public class LoginServiceDAO {

    @Autowired
    @Qualifier(Const.DATABASE_POOL_NAME_DEFAULT)
    private SqlSession config;

}
