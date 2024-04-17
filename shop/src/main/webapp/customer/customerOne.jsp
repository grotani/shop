<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	// 로그인 세션 변수
	if( session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	String editPwMsg = request.getParameter("editPwMsg");
	String name = request.getParameter("name");
	
	System.out.println(name);
	
	ArrayList<HashMap<String,Object>> list = CustomerDAO.customerOne(name);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	</div>
	<!-- 메인내용 -->
	<h1>회원정보</h1>
		<% if(editPwMsg != null) { %>
		<div><%=editPwMsg %></div>
		<%	} %>
		<div>
			<%
				for(HashMap<String,Object> m : list) {
			%>
			<div>
				<div>mail :<%=(String)m.get("mail") %> </div>
				<div>name :<%=(String)m.get("name") %> </div>
				<div>birth :<%=(String)m.get("birth") %> </div>
				<div>gender :<%=(String)m.get("gender") %> </div>
				<div>updateDate :<%=(String)m.get("updateDate") %> </div>
				<div>createDate :<%=(String)m.get("createDate") %> </div>
				
			</div>
				<div>
					<a href="/shop/customer/updateCustomer.jsp?name=<%=(String)m.get("name") %>">회원정보수정</a>
				</div>
				<div>
					<a href="/shop/customer/editPwForm.jsp?mail=<%=(String)(m.get("mail")) %>&name=<%=(String)m.get("name") %>">비밀번호변경</a>
				</div>
				<div>
					<a href="/shop/customer/deleteCustomerAction.jsp?mail=<%=(String)(m.get("mail")) %>&pw=<%=(String)m.get("pw") %>">회원탈퇴</a>
				</div>
			<%
				}
			%>
		</div>
</body>
</html>