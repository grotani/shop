<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%
	// 삭제요청값 
	String category = request.getParameter("category");
	System.out.println("category");
	//
	
	// 삭제쿼리 
	String sql = "DELETE FROM category WHERE category = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt= conn.prepareStatement(sql);
	stmt.setString(1, category);
	int row = stmt.executeUpdate();
	
	if(row == 0) {
		response.sendRedirect("/shop/emp/deleteCategoryForm.jsp?category="+category);
		
	} else {
		response.sendRedirect("/shop/emp/categoryList.jsp");

	} 
%>