<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 
	if(session.getAttribute("loginCustomer") == null) { 
		response.sendRedirect("/shop/customer/loginForm.jsp"); 
		return;
	}	
%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo +"<==상품번호");
	
	HashMap<String, Object> CustGoodsOne = GoodsDAO.selectCustGoodsOne(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>custGoodOne</title>
</head>
<body>
<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	</div>
	<h1>상품상세</h1>
		<div>
			<div>
				<div>
					<div>
						<ul>
							
							<li>카테고리:</li>
						</ul>
					</div>				
				</div>
			</div>
		</div>
</body>
</html>