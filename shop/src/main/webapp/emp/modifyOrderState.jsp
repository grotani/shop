<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	// 고객 주문 상태 결제완료 -> 배송중으로 변경해주기
	// 인증분기 : 세션 변수 이름 = > loginEmp
		if(session.getAttribute("loginEmp") == null) { 
			response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
			return;
		}

		String state = request.getParameter("state");
	    String orderNoParam = request.getParameter("ordersNo");
	    
	    // 주문번호와 상태가 null이 아닌지 확인
	    if (orderNoParam != null && state != null) {
	        int ordersNo = Integer.parseInt(orderNoParam);

	        // 주문상태가 "결제완료"일 때만 "배송중"로 변경
	        if ("결제완료".equals(state)) {
	            // 주문상태 변경
	            int row = OrdersDAO.modifyCustOrder(state, ordersNo);

	            if (row == 1) {
	                System.out.println("배송중 처리 되었습니다.");
	                response.sendRedirect("/shop/emp/ordersList.jsp?ordersNo=" + ordersNo);
	            } else {
	                System.out.println("주문상태 변경에 실패하였습니다.");
	                response.sendRedirect("/shop/emp/ordersList.jsp?ordersNo=" + ordersNo + "&success=false");
	            }
	        } else {
	            // 주문상태가 "결제완료"가 아닌 경우
	            System.out.println("주문상태가 결제완료가 아닙니다.");
	            response.sendRedirect("/shop/emp/ordersList.jsp?ordersNo=" + ordersNo + "&success=false");
	        }
	    } else {
	        // 주문번호 또는 상태가 null인 경우
	        System.out.println("주문번호 또는 상태가 전달되지 않았습니다.");
	        response.sendRedirect("/shop/emp/ordersList.jsp?success=false");
	    }
%>



