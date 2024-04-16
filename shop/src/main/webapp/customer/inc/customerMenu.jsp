<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	HashMap<String,Object> login 
		= (HashMap<String,Object>)(session.getAttribute("login"));
%>



<!-- 메뉴추가할때 사용하기 -->
<nav class="navbar navbar-expand-sm bg-dark  navbar-dark">
<div class="container-fluid">
	<ul class="navbar-nav">
	<span>
			<!-- 개인정보 수정 -->
			<li class="nav-item">
			<a  class="nav-link" href="/shop/customer/customerOne.jsp">
				<%=(String)(login.get("login")) %>님 반갑습니다
			</a> 
			</li>
			
	</span>
</div>