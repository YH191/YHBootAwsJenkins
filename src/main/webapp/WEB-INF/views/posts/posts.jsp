<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
  <%@ include file="../layout/header.jspf" %>
  <body>
    <div id="posts_list">
      <!-- 목록 출력 영역 -->
      <table id="table" class="table table-horizontal table-bordered">
        <thead id="thead" class="thead-strong">
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>최종수정일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <tbody id="tbody">
        <c:if test="${empty list.content}">
          <!-- 해당 내용이 실행될 경우 list 변수가 없는 경우임 -->
          <tr>
            <td colspan="5">게시글이 없습니다.</td>
          </tr>
        </c:if>
          <c:forEach items="${list.content}" var="post">
            <tr>
              <td>${post.id}</a></td>
              <td><a href="/posts/read/${post.id}">${post.title}</a></td>
              <td>${post.writer}</td>
              <td>${fn:substring(post.modifiedDate, 0, 10)}</td>
              <td>${post.view}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <%-- Page --%>
      <div class="pagination justify-content-center">
        <c:if test="${list.totalPages > 1}">
          <ul class="pagination">
            <c:choose>
              <c:when test="${hasPrev}">
                <li class="page-item">
                  <a class="page-link" href="/posts?page=${previous}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="page-item disabled">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
              </c:otherwise>
            </c:choose>

            <c:forEach begin="0" end="${list.totalPages - 1}" varStatus="status">
              <li class="page-item ${status.index == list.number ? 'active' : ''}">
                <a class="page-link" href="/posts?page=${status.index}">${status.index + 1}</a>
              </li>
            </c:forEach>

            <c:choose>
              <c:when test="${hasNext}">
                <li class="page-item">
                  <a class="page-link" href="/posts?page=${next}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="page-item disabled">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </c:if>
      </div>

      <c:if test="${user != null}">
        <div style="text-align:right">
          <a href="/posts/write" role="button" class="btn btn-primary"> 글쓰기</a>
        </div>
      </c:if>
      <c:if test="${user == null}">
        <div style="text-align:right">
          <a role="button" class="btn btn-primary">비회원은 글을 작성할 수 없습니다</a>
        </div>
      </c:if>
    </div>
    <%@ include file="../layout/footer.jspf" %>
  </body>
</html>