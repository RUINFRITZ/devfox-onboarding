CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(64) UNIQUE,
    password VARCHAR(256) NOT NULL,
    nickname VARCHAR(32) UNIQUE,
    point int,
    role VARCHAR(16) DEFAULT 'USER',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_pk PRIMARY KEY (user_id)
);

CREATE TABLE posts (
	post_id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(64),
    content TEXT,
    views INT DEFAULT 0,
    likes INT DEFAULT 0,
    is_deleted DATETIME DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT posts_pk PRIMARY KEY (post_id),
    CONSTRAINT posts_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE comments (
	comment_id INT NOT NULL AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted DATETIME DEFAULT NULL,
    CONSTRAINT comments_pk PRIMARY KEY (comment_id),
    CONSTRAINT cmmt_post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id),
    CONSTRAINT ccmmt_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE tags (
	tag_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(16) UNIQUE,
    CONSTRAINT tag_id_pk PRIMARY KEY (tag_id)
);

CREATE TABLE post_tags (
	post_id INT,
    tag_id INT,
    CONSTRAINT post_tags_pk PRIMARY KEY (post_id, tag_id),
    CONSTRAINT ptags_post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id),
    CONSTRAINT ptags_tag_id_fk FOREIGN KEY (tag_id) REFERENCES tags (tag_id)
);

CREATE TABLE likes (
	like_id INT NOT NULL AUTO_INCREMENT,
	post_id INT,
	user_id INT,
    CONSTRAINT likes_like_id_fk PRIMARY KEY (like_id),
	CONSTRAINT likes_post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id),
    CONSTRAINT likes_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT likes_like_uq UNIQUE (post_id, user_id)
);

CREATE TABLE bookmarks (
	bookmark_id INT NOT NULL AUTO_INCREMENT,
    post_id INT,
	user_id INT,
    CONSTRAINT bookmarks_bookmark_id_pk PRIMARY KEY (bookmark_id),
    CONSTRAINT bookmarks_post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id),
    CONSTRAINT bookmarks_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT bookmarks_bm_uq UNIQUE (post_id, user_id)
);