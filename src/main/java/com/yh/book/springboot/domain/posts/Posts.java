package com.yh.book.springboot.domain.posts;

import com.yh.book.springboot.domain.BaseTimeEntity;
import com.yh.book.springboot.domain.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Entity
public class Posts extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 500, nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(nullable = false)
    private String writer;

    @Column(columnDefinition = "integer default 0", nullable = false)
    private int view;

    @Column(nullable = false)
    private boolean secret; // 비밀글 여부를 나타내는 필드

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "posts", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    @OrderBy("id asc") // 댓글 정렬
    private List<Comment> comments;

    public boolean isSecret() {
        return secret;
    }

    /*비밀글 정보*/
    public void setSecret(boolean secret) {
        this.secret = secret;
    }
    /* 게시글 수정 */
    public void update(String title, String content){
        this.title = title;
        this.content = content;
    }
}
