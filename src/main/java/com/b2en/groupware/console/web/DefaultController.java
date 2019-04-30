package com.b2en.groupware.console.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DefaultController {

    @RequestMapping("/ping")
    @ResponseBody
    public String agentConfigList(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody() String body) throws Exception {
        System.out.println("수신완료");
        System.out.println(body);
        return "pong";
    }

}
