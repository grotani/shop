<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 세션 변수 
	if(session.getAttribute("loginCustomer") == null) { 
		response.sendRedirect("/shop/customer/loginForm.jsp"); 
		return;
	}	
%>    
<%
	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	System.out.println(mail);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>비밀번호 변경</h1>
	<form method="post" action="/shop/customer/editPwAction.jsp">
		<div>
			name 
			<input type="text" name="name" value="<%=name%>" readonly="readonly">
		</div>
		<div>
			mail 
			<input type="text" name="mail" value="<%=mail%>" readonly="readonly">
		</div>
		<div>
			이전 비밀번호
			<input type="password" name="oldPw">
		</div>
		<div>
			변경할 비밀번호
			<input type="password" name="newPw">
		</div>
			<button type="submit">비밀번호수정</button>
	</form>

</body>
</html>