<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "shop.dao.*" %>
<%@ page import="java.util.*"%>


<%
	// 주문자의 이메일 정보를 받아옵니다.
	String mail = request.getParameter("mail");

	//로그인 인증분기 : 로그인 되어있지 않으면  login폼으로 이동
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	} 
	
%>
<% 
	
	// 페이징 연결
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = ((currentPage-1) *rowPerPage);

	int totalRow = OrdersDAO.totalRow(mail);
	System.out.println(totalRow +"<==totalROw");
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
		System.out.println(lastPage +"<==lastPage");
		ArrayList<HashMap<String,Object>> checkOne = OrdersDAO.selectOrderListByCustomer(mail, startRow, rowPerPage);

		
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<div class="d-flex justify-content-end"></div>
	<h1>주문목록</h1>
	<div class="table-responsive">
        <table class="table table-striped">
			<thead>
				<tr>
		            <th scope="col">주문번호</th>
		            <th scope="col">이메일</th>
		            <th scope="col">상품명</th>
		            <th scope="col">상품수량</th>
		            <th scope="col">상품가격</th>
		            <th scope="col">배송지</th>
		            <th scope="col">주문상태</th>    
		        </tr>
		     </thead>
            <tbody>    
				<%
					for(HashMap<String,Object> m : checkOne) {
				%>
					<tr>
						<td><%=(Integer)(m.get("ordersNo"))%></td>
						<td><%=(String)(m.get("mail"))%></td>
						<td><%=(String)(m.get("goodsTitle"))%></td>
						<td><%=(Integer)(m.get("totalAmount"))%></td>
						<td><%=(Integer)(m.get("totalPrice"))%></td>
						<td><%=(String)(m.get("addres"))%></td>
						<td><%=(String)(m.get("state"))%></td>
					</tr>
					<%
						}
					%>
		     </tbody>
        </table>
    </div>			
</body>
</html>