<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
0
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
	
	table { margin : 0 auto; width : 800px; }
		
</style>
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
		 <h2>掲示板</h2><br>
		 <h4><c:if test="${pageMaker.searchWord!=''}">"${pageMaker.searchWord}" 検索結果</c:if></h4>
		 <table>
		 	<tr>
		 		<th>No.</th>
		 		<th>タイトル</th>
		 		<th>ビューズ</th>
		 		<th>作成者</th>
		 		<th>作成日</th>
				<th>
					<sec:authorize access="isAuthenticated()">
						<input type="button" style = "padding : 4px;" onclick ="location.href='/board/write'" value = "記事作成"/>
					</sec:authorize>
				</th>
		 	</tr>
		 	<c:forEach var="i" items="${list}">
		 		<tr style ="cursor : pointer;" onclick="location.href='/board/view/${i.post_id}?searchType=${pageMaker.searchType}&searchWord=${pageMaker.searchWord}&pageNum=${pageMaker.pageNum}&pageAmount=${pageMaker.pageAmount}'">
		 			<td>${i.post_id}</td>
		 			<td>${i.title}</td>
		 			<td style="text-align : center;">${i.views}</td>
		 			<td>${i.email}</td>
		 			<td colspan="3" style="text-align : center;">
						<fmt:formatDate var="resultCreated" value="${i.created_at}" pattern = "yyyy-MM-dd"/>${resultCreated}		 				
		 			</td>
		 		</tr>
		 	</c:forEach>
		 </table>
		 <br>
		 
		 <div align="center" style="font-size : 22px;">
		 	<c:if test="${pageMaker.prev}">
		 		<a href="/?searchType=${pageMaker.searchType}&searchWord=${pageMaker.searchWord}&pageNum=${pageMaker.startPage - 1}&pageAmount=${pageMaker.pageAmount}">%lt;</a>
		 	</c:if>
		 	
		 	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" step="1">
		 		<span style = "color : RGB(255, 109, 45);"><c:if test="${num == pageMaker.pageNum}">${num}</c:if></span>
		 		<c:if test="${num != pageMaker.pageNum}">
		 			<a href="/?&searchType=${pageMaker.searchType}&searchWord=${pageMaker.searchWord}&pageNum=${num}&pageAmount=${pageMaker.pageAmount}">${num}</a>
		 		</c:if>
		 	</c:forEach>
		 	
		 	<c:if test="${pageMaker.next}">
		 		<a href="/?searchType=${pageMaker.searchType}&searchWord=${pageMaker.searchWord}&pageNum=${pageMaker.startPage + 1}&pageAmount=${pageMaker.pageAmount}">%gt;</a>
		 	</c:if>
		 	
		 </div>
		 <br>
		 
		 <form method="get" action="/">
		 	<div>
				<select name="searchType">
					<option value="" <c:out value="${pageMaker.searchType==''? 'selected':''}"/>>All</option>
					<option value="title" <c:out value="${pageMaker.searchType=='title'? 'selected':''}"/>>タイトル</option>
					<option value="content" <c:out value="${pageMaker.searchType=='content'? 'selected':''}"/>>コンテンツ</option>
				</select>
				<input type = "text" name = "searchWord" value = "${pageMaker.searchWord}">
				<input type = "hidden" name = "pageNum" value = "${pageMaker.pageNum}">
				<input type = "hidden" name = "pageAmount" value = "${pageMaker.pageAmount}">
				<input type = "submit" value = "検索">
			</div>
		 </form>
		 
	</section>
	
	<footer>
		<p>DEVFOX onboarding 課題、掲示板<br>朴潤正 / PARK YUNJEONG</p>
	</footer>

</body>
</html>