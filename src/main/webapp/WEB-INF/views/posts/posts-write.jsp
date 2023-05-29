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
          <div class="form-check">
            <input type="checkbox" class="form-check-input" id="secret" name="secret">
            <label class="form-check-label" for="secret">비밀글 설정</label>
          </div>
        </form>
        <a href="/posts" role="button" class="btn btn-info">취소</a>
        <button type="button" id="btn-save" class="btn btn-primary">작성</button>
      </div>
    </div>

    <script>
      $(document).ready(function() {
        $('#btn-save').click(function() {
          save();
        });
      });

      function save() {
        const data = {
          title: $('#title').val(),
          writer: $('#writer').val(),
          content: $('#content').val(),
          secret: $('#secret').prop('checked')
        };

        // 공백 및 빈 문자열 체크
        if (!data.title || data.title.trim() === "" || !data.content || data.content.trim() === "") {
          swal("입력하지 않은 부분이 있습니다.");
          return false;
        } else {
          $.ajax({
            type: 'POST',
            url: '/api/posts',
            dataType: 'JSON',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
          }).done(function () {
            swal({
              title: '등록되었습니다.',
              icon: 'success',
              buttons: {
                confirm: {
                  text: '확인',
                  value: true,
                  visible: true,
                  className: 'swal-button-confirm',
                  closeModal: true
                }
              }
            }).then((value) => {
              if (value) {
                window.location.href = '/posts';
              }
            });
          }).fail(function (error) {
            swal(JSON.stringify(error));
          });
        }
      }
    </script>

  <%@ include file="../layout/footer.jspf" %>
  </body>
</html>