package com.yh.book.springboot.web.dto;

import com.yh.book.springboot.domain.posts.Posts;
import com.yh.book.springboot.domain.user.User;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PostsSaveRequestDto {
    private Long id;
    private String title;
    private String writer;
    private String content;
    private String createdDate, modifiedDate;
    private int view;
    private User user;

    @Builder
    public PostsSaveRequestDto(Long id, String title, String writer, String content,String createdDate,
                               String modifiedDate, int view, User user){
        this.id = id-1;
        this.title = title;
        this.writer = writer;
        this.content = content;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.view = view;
        this.user = user;
    }

    public Posts toEntity(){
        return Posts.builder()
                .id(id)
                .title(title)
                .writer(writer)
                .content(content)
                .view(0)
                .user(user)
                .build();
    }
}
