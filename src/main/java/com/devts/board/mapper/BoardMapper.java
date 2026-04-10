package com.devts.board.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.devts.board.domain.BoardDto;

@Repository("com.devts.board.mapper.BoardMapper")
public interface BoardMapper {

	public List<BoardDto> postList();
	
	public List<BoardDto> getPostListWithPaging(Map<String, Object> paramMap);
	
	public BoardDto postView(int post_id);
	
	public int postWrite(BoardDto board);
	
	public int postDelete(int post_id);
	
	public int postUpdate(BoardDto board);
	
	int getPostTotalCnt(Map<String, Object> paramMap);
	
	int updatePostViews(int post_id);
}
