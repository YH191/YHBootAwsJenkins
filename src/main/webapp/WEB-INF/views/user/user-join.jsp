<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form id="joinForm" action="/auth/joinProc" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" value="${userDto.username}" class="form-control" placeholder="아이디를 입력해주세요"/>
                <span id="valid_username" class="error"></span>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" value="${userDto.password}" class="form-control" placeholder="비밀번호를 입력해주세요"/>
                <span id="valid_password" class="error"></span>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="${userDto.nickname}" class="form-control" placeholder="닉네임을 입력해주세요"/>
                <span id="valid_nickname" class="error"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="${userDto.email}" class="form-control" placeholder="이메일을 입력해주세요"/>
                <span id="valid_email" class="error"></span>
            </div>

            <button type="submit" class="btn btn-primary"> 가입</button>
            <a href="/" role="button" class="btn btn-info"> 목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>

<script>
    // 입력창에서 focus가 벗어났을 때 유효성 검사 실행
    document.getElementById('username').addEventListener('blur', function() {
        var input = this.value;
        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{4,20}$/.test(input)) {
            document.getElementById('valid_username').textContent = '아이디는 특수문자를 제외한 4~20자리여야 합니다.';
        } else {
            document.getElementById('valid_username').textContent = '';
        }
    });

    document.getElementById('password').addEventListener('blur', function() {
        var input = this.value;
        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(input)) {
            document.getElementById('valid_password').textContent = '비밀번호는 8~16자 사이의 길이를 가져야 하며, 숫자와 특수문자가 반드시 포함되어야 합니다.';
        } else {
            document.getElementById('valid_password').textContent = '';
        }
    });

    document.getElementById('nickname').addEventListener('blur', function() {
        var input = this.value;
        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{2,10}$/.test(input)) {
            document.getElementById('valid_nickname').textContent = '닉네임은 특수문자를 제외한 2~10자리여야 합니다.';
        } else {
            document.getElementById('valid_nickname').textContent = '';
        }
    });

    document.getElementById('email').addEventListener('blur', function() {
        var input = this.value;
        if (!/^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/.test(input)) {
            document.getElementById('valid_email').textContent = '이메일 형식이 올바르지 않습니다.';
        } else {
            document.getElementById('valid_email').textContent = '';
        }
    });

    // 가입 버튼 클릭 시 유효성 검사 실행
    document.getElementById('joinForm').addEventListener('submit', function(event) {
        var usernameInput = document.getElementById('username');
        var passwordInput = document.getElementById('password');
        var nicknameInput = document.getElementById('nickname');
        var emailInput = document.getElementById('email');

        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{4,20}$/.test(usernameInput.value)) {
            document.getElementById('valid_username').textContent = '특수문자를 제외한 4~20자를 사용하세요.';
            event.preventDefault(); // 폼 제출 중단
        }
        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(passwordInput.value)) {
            document.getElementById('valid_password').textContent = '8~16자, 숫자와 특수문자를 사용하세요.';
            event.preventDefault(); // 폼 제출 중단
        }
        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{2,10}$/.test(nicknameInput.value)) {
            document.getElementById('valid_nickname').textContent = '특수문자를 제외한 2~10자를 사용하세요.';
            event.preventDefault(); // 폼 제출 중단
        }
        if (!/^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/.test(emailInput.value)) {
            document.getElementById('valid_email').textContent = '이메일 형식이 올바르지 않습니다.';
            event.preventDefault(); // 폼 제출 중단
        }
    });
</script>
</html>