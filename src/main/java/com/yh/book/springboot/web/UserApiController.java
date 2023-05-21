package com.yh.book.springboot.web;

import com.yh.book.springboot.service.posts.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * REST API Controller
 */
@RequiredArgsConstructor
@RequestMapping("/api")
@RestController
public class UserApiController {

    private final UserService userService;

    private final AuthenticationManager authenticationManager;

//    @PutMapping("/user")
//    public ResponseEntity<String> modify(@RequestBody UserDto.Request dto) {
//        userService.modify(dto);
//
//        /* 변경된 세션 등록 */
//        Authentication authentication = authenticationManager.authenticate(
//                new UsernamePasswordAuthenticationToken(dto.getUsername(), dto.getPassword()));
//
//        SecurityContextHolder.getContext().setAuthentication(authentication);
//
//        return new ResponseEntity<>("success", HttpStatus.OK);
//    }
}
