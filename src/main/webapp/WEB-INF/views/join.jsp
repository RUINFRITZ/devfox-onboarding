<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page session="true" %>

<html>
<head>
	<meta charset="UTF-8">
	<title>コミュニティーシステム</title>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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

	section { text-align : center; height : 480px; padding : 22px;}
	
	footer { padding : 22px 0; text-align : center; background-color : RGB(255, 109, 45);}
	
	table, th, td { border : 1px solid #bbb }
	table { margin : 0 auto; width : 400px; }
</style>

<script>
	function check() {
		if(join.email.value.trim() == "") {
			alert(" * メールを入力してください。");
			join.username.focus();
			return false;
		}
		if(join.password.value.trim() == "") {
			alert(" * パスワードを入力してください。");
			join.password.focus();
			return false;
		}
		if(join.password2.value.trim() == "") {
			alert(" * パスワード確認を入力してください。");
			join.password2.focus();
			return false;
		}
		if(join.password2.value != join.password.value) {
			alert(" * パスワード入力が一致しません。");
			join.password2.focus();
			return false;
		}
		if(join.nickname.value.trim() == "") {
			alert(" * ニックネームを入力してください。");
			join.nickname.focus();
			return false;
		}
		
		if(document.getElementById('is_email_exist').value === 'n') {
			alert(" * メールチェッくをおねがいします。");
			return false;
		}
		
		alert(" - ご登録を歓迎いたします。");
		return true;
	}
	
	$(document).ready(function() {
		var msg = "${msg}";
		
		if(msg === "ERROR_DUPLICATE") {
			alert(" * すでに存在する会員です。");
			$("#email").focus();
		} else if (msg === "JOIN_SUCCESS") {
			alert(" - ありがとうございます。ログインしてください。");
		}
	})
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
		 <h2 style = "margin-bottom: 22px;">Member Join</h2>
		 <form name="join" method="post" action="/join.do" onsubmit="return check()">
		 	<table>
				<tr>
					<th>E-mail</th>
					<td>
						<input type="hidden" name="is_email_exist" id="is_email_exist" value="n">
						<input type="email" name="email" id="email"><input type="button" id="emcheck" value="メールチェッく"><br>
						<p id = "emcheckmsg"></p>
					</td>
				</tr>		 	
				<tr>
					<th>Password</th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<th>Password確認</th>
					<td><input type="password" name="password2"></td>
				</tr>
				<tr>
					<th>Nickname</th>
					<td>
						<input type="text" name="nickname">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align : center;">
						<input type = "submit" value = "登録">
					</td>
				</tr>		 	
		 	</table>
		 </form>
	</section>
	
	<footer>
		<p>DEVFOX onboarding 課題、掲示板<br>朴潤正 / PARK YUNJEONG</p>
	</footer>

	<script>
	
		$(function() {
			$('#emcheck').on('click', function() {
				const emailVal = $('#email').val().trim();
				if(emailVal === '') {
					alert(" * メールを入力してください。");
					$('#email').focus();
					return false;
				}
				
				$.ajax({
					url: '/emailcheck',
					type: 'GET',
					data: { email: emailVal },
					success: function(result) {
						if(result.toString().trim() === "0") {
							$('#emcheckmsg').html("<b style = 'color : blue'>使用可能なメールです。</b>");
							$('#is_email_exist').val('y');
						} else {
							$('#emcheckmsg').html("<b style = 'color : red'>使用されているメールです。</b>");
							$('#is_email_exist').val('n');
						}
					},
					error: function(xhr, status, error) {
						console.error(" * Ajax ERROR : ", error);
						alert(" * サーバーエラーです。");
					}
				})
			});
			
			$("#email").on('keyup', function() {
				$('#is_email_exist').val("n");
				$('#emcheckmsg').html("");
			});
		});
		
	</script>
</body>
</html>