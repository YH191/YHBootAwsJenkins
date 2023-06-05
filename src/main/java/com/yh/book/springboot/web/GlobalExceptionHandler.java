package com.yh.book.springboot.web;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        model.addAttribute("errorMessage", e.getMessage()); // 에러 메시지를 모델에 추가
        return "error"; // 에러를 표시할 에러 페이지로 리다이렉트
    }
}