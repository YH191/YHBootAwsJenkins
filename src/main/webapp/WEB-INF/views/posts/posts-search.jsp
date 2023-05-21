<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <%@ include file="../layout/header.jspf" %>
  <body>
    <div id="posts_list">
      <table id="table" class="table table-horizontal table-bordered">
        <h6>게시글 검색 결과</h6>
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
         <c:forEach items="${searchList.content}" var="post">
           <tr>
             <td>${post.id}</td>
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
          <a href="/posts/write" role="button" class="btn btn-primary"> 글쓰기</a>
        </div>
      </c:if>
      <c:if test="${user == null}">
        <div style="text-align:right">
          <a role="button" class="btn btn-primary">비회원은 글을 작성할 수 없습니다</a>
        </div>
      </c:if>
<%-- Page --%>
            <div class="pagination justify-content-center">
              <c:if test="${searchList.totalPages > 1}">
                <ul class="pagination">
                  <c:choose>
                    <c:when test="${hasPrev}">
                      <li class="page-item">
                        <a class="page-link" href="/?page=${previous}" aria-label="Previous">
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
                      <a class="page-link" href="/?page=${status.index}">${status.index + 1}</a>
                    </li>
                  </c:forEach>

                  <c:choose>
                    <c:when test="${hasNext}">
                      <li class="page-item">
                        <a class="page-link" href="/?page=${next}" aria-label="Next">
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
    <%@ include file="../layout/footer.jspf" %>
  </body>
</html>