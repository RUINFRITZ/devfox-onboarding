package com.devts.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.devts.board.domain.BoardDto;
import com.devts.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name = "com.devts.board.service.BoardService")
	BoardService mBoardService;
	
	@GetMapping("/view")
	public String postView() {
		
		return "view";
	}
	
	@GetMapping("/write")
	public String postWrite() {
		
		return "/board/write";
	}

	@RequestMapping("/write.do")
	public String postWritePro(HttpServletRequest req) {
		BoardDto board = new BoardDto();
		
		board.setTitle(req.getParameter("title"));
		board.setTitle(req.getParameter("content"));
		
		board.setTitle(req.getParameter("email"));
		
		mBoardService.postWrite(board);
		
		return "redirect:/";
	}
	
}
