<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%@page import="java.net.URLEncoder"%>

<%
	// 삭제요청값 
	request.setCharacterEncoding("UTF-8");
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	System.out.println(mail);
	System.out.println(pw);
	
	int row = CustomerDAO.deleteCustomer(mail, pw);
	
	if(row == 1) { // 탈퇴성공
		System.out.println("회원탈퇴성공");
		String deleteMsg = URLEncoder.encode("성공적으로 탈퇴 되었습니다.","utf-8");
		response.sendRedirect("/shop/customer/loginForm.jsp?deleteMsg="+deleteMsg);
		session.invalidate(); // 세션 초기화 
		
	} else {
		System.out.println("회원탈퇴 실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?mail="+mail);
	}
%>

