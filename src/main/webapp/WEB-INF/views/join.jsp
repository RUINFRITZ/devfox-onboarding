<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<html>
<head>
	<meta charset="UTF-8">
	<title>コミュニティーシステム</title>

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
			alert("メールを入力してください。");
			join.email.focus();
			return false;
		}
		if(join.password.value.trim() == "") {
			alert("パスワードを入力してください。");
			join.password.focus();
			return false;
		}
		if(join.password2.value.trim() == "") {
			alert("パスワード確認を入力してください。");
			join.password2.focus();
			return false;
		}
		if(join.password2.value == join.password.value) {
			alert("パスワード入力が一致しません。");
			join.password2.focus();
			return false;
		}
		if(join.nickname.value.trim() == "") {
			alert("ニックネームを入力してください。");
			join.nickname.focus();
			return false;
		}
		
		alert("ご登録を歓迎いたします。");
		return true;
	}
</script>
</head>

<body>
	<header>
		<h1>コミュニティーシステム</h1>
	</header>
	
	<nav>
	<%
	String userid = (String) session.getAttribute("loginid");
	
	if(userid != null) { // ロぐイン状態判別
	%>
		<p><%= userid %></p>
		<a href="/logout.do">Logout</a>
		<a href="/mypage">Mypage</a>
	<%
	} else {
	%>	
		<a href="/login">Login</a>
		<a href="/join">Join</a>
	<%
	}
	%>
		<a href="/">Home</a>
		<form class="search_form" method="post" action="/search.do">
			<input type=text name=search>
			<input type = "submit" value = "検索">
		</form>
	</nav>
	
	<section>
		 <h2 style = "margin-bottom: 22px;">Member Join</h2>
		 <form name="login" method="post" action="/login.do" onsubmit="return check()">
		 	<table>
				<tr>
					<th>E-mail</th>
					<td><input type="email" name="email"></td>
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
					<td><input type="text" name="Nickname"></td>
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

</body>
</html>