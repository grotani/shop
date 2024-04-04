<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
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
<!-- Model Layer -->
<%
	// DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	String category = request.getParameter("category");
	
	String sql = "INSERT INTO category(category, create_date) VALUES (?, now())";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	int row = 0;
	stmt.setString(1, category);
	System.out.println(stmt +"카데고리 추가");
	row = stmt.executeUpdate();
	
	
%>
<!-- Controller Layer -->
<%
	if(row == 1) {
		response.sendRedirect("/shop/emp/categoryList.jsp");
	} else {
		response.sendRedirect("/shop/emp/addCategoryAction.jsp");
	}
%>