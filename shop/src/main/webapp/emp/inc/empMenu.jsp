<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>

<!-- 메뉴추가할때 사용하기 -->
<nav class="navbar navbar-expand-sm bg-dark  navbar-dark">
<div class="container-fluid">
	<ul class="navbar-nav">
		<li class="nav-item">
		<a  class="nav-link" href="/shop/emp/empList.jsp">사원관리</a>
		</li>
		<!-- category CRUD -->
		<li class="nav-item">
		<a  class="nav-link" href="/shop/emp/categoryList.jsp">카테고리관리</a>
		</li>
		<li class="nav-item">
		<a  class="nav-link" href="/shop/emp/goodsList.jsp">상품관리</a>
		</li>
		<li class="nav-item">
		<a  class="nav-link" href="/shop/emp/customerList.jsp">회원목록</a>
		</li>
		<span>
			<!-- 개인정보 수정 -->
			<li class="nav-item">
			<a  class="nav-link" href="/shop/emp/empOne.jsp?empName=<%=loginMember.get("empName")%>">
				<%=(String)(loginMember.get("empName")) %>님 반갑습니다
			</a> 
			</li>
		</ul>	

	</span>
</div>
	