<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page session="true" %>

<html>
<head>
	<meta charset="UTF-8">
	<title>コミュニティーシステム</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
	* { margin : 0; padding : 0; }
	a { text-decoration : none; color : #222 }

	header { padding : 22px 0; background : RGB(255, 109, 45);}
	header h1 { text-align : center; }
	
	nav { 
		background : #ccc;
		padding : 8px 2px;
		display : flex;
		justify-content : center;
		gap : 30px;
	}

	section { text-align : center; min-height : 480px; height : auto; padding : 22px; overflow : hidden;}
	
	footer { padding : 22px 0; text-align : center; background-color : RGB(255, 109, 45);}
	
	table, th, td { border : 1px solid #888; }
	
	table { margin : 0 auto; width : 880px; }

	
</style>

<script>
	var loginUser = "";
	<sec:authorize access = "isAuthenticated()">
		loginUser = '<sec:authentication property="principal.username" />';
	</sec:authorize>
	
	function htmlDecode(html) {
		var txt = document.createElement("textarea");
		txt.innerHTML = html;
		return txt.value;
	}
	
	if(loginUser) {
		loginUser = htmlDecode(loginUser);
	}

	function isDeWriter() {
		if(del.writer.value == del.user.value) {
			if(window.confirm(" * 本当に削除しますか？")) {
				return true;
			} else {
				return false;
			}
		} else {
			alert("作成者しかできません。");
			return false;
		}
	}
	
	function isUpWriter() {
		if(udt.writer.value == udt.user.value) {
			if(window.confirm(" - 修正しますか？")) {
				return true;
			} else {
				return false;
			}
		} else {
			alert("作成者しかできません。");
			return false;
		}
	}
</script>

</head>

<body>
	<header>
		<h1>コミュニティーシステム</h1>
	</header>
		
	<nav>
	<sec:authorize access="isAuthenticated()">
		<p><sec:authentication property="principal.username" /> 様</p>
		<form class="logout_form" method="post" action="/logout.do">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<input type="submit" id="logout" value="ログアウト">
		</form>
		<a href="/mypage">Mypage</a>
	</sec:authorize>
	
	<sec:authorize access="isAnonymous()">
		<a href="/login">Login</a>
		<a href="/join">Join</a>
	</sec:authorize>
	
		<a href="/">Home</a>
	</nav>
	
	<section>
		 <h2 style="margin-bottom : 22px;">記事詳細</h2>
		 	<table>
		 		<tr>
		 			<th>タイトル</th>
			 		<td colspan = "4">
			 			<p>${view.title}</p>
			 		</td>
		 		</tr>
		 		<tr>
		 			<th>ディテール</th>
		 			<td>ビューズ : ${view.views}</td>
		 			<td>作成者 : ${view.email}</td>
		 			<td>作成日時 : <fmt:formatDate var="resultCreated" value="${view.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/>${resultCreated}</td>
		 			<td>修正日時 : <fmt:formatDate var="resultUpdated" value="${view.updated_at}" pattern="yyyy-MM-dd HH:mm:ss"/>${resultUpdated}</td>
		 		</tr>
		 		<tr>
		 			<th>コンテンツ</th>
		 			<td colspan = "4" style ="height : 222px;">${view.content}</td>
		 		</tr>
		 		<tr>
					<td colspan="5" style ="text-align : center; gap = 80px;">
						<input type = "button" value = "リスト" onclick="location.href='/'">
						
						<sec:authorize access="isAuthenticated()">
							<form name="del" method="post" action="/board/delete/${view.post_id}" onsubmit="return isDeWriter()">
								<input type = "hidden" name = "${_csrf.parameterName}" value = "${_csrf.token}" >
								<input type = "hidden" name = "writer" value = "${view.email}" >
								<input type = "hidden" name = "user" value = "<sec:authentication property="principal.username" />" >
								<input type = "submit" value = "デリート">
							</form>
							
							<form name="udt" method="post" action="/board/update/${view.post_id}" onsubmit="return isUpWriter()">
								<input type = "hidden" name = "${_csrf.parameterName}" value = "${_csrf.token}" >
								<input type = "hidden" name = "writer" value = "${view.email}" >
								<input type = "hidden" name = "user" value = "<sec:authentication property="principal.username" />" >
								<input type = "submit" value = "モディファイ">
							</form>
						</sec:authorize>
					</td>
				</tr>
		 	</table>
		 	
		 	<div style = "width : 880px; margin : 0 auto;">
		 		<br>
		 		
		 		<div style = "border-radius : 8px; border : 2px solid silver;"><br>
		 			<div style = "text-align : center;"><strong>コメント作成</strong></div>
		 				<sec:authorize access="isAuthenticated()">
				 			<div>
				 				<label style = "padding : 15px">作成者</label><input type = "text" style = "border : 1px solid #ccc; border-radius : 15px; width : 80%; height : 40px; margin : 10px; padding : 10px;" id = "comment_writer" name = "comment_writer" value="<sec:authentication property="principal.username" />" READONLY>
				 			</div>
						</sec:authorize>
	
						<sec:authorize access="isAnonymous()">
				 			<div>
				 				<label style = "padding : 15px">作成者</label><input type = "text" style = "border : 1px solid #ccc; border-radius : 15px; width : 75%; height : 40px; margin : 10px; padding : 10px;" id = "comment_writer" name = "comment_writer" value="ログインが必要な機能です。" READONLY>
				 			</div>
						</sec:authorize>
		 			<div>
		 				<label style = "padding : 15px">コメント内容</label><textarea style = "border : 1px solid #ccc; border-radius : 15px; width : 88%; height : 80px; margin : 10px; padding : 10px;" id = "comment_content" name = "comment_content"></textarea>
		 			</div>
		 			<div style = "float:right; padding:10px;">
						<button id ="registCommentBtn" style = "height : 48px; width : 64px; border-radius : 22px;">保存</button>
		 			</div>
		 			<br><br><br>
		 		</div>
		 		<br>
		 		<div>
		 			<ul class = "chat" style = "padding-left : 0px; list-style : none;">
		 			</ul>
		 		</div>	
		 	</div>
		 	
			<script>
				var csrfHeaderName = "${_csrf.headerName}";
				var csrfTokenValue = "${_csrf.token}";
			
				var commentService = (function() {
					
					function add(comment, callback, error) {
						$.ajax({
							type: 'POST',
							url: '/comment/new',
							data: JSON.stringify(comment),
							contentType: "application/json; charset=UTF-8",
							beforeSend: function(xhr) {
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success: function(result, status, xhr) {
								if(callback) {
									callback(" - 登録されました。");		
								}
							},
							error: function(xhr, status, er) {
								if(error) {
									error(er);	
								}
							}
						});
					}
					
					function getList(param, callback, error) {
						var postId = param.post_id;
						
						$.getJSON("/comment/" + postId,
							function(data) {
								if(callback) {
									callback(data);
								}
						}).fail(function(xhr, status, err) {
							if(error) {	error(err);	}
						});
					}
					
					function update(comment, callback, error) {
						console.log("comment_id : " + comment.comment_id);
						
						$.ajax({
							type: 'PUT',
							url: '/comment/' + comment.comment_id,
							data: JSON.stringify(comment),
							contentType: "application/json; charset=UTF-8",
							beforeSend: function(xhr) {
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success: function(result, status, xhr) {
								if(callback) {
									callback(result);		
								}
							}, error: function(xhr, status, er) {
								if(error) {
									error(er);	
								}
							}
						});
					}
					
					function remove(comment_id, callback, error) {
						
						$.ajax({
							type: 'DELETE',
							url: '/comment/' + comment_id,
							beforeSend: function(xhr) {
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success: function(deleteresult, status, xhr) {
								if(callback) {
									callback(deleteresult);		
								}
							}, error: function(xhr, status, er) {
								if(error) {
									error(er);	
								}
							}
						});
					}
					
					return {
						add: add,
						getList: getList,
						update: update,
						remove: remove
					};
					
				})();
			
			</script>
		 	
		 	<script>
		 		$(document).ready(function() {
		 			var postId = '<c:out value="${view.post_id}"/>';
		 			var commentUL = $(".chat");
		 			
		 			window.showCommentList = function() {
		 				commentService.getList(
		 					{ post_id : postId },
		 					function(list) {
		 						var str = "";
		 						
								console.log("Current Login User : ", loginUser);
		 						
		 						if(list == null || list.length == 0){
		 							commentUL.html("<li style='padding : 10px; text-align : center;'>登録されたコメントがありません。</li>");
		 							return;
		 						}
		 						
		 						for(var i=0, len=list.length || 0; i<len; i++) {
		 							console.log("Comment Writer [" + i + "] : ", list[i].email);
		 							var dateObj = new Date(list[i].created_at);
		 							var formattedDate = dateObj.getFullYear() + "-" +
		 								("0" + (dateObj.getMonth() + 1)).slice(-2) + " " +
		 								("0" + dateObj.getDate()).slice(-2) + "-" +
		 								("0" + dateObj.getHours()).slice(-2) + ":" +
		 								("0" + dateObj.getMinutes()).slice(-2) + ":" +
		 								("0" + dateObj.getSeconds()).slice(-2);
		 							
		 							str += "<li id='comment_item_" + list[i].comment_id + "' style='border : 1px solid #ccc; border-radius : 4px; margin-bottom : 10px;'>";
		 							str += "<div style = 'padding : 10px;'>作成者 : <strong> " + list[i].email + "</strong><small style='float : right;'>";
		 							str += "作成日時 : " + formattedDate + "</small></div>";
		 							str += "<p id='content_text_" + list[i].comment_id + "' style = 'padding : 10px; margin : 0;'>" + list[i].content + "</p>";
									
		 							if(loginUser.trim().toLowerCase() === list[i].email.trim().toLowerCase()) {
			 							str += "<div><input type = 'button' onclick='commentUpdate(" + list[i].comment_id + ", `" + list[i].content + "`)' value = 'モディファイ' style = 'float : right; width : 100px; height : 32px; border-radius : 22px; margin-right : 16px; cursor : pointer;'>"
				 						str += "<input type = 'button' class='commentDeleteBtn' data-delete='" + list[i].comment_id + "' value='デリート' style = 'float : right; width : 80px; height : 32px; border-radius : 22px; margin-right : 16px; cursor : pointer;'><br><br></div>";
		 							}
		 							
		 							str += "</li><br>";
		 						}
		 						
		 						commentUL.html(str);
		 						$("input:button.commentDeleteBtn").on('click', commentDeleteBtn)
		 					}
		 				)
		 			};
		 			
		 			window.showCommentList();
		 			
		 			$('#registCommentBtn').click(function() {
		 				var registCommentWriter = document.getElementById('comment_writer').value.trim();
		 				var registCommentContent = document.getElementById('comment_content').value.trim();
		 				
		 				if(registCommentWriter == "" || registCommentContent == "") {
		 					alert(" * 項目を書いてくたさい。");
		 				}　else {
		 					var comment = {
		 							post_id : postId,
		 							email : registCommentWriter,
		 							content : registCommentContent
		 					};
		 					
		 					commentService.add(
		 						comment,
		 						function(result) {
		 							alert(result);
		 							showCommentList();
		 							$('#comment_content').val("");
		 						}
		 					);
		 				}
		 			})
		 			
		 			// JQueryの付与された属性の伝達
		 			function commentDeleteBtn() {
		 				var commentId = $(this).attr("data-delete");
		 				
		 				if(window.confirm(" * 本当に削除しますか？")) {
		 					commentService.remove(
				 					commentId,
				 					function(result) {
										if(result === "success") {
											alert(" - 削除成功");
											window.showCommentList();
										}
				 					}, function(err) {
				 						alert(" * Error");
				 					}
				 				);
		 					return true;
		 				} else {
		 					return false;
		 				}
		 			}
		 		});
		 		
		 		function commentUpdate(comment_id, content) {
	 				let cmt = "";
	 				
	 				cmt += "<li style='margin-bottom : 10px; list-style : none;'>";
	 				cmt += "<small style='float : right; padding : 8px;'>モディファイモード</small></div>";
	 				cmt += "<input type='text' id='content_" + comment_id + "' style = 'height : 80px; width : 80%; padding : 8px; margin : 22px;' value = '"+ content + "'>";

	 				cmt += "<div><input type = 'button' class='commentUpdateBtn' onclick='commentUpdatePro(" + comment_id + ")' value='セーブ' style = 'float : right; width : 80px; height : 32px; border-radius : 22px; margin-right : 16px; cursor : pointer;'>";
	 				cmt += "<input type = 'button' onclick='showCommentList()' value = 'キャンセル' style = 'float : right; width : 80px; height : 32px; border-radius : 22px; margin-right : 16px; cursor : pointer;'<br><br></div>";
						
	 				cmt += "</li><br>";
	 				
	 				$("#comment_item_" + comment_id).html(cmt);
	 			}
	 			
	 			// JQueryの「onclick」属性を直接伝達
	 			function commentUpdatePro(comment_id) {
	 				let updateContent = $('#content_' + comment_id).val();
	 				let comment = {
	 						comment_id: comment_id,
	 						content: updateContent
	 				}
					
	 				commentService.update(
	 					comment,
	 					function(result) {
							if(result === "success") {
								alert(" - 修正成功");
								window.showCommentList();
							}		 						
	 					}, function(err) {
	 						alert(" * Error");
	 						console.error(err);
	 					}
		 			);
	 			}
		 	
		 	</script>
		 	
	</section>
	
	<footer>
		<p>DEVFOX onboarding 課題、掲示板<br>朴潤正 / PARK YUNJEONG</p>
	</footer>

</body>
</html>