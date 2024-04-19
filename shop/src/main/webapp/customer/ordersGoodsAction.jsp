<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	//로그인 세션 변수
	if( session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
	
%>

<%
	int goodNo = Integer.parseInt(request.getParameter("goodNo"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	String mail = request.getParameter("mail");
	String addres = request.getParameter("addres");
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	
	
	int row = OrdersDAO.insertOrder(mail, goodNo, totalAmount, totalPrice, addres);
	
	if(row == 1) { // 성공
		response.sendRedirect("/shop/customer/orderCheck.jsp");
	} else { //실패
		response.sendRedirect("/shop/customer/custGoodsOne.jsp");
	}
	
	
%>