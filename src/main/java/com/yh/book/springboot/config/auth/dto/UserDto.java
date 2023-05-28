package com.yh.book.springboot.config.auth.dto;

import com.yh.book.springboot.domain.user.Role;
import com.yh.book.springboot.domain.user.User;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * request, response DTO 클래스를 하나로 묶어 InnerStaticClass로 한 번에 관리
 */
public class UserDto {

    /** 회원 Service 요청(Request) DTO 클래스 */
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public static class Request {

        private Long id;

        @Pattern(regexp = "^[ㄱ-ㅎ가-힣a-zA-Z0-9-_]{4,20}$", message = "특수문자를 제외한 4~20자를 사용하세요.")
        @NotBlank(message = "아이디는 필수 입력 값입니다.")
        private String username;

        @Pattern(regexp = "^(?=.*[0-9])(?=.*\\W)(?=\\S+$).{8,16}$", message = "8~16자, 숫자와 특수문자를 사용하세요.")
        @NotBlank(message = "비밀번호는 필수 입력 값입니다.")
        private String password;

        @Pattern(regexp = "^[ㄱ-ㅎ가-힣a-zA-Z0-9-_]{2,10}$", message = "특수문자를 제외한 2~10자를 사용하세요.")
        @NotBlank(message = "닉네임은 필수 입력 값입니다.")
        private String nickname;

        @Pattern(regexp = "^(?:\\w+\\.?)*\\w+@(?:\\w+\\.)+\\w+$", message = "이메일 형식이 올바르지 않습니다.")
        @NotBlank(message = "이메일은 필수 입력 값입니다.")
        private String email;


        private Role role;

        /* DTO -> Entity */
        public User toEntity() {
            User user = User.builder()
                    .id(id)
                    .username(username)
                    .password(password)
                    .nickname(nickname)
                    .email(email)
                    .loginInfo("local")
                    .role(username.equalsIgnoreCase("admin")? role.ADMIN : role.USER)
                    .build();
            return user;
        }
    }

    /**
     * 인증된 사용자 정보를 세션에 저장하기 위한 클래스
     * 세션을 저장하기 위해 User 엔티티 클래스를 직접 사용하게 되면 직렬화를 해야 하는데,
     * 엔티티 클래스에 직렬화를 넣어주면 추후에 다른 엔티티와 연관관계를 맺을시
     * 직렬화 대상에 다른 엔티티까지 포함될 수 있어 성능 이슈 우려가 있기 때문에
     * 세션 저장용 Dto 클래스 생성
     * */
    @Getter
    public static class Response implements Serializable {

        private final Long id;
        private final String username;
        private final String nickname;
        private final String email;
        private final String loginInfo;
        private final Role role;
        private final String modifiedDate;

        /* Entity -> dto */
        public Response(User user) {
            this.id = user.getId();
            this.username = getUsernameWithoutDomain(user.getUsername());
            this.nickname = user.getNickname();
            this.loginInfo = user.getLoginInfo();
            this.email = user.getEmail();
            this.role = user.getRole();
            this.modifiedDate = user.getModifiedDate();
        }

        private String getUsernameWithoutDomain(String email) {
            int atIndex = email.indexOf("@");
            if (atIndex == -1) { // @이 없는 경우
                return email;
            } else {
                return email.substring(0, atIndex);
            }
        }
    }
}
