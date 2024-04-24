<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>

<%
    // 로그인 세션 변수 확인
    HashMap<String, Object> loginCustomer = (HashMap<String, Object>) session.getAttribute("loginCustomer");
    if (loginCustomer == null) {
        response.sendRedirect("/shop/customer/loginForm.jsp");
        return;
    }

    String mail = (String) loginCustomer.get("mail"); // 세션에서 이메일 가져오기
    if (mail == null || mail.isEmpty()) {
        response.sendRedirect("/shop/customer/loginForm.jsp");
        return;
    }
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
    int score = Integer.parseInt(request.getParameter("score"));
    String content = request.getParameter("content");

    int rowsAffected = CommentDAO.addComment(goodsNo, ordersNo, score, content);

    if (rowsAffected > 0) {
        // 후기 추가 성공 시 주문 목록 페이지로 이동
        response.sendRedirect("/shop/customer/orderCheck.jsp?mail=" + mail);
    } else {
        // 후기 추가 실패 시 경고창 표시 후 이전 페이지로 돌아가기
        out.println("<script>alert('후기 추가에 실패했습니다.');</script>");
        out.println("<script>history.back();</script>");
    }
%>
