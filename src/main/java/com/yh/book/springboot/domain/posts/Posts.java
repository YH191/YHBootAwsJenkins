package com.yh.book.springboot.domain.posts;

import com.yh.book.springboot.domain.BaseTimeEntity;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class Posts extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 500, nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    private String author;

    @Column(columnDefinition = "integer default 0", nullable = false)
    private int view;

    @Builder
    public Posts(String title, String content, String author, int view){
        this.title = title;
        this.content = content;
        this.author = author;
        this.view = view;
    }

    public void update(String title, String content){
        this.title = title;
        this.content = content;
    }
}
