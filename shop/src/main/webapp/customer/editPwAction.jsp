<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	if(session.getAttribute("loginCustomer") == null) { 
		response.sendRedirect("/shop/customer/loginForm.jsp"); 
		return;
	}	
	
%>

<%
	
	// 비밀번호 변경
	String name = request.getParameter("name");
	name = URLEncoder.encode(name,"utf-8");
	String mail = request.getParameter("mail");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	System.out.println(mail);
	System.out.println(oldPw + "<==oldPw");
	System.out.println(newPw + "<==newPw");
	
	
	int row = CustomerDAO.updatePw(mail, oldPw, newPw);
	
	if(row == 1){//수정 성공
		System.out.println("비밀번호변경");
		String editPwMsg = URLEncoder.encode("비밀번호가 정상적으로 변경되었습니다.","utf-8");
		response.sendRedirect("/shop/customer/customerOne.jsp?name="+name);
		
	}else{
		System.out.println("비밀번호변경 실패");
		response.sendRedirect("/shop/customer/editPwForm.jsp");
		
	}
%>