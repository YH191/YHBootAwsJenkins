<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form action="/auth/joinProc" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" value="" class="form-control" placeholder="아이디를 입력해주세요"/>
                <c:if test="${not empty valid_username}"><span id="valid">${valid_username}</span></c:if>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" value="" class="form-control" placeholder="비밀번호를 입력해주세요"/>
                <c:if test="${not empty valid_password}"><span id="valid">${valid_password}</span></c:if>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="" class="form-control" placeholder="닉네임을 입력해주세요"/>
                <c:if test="${not empty valid_nickname}"><span id="valid">${valid_nickname}</span></c:if>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="" class="form-control" placeholder="이메일을 입력해주세요"/>
                <c:if test="${not empty valid_email}"><span id="valid">${valid_email}</span></c:if>
            </div>

            <button type="submit" class="btn btn-primary bi bi-person"> 가입</button>
            <a href="/" role="button" class="btn btn-info bi bi-arrow-return-left"> 목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>
</html>