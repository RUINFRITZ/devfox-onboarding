package com.devts.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.devts.board.domain.CommentDto;
import com.devts.board.mapper.CommentMapper;
import com.devts.board.mapper.MemberMapper;

@Service("com.devts.board.service.CommentService")
public class CommentService {

	@Resource(name = "com.devts.board.mapper.CommentMapper")
	CommentMapper mCommentMapper;
	@Resource(name = "com.devts.board.mapper.MemberMapper")
	MemberMapper mMemberMapper;
	
	public List<CommentDto> commentList(int post_id) {
		return mCommentMapper.commentList(post_id);
	}
	
	public int commentInsert(CommentDto comment) {
		comment.setUser_id(mMemberMapper.memberUserIdGet(comment.getEmail()));
		// System.out.println("" + comment.getUser_id());
		return mCommentMapper.commentInsert(comment);
	}
	
	public int commentDelete(int comment_id) {
		return mCommentMapper.commentDelete(comment_id);
	}
	
	public int commentUpdate(CommentDto comment) {
		return mCommentMapper.commentUpdate(comment);
	}
	
}
