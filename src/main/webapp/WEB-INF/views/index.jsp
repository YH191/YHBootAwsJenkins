<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <%@ include file="layout/header.jspf" %>
  <body>
    <div id="posts_list">
      <!-- 목록 출력 영역 -->
      <table id="table" class="table table-horizontal table-bordered">
        <thead id="thead" class="thead-strong">
          <tr>
            <th>게시글번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>최종수정일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <tbody id="tbody">
          <c:forEach items="${list.content}" var="post">
            <tr>
              <td><a href="/posts/read/${post.id}">${post.id}</a></td>
              <td><a href="/posts/read/${post.id}">${post.title}</a></td>
              <td>${post.writer}</td>
              <td>${post.modifiedDate}</td>
              <td>${post.view}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <c:if test="${user != null}">
        <div style="text-align:right">
          <a href="/posts/write" role="button" class="btn btn-primary bi bi-pencil-fill"> 글쓰기</a>
        </div>
      </c:if>
      <c:if test="${user == null}">
        <div style="text-align:right">
          <a role="button" class="btn btn-primary">비회원은 글을 작성할 수 없습니다</a>
        </div>
      </c:if>
    </div>
    <%@ include file="layout/footer.jspf" %>
  </body>
</html>