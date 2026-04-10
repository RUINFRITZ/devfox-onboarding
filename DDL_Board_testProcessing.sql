INSERT INTO users (email, password, nickname, point) VALUES ('test@devfox.com', 1234, 'foxfox', 0);

SELECT * FROM users;
SELECT email FROM users where email = "foxfox@fox.com";

ALTER TABLE users DROP COLUMN is_active;
ALTER TABLE users ADD COLUMN is_active TINYINT DEFAULT 1;

INSERT INTO posts (user_id, title, content) VALUES (2, 'この１ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (2, 'この２ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (1, 'その３ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (1, 'その４ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (3, 'あの５ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (3, 'あの６ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (2, 'どの７ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (2, 'どの８ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (1, 'この９ギジュッツ大丈夫ですか', 'paging Dummy');
INSERT INTO posts (user_id, title, content) VALUES (1, 'この１０ギジュッツ大丈夫ですか', 'paging Dummy');
rollback;
commit;

SELECT * FROM posts;
SELECT * FROM posts WHERE is_deleted IS NULL ORDER BY created_at DESC;
SELECT * FROM posts WHERE post_id = 2 AND is_deleted IS NULL;
SELECT * FROM posts WHERE post_id = "2";
UPDATE posts SET is_deleted=now() WHERE post_id = 2;
UPDATE posts SET title='test', content='test', updated_at=now() WHERE post_id = 2;

SELECT post_id, p.user_id as user_id, title, content, views, likes, p.created_at as created_at, u.email as email
FROM posts as p LEFT JOIN users as u
ON p.user_id = u.user_id
WHERE is_deleted IS NULL
ORDER BY created_at DESC;

SELECT user_id FROM users WHERE email = 'foxfox@fox.com';
SELECT count(*) FROM users WHERE email= 'foxfox@fox.com';
SELECT post_id, p.user_id as user_id, title, content, views, likes,  p.created_at as created_at, u.email as email
FROM posts as p LEFT JOIN users as u 
ON p.user_id = u.user_id
WHERE post_id = 2 AND is_deleted IS NULL;

SELECT @@time_zone;

INSERT comments (post_id, user_id, content) VALUE (2, 2, 'test');
INSERT comments (post_id, user_id, content) VALUE (4, 2, 'test2');

SELECT c.comment_id, c.post_id, c.user_id, c.content, c.created_at, u.email as email
FROM comments as c LEFT JOIN users as u
ON c.user_id = u.user_id
WHERE is_deleted IS NULL AND c.post_id = 4
ORDER BY c.created_at DESC;

UPDATE comments SET content = 'testtest' WHERE comment_id = 2; 