<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
	session.invalidate();
	String logoutMsg = URLEncoder.encode("정상적으로 로그아웃 되었습니다","utf-8");
	response.sendRedirect("/shop/emp/empLoginForm.jsp?logoutMsg="+logoutMsg);	

%>
