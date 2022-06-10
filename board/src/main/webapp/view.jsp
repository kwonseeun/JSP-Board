<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
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
		
		int bbsId =0;
		if (request.getParameter("bbsId") != null){
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
		if (bbsId == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		//해당 글의 구체적인 내용을 가져오고, 유효한 글이라면 bbs에 담는다.
		Bbs bbs = new BbsDAO().getBbs(bbsId);
		
		
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
			
				<!--  홀수와 짝수로 색상이 변경됨 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<!-- thead : 테이블의 제목부분 각각의 속성들을 알려주는 역할을 합니다. -->
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserId()%></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14, 16)+"분"%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;">
							<!-- 글 내용에서 특수 문자를 보여주기 위한 추가 코딩 -->
							<%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%></td>
						</tr>

					</tbody>
					
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userId != null && userId.equals(bbs.getUserId())){
				%>
					<a href="update.jsp?bbsId=<%= bbsId %>" class="btn btn-primary">수정</a>
					<a href="deleteAction.jsp?bbsId=<%= bbsId %>" class="btn btn-primary">삭제</a>
				<% 
					}
				%>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-1.11.3.js"
		integrity="sha256-IGWuzKD7mwVnNY01LtXxq3L84Tm/RJtNCYBfXZw3Je0="
		crossorigin="anonymous"></script>

</body>
</html>