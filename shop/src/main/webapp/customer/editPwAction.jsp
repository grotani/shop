<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.*" %>
<%
	if(session.getAttribute("loginCustomer") == null) { 
		response.sendRedirect("/shop/customer/loginForm.jsp"); 
		return;
	}	
%>

<%

	// 비밀번호 변경
	
	String mail = request.getParameter("mail");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	
	int row = CustomerDAO.updatePw(mail, oldPw, newPw);
	
	if (row == 1) {
		
	}
%>