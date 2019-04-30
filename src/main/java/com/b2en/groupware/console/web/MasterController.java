package com.b2en.groupware.console.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.b2en.groupware.console.Const;
import com.b2en.groupware.console.util.ConsoleUtil;
import com.b2en.groupware.console.web.login.model.UserModel;
import com.b2en.groupware.console.web.login.service.LoginService;

public class MasterController {
    private Logger logger = LoggerFactory.getLogger(MasterController.class);

    @Autowired
    private LoginService loginService;

    protected String loginId;
    protected String loginName;
    protected String loginIp;
    protected String sessionId;

    protected boolean isLogin(ModelAndView mav) {
        mav.addObject("WS_SERVICE_NAME", Const.WEBSOCKET_SERVICE_NAME);
        mav.addObject("WS_REQUEST", Const.WEBSOCKET_REQUEST_CHANNEL);
        mav.addObject("WS_RESPONSE", Const.WEBSOCKET_RESPONSE_CHANNEL);
        mav.addObject("REQUEST_PROCESS_STATUS_KEY", Const.REQUEST_PROCESS_STATUS_KEY);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_OK", Const.REQUEST_PROCESS_STATUS_VALUE_OK);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_FAIL", Const.REQUEST_PROCESS_STATUS_VALUE_FAIL);
        return true;
    }

    protected boolean isLogin(ModelAndView mav, HttpServletRequest request, HttpSession session, String viewName, boolean loginCheck) {
        mav.addObject("WS_SERVICE_NAME", Const.WEBSOCKET_SERVICE_NAME);
        mav.addObject("WS_REQUEST", Const.WEBSOCKET_REQUEST_CHANNEL);
        mav.addObject("WS_RESPONSE", Const.WEBSOCKET_RESPONSE_CHANNEL);
        mav.addObject("REQUEST_PROCESS_STATUS_KEY", Const.REQUEST_PROCESS_STATUS_KEY);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_OK", Const.REQUEST_PROCESS_STATUS_VALUE_OK);
        mav.addObject("REQUEST_PROCESS_STATUS_VALUE_FAIL", Const.REQUEST_PROCESS_STATUS_VALUE_FAIL);

        String sessionUserId = (String) session.getAttribute("USER_ID");
        String sessionUserName = (String) session.getAttribute("USER_NAME");
        String sessionUserType = (String) session.getAttribute("USER_TYPE");
        if (sessionUserId == null || "".equals(sessionUserId)) {
            RedirectView redirectView = new RedirectView(); // redirect url 설정
            redirectView.setUrl("/login");
            redirectView.setExposeModelAttributes(false);

            mav.setView(redirectView);

            return false;
        } else {
            loginId = sessionUserId;
            loginName = sessionUserName;
            loginIp = getIp(request);
            mav.addObject("ID", sessionUserId);
            mav.addObject("USER_TYPE", sessionUserType);
        }
        sessionId = session.getId();

        /**
         * 메뉴 없는 화면을 원하십니까? /delegate url을 통해서 들어온 요청은 메뉴를 없앤 url로 변경한다.
         */
        String noMenu = (String) session.getAttribute("NOMENU");
        if ("Y".equals(noMenu)) {
            if (!"/dashboard/Dashboard".equals(viewName) && !"/dashboard/Topology".equals(viewName)) {
                viewName = viewName + "NoMenu";
            }
        }

        try {

            mav.addObject("MENU_LIST", session.getAttribute("MENU_LIST"));
            mav.addObject("USER_NAME", loginName);

            if (!loginId.equals("admin")) {
                List<String> authMenuList = null;//consoleService.selectTrnscStatsIntrfcForSummary(loginId);
                String menuCode = (String) mav.getModelMap().get(Const.MENU_CODE);
                if (!authMenuList.contains(menuCode) && !"/console/UserInfo".equals(viewName) && !"/console/PasswordChange".equals(viewName)) {
                    String referer = request.getHeader("referer");
                    mav.addObject("prevUrl", referer);
                    mav.setViewName("AuthCheck");
                } else {
                    mav.setViewName(viewName);
                }
            } else {
                mav.setViewName(viewName);
            }
        } catch (Exception e) {

        }

        return true;
    }

    protected String getIp(HttpServletRequest request) {
        return ConsoleUtil.getRemoteIP(request);
    }

    protected UserModel getLoginInfo(HttpSession session) throws Exception {
        UserModel login = null;
        try {
            login = (UserModel) session.getAttribute("LOGIN_MODEL");

            if (login == null) {
                String sessionUserId = (String) session.getAttribute("USER_ID");
                if (sessionUserId != null && !"".equals(sessionUserId)) {
                    UserModel model = new UserModel();
                    model.setId(sessionUserId);
                    login = loginService.selectUserManage(model);
                }
            }
        } catch (Exception e) {
            return login;
        }
        return login;
    }
}
