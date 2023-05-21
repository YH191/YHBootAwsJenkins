<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form id="modifyForm" method="post" action="/modify">
            <label for="id"></label>
            <input type="hidden" id="id" value="${user.id}"/>
            <input type="hidden" id="modifiedDate" value="${user.modifiedDate}"/>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="${user.username}" class="form-control" readonly disabled/>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" class="form-control" placeholder="수정할 비밀번호를 입력해주세요"/>
                <span id="valid_password" class="error"></span>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" value="${user.nickname}" class="form-control" placeholder="수정할 닉네임을 입력해주세요"/>
                <span id="valid_nickname" class="error"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" value="${user.email}" class="form-control" readonly disabled/>
            </div>

            <button id="btn-user-modify" class="btn btn-primary" type="submit">완료</button>
            <a href="/" role="button" class="btn btn-info">목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>
<script>
    // 입력창에서 focus가 벗어났을 때 유효성 검사 실행
    document.getElementById('password').addEventListener('blur', function() {
        var input = this.value;
        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(input)) {
            document.getElementById('valid_password').textContent = '비밀번호는 8~16자, 숫자와 특수문자를 사용해야 합니다.';
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

    // 수정 완료 버튼 클릭 시 유효성 검사 실행
    document.getElementById('btn-user-modify').addEventListener('click', function(event) {
        var passwordInput = document.getElementById('password').value;
        var nicknameInput = document.getElementById('nickname').value;

        // Perform validation checks
        var isValid = true;

        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(passwordInput)) {
            document.getElementById('valid_password').textContent = '비밀번호는 8~16자, 숫자와 특수문자를 사용해야 합니다.';
            isValid = false;
        } else {
            document.getElementById('valid_password').textContent = '';
        }

        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{2,10}$/.test(nicknameInput)) {
            document.getElementById('valid_nickname').textContent = '닉네임은 특수문자를 제외한 2~10자리여야 합니다.';
            isValid = false;
        } else {
            document.getElementById('valid_nickname').textContent = '';
        }

        if (!isValid) {
            event.preventDefault(); // Prevent form submission if validation fails
        }
    });
</script>
</html>