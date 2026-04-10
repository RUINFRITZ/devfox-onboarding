package com.devts.board.controller;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.devts.board.domain.BoardDto;
import com.devts.board.service.BoardService;
import com.devts.board.service.MemberService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name = "com.devts.board.service.BoardService")
	BoardService mBoardService;
	@Resource(name = "com.devts.board.service.MemberService")
	MemberService mMemberService;
	
	@RequestMapping("/view/{post_id}")
	public String postView(@PathVariable int post_id, Model model) {
		
		model.addAttribute("view", mBoardService.postView(post_id));
		return "/board/view";
	}
	
	@GetMapping("/write")
	public String postWrite() {
		
		return "/board/write";
	}

	@PostMapping("/write.do")
	public String postWritePro(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			BoardDto board = new BoardDto();
			
			int user_id = mMemberService.memberUserIdGet(req.getParameter("email"));
			
			board.setUser_id(user_id);
			board.setTitle(title);
			board.setContent(content);
			
			mBoardService.postWrite(board);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	}
	
	@RequestMapping("/update/{post_id}")
	public String postUpdateForm(@PathVariable int post_id, Model model) {
		model.addAttribute("view", mBoardService.postView(post_id));		
		
		return "board/update";
	}

	@RequestMapping("/updatepro.do")
	public String postUpdatePro(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int post_id = Integer.parseInt(req.getParameter("post_id"));
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			BoardDto board = new BoardDto();
			
			board.setPost_id(post_id);
			board.setTitle(title);
			board.setContent(content);
			
			mBoardService.postUpdate(board);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/view/" + req.getParameter("post_id");
	}
	
	@RequestMapping("/delete/{post_id}")
	public String postDelete(@PathVariable int post_id) {
		mBoardService.postDelete(post_id);
		
		return "redirect:/";
	}
}
