package com.yh.book.springboot.config.auth;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        // 세션에서 로그인 정보를 가져옴
        Object loginUser = session.getAttribute("user");

        // 로그인 정보가 있을 경우에만 세션 유효 시간을 갱신
        if (loginUser != null) {
        session.setMaxInactiveInterval(1800);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 이 메소드를 사용하지 않을 경우, 빈 메소드로 남겨둡니다.
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // 이 메소드를 사용하지 않을 경우, 빈 메소드로 남겨둡니다.
    }
}