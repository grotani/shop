<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%

	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	System.out.println(mail + "<==mail");
	System.out.println(pw + "<==pw");
	
	
	boolean result = CustomerDAO.checkPw(mail, pw);
	
	if(result == false) {
		System.out.println("기존사용 비밀번호 변경 불가");
		System.out.println(pw);
		response.sendRedirect("/shop/customer/editPwForm.jsp?pw="+pw+"&ckPw=x");
		
	} else {
		System.out.println("비밀번호 변경가능");
		System.out.println(pw);
		response.sendRedirect("/shop/customer/editPwForm.jsp?pw="+pw+"&ckPw=o");
		
	}
	
%>