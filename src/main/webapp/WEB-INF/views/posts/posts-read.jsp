<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../layout/header.jspf" %>
<body>
<div id="posts_list">
  <div class="col-md-12">
    <form class="card">
      <div class="card-header d-flex justify-content-between">
        <label for="id">번호 : ${posts.id}</label>
        <input type="hidden" id="id" value="${posts.id}"/> <!-- label 연결 -->
        <label for="createdDate">${posts.createdDate}</label>
      </div>
      <div class="card-header d-flex justify-content-between">
        <label for="writer">작성자 : ${posts.writer}</label>
        <label for="view">조회수 : ${posts.view}</i></label>
      </div>
      <div class="card-body">
        <label for="title">제목</label>
        <input type="text" class="form-control" id="title" value="${posts.title}" readonly/>
        <br/>
        <label for="content">내용</label>
        <textarea rows="5" class="form-control" id="content" readonly>${posts.content}</textarea>
      </div>
    </form>

    <!-- Buttons -->
    <a href="/posts" role="button" class="btn btn-info"> 목록</a>
    <c:if test="${user != null}">
      <c:if test="${writer}">
        <a href="/posts/update/${posts.id}" role="button" class="btn btn-primary"> 수정</a>
        <button type="button" onclick="deletePost()" id="btn-delete" class="btn btn-danger"> 삭제</button>
      </c:if>
    </c:if>

    <!-- Comments -->
    <%@ include file="../comment/list.jspf" %>
    <%@ include file="../comment/form.jspf" %>
  </div>
</div>

<script>
  function deletePost() {
    const id = $('#id').val();
    const con_check = confirm("정말 삭제하시겠습니까?");

    if (con_check === true) {
      $.ajax({
        type: 'DELETE',
        url: '/api/posts/' + id,
        dataType: 'JSON',
        contentType: 'application/json; charset=utf-8'

      }).done(function () {
        alert("삭제되었습니다.");
        window.location.href = '/posts';
      }).fail(function (error) {
        alert(JSON.stringify(error));
      });
    } else {
      return false;
    }
  }
</script>

<%@ include file="../layout/footer.jspf" %>
</body>
</html>