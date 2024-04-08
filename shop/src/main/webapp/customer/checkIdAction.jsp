<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// Db 연결
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	String checkMail = request.getParameter("checkMail");
	
	String sql = "SELECT mail FROM customer WHERE mail =?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, checkMail);
	rs = stmt.executeQuery();
	
%>

<%
	if(rs.next()) {
		System.out.println("회원가입 불가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail="+checkMail+"&cm=x");
		
	} else {
		System.out.println("회원가입 가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail="+checkMail+"&cm=o");
	}

%>

