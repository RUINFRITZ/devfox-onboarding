package com.devts.board.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.devts.board.domain.MemberDto;
import com.devts.board.mapper.MemberMapper;

@Service("com.devts.board.service.MemberService")
public class MemberService {
	
	// Member Mapper 依存性注入
	@Resource(name = "com.devts.board.mapper.MemberMapper")
	MemberMapper mMemberMapper;
	
	// 会員を登録しなす。
	public int memberInsertService(MemberDto member) {
		return mMemberMapper.memberInsert(member);
	}
	
	// メンバーのメールの重複を確認します。
	public int memberEmailCheck(String email) {
		return mMemberMapper.memberEmailCheck(email);
	}
	
	// メールを利用してuser_idを持ってきます。
	public int memberUserIdGet(String email) {
		return mMemberMapper.memberUserIdGet(email);
	}
}
