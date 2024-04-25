<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "shop.dao.*" %>
<%@ page import="java.util.*"%>

<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
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

	int totalRow = OrdersDAO.orderListtotalRow();
	System.out.println(totalRow +"<==totalROw");
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
		System.out.println(lastPage +"<==lastPage");
		ArrayList<HashMap<String,Object>> orderList = OrdersDAO.selectOrdersList(startRow, rowPerPage);

		
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
<!-- 메인메뉴 -->
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
<div class="d-flex justify-content-end"></div>
<h1 class="mt-4 mb-3">고객 주문 목록</h1>
<div class="table-responsive">
    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">주문번호</th>
                <th scope="col">상품번호</th>
                <th scope="col">이메일</th>
                <th scope="col">상품명</th>
                <th scope="col">주문수량</th>
                <th scope="col">상품가격</th>
                <th scope="col">배송지</th>
                <th scope="col">주문상태</th>
                <th scope="col">주문일자</th>
            </tr>
        </thead>
        	<% for(HashMap<String,Object> m : orderList ) { %>
      		<tr>
	            <td><%= m.get("ordersNo") %></td>
	            <td><%= m.get("goodsNo") %></td>
	            <td><%= m.get("mail") %></td>
	            <td><%= m.get("goodsTitle") %></td>
	            <td><%= m.get("totalAmount") %></td>
	            <td><%= m.get("totalPrice") %></td>
	            <td><%= m.get("addres") %></td>	                                                    
          		<td>
                       		<% 
	                            String currentState = (String) m.get("state");
	                            if ("결제완료".equals(currentState)) { %>
	                                <a href="/shop/emp/modifyOrderState.jsp?state=결제완료&ordersNo=<%= m.get("ordersNo") %>" class="btn btn-dark">
                                   	<%= currentState %>
                               		</a>
                            <% } else { %>
                                <%= currentState %>
                            <% } %>
                </td>
                <td><%= m.get("updateDate") %></td> 	
          	</tr>  
          			       
             <% } %>    
        </tbody>
    </table>
</div>
<!-- 페이징 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-end">
		<%
			if(currentPage>1) {
		%>
			<li class="page-item">
				<a class="page-link " href="/shop/emp/ordersList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/ordersList.jsp?"<%=currentPage-1%>>이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/ordersList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/ordersList.jsp?"<%=currentPage-1%>>이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/ordersList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/ordersList.jsp?currentPage=<%=lastPage%>">마지막페이지</a> 
			</li>
		<%		
			}
		%>
		</ul>
	</nav>
</body>
</html>