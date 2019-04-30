package com.b2en.groupware.console.web.login;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b2en.groupware.console.Const;
import com.b2en.groupware.console.util.ConsoleUtil;
import com.b2en.groupware.console.web.MasterController;
import com.b2en.groupware.console.web.login.model.LoginResultType;
import com.b2en.groupware.console.web.login.model.UserModel;
import com.b2en.groupware.console.web.login.service.LoginService;

@Controller
public class LoginController extends MasterController {

    private Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService loginService;

    @RequestMapping("/login")
    public ModelAndView login(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("REQUEST_PROCESS_STATUS_KEY", Const.REQUEST_PROCESS_STATUS_KEY);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_OK", Const.REQUEST_PROCESS_STATUS_VALUE_OK);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_FAIL", Const.REQUEST_PROCESS_STATUS_VALUE_FAIL);

        mav.addObject("loginButtenName", System.getProperty("login.butten.name"));
        mav.addObject("loginButtenLink", System.getProperty("login.butten.link"));

        //String rex = "^(https?):\\/\\/([^:\\/\\s]+)(:([^\\/])*)?";
        //String preUrl = request.getHeader("referer");
        //logger.debug("[이전URL]===>{}", preUrl);

        try {
            ConsoleUtil.rsaKeyGen(session, mav);
        } catch (Exception e) {
            logger.error("{}", e);
        }
        mav.setViewName("login/Login");

        return mav;
    }

    @RequestMapping(value = "/xhr/loginProcess/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> loginProcessXhr(HttpSession session, HttpServletRequest request, HttpServletResponse response //
            , @RequestBody UserModel login) throws Exception {
        Map<String, Object> data = new HashMap<>();
        try {

            PrivateKey privateKey = ConsoleUtil.rsaKeyGet(session);

            String id = ConsoleUtil.decryptRsa(privateKey, login.getId());
            String pw = ConsoleUtil.decryptRsa(privateKey, login.getPassword());

            login.setId(id);
            login.setPassword(pw);

            UserModel resultModel = loginService.selectUserManage(login);
            if (resultModel.getLoginResult() == LoginResultType.SUCCESS) {
                session.setMaxInactiveInterval(0);
                session.setAttribute("USER_SEQ", resultModel.getUserSeq());
                session.setAttribute("USER_ID", resultModel.getId());
                session.setAttribute("USER_NAME", resultModel.getNm());
                session.setAttribute("USER_TYPE", resultModel.getUserTy());
                session.setAttribute("LOGIN_MODEL", resultModel);
                session.setAttribute("NOMENU", "N");
                data.put(Const.RESULT, true);

                ConsoleUtil.rsaKeyRemove(session);
                data.put("redirect", "/summary");

                //session.setAttribute("MENU_LIST", menuList);

            } else if (resultModel.getLoginResult() == LoginResultType.NO_ID) {
                data.put(Const.RESULT, false);
                data.put(Const.REQUEST_PROCESS_STATUS_MSG, "등록되지 않은 아이디입니다.<br>아이디를 다시 확인하세요.");
            } else if (resultModel.getLoginResult() == LoginResultType.PASSWORD) {
                data.put(Const.RESULT, false);
                data.put(Const.REQUEST_PROCESS_STATUS_MSG, "비밀번호를 잘못 입력하셨습니다. <br>비밀번호를 다시 확인하세요.");
            }

            data.put(Const.REQUEST_PROCESS_STATUS_KEY, Const.REQUEST_PROCESS_STATUS_VALUE_OK);
        } catch (Exception e) {
            logger.error("{}", e);
            data.put(Const.REQUEST_PROCESS_STATUS_KEY, Const.REQUEST_PROCESS_STATUS_VALUE_FAIL);
            data.put(Const.REQUEST_PROCESS_STATUS_MSG, e.getMessage());
            logger.error("{}", e);
        }

        return data;
    }

    @RequestMapping(value = "/xhr/loginProcess/logout", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> logoutProcessXhr(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<>();
        try {

            session.invalidate();
            data.put("redirect", "/login");

            data.put(Const.REQUEST_PROCESS_STATUS_KEY, Const.REQUEST_PROCESS_STATUS_VALUE_OK);
        } catch (Exception e) {
            logger.error("{}", e);
            data.put(Const.REQUEST_PROCESS_STATUS_KEY, Const.REQUEST_PROCESS_STATUS_VALUE_FAIL);
            data.put(Const.REQUEST_PROCESS_STATUS_MSG, e.getMessage());
            logger.error("{}", e);
        }

        return data;
    }

}
