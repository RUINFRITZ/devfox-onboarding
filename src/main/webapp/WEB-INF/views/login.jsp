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
		if(login.email.value.trim() == "") {
			alert("メールを入力してください。");
			login.email.focus();
			return false;
		}
		if(login.password.value.trim() == "") {
			alert("パスワードを入力してください。");
			login.password.focus();
			return false;
		}
		
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
		 <h2 style = "margin-bottom: 22px;">Member login</h2>
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
					<td colspan="2" style="text-align : center;">
						<input type = "submit" value = "ログイン">
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