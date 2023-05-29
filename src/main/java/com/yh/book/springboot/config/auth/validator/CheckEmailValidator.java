package com.yh.book.springboot.config.auth.validator;

import com.yh.book.springboot.config.auth.dto.UserDto;
import com.yh.book.springboot.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

/**
 * 이메일 중복 확인 유효성 검증
 */
@RequiredArgsConstructor
@Component
public class CheckEmailValidator extends AbstractValidator<UserDto.Request> {

    private final UserRepository userRepository;

    @Override
    protected void doValidate(UserDto.Request dto, Errors errors) {
        if (userRepository.existsByEmail(dto.toEntity().getEmail())) {
            errors.rejectValue("email", "이메일 중복 오류", "이미 사용중인 이메일 입니다.");
        }
    }
}
