<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
	// DB 연결 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	int goodsNo= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo + "이미지");
	String sql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate FROM goods WHERE goods_no = ?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list
	= new ArrayList<HashMap<String,Object>>();
	while(rs.next()) {
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("goodsNo", rs.getInt("goodsNo"));
		m.put("category", rs.getString("category"));
		m.put("goodsTitle", rs.getString("goodsTitle"));
		m.put("filename", rs.getString("filename"));
		m.put("goodsContent", rs.getString("goodsContent"));
		m.put("goodsPrice", rs.getInt("goodsPrice"));
		m.put("goodsAmount", rs.getInt("goodsAmount"));
		m.put("createDate", rs.getString("createDate"));
		list.add(m);
	}
	
	

%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsOne</title>
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
<!-- 메인메뉴  -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

<!-- 메인내용 -->
<h1>상품상세</h1>
	<div>
		<%
			for(HashMap<String,Object> m : list) {
		%>
		<div>
			<div>
				<img src = "/shop/upload/<%=(String)m.get("filename")%>" width=200px;>
			</div>	
			<div>카테고리:<%=(String)m.get("category")%></div>
			<div>상품명:<%=(String) m.get("goodsTitle")%></div>
			<div>상품 가격:<%=(Integer)m.get("goodsPrice")%></div>
			<div>상품 설명:<%=(String)m.get("goodsContent")%></div>
			<div>상품 수량:<%=(Integer)m.get("goodsAmount")%></div>
			<div>상품 등록일자:<%=(String)m.get("createDate")%></div>
		</div>
		
			<div>
				<a href="/shop/emp/updateGoodsForm.jsp?goodsNo=<%=(Integer)m.get("goodsNo") %>">상품수정</a>
			</div>
		<% 		
			}
		%>
	</div>

</body>
</html>