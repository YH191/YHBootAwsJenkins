package com.yh.book.springboot.web.dto;

import com.yh.book.springboot.domain.posts.Posts;
import lombok.Getter;

@Getter
public class PostsResponseDto {
    private Long id;
    private String title;
    private String writer;
    private String content;
    private String createdDate, modifiedDate;
    private int view;
    private Long userId;
    //private List<CommentDto.Response> comments;

    public PostsResponseDto(Posts entity){
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.writer = entity.getWriter();
        this.content = entity.getContent();
        this.createdDate = entity.getCreatedDate();
        this.modifiedDate = entity.getModifiedDate();
        this.view = entity.getView();
        this.userId = getUserId();
        //this.comments = posts.getComments().stream().map(CommentDto.Response::new).collect(Collectors.toList());
    }
}
