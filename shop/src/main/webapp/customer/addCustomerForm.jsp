<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	
	String checkMail = request.getParameter("checkMail");
	if(checkMail == null) {
		checkMail = "";
	}
	String cm = request.getParameter("cm");
	if(cm == null) {
		cm = "";
	}
	String msg = "";
	if(cm.equals("o")) {
		msg = "회원가입이 가능합니다";
	} else if(cm.equals("x")) {
		msg = "중복된 이메일 회원가입이 불가능합니다.";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>회원가입</h1>
	
	<div>
	<form method="post" action="/shop/customer/checkIdAction.jsp">
		<div>
			mail 확인:
			<input type="email" name="checkMail" value="<%=checkMail%>"> 
			<span><%=msg %></span>
			<button type="submit">중복확인</button>
		</div>
		
	</form>	
	<form method="post" action="/shop/customer/addCustomerAction.jsp"> 
		<div>
			mail :
			<%
				if(cm.equals("o")) {
			%>
				<input value="<%=checkMail %>" type="text" name="mail" readonly="readonly">
			<% 		
				} else {
			%>
				<input type="email" name="mail" readonly="readonly">
			<% 		
				}
			%>
		</div>
		<div>
			pw :
			<input type="password" name="pw">
		</div>
		<div>
			이름 :
			<input type="text" name="name">
		</div>
		<div>
			생일 :
			<input type="date" name="birth">
		</div>
		<div>
			성별 :
			<input type="radio" name="gender" value="남">남
			<input type="radio" name="gender" value="여">여
		</div>
		<button type="submit">회원가입</button>
	</div>
	</form>
</body>
</html>