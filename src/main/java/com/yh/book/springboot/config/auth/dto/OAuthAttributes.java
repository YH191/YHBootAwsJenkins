package com.yh.book.springboot.config.auth.dto;

import com.yh.book.springboot.domain.user.Role;
import com.yh.book.springboot.domain.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;

@Slf4j
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class OAuthAttributes {
    private Map<String, Object> attributes;     // 사용자 속성을 담는 맵
    private String nameAttributeKey;            // 사용자 이름에 해당하는 속성 키
    private String username;                    // 사용자 이름
    private String nickname;                    // 사용자 닉네임
    private String login_Info;                   // 로그인 정보
    private String email;                       // 사용자 이메일 주소
    private Role role;                          // 사용자의 역할(Role)

    public static OAuthAttributes of(String registrationId,
                                     String userNameAttributeName,
                                     Map<String, Object> attributes) {
        /* 구글 네이버 구분 */
        if ("naver".equals(registrationId)) {
            return ofNaver("id", attributes);
        }

        return ofGoogle(userNameAttributeName, attributes);
    }

    private static OAuthAttributes ofGoogle(String userNameAttributeName,
                                            Map<String, Object> attributes) {

        return OAuthAttributes.builder()
                .username((String) attributes.get("email"))      // 구글의 이메일 속성 값을 사용자 이름으로 설정
                .email((String) attributes.get("email"))         // 구글의 이메일 속성 값을 이메일로 설정
                .nickname((String) attributes.get("name"))       // 구글의 이름 속성 값을 닉네임으로 설정
                .login_Info((String) "google")                    // 로그인 정보를 "google"로 설정
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)        // OAuth 2.0 표준 스펙에서 정의된 클레임(Claim) 중 하나인 "sub" (Subject)을 반환
                .build();
    }

    private static OAuthAttributes ofNaver(String userNameAttributeName,
                                           Map<String, Object> attributes) {
        /* JSON 반환값 Map에 저장 */
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");

        // log.info("naver response : " + response);

        return OAuthAttributes.builder()
                .username((String) response.get("email"))        // 네이버의 이메일 속성 값을 사용자 이름으로 설정
                .email((String) response.get("email"))           // 네이버의 이메일 속성 값을 이메일로 설정
                .nickname((String) response.get("nickname"))           // 네이버의 아이디 속성 값을 닉네임으로 설정
                .login_Info((String) "naver")                     // 로그인 정보를 "naver"로 설정
                .attributes(response)
                .nameAttributeKey(userNameAttributeName)        // 네이버에서 사용자 식별자를 얻기 위해 "id" 속성을 사용
                .build();
    }

    public User toEntity() {
        return User.builder()
                .username(email)                                 // 사용자 이메일을 사용자 이름으로 설정
                .email(email)                                    // 사용자 이메일 설정
                .nickname(nickname)                              // 사용자 닉네임 설정
                .login_Info(login_Info)                            // 로그인 정보 설정
                .role(Role.SOCIAL)                               // 사용자 역할을 "SOCIAL"로 설정
                .build();
    }

}

