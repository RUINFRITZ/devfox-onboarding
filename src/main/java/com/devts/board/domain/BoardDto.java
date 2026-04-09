package com.devts.board.domain;

import java.util.Date;

public class BoardDto {

//	CREATE TABLE posts (
	private int post_id; // INT NOT NULL AUTO_INCREMENT,
	private int user_id; // INT,
	private String title; // VARCHAR(64),
	private String content; // TEXT,
	private int views; // INT DEFAULT 0,
	private int likes; // INT DEFAULT 0,
	private String is_deleted; // DATETIME DEFAULT NULL,
	private Date created_at; // DATETIME DEFAULT CURRENT_TIMESTAMP,
	private Date updated_at; // DATETIME DEFAULT CURRENT_TIMESTAMP,
//	CONSTRAINT posts_pk PRIMARY KEY (post_id),
//	CONSTRAINT posts_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id)
	
	private String email; // LEFT JOIN

	public BoardDto() {
		
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public String getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(String is_deleted) {
		this.is_deleted = is_deleted;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Date getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
}
