<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
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

    // 주문정보
    int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); // 상품번호
    int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount")); // 상품수량
    int totalAmount = Integer.parseInt(request.getParameter("totalAmount")); // 상품구매수량
    String addres = request.getParameter("addres"); // 입력한 배송지
    int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice")); //상품가격
    int totalPrice = goodsPrice * totalAmount;  // 상품총가격
    
    System.out.println(goodsNo);
    System.out.println(totalAmount);
    System.out.println(addres);
    System.out.println(goodsPrice);
    System.out.println(totalPrice);

    // 주문 처리
    int orderRow = OrdersDAO.insertOrder(mail, goodsNo, totalAmount, totalPrice, addres);

    // 상품 재고 업데이트
    int updateRow = GoodsDAO.updateGoodsAmount(goodsAmount, totalAmount, goodsNo);

    if (orderRow == 1 && updateRow == 1) { // 주문 및 재고 업데이트 성공
        System.out.println("주문 및 재고 업데이트 완료");
        response.sendRedirect("/shop/customer/orderCheck.jsp?mail=" + mail);
    } else { // 실패
        System.out.println("주문 및 재고 업데이트 실패");
        response.sendRedirect("/shop/customer/custGoodsOne.jsp");
    }
%>
