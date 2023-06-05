package com.yh.book.springboot.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ErrorController implements org.springframework.boot.web.servlet.error.ErrorController {

    @RequestMapping("/error")
    @ResponseBody
    public String handleError(HttpServletRequest request) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        Exception exception = (Exception) request.getAttribute("javax.servlet.error.exception");
        String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
        // 에러 정보를 기반으로 적절한 JSON 또는 텍스트 응답을 생성하고 반환합니다.
        return "Error occurred with status code: " + statusCode + ", message: " + errorMessage;
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }
}
