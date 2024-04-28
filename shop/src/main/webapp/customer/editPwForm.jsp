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
	// 비밀번호 변경시 이전 사용이력 있는지 확인하고 이전 비밀번호 사용 불가
	String pw = request.getParameter("pw");
	if(pw == null) {
		pw = "";
		
	}
	String ckPw = request.getParameter("ckPw");
	if(ckPw == null) {
		ckPw = "";
	}
	String msg = "";
	if(ckPw.equals("o")) {
		msg = "변경가능한 비밀번호입니다.";
	} else if(ckPw.equals("x")) {
		msg = "이전 사용 비밀번호로 변경이 불가능합니다";
	}
	
	// 디버깅
	System.out.println(pw+"<==newPw");
	System.out.println(ckPw+"<==ckPw");

%>  
<%
	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	System.out.println(mail + "<=이메일");
	System.out.println(name + "<=사용자 이름");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>비밀번호 변경</h1>
	<form method="post" action="/shop/customer/checkPwAction.jsp?name=<%=name%>+mail=<%=mail%>">	
		<div>
			비밀번호 변경가능 확인
			<input type="password" name="pw" value="<%=pw%>">
			<span><%=msg %></span>
			<button type="submit">가능확인</button>
		</div>
	</form>	
		<form method="post" action="/shop/customer/editPwAction.jsp">
		<div>
			name			
			<input type="text" name="name" value="<%=name%>" readonly="readonly">
			<input type="hidden" name="name" value="<%=name%>">
		</div>
		<div>
			mail 
			<input type="text" name="mail" value="<%=mail%>" readonly="readonly">
			<input type="hidden" name="mail" value="<%=mail%>">
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