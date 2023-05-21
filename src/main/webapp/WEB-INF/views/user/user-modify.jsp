<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form id="user-modify-form" onsubmit="return validateForm()">
            <label for="id"></label>
            <input type="hidden" id="id" name="id" value="${user.id}"/>
            <input type="hidden" id="modifiedDate" name="modifiedDate" value="${user.modifiedDate}"/>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="${user.username}" class="form-control" readonly/>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="수정할 비밀번호를 입력해주세요" required/>
                <span id="valid_password" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="${user.nickname}" class="form-control" placeholder="수정할 닉네임을 입력해주세요" required/>
                <span id="valid_nickname" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" value="${user.email}" class="form-control" readonly/>
            </div>

            <button id="btn-user-modify" class="btn btn-primary" onclick="userModify()">완료</button>
            <a href="/" role="button" class="btn btn-info">목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>
</html>