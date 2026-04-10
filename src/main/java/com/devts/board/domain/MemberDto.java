package com.devts.board.domain;

import java.util.Date;

public class MemberDto {
	
	private int user_id; // INT NOT NULL AUTO_INCREMENT,
    private String email; // VARCHAR(64) UNIQUE,
    private String password; // VARCHAR(256) NOT NULL,
    private String nickname; // VARCHAR(32) UNIQUE,
    private int point; // int,
    private String role; // VARCHAR(16) DEFAULT 'USER',
    private Date created_at; // DATETIME DEFAULT CURRENT_TIMESTAMP,
    private int is_active; // DATETIME DEFAULT CURRENT_TIMESTAMP,
    // CONSTRAINT users_pk PRIMARY KEY (user_id)
    
    public MemberDto() {
    	
    }
    
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}

	public int getIs_active() {
		return is_active;
	}

	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
    
}
