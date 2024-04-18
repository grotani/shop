<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import = "shop.dao.*" %>

<%
	String empId = request.getParameter("empId");
	System.out.println(empId);
	String active = request.getParameter("active");
	System.out.println(active);
	
	// 권한 변경 
	
	
	int row = EmpDAO.modifyEmp(active, empId);
	

	if (row == 1) {
		System.out.println("사용자의 권한이 변경되었습니다.");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	} else {
		System.out.println("권한변경을 하실수 없습니다.");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}


%>
