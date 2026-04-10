package com.devts.board.domain;

import java.util.Date;

public class CommentDto {

//	CREATE TABLE comments (
	private int comment_id; // INT NOT NULL AUTO_INCREMENT,
	private int post_id; // INT,
	private int user_id; // INT,
	private String content; // CONTENT,
	private Date created_at; // DATETIME DEFAULT CURRENT_TIMESTAMP,
	private Date is_deleted; // DATETIME DEFAULT NULL,
//	CONSTRAINT comments_pk PRIMARY KEY (comment_id),
//	CONSTRAINT cmmt_post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id),
//	CONSTRAINT ccmmt_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id)

	private String email;

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Date getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(Date is_deleted) {
		this.is_deleted = is_deleted;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
