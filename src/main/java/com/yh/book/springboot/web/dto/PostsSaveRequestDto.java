package com.yh.book.springboot.web.dto;

import com.yh.book.springboot.domain.posts.Posts;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PostsSaveRequestDto {
    private String title;
    private String content;
    private String author;
    private int view;

    @Builder
    public PostsSaveRequestDto(String title, String content, String author, int view){
        this.title = title;
        this.content = content;
        this.author = author;
        this.view = view;
    }

    public Posts toEntity(){
        return Posts.builder()
                .title(title)
                .content(content)
                .author(author)
                .view(view)
                .build();
    }
}
