<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
  <%@ include file="../layout/header.jspf" %>
  <body>
    <div id="one-container">
      <div id="posts_list">
        <table id="table" class="table table-horizontal table-bordered">
          <h6>게시글 검색 결과</h6>
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
            <c:if test="${empty searchList.content}">
              <!-- 해당 내용이 실행될 경우 list 변수가 없는 경우임 -->
              <tr>
                <td colspan="5">게시글이 없습니다.</td>
              </tr>
            </c:if>
            <c:forEach items="${searchList.content}" var="post">
              <tr>
                <td>
                  <c:if test="${post.secret}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
                      <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z" />
                    </svg>
                  </c:if>
                  ${post.id}
                </td>
                <td>
                  <a href="javascript:void(0);" onclick="viewPost(${post.id}, '${post.writer}', ${post.secret})">${post.title}</a>
                </td>
                <td>${post.writer}</td>
                <td>${fn:substring(post.modifiedDate, 0, 10)}</td>
                <td>${post.view}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <%-- Pagination --%>
        <div class="pagination justify-content-center">
          <c:if test="${searchList.totalPages > 1}">
            <ul class="pagination">
              <c:choose>
                <c:when test="${hasPrev}">
                  <li class="page-item">
                    <a class="page-link" href="/posts/search?page=${previous}&amp;keyword=${fn:escapeXml(keyword)}" aria-label="Previous">
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

              <c:forEach begin="0" end="${searchList.totalPages - 1}" varStatus="status">
                <li class="page-item ${status.index == searchList.number ? 'active' : ''}">
                  <a class="page-link" href="/posts/search?page=${status.index}&amp;keyword=${fn:escapeXml(keyword)}">${status.index + 1}</a>
                </li>
              </c:forEach>

              <c:choose>
                <c:when test="${hasNext}">
                  <li class="page-item">
                    <a class="page-link" href="/posts/search?page=${next}&amp;keyword=${fn:escapeXml(keyword)}" aria-label="Next">
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
      </div>
    </div>
    <%@ include file="../layout/footer.jspf" %>

    <script>
      function viewPost(postId, writer, secret) {
        const userRole = '${userRole}';

        // 현재 사용자와 글 작성자가 같거나 관리자인 경우에만 글을 볼 수 있도록 처리
        if (secret && (userRole === 'ROLE_ADMIN' || '${username}' === writer)) {
          window.location.href = '/posts/read/' + postId;
        } else if (secret && (userRole !== 'ROLE_ADMIN' || '${username}' !== writer)) {
          swal('작성자와 관리자만 볼 수 있는 비밀글입니다.');
        } else {
          window.location.href = '/posts/read/' + postId;
        }
      }
    </script>
  </body>
</html>
