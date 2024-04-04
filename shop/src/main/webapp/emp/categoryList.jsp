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
	// DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	
	// 카테고리 리스트
	String category = request.getParameter("category");
	String sql = "SELECT category, create_date createDate FROM category";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list
	= new ArrayList<HashMap<String,Object>>();
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category",rs.getString("category"));
		m.put("createDate",rs.getString("createDate"));
		list.add(m);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
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
<body  class="container font">
<!-- empMenu.jsp include : 주제(서버) vs redirect (주체:클라이언트) -->
<!-- 주체가 서버이기에 include 할때 절대 주소가 /shop/ 부터 시작하지 않음 -->
<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
<div class= "d-flex justify-content-end">
	<a href="/shop/emp/addCategoryForm.jsp">category 추가</a>
	<a href="/shop/emp/deleteCategoryForm.jsp?category=<%=category%>">category 삭제</a>
</div >
	<h1>Category List</h1>
	<table class="table border">
		<tr>
			<th>category</th>
			<th>createDate</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
			<tr>
				<td><%=(String)(m.get("category"))%></td>
				<td><%=(String)(m.get("createDate"))%></td>
			</tr>
		<% 		
			}
		%>
	</table>
</body>
</html>