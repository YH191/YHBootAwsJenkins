package com.yh.book.springboot.web;

import org.springframework.boot.web.error.ErrorAttributeOptions;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;


@Controller
public class ErrorControllerAWS implements ErrorController {

    private final ErrorAttributes errorAttributes;

    public ErrorControllerAWS(ErrorAttributes errorAttributes) {
        this.errorAttributes = errorAttributes;
    }

    @RequestMapping("/error")
    public String handleError(WebRequest webRequest, Model model) {
        Map<String, Object> errorAttributes = this.errorAttributes.getErrorAttributes(webRequest, ErrorAttributeOptions.defaults());
        int statusCode = (int) errorAttributes.get("status");
        String errorMessage = (String) errorAttributes.get("error");
        model.addAttribute("statusCode", statusCode);
        model.addAttribute("errorMessage", errorMessage);
        return "error";
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }
}