<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-6">
        <form action="/auth/loginProc" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <label>아이디</label>
                <input type="text" class="form-control" name="username" placeholder="아이디를 입력해주세요">
            </div>

            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" class="form-control" name="password" placeholder="비밀번호를 입력해주세요">
            </div>

            <c:if test="${param.error == 'true'}">
                <p id="error-msg" class="alert alert-danger">${param.exception}</p>
            </c:if>

            <button type="submit" class="form-control btn btn-outline-secondary"> 로그인</button>
            <a href="/oauth2/authorization/google" class="btn btn btn-outline-secondary mx-1" role="button">Google Login</a>
            <a href="/oauth2/authorization/naver" class="btn btn btn-outline-secondary mx-1" role="button">Naver Login</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>
</html>