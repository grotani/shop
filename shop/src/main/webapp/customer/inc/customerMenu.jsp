<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
%>



<!-- 메뉴추가할때 사용하기 -->
<nav class="navbar navbar-expand-sm bg-dark  navbar-dark">
<div class="container-fluid">
			 <% 
                HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
                if (loginMember != null) {
            %>
            <ul class="navbar-nav">
            	<li class="nav-item">
            		<a class="nav-link" href="/shop/customer/custGoodsList.jsp">상품목록</a>
            	</li>
            	
            	<li>
                    <a  class="nav-link" href="/shop/customer/customerOne.jsp?name=<%= loginMember.get("name") %>&mail=<%=loginMember.get("mail")%>"><%= loginMember.get("name") %>님 반갑습니다</a>
            	</li>
            </ul>
            <% 
                }
            %>
</div>
</nav>