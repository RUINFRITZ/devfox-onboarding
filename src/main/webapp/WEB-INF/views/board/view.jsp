<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
	
	table, th, td { border : 1px solid #888; }
	
	table { margin : 0 auto; width : 880px; }

	
</style>

<script>
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
	</section>
	
	<footer>
		<p>DEVFOX onboarding 課題、掲示板<br>朴潤正 / PARK YUNJEONG</p>
	</footer>

</body>
</html>