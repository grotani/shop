<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="shop.dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>
<!-- 세션 설정값  : 입력시 로그인 emp의 emp_id 값이 필요해서 -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>
	
	

<!-- Controller Layer -->
<%
	String category = request.getParameter("category");

	int row = CategoryDAO.addCategory(category);
	
	if(row == 1) {
		response.sendRedirect("/shop/emp/categoryList.jsp");
	} else {
		response.sendRedirect("/shop/emp/addCategoryAction.jsp");
	}
%>