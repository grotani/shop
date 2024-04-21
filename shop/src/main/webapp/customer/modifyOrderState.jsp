<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	//로그인 세션 변수 확인
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>) session.getAttribute("loginCustomer");
	if (loginCustomer == null) {
	    response.sendRedirect("/shop/customer/loginForm.jsp");
	    return;
	}
    String state = request.getParameter("state");
    String orderNoParam = request.getParameter("ordersNo");
    
    String mail = (String) loginCustomer.get("mail"); // 세션에서 이메일 가져오기
    if (mail == null || mail.isEmpty()) {
        response.sendRedirect("/shop/customer/loginForm.jsp");
        return;
    }

    // 주문번호와 상태가 null이 아닌지 확인
    if (orderNoParam != null && state != null) {
        int ordersNo = Integer.parseInt(orderNoParam);

        // 주문상태가 "배송중"일 때만 "배송완료"로 변경
        if ("배송중".equals(state)) {
            // 주문상태 변경
            int row = OrdersDAO.modifyOrder(state, ordersNo);

            if (row == 1) {
                System.out.println("배송완료 처리 되었습니다.");
                response.sendRedirect("/shop/customer/orderCheck.jsp?mail=" + mail);
            } else {
                System.out.println("주문상태 변경에 실패하였습니다.");
                response.sendRedirect("/shop/customer/orderCheck.jsp?ordersNo=" + ordersNo + "&success=false");
            }
        } else {
            // 주문상태가 "배송중"이 아닌 경우
            System.out.println("주문상태가 배송중이 아닙니다.");
            response.sendRedirect("/shop/customer/orderCheck.jsp?ordersNo=" + ordersNo + "&success=false");
        }
    } else {
        // 주문번호 또는 상태가 null인 경우
        System.out.println("주문번호 또는 상태가 전달되지 않았습니다.");
        response.sendRedirect("/shop/customer/orderCheck.jsp?success=false");
    }
%>
