package com.devts.board.mapper;

import org.springframework.stereotype.Repository;

import com.devts.board.domain.MemberDto;

@Repository("com.devts.board.mapper.MemberMapper")
public interface MemberMapper {
	
	// 会員を登録しなす。
	public int memberInsert(MemberDto dto);
	
	// メンバーのメールの重複を確認します。
	public int memberEmailCheck(String email);
	
	// メールを利用してuser_idを持ってきます。
	public int memberUserIdGet(String email);
	
//	// ログインのためにメールとパスワードを利用して照会します。
//	public MemberDto memberLogin(MemberDto dto);
}
