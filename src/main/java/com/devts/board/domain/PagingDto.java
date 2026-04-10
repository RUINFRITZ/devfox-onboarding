package com.devts.board.domain;

public class PagingDto {

	private int pageNum;
	private int pageAmount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	
	private String searchType;
	private String searchWord;
	
	public PagingDto(int pageNum, int pageAmount, String searchType, String searchWord, int total) {
		this.pageNum = pageNum;
		this.pageAmount = pageAmount;
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.total = total;
		
		this.endPage = (int)Math.ceil(this.pageNum/5.0) * 5;
		this.startPage = this.endPage - 4;
		
		int tmpEndPage = (int)Math.ceil((total*1.0)/pageAmount);
		
		if(this.endPage > tmpEndPage) this.endPage = tmpEndPage;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < tmpEndPage;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageAmount() {
		return pageAmount;
	}

	public void setPageAmount(int pageAmount) {
		this.pageAmount = pageAmount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
}
