<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");


	String sql = "Update emp Set active = ? Where emp_id = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	int row = 0;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, active);
	stmt.setString(2, empId);
	
	System.out.println(stmt + "권한변경 확인");
	
	

	

%>
