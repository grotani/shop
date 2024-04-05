<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>

<%
//DB 연결 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	String filename = request.getParameter("filename");
	System.out.println(filename + "이미지");
	String sql = "";
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>