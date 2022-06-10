package com.yh.book.springboot.config.auth.dto;

import com.yh.book.springboot.domain.user.Role;
import com.yh.book.springboot.domain.user.User;
import lombok.Builder;
import lombok.Getter;

import java.util.Map;

@Getter
public class OAuthAttributes {
    private Map<String, Object> attributes;
    private String nameAttributeKey;
    private String username;
    private String nickname;
    private String email;
    private Role role;

    @Builder
    public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey, String username,
                           String nickname, String email, Role role){
        this.attributes = attributes;
        this.nameAttributeKey = nameAttributeKey;
        this.username = username;
        this.nickname = nickname;
        this.email = email;
        this.role = role;
    }

    public static OAuthAttributes of(String registrationId, String userNameAttributeName,
                                     Map<String, Object> attributes){
        /* 구글인지 네이버인지 카카오인지 구분하기 위한 메소드 (ofNaver, ofKaKao) */
        if("naver".equals(registrationId)){
            return ofNaver("id", attributes);
        }
        return ofGoogle(userNameAttributeName, attributes);
    }

    private static OAuthAttributes ofGoogle(String userNameAttributeName,
                                            Map<String, Object> attributes){
        return OAuthAttributes.builder()
                .username((String) attributes.get("email"))
                .email((String) attributes.get("email"))
                .nickname((String) attributes.get("name"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }

    private static OAuthAttributes ofNaver(String userNameAttributeName,
                                            Map<String, Object> attributes){
        /* JSON형태이기 때문에 Map을 통해 데이터를 가져온다. */
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        return OAuthAttributes.builder()
                .username((String) response.get("email"))
                .email((String) response.get("email"))
                .nickname((String) response.get("nickname"))
                .attributes(response)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }
    public User toEntity(){
        return User.builder()
                .username(email)
                .email(email)
                .nickname(nickname)
                .role(Role.SOCIAL)
                .build();
    }

}
