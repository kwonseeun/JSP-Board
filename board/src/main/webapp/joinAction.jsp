<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="java.io.PrintWriter"%>
<% 
	request.setCharacterEncoding("UTF-8");	
%>

<jsp:useBean id="User" class="user.User" scope="page" />
<jsp:setProperty name="User" property="userId"/>
<jsp:setProperty name="User" property="userPw"/>
<jsp:setProperty name="User" property="userName"/>
<jsp:setProperty name="User" property="userGender"/>
<jsp:setProperty name="User" property="userMail"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

</head>
<body>
	<% 
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if( userId != null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("history.href='main.jsp'");
			script.println("<script>");
			
		}
		if (User.getUserId() == null || User.getUserPw() == null || User.getUserName() == null ||
			User.getUserGender() == null || User.getUserMail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("history.back()");
			script.println("</script>");
				
		} else {
			UserDAO userDAO = new UserDAO();
			//login.jsp에서 id, pw를 받아온다. 
			int result = userDAO.join(User);
			if ( result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('아이디가 이미 존재합니다.')");
					script.println("history.back()");
					script.println("</script>");
			} else {	
					session.setAttribute("userId", User.getUserId());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='main.jsp'");
					script.println("</script>");
			}
		}
	
	%>

</body>
</html>