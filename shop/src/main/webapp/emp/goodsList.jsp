<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!-- Control Layer -->
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>

<%
	// DB 연결 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	// 페이징 연결
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int startRow = ((currentPage-1) *rowPerPage);
	
	String sqlPage = "select count(*) from goods";
	PreparedStatement stmtPage = null;
	ResultSet rsPage = null;
	stmtPage = conn.prepareStatement(sqlPage);
	rsPage = stmtPage.executeQuery();
	int totalRow  = 0;
	if(rsPage.next()) {
		totalRow = rsPage.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
	String category = request.getParameter("category");

	/*if(rsPage.next()) {
		totalRow = rsPage.getInt("");
	}
	*/
	
	/*
		null 이면
		select * from goods
		null이 아니면
		select * from goods where category=?
	*/
	
	
%>	

<!-- Model Layer -->
<%
	String sql1 = "select category, count(*) cnt from goods  GROUP BY category ORDER BY category ASC";
	PreparedStatement stmt1 = null;
	ResultSet rs1= null;
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String,Object>> categoryList = 
		new ArrayList<HashMap<String,Object>>();
	while(rs1.next()) {
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
		
	}
	// 디버깅 
	System.out.println(categoryList);
	
	// goods 목록 리스트  
	String sql2 = "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate from goods where category = ? limit ?,?";
		
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category);
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String,Object>> list
	=new ArrayList<HashMap<String,Object>>();
	while(rs2.next()) {
		HashMap<String,Object> m2 = new HashMap<String,Object>();
		m2.put("category", rs2.getString("category"));
		m2.put("goodsTitle", rs2.getString("goodsTitle"));
		m2.put("goodsContent", rs2.getString("goodsContent"));
		m2.put("goodsPrice", rs2.getInt("goodsPrice"));
		m2.put("goodsAmount", rs2.getInt("goodsAmount"));
		m2.put("updateDate", rs2.getString("updateDate"));
		list.add(m2);
	}
	// 카테고리가 null 일때
	String sql3 = "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate from goods limit ?,?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setInt(1, startRow);
	stmt3.setInt(2, rowPerPage);
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String,Object>> list2
	=new ArrayList<HashMap<String,Object>>();
	while(rs3.next()) {
		HashMap<String,Object> m3 = new HashMap<String,Object>();
		m3.put("category", rs3.getString("category"));
		m3.put("goodsTitle", rs3.getString("goodsTitle"));
		m3.put("goodsContent", rs3.getString("goodsContent"));
		m3.put("goodsPrice", rs3.getInt("goodsPrice"));
		m3.put("goodsAmount", rs3.getInt("goodsAmount"));
		m3.put("updateDate", rs3.getString("updateDate"));
		list2.add(m3);
	}

%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<!-- css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<!-- 메인메뉴  -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
			 <a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">			
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>	
		<% 		
			}
		%>
	</div>
	
	<!-- 메인내용 리스트  -->
	<div>
		<h1>goods목록</h1>
		<table>
			<tr>
				<td>category</td>
				<td>goodsTitle</td>
				<td>goodsContent</td>
				<td>goodsPrice</td>
				<td>goodsAmount</td>
				<td>updateDate</td>
			</tr>
			
			<%
				if(category == null){
					for(HashMap<String,Object> m3 : list2) {
			%>	
				<tr>
					<td><%= m3.get("category") %></td>
					<td><%= m3.get("goodsTitle") %></td>
					<td><%= m3.get("goodsContent") %></td>
					<td><%= m3.get("goodsPrice") %></td>
					<td><%= m3.get("goodsAmount") %></td>
					<td><%= m3.get("updateDate") %></td>
				</tr>
				<%
					} 
				} else {
					for(HashMap<String,Object> m2 : list) {
				%>
				<tr>
					<td><%= m2.get("category") %></td>
					<td><%= m2.get("goodsTitle") %></td>
					<td><%= m2.get("goodsContent") %></td>
					<td><%= m2.get("goodsPrice") %></td>
					<td><%= m2.get("goodsAmount") %></td>
					<td><%= m2.get("updateDate") %></td>
				</tr>
				<%		
					}
				}
				%>
			
		
		</table>
	</div>
		<!-- 페이징 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-end">
		<%
			if(currentPage>1) {
		%>
			<li class="page-item">
				<a class="page-link " href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&category=<%=category%>">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/goodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>
	
	
</body>
</html>