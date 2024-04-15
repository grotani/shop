<%@page import="shop.dao.GoodsDAO"%>
<%@page import="org.apache.catalina.util.Introspection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<!-- Controller Layer -->
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
	
	// 요청값 
	int goodsNo= Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	
	// 요청값 디버깅
	System.out.println(goodsTitle);
	System.out.println(goodsContent);
	System.out.println(goodsPrice);
	System.out.println(goodsAmount);
	
	// db업데이트 쿼리 
	
	int row = GoodsDAO.updateGoods(goodsNo, goodsTitle, goodsContent, goodsPrice, goodsAmount);
	
	if(row == 1) {
		response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo);
	} else {
		response.sendRedirect("/shop/emp/updateGoodsForm.jsp?goodsNo="+goodsNo);
	}
	
	
%>