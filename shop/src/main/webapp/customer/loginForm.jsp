<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	if( session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/custGoodsList.jsp");
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
			
	%>
		<%=errMsg %>
	<% 
		} else if(logoutMsg != null) {
	%>
		<%=logoutMsg %>
	<% 		
		} 
	%>
	<div>
		<div>
		<form method="post" action="/shop/customer/loginAction.jsp">
			<table>
			<tr>
				<td>ID(email):</td>
				<td><input type="email" name="mail"></td>
			</tr>
			<tr>
				<td>PW:</td> 
				<td><input type="password" name="pw"></td>
			</tr>
			
			</table>
			<button type="submit">로그인</button>
		</form>
		</div>
	</div>
</body>
</html>