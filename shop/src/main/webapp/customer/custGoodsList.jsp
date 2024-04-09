<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	if(session.getAttribute("loginCustomer") == null) { 
		response.sendRedirect("/shop/customer/loginForm.jsp"); 
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
		int rowPerPage = 12; // 한페이지에 보여줄 상품 개수 
		int startRow = ((currentPage-1)*rowPerPage);
		
		String category = request.getParameter("category");
		if(category == null) {
			category = "";
		}
		String sqlPage = "select count(*) from goods where category like ?";
		PreparedStatement stmtPage = null;
		ResultSet rsPage = null;
		stmtPage = conn.prepareStatement(sqlPage);
		stmtPage.setString(1, "%"+category+"%");
		rsPage = stmtPage.executeQuery();
		int totalRow  = 0;
		if(rsPage.next()) {
			totalRow = rsPage.getInt("count(*)");
		}
		int lastPage = totalRow / rowPerPage;
		if(totalRow%rowPerPage != 0) {
			lastPage = lastPage+1;
		}
%>

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
	
		// goods 목록 리스트  
		String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category Like ? limit ?,?";
			
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1,"%"+category+"%");
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String,Object>> list
		=new ArrayList<HashMap<String,Object>>();
		while(rs2.next()) {
			HashMap<String,Object> m2 = new HashMap<String,Object>();
			m2.put("goodsNo", rs2.getString("goodsNo"));
			m2.put("category", rs2.getString("category"));
			m2.put("goodsTitle", rs2.getString("goodsTitle"));
			m2.put("filename", rs2.getString("filename"));
			m2.put("goodsPrice", rs2.getInt("goodsPrice"));
			list.add(m2);
			
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
<style>
	
		/* 폰트설정 학교안심 몽글몽글 */
		@font-face {
		    font-family: 'TTHakgyoansimMonggeulmonggeulR';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimMonggeulmonggeulR.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		.font {
			font-family:'TTHakgyoansimMonggeulmonggeulR';
		}
			
</style>
</head>
<body class="container font">

	
	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/customer/custGoodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
			 <a href="/shop/customer/custGoodsList.jsp?category=<%=(String)(m.get("category"))%>">			
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>	
		<% 		
			}
		%>
	</div>
	 <!-- 로그아웃 버튼 -->
    <div class="text-end mt-3">
        <form action="/shop/customer/logout.jsp" method="post">
            <button type="submit" class="btn btn-dark mt-3">로그아웃</button>
        </form>
    </div>
	<!-- 메인내용 리스트  -->

		<h1>상품목록</h1>
	
			<div class="container text-center">
			 	<div class="row">
					 
						<%
			
								for(HashMap<String,Object> m2 : list) {
						%>	
						<div  class="col-4">
		                 	<div>
		                 		<a href="/shop/customer/custGoodsOne.jsp?goodsNo=<%=(String) m2.get("goodsNo") %>">
		                 		<img src ="/shop/upload/<%= m2.get("filename") %>"width=200px;></a>
		                 	</div>
		                  	<div>카테고리 : <%=(String) m2.get("category") %></div>
							<div>상품명 : <%=(String) m2.get("goodsTitle") %></div>
							<div>가격 : <%=(Integer) m2.get("goodsPrice") %></div>					
						</div>
						<%
							} 
						%>
				</div>
			
		
		
	
		<!-- 페이징 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-end">
		<%
			if(currentPage>1) {
		%>
			<li class="page-item">
				<a class="page-link " href="/shop/customer/custGoodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?currentPage=1&category=<%=category%>&category=<%=category%>">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a> 
			</li>
		<% 		
			} else  {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/custGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>
	
	
</body>
</html>