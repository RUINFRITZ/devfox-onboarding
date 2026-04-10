package com.devts.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.devts.board.domain.BoardDto;
import com.devts.board.mapper.BoardMapper;

@Service("com.devts.board.service.BoardService")
public class BoardService {
	
	// Mapper 依存性注入
	@Resource(name = "com.devts.board.mapper.BoardMapper")
	BoardMapper mBoardMapper;
	
	public List<BoardDto> postList() {
		return mBoardMapper.postList();
	}
	
	public List<BoardDto> getPostListWithPaging(Map<String, Object> paramMap){
		int startPostNum = ((Integer)paramMap.get("pageNum") - 1) * (Integer)paramMap.get("pageAmount");
		paramMap.put("startPostNum", startPostNum);
		return mBoardMapper.getPostListWithPaging(paramMap);
	}
	
	public BoardDto postView(int post_id) {
		mBoardMapper.updatePostViews(post_id);
		return mBoardMapper.postView(post_id);
	}
	
	// 記事を登録(作成)します。
	public int postWrite(BoardDto board) {
		return mBoardMapper.postWrite(board);
	}
	
	// 記事を完全にデータベースで削除しするではなく、id_deletedカラムに現在時間を入れます。
	public int postDelete(int post_id) {
		return mBoardMapper.postDelete(post_id);
	}
	
	// 記事の同じpost_idに修正しなす。
	public int postUpdate(BoardDto board) {
		return mBoardMapper.postUpdate(board);
	}
	
	public int getPostTotalCnt(Map<String, Object> paramMap) {
		return mBoardMapper.getPostTotalCnt(paramMap);
	}
	
	public int updatePostViews(int post_id) {
		return mBoardMapper.updatePostViews(post_id);
	}
	
}
