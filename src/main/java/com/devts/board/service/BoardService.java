package com.devts.board.service;

import java.util.List;

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
	
	public BoardDto postView(String post_id) {
		return mBoardMapper.postView(post_id);
	}
	
	// 記事を登録(作成)します。
	public int postWrite(BoardDto board) {
		return mBoardMapper.postWrite(board);
	}
	
	// 記事を完全にデータベースで削除しするではなく、id_deletedカラムに現在時間を入れます。
	public int postDelete(String post_id) {
		return mBoardMapper.postDelete(post_id);
	}
	
	// 記事の同じpost_idに修訂しなす。
	public int postUpdate(BoardDto board) {
		return mBoardMapper.postUpdate(board);
	}
	
}
