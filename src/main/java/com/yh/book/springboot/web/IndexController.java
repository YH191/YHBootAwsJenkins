package com.yh.book.springboot.web;

import com.yh.book.springboot.config.auth.LoginUser;
import com.yh.book.springboot.config.auth.dto.UserSessionDto;
import com.yh.book.springboot.domain.posts.Posts;
import com.yh.book.springboot.service.posts.PostsService;
import com.yh.book.springboot.web.dto.PostsResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RequiredArgsConstructor
@Controller
public class IndexController {

    private final PostsService postsService;

    @GetMapping("/")                 /* default page = 0, size = 10  */
    public String index(Model model, @PageableDefault(sort = "id", direction = Sort.Direction.DESC)
            Pageable pageable, @LoginUser UserSessionDto user) {
        Page<Posts> list = postsService.pageList(pageable);

        if (user != null) {
            model.addAttribute("user", user.getNickname());
        }

        model.addAttribute("posts", list);
        model.addAttribute("previous", pageable.previousOrFirst().getPageNumber());
        model.addAttribute("next", pageable.next().getPageNumber());
        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());

        return "index";
    }

    /* 글 작성 */
    @GetMapping("/posts/write")
    public String postsWrite(Model model, @LoginUser UserSessionDto user){
        if (user != null) {
            model.addAttribute("user", user.getNickname());
            model.addAttribute("user.nickname", user.getNickname());
        }

        return "posts/posts-write";
    }

    /* 글 상세보기 */
    @GetMapping("/posts/read/{id}")
    public String read(@PathVariable Long id, Model model, @LoginUser UserSessionDto user) {
        PostsResponseDto dto = postsService.findById(id);
//        List<CommentDto.Response> comments = dto.getComments();


//        /* 댓글 관련 */
//        if (comments != null && !comments.isEmpty()) {
//            model.addAttribute("comments", comments);
//        }

        /* 사용자 관련 */
        if (user != null) {
            model.addAttribute("user", user.getNickname());

            /* 게시글 작성자 본인인지 확인 */
            if (dto.getWriter().equals(user.getNickname())) {
                model.addAttribute("writer", true);
            }

//            /* 댓글 작성자 본인인지 확인 */
//            if (comments.stream().anyMatch(s -> s.getUserId().equals(user.getId()))) {
//                model.addAttribute("isWriter", true);
//            }
/*            for (int i = 0; i < comments.size(); i++) {
                boolean isWriter = comments.get(i).getUserId().equals(user.getId());
                model.addAttribute("isWriter",isWriter);
            }*/
        }

        postsService.updateView(id); // views ++
        model.addAttribute("posts", dto);
        return "posts/posts-read";
    }

    /* 글 수정 */
    @GetMapping("/posts/update/{id}")
    public String postsUpdate(@PathVariable Long id, Model model, @LoginUser UserSessionDto user){
        PostsResponseDto dto = postsService.findById(id);
        if (user != null) {
            model.addAttribute("user", user.getNickname());
        }
        model.addAttribute("posts", dto);

        return "posts/posts-update";
    }

    /* 글 검색 */
    @GetMapping("/posts/search")
    public String search(String keyword, Model model, @LoginUser UserSessionDto user,
                         @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Posts> searchList = postsService.search(keyword, pageable);

        if (user != null) {
            model.addAttribute("user", user.getNickname());
        }
        model.addAttribute("searchList", searchList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("previous", pageable.previousOrFirst().getPageNumber());
        model.addAttribute("next", pageable.next().getPageNumber());
        model.addAttribute("hasNext", searchList.hasNext());
        model.addAttribute("hasPrev", searchList.hasPrevious());

        return "posts/posts-search";
    }

}
