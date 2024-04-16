<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="shop.dao.*" %>

<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	// 디버깅 코드 
	System.out.println(mail);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(birth);
	System.out.println(gender);
	
	int row = CustomerDAO.insertCustomer(mail, pw, name, birth, gender);
	if(row == 1) {
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/customer/loginForm.jsp");
	} else {
		System.out.println("회원가입실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}

%>
