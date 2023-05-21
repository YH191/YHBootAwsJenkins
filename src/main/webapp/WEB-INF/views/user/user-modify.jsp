<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form onsubmit="return validateForm()">
            <label for="id"></label>
            <input type="hidden" id="id" value="${user.id}"/>
            <input type="hidden" id="modifiedDate" value="${user.modifiedDate}"/>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="${user.username}" class="form-control" readonly/>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" class="form-control" placeholder="수정할 비밀번호를 입력해주세요" required/>
                <span id="valid_password" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" value="${user.nickname}" class="form-control" placeholder="수정할 닉네임을 입력해주세요" required/>
                <span id="valid_nickname" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" value="${user.email}" class="form-control" readonly/>
            </div>

            <button id="btn-user-modify" class="btn btn-primary">완료</button>
            <a href="/" role="button" class="btn btn-info">목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>

<script>
    function validateForm() {
        var password = document.getElementById('password').value;
        var nickname = document.getElementById('nickname').value;

        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(password)) {
            document.getElementById('valid_password').textContent = '8~16자, 숫자와 특수문자를 사용하세요.';
            return false;
        } else {
            document.getElementById('valid_password').textContent = '';
        }

        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{2,10}$/.test(nickname)) {
            document.getElementById('valid_nickname').textContent = '특수문자를 제외한 2~10자를 사용하세요.';
            return false;
        } else {
            document.getElementById('valid_nickname').textContent = '';
        }

        return true;
    }
</script>

</html>