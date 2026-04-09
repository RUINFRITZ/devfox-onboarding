package com.devts.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.devts.board.domain.BoardDto;

@Repository("com.devts.board.mapper.BoardMapper")
public interface BoardMapper {

	public List<BoardDto> postList();
	
	public BoardDto postView(String post_id);
	
	public int postWrite(BoardDto board);
	
	public int postDelete(String post_id);
	
	public int postUpdate(BoardDto board);
}
