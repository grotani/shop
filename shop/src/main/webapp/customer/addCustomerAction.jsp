<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	String mail = request.getParameter("mail");
	System.out.println(mail);
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	String sql="INSERT INTO customer(mail, pw, name, birth, Gender,update_date, create_date)VALUES (?, PASSWORD(?), ?, ?, ?,NOW(),NOW())";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	stmt.setString(2, pw);
	stmt.setString(3, name);
	stmt.setString(4, birth);
	stmt.setString(5, gender);
	int row = stmt.executeUpdate();

	if(row == 1) {
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/customer/loginForm.jsp");
	} else {
		System.out.println("회원가입실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}

%>
