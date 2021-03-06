<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , inital-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<title>글쓰기</title>
</head>
<body>
<	<!-- 로그인이 된 사람은 로그인정보를 담을 수 있도록 만들어 준다.  -->

<%
	String userId = null;
	if( session.getAttribute("userId") != null ){
			userId = (String) session.getAttribute("userId");
	}
%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Web Site</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="font.jsp">포스터 분석</a></li>
				<li><a href="posterCategory.jsp">포스터 카테고리</a></li>
				<li><a href="analisys.jsp">통계</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>

			<%
				//로그인이 되어 있지 않다면
				if (userId == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					role="button" aria-haspopup="true" data-toggle="dropdown"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					role="button" aria-haspopup="true" data-toggle="dropdown"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<!--  홀수와 짝수로 색상이 변경됨 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<!-- thead : 테이블의 제목부분 각각의 속성들을 알려주는 역할을 합니다. -->
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
								name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>

				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">

			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-1.11.3.js"
		integrity="sha256-IGWuzKD7mwVnNY01LtXxq3L84Tm/RJtNCYBfXZw3Je0="
		crossorigin="anonymous"></script>
</body>
</html>