package com.yh.book.springboot.domain.user;

import com.yh.book.springboot.domain.BaseTimeEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Entity
public class User extends BaseTimeEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 30, unique = true)
    private String username; // 아이디

    @Column(nullable = false, unique = true)
    private String nickname;

    @Column(length = 100)
    private String password;

    @Column(nullable = false, length = 50, unique = true)
    private String email;

    @Column(nullable = true, length = 30, unique = false)
    private String loginInfo = "local";

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    /* 회원정보 수정 */
    public void modify(String nickname, String password) {
        this.nickname = nickname;
        this.password = password;
    }

    /* 소셜로그인시 이미 등록된 회원이라면 수정날짜만 업데이트 후 기존 데이터를 유지 */
    public User updateModifiedDate() {
        this.onPreUpdate();
        return this;
    }
    /* 사용자의 role 반환 */
    public String getRoleValue() {
        return this.role.getValue();
    }

    /* admin 사용자는 기본 admin 권한 부여 */
    public User(String username, String nickname, String password, String email, Role role) {
        this.username = username;
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.loginInfo = "local";
        if (username.equalsIgnoreCase("admin")) {
            this.role = Role.ADMIN;
        } else {
            this.role = Role.USER;
        }
    }
}
