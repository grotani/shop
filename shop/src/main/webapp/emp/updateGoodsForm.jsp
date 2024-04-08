<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>

<%
	// DB연결 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo + "<==goodsNo");
	
	String sql = "SELECT category, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate FROM goods WHERE goods_no = ?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		
	
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
		<img src = "/shop/upload/<%=rs.getString("filename")%>" width=200px;>
	</div>	
	<div>
		카테고리
		<input type="text" name="category" value="<%=rs.getString("category")%>" readonly="readonly">
	</div>
	<div>
		상품명 
		<input type="text" name="goodsTitle" value="<%=rs.getString("goodsTitle")%>">
	</div>
	<div>
		상품설명
		<textarea rows="10" cols="70" name="goodsContent"  value="<%=rs.getString("goodsContent")%>"></textarea>
	</div>
	<div>
		상품가격 
		<input type="text" name="goodsPrice" value="<%=rs.getInt("goodsPrice")%>">
	</div>
	<div>
		상품수량
		<input type="text" name="goodsAmount" value="<%=rs.getInt("goodsAmount")%>">
	</div>
	<div>
		상품등록일자
		<input type="text" name="createDate" value="<%=rs.getString("createDate")%>">
	</div>
</div>	
	<button type="submit">수정하기</button>
</form>

</body>
</html>
<% 
	}
%>
