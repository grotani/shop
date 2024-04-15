<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%
	// 삭제요청값 
	String category = request.getParameter("category");
	System.out.println(category);
	
	
	
	int row = CategoryDAO.deleteCategory(category);
	
	if(row == 0) {
		response.sendRedirect("/shop/emp/deleteCategoryForm.jsp?category="+category);
		
	} else {
		response.sendRedirect("/shop/emp/categoryList.jsp");

	} 
%>