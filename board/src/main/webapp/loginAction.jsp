<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="User" class="user.User" scope="page" />
<jsp:setProperty name="User" property="userId" />
<jsp:setProperty name="User" property="userPw" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹 사이트</title>
</head>
<body>
	<%  
		// 로그인 한 사람은 회원가입 페이지에 접근할 수 없도록 만든다. 
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userSId");
		}
		if (userId != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		
		UserDAO userDAO = new UserDAO();
		//login.jsp 에서 id와 password를 받아온다.
		int result = userDAO.login(User.getUserId(), User.getUserPw());
		
		if ( result == 1 ){
				session.setAttribute("userId", User.getUserId());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
		}
		else if (result == 0 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
		else if( result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디가 존재하지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
		else if( result == -2 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('database에 오류가 발생하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}		
	%>
</body>
</html>