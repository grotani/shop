<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>
<!-- Model Layer -->
<%
ArrayList<String> categoryList = CategoryDAO.selectCategory();
%>
<!-- View Layer -->
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
<body class="container font">
	<!-- 메인메뉴  -->
	<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>	</div>
	
	
	<h1>상품등록</h1>
	<form method="post" action="/shop/emp/addGoodsAction.jsp"
			enctype="multipart/form-data">
		<div>
			category
			<select name="category">
				<option value="">선택</option>
				<%
					for(String c : categoryList) {
				%>
					<option value="<%=c%>"><%=c%></option>
				<% 		
					}
				%>
			</select>
		</div>
		<!-- emp_id 값은 action쪽에서 세션변수에서 바인딩  -->
		<table>
		<tr>
			<td>goodsTitle :</td>
			<td><input type="text" name="goodsTitle"></td>
		</tr>
		<tr>
			<td>goodsImage :</td>
			<td><input type="file" name="goodsImg"></td>
		</tr>
		<tr>
			<td>goodsPrice :</td>
			<td><input type="number" name="goodsPrice"></td>
		</tr>
		<tr>
			<td>goodsAmount :</td>
			<td><input type="number" name="goodsAmount"></td>
		</tr>
		<tr>
			<td>goodsContent :</td>
			<td><textarea rows="5" cols="50" name="goodsContent"></textarea></td>
		</tr>
		</table>
			<button type="submit">상품등록</button>
		
	</form>
</body>
</html>