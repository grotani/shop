<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%
	if(session.getAttribute("loginCustomer") != null) { 
		response.sendRedirect("/shop/customer/custGoodsList.jsp"); 
		return;
	}
%>
<%
	// DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	String sql ="select mail, pw, name, birth, gender from customer where mail=? and pw=password(?)";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	stmt.setString(2, pw);
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		System.out.println("로그인성공");
		
		HashMap<String,Object> loginCustomer = new HashMap<String,Object>();
		loginCustomer.put("mail", rs.getString("mail")); 
		loginCustomer.put("name", rs.getString("name")); 
		
		
		session.setAttribute("loginCustomer", loginCustomer);
		
		response.sendRedirect("/shop/customer/custGoodsList.jsp");
		
	} else {
		String errMsg = URLEncoder.encode("입력하신 이메일과 pw를 확인해주세요." , "utf-8");
		response.sendRedirect("/shop/customer/loginForm.jsp?errMsg="+errMsg);

	}
	
%>
