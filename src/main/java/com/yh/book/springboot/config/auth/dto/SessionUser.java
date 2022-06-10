package com.yh.book.springboot.config.auth.dto;

import com.yh.book.springboot.domain.user.User;
import lombok.Getter;

import java.io.Serializable;

@Getter
public class SessionUser implements Serializable {
    private String username;
    private String email;
    private String password;

    public SessionUser(User user) {
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.password = user.getPassword();
    }
}
