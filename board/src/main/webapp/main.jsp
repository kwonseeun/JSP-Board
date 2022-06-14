<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<title>login</title>
</head>
<body>
	<!--  로그인이 된 사람은 로그인정보를 담을 수 있도록 만들어 주겠습니다. -->
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="#">포스터 분석</a></li>
				<li><a href="#">포스터 카테고리</a></li>
				<li><a href="#">통계</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
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
	
	<!-- 일반적으로 웹사이트를 소개하는 영역이 있는데 부트스랩에서 jumbotron이라고 사용을 합니다. -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1> web site</h1>
				<p> 이 웹 사이트는 부트스트랩으로 만든 JSP 웹 사이트 입니다. 최소한의 간단한 로직만을 이용해서 개발했습니다. </p>
				<!-- 보통 웹페이지에 버튼이 하나씩 있는게 이뻐서 하나 넣어보았습니다. -->
				<p><a class="btn btn-primary btn-pull" href="main.jsp" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	
	<!-- carousel은 사진첩 같은거라고 생각 하시면 됩니다. -->
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			
			<div class="carousel-inner">
				<div class="item active"> <!-- active 현재 선택 -->
					<img src="images/1.png">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>

		<script src="https://code.jquery.com/jquery-1.11.3.js"
			integrity="sha256-IGWuzKD7mwVnNY01LtXxq3L84Tm/RJtNCYBfXZw3Je0="
			crossorigin="anonymous"></script>
</body>
</html>