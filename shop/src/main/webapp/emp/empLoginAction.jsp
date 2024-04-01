<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") != null) { 
		response.sendRedirect("/shop/emp/empList.jsp"); 
		return;
	}
	
%>

<%
	// 요청값 분석 => 
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	
	/*
	select emp_id empId 
	From emp
	where active='ON' and emp_id = ? And emp_pw = password(?)
	*/
	String sql = "select emp_id empId From emp where active='ON' and emp_id=? And emp_pw=password(?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	
	
	/*
		실패 /emp/empLoginForm.jsp
		성공 /emp/empList.jsp
	*/
	
	if(rs.next()) {
		System.out.println("로그인 성공!");
		
		session.setAttribute("loginEmp", rs.getString("empId"));
		response.sendRedirect("/shop/emp/empList.jsp");
	
	} else {
		System.out.println("로그인 실패!");
		String errMsg = URLEncoder.encode("입력하신 ID 와 PW 를 확인해주세요." , "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
	}
	
	
	
%>
