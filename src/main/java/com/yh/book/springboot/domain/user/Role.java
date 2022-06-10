package com.yh.book.springboot.domain.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role {

    GUEST("ROLE_GUEST", "손님"),
    USER("ROLE_USER", "일반 회원 사용자"),
    ADMIN("ROLE_ADMIN", "관리자"),
    SOCIAL("ROLE_SOCIAL", "소셜 회원 이용자");

    private final String value;
    private final String title;
}
