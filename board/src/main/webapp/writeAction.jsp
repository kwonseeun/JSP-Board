<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<title>글쓰기</title>
</head>
<body>
	<%
		String userId = null;
			if(session.getAttribute("userId") != null) {
				userId = (String) session.getAttribute("userId");
			}
			if (userId == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('로그인을 하세요.')");
					script.println("location.href='login.jsp'");
					script.println("</script>");
			} else {
				if(bbs.getBbsTitle() == null || bbs.getBbsTitle() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userId, bbs.getBbsContent());
					
					if (result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("<alert('글쓰기에 실패했습니다. ')");
						script.println("history.back()");
						script.println("</script>");
						
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href='bbs.jsp'");
						script.println("</script>");
					}
				}
			}
	%>
	
	<script src="https://code.jquery.com/jquery-1.11.3.js"
		integrity="sha256-IGWuzKD7mwVnNY01LtXxq3L84Tm/RJtNCYBfXZw3Je0="
		crossorigin="anonymous"></script>
</body>
</html>