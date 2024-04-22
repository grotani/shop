<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
 	// 삭제 요청값 
 	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo+"리뷰삭제 주문번호");
	
	int row = CommentDAO.deleteComment(ordersNo);
	
	if(row == 1) { // 리뷰삭제성공
		System.out.println("리뷰삭제완료");
		response.sendRedirect("/shop/emp/commentList.jsp");
	} else {
		System.out.println("리뷰삭제실패");
		response.sendRedirect("/shop/emp/commentList.jsp");
	}
	
%>