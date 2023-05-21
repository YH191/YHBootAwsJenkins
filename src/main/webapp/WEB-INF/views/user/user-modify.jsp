<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<div id="posts_list">
    <div class="container col-md-4">
        <form id="user-modify-form" onsubmit="return validateForm(event)">
            <label for="id"></label>
            <input type="hidden" id="id" name="id" value="${user.id}" />
            <input type="hidden" id="modifiedDate" name="modifiedDate" value="${user.modifiedDate}" />
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="${user.username}" class="form-control" readonly />
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="수정할 비밀번호를 입력해주세요" required />
                <span id="valid_password" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="${user.nickname}" class="form-control" placeholder="수정할 닉네임을 입력해주세요" required />
                <span id="valid_nickname" style="color: red;"></span>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" value="${user.email}" class="form-control" readonly />
            </div>

            <button id="btn-user-modify" class="btn btn-primary">완료</button>
            <a href="/" role="button" class="btn btn-info">목록</a>
        </form>
    </div>
</div>
<%@ include file="../layout/footer.jspf" %>
</html>

<script>
    function validateForm(event) {
        event.preventDefault();

        var password = document.getElementById('password').value;
        var nickname = document.getElementById('nickname').value;
        var validPassword = document.getElementById('valid_password');
        var validNickname = document.getElementById('valid_nickname');

        if (!/^(?=.*[0-9])(?=.*\W)(?=\S+$).{8,16}$/.test(password)) {
            validPassword.textContent = '8~16자, 숫자와 특수문자를 사용하세요.';
            return false;
        } else {
            validPassword.textContent = '';
        }

        if (!/^[\u3131-\uD79Da-zA-Z0-9-_]{2,10}$/.test(nickname)) {
            validNickname.textContent = '특수문자를 제외한 2~10자를 사용하세요.';
            return false;
        } else {
            validNickname.textContent = '';
        }

        var con_check = confirm("수정하시겠습니까?");
        if (con_check === true) {
            document.getElementById('btn-user-modify').disabled = true;
            document.getElementById('btn-user-modify').textContent = '수정 중...';

            var form = document.getElementById('user-modify-form');
            var data = {
                id: form.elements["id"].value,
                modifiedDate: form.elements["modifiedDate"].value,
                username: form.elements["username"].value,
                password: form.elements["password"].value,
                nickname: form.elements["nickname"].value
            };

            fetch('/api/user', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("회원 수정이 완료되었습니다.", "success");
                        window.location.href = "/";
                    } else if (response.status === 500) {
                        alert("이미 사용중인 닉네임 입니다.", "error");
                        document.getElementById('nickname').focus();
                        document.getElementById('btn-user-modify').disabled = false;
                        document.getElementById('btn-user-modify').textContent = '완료';
                    } else {
                        alert("오류가 발생했습니다.", "error");
                        document.getElementById('btn-user-modify').disabled = false;
                        document.getElementById('btn-user-modify').textContent = '완료';
                        console.log(response.statusText);
                    }
                })
                .catch(function (error) {
                    alert("오류가 발생했습니다.", "error");
                    console.log(error);
                });
        } else {
            return false;
        }
    }
</script>