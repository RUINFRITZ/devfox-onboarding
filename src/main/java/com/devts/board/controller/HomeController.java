package com.devts.board.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.devts.board.domain.BoardDto;
import com.devts.board.domain.PagingDto;
import com.devts.board.service.BoardService;

@Controller
public class HomeController {
	
	@Resource(name = "com.devts.board.service.BoardService")
	BoardService mBoardService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, @RequestParam(required = false) String pageNum, @RequestParam(required = false) String pageAmount, @RequestParam(required = false) String searchType, @RequestParam(required = false) String searchWord) {
		
		if(pageNum == null) pageNum = "1";
		if(pageAmount == null) pageAmount = "5";
		if(searchType == null) searchType = "";
		if(searchWord == null) searchWord = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNum", Integer.parseInt(pageNum));
		map.put("pageAmount", Integer.parseInt(pageAmount));
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<BoardDto> postList = mBoardService.getPostListWithPaging(map);
		int total = mBoardService.getPostTotalCnt(map);
		model.addAttribute("list", postList);
		
		PagingDto paging = new PagingDto(Integer.parseInt(pageNum), Integer.parseInt(pageAmount), searchType, searchWord, total);
		model.addAttribute("pageMaker", paging);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
}
