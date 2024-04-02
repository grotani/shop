<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>


<%
	String empId = request.getParameter("empId");
	System.out.println(empId);
	String active = request.getParameter("active");
	System.out.println(active);

	String sql = "UPDATE emp SET active = ? WHERE emp_id = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	int row = 0;
	stmt = conn.prepareStatement(sql);
	
	
	if(active.equals("ON")) {
		active = "OFF";
	} else {
		active = "ON";
	}
	stmt.setString(1,active);	
	stmt.setString(2, empId);
	
	
	
	System.out.println(stmt + "권한변경 확인");
	row = stmt.executeUpdate();
	if (row == 1) {
		System.out.println("사용자의 권한이 변경되었습니다.");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	} else {
		System.out.println("권한변경을 하실수 없습니다.");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}


%>
