package com.yh.book.springboot.config.auth.validator;

import com.yh.book.springboot.config.auth.dto.UserDto;
import com.yh.book.springboot.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

/**
 * 닉네임 중복 확인 유효성 검증
 */
@RequiredArgsConstructor
@Component
public class CheckNicknameValidator extends AbstractValidator<UserDto.Request> {

    private final UserRepository userRepository;

    @Override
    protected void doValidate(UserDto.Request dto, Errors errors) {
        if (userRepository.existsByNickname(dto.toEntity().getNickname())) {
            errors.rejectValue("nickname", "닉네임 중복 오류", "이미 사용중인 닉네임 입니다.");
        }
    }
}
