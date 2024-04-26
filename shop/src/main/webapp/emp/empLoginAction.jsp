<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") != null) { 
		response.sendRedirect("/shop/emp/empList.jsp"); 
		return;
	}
	
%>

<%
	// 요청값 분석 =>  controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	System.out.println(empId + "아이디");
	System.out.println(empPw + "pw");
	
	
	// 모델 호출하는 코드 
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	
	if(loginEmp == null) {
		System.out.println("로그인 실패!");
		String errMsg = URLEncoder.encode("입력하신 ID 와 PW 를 확인해주세요." , "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
		
	
	} else {
		System.out.println("로그인 성공!"); 
		// 하나의 세션 변수안에 여러개의 값을 저장하기 위해서 HashMap
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
	
	
%>
