<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.*" %>
<%
    if(session.getAttribute("loginCustomer") != null) { 
        response.sendRedirect("/shop/customer/custGoodsList.jsp"); 
        return;
    }
%>
<%
  
    String mail = request.getParameter("mail");
    String pw = request.getParameter("pw");
    
    HashMap<String, String> loginCustomer = CustomerDAO.login(mail, pw);
    
    if(loginCustomer == null) {
        System.out.println("로그인 실패");
        String errMsg = URLEncoder.encode("입력하신 이메일과 비밀번호를 확인해주세요." , "utf-8");
        response.sendRedirect("/shop/customer/loginForm.jsp?errMsg="+errMsg);
       
        
    } else {
    	System.out.println("로그인 성공");
         session.setAttribute("loginCustomer", loginCustomer); 
        response.sendRedirect("/shop/customer/custGoodsList.jsp");
    }
%>
