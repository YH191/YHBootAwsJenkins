<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <%@ include file="../layout/header.jspf" %>

  <div id="one-container">
    <div id="posts_list">
      <div class="col-md-12">
        <form class="card">
          <div class="card-header d-flex justify-content-between">
            <label for="id">번호 : ${posts.id}</label>
            <input type="hidden" id="id" value="${posts.id}" />
            <!-- label 연결 -->
            <label for="createdDate">${posts.createdDate}</label>
          </div>
          <div class="card-header d-flex justify-content-between">
            <label for="writer">작성자 : ${posts.writer}</label>
            <label for="view"><i class="bi bi-eye-fill">${posts.view}</i></label>
          </div>
          <div class="card-body">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" value="${posts.title}" />
          </div>
          <div class="card-body">
            <label for="content">내용</label>
            <textarea rows="5" class="form-control" id="content">${posts.content}</textarea>
          </div>
        </form>

        <!-- 버튼 -->
        <div id="content-container">
          <a href="/posts/read/${posts.id}" role="button" class="btn btn-info"> 취소</a>
          <button type="button" id="btn-update" class="btn btn-primary">완료</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    $(document).ready(function () {
      $('#btn-update').click(function () {
        update();
      });
    });

    function update() {
      const data = {
        id: $('#id').val(),
        title: $('#title').val(),
        content: $('#content').val(),
      };

      swal({
        title: '수정하시겠습니까?',
        icon: 'warning',
        buttons: {
          confirm: {
            text: '수정',
            value: true,
            visible: true,
            className: 'btn-primary',
            closeModal: true,
          },
          cancel: {
            text: '취소',
            value: false,
            visible: true,
            className: '',
            closeModal: true,
          },
        },
        dangerMode: false,
      }).then((confirm) => {
        if (confirm) {
          if (!data.title || data.title.trim() === '' || !data.content || data.content.trim() === '') {
            swal({
              title: '입력 오류',
              text: '입력하지 않은 부분이 있습니다.',
              icon: 'error',
            });
            return false;
          } else {
            $.ajax({
              type: 'PUT',
              url: '/api/posts/' + data.id,
              dataType: 'JSON',
              contentType: 'application/json; charset=utf-8',
              data: JSON.stringify(data),
            })
              .done(() => {
                swal({
                  title: '수정 완료',
                  text: '게시물이 수정되었습니다.',
                  icon: 'success',
                }).then(() => {
                  window.location.href = '/posts/read/' + data.id;
                });
              })
              .fail((error) => {
                swal({
                  title: '에러 발생',
                  text: JSON.stringify(error),
                  icon: 'error',
                });
              });
          }
        } else {
          return false;
        }
      });
    }
  </script>

  <%@ include file="../layout/footer.jspf" %>
</html>
