<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>

<%
	
	// 상품수정하기 
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo + "<==goodsNo");
	
	HashMap<String, Object> updtegoods = GoodsDAO.updateGoodsform(goodsNo);
	
	
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>상품수정</h1>
<form method="post" action="/shop/emp/updateGoodsAction.jsp">
<div>
	<div>
		<img src = "/shop/upload/<%=(String)(updtegoods.get("filename")) %>" width=200px;>
	</div>	
	<div>
		<input type="hidden" name="goodsNo" value="<%=(Integer)(updtegoods.get("goodsNo"))%>">
	</div>
	
	<div>
		카테고리
		<input type="text" name="category" value="<%=(String)(updtegoods.get("category"))%>" readonly="readonly">
	</div>
	<div>
		상품명 
		<input type="text" name="goodsTitle" value="<%=(String)(updtegoods.get("goodsTitle"))%>">
	</div>
	<div>
		상품설명
		<textarea rows="10" cols="70" name="goodsContent"  value="<%=(String)(updtegoods.get("goodsContent"))%>"></textarea>
	</div>
	<div>
		상품가격 
		<input type="text" name="goodsPrice" value="<%=(Integer)(updtegoods.get("goodsPrice"))%>">
	</div>
	<div>
		상품수량
		<input type="text" name="goodsAmount" value="<%=(Integer)(updtegoods.get("goodsAmount"))%>">
	</div>
	<div>
		상품등록일자
		<input type="text" name="createDate" value="<%=(String)(updtegoods.get("createDate"))%>">
	</div>
</div>	
	<button type="submit">수정하기</button>
</form>

</body>
</html>

