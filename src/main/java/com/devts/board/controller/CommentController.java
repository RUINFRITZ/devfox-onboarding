package com.devts.board.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.devts.board.domain.CommentDto;
import com.devts.board.service.CommentService;

@RestController
@RequestMapping("/comment")
public class CommentController {

	@Resource(name = "com.devts.board.service.CommentService")
	CommentService mCommentService;
	
	@GetMapping(value = "/{post_id}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CommentDto>> commentList(@PathVariable int post_id) {
		return new ResponseEntity<List<CommentDto>>(mCommentService.commentList(post_id), HttpStatus.OK);
	}
	
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> commentInsert(@RequestBody CommentDto comment) {
		int insertResult = mCommentService.commentInsert(comment);
		
		return insertResult==1 ? new ResponseEntity<String>(" - 登録されました。", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{comment_id}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> commentUpdate(@RequestBody CommentDto comment, @PathVariable String comment_id) {
		comment.setComment_id(Integer.parseInt(comment_id));
		
		return (mCommentService.commentUpdate(comment) > 0) ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value = "/{comment_id}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> commentDelete(@PathVariable String comment_id) {
		return mCommentService.commentDelete(Integer.parseInt(comment_id)) > 0 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
