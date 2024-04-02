<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	
	
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println(loginEmp + "<=로그인ID");
	
	
	if(loginEmp != null) { 
		response.sendRedirect("/shop/emp/empList.jsp"); 
		return;
	}	
	
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>로그인</h1>
	
	<%
		if(errMsg != null) {
			// 로그인 하지 않았을때 에러 메세지 
	%>
		<%=errMsg %>
	<% 
		} else if(logoutMsg != null) {
	%>
		<%=logoutMsg %>
	<% 		
		} 
	%>
	
	<form method="post" action="/shop/emp/empLoginAction.jsp">
		<table>
		<tr>
			<td>ID:</td>
			<td><input type="text" name="empId"></td>
		</tr>
		<tr>
			<td>PW:</td> 
			<td><input type="password" name="empPw"></td>
		</tr>
		
		
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>