package com.yh.book.springboot.config.auth.dto;

import com.yh.book.springboot.domain.user.Role;
import com.yh.book.springboot.domain.user.User;
import lombok.Getter;

import java.io.Serializable;

@Getter
public class UserSessionDto implements Serializable {
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private Role role;

    /* Entity -> Dto */
    public UserSessionDto(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.nickname = user.getNickname();
        this.email = user.getEmail();
        this.role = user.getRole();
    }
}


