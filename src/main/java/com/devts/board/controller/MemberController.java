package com.devts.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devts.board.domain.MemberDto;
import com.devts.board.service.MemberService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name = "com.devts.board.service.MemberService")
	MemberService mMemberService;
	
	@GetMapping(value = "/login")
	public String login(String error, Model model) {
		logger.info("ERROR : " + error);
		
		if(error != null) {
			model.addAttribute("error", " * Login Failed");
		}
		
		return "login";
	}
	
	@PostMapping("/login.do") // value属性だけある場合は省略できます。
	public String loginpro() {
		
		return "home";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Model model) {
		
		return "join";
	}
	
	@GetMapping(value = "/emailcheck")
	@ResponseBody
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
	
	@PostMapping(value = "/logout.do")
	public String logout(HttpServletRequest req, HttpServletResponse res) {
		Authentication auth = SecurityContextHolder.getContextHolderStrategy().getContext().getAuthentication();
		
		if(auth != null) {
			new SecurityContextLogoutHandler().logout(req, res, auth);
		}
		
		return "home";
	}
	
}
