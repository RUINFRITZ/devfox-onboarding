package com.devts.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.devts.board.domain.CommentDto;

@Repository("com.devts.board.mapper.CommentMapper")
public interface CommentMapper {

	public List<CommentDto> commentList(int post_id);
	
	// コメントを登録しなす。
	public int commentInsert(CommentDto comment);
	
	// コメントをソフトディリトしなす。
	public int commentDelete(int comment_id);
	
	// 修正した内容を同じ「comment_id」に保存します。
	public int commentUpdate(CommentDto comment);
	
}
