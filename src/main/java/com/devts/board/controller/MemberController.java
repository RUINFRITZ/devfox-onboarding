package com.devts.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devts.board.domain.MemberDto;
import com.devts.board.service.MemberService;

@Controller
public class MemberController {
	
	@Resource(name = "com.devts.board.service.MemberService")
	MemberService mMemberService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		
		return "login";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Model model) {
		
		return "join";
	}
	
	@GetMapping(value = "/emailcheck")
	public int MemberEmailCheck(HttpServletRequest req) {
		
		return mMemberService.memberEmailCheck(req.getParameter("email"));
	}
	
	// Spring-Securityを利用して暗号化します。
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/join.do")
	private String MemberInsertPro(HttpServletRequest req) {
		
		MemberDto dto = new MemberDto();
		
		dto.setEmail(req.getParameter("email"));
		dto.setNickname(req.getParameter("nickname"));
		
		String enpass = passwordEncoder.encode(req.getParameter("password"));
		dto.setPassword(enpass);
		
		mMemberService.memberInsertService(dto);
		
		return "redirect:/login";
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model) {
		
		return "mypage";
	}
	
}
