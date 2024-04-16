<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="shop.dao.*" %>

<%
	String mail = request.getParameter("mail");
	System.out.println(mail);

	boolean result = CustomerDAO.checkMail(mail);

	if(result == false) {
		System.out.println("회원가입 불가능");
		System.out.println(mail);
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?mail="+mail+"&cm=x");
		
	} else {
		System.out.println("회원가입 가능");
		System.out.println(mail);
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?mail="+mail+"&cm=o");
	}

%>

