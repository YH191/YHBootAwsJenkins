package com.yh.book.springboot.web;

import com.yh.book.springboot.config.auth.LoginUser;
import com.yh.book.springboot.config.auth.dto.SessionUser;
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

import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Controller
public class IndexController {

    private final PostsService postsService;
    private final HttpSession httpSession;

    @GetMapping("/posts/write")
    public String postsWrite(Model model, @LoginUser SessionUser user){
        model.addAttribute("userName", user.getName());
        return "posts/posts-write";
    }

    @GetMapping("/")    /* default size = 10 */
    public String index(Model model, @PageableDefault(sort = "id", direction = Sort.Direction.DESC)
            Pageable pageable, @LoginUser SessionUser user) {
        model.addAttribute("posts", postsService.findAllDesc());
        if(user != null){
            model.addAttribute("userName", user.getName());
        }
        Page<Posts> list = postsService.pageList(pageable);
        model.addAttribute("posts", list);
        model.addAttribute("previous", pageable.previousOrFirst().getPageNumber());
        model.addAttribute("next", pageable.next().getPageNumber());
        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());

        return "index";
    }

    @GetMapping("/posts/read/{id}")
    public String read(@PathVariable Long id, Model model) {
        PostsResponseDto dto = postsService.findById(id);
        postsService.updateView(id);  //views ++
        model.addAttribute("posts", dto);

        return "posts/posts-read";
    }

    @GetMapping("/posts/update/{id}")
    public String postsUpdate(@PathVariable Long id, Model model){
        PostsResponseDto dto = postsService.findById(id);
        model.addAttribute("posts", dto);

        return "posts/posts-update";
    }


}
