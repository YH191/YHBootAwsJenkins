<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%@ include file="../layout/header.jspf" %>
  <body>
    <div id="posts_list">
      <div class="container col-md-8">
        <form>
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
          </div>
          <input type="hidden" class="form-control" id="writer" value="${username}">
          <div class="form-group">
            <label for="content">내용</label>
            <textarea rows="10" class="form-control" id="content" placeholder="내용을 입력하세요"></textarea>
          </div>
        </form>
        <a href="/" role="button" class="btn btn-info"> 취소</a>
        <button type="button" id="btn-save" class="btn btn-primary"> 작성</button>
      </div>
    </div>
  <%@ include file="../layout/footer.jspf" %>
  </body>
</html>