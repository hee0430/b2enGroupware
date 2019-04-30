package com.b2en.groupware.console.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/error")
@Controller
public class ExceptionController {

    @ExceptionHandler(Exception.class)
    public ModelAndView agentConfigList(HttpServletRequest request, Exception e) throws Exception {
	ModelAndView mav = new ModelAndView();
	mav.addObject("exception", e);
	mav.setViewName("error");
	return mav;
    }

}
