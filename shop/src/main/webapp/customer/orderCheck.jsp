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
		
		.star-rating {
	        display: flex;
	    }
	
	    .star-rating input[type="radio"] {
	        display: none;
	    }
	
	    .star-rating label.star {
	        font-size: 2em;
	        color: gray;
	        cursor: pointer;
	    }
	
	    .star-rating input[type="radio"]:checked ~ label.star {
	        color: gold;
	    }
	</style>
</head>
<body class="container font">
<!-- 메인메뉴 -->
    <div>
        <jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
    </div>

<div class="d-flex justify-content-end"></div>
<h1 class="mt-4 mb-3">주문 목록</h1>
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
                <th scope="col">리뷰쓰기</th>
            </tr>
        </thead>
        <tbody>
            <% for (HashMap<String, Object> m : checkOne) { %>
                <tr>
                    <td><%= m.get("ordersNo") %></td>
                    <td><%= m.get("mail") %></td>
                    <td><%= m.get("goodsTitle") %></td>
                    <td><%= m.get("totalAmount") %></td>
                    <td><%= m.get("totalPrice") %></td>
                    <td><%= m.get("addres") %></td>
                    <td>
                        <% 
                            String currentState = (String) m.get("state");
                            if ("배송중".equals(currentState)) { %>
                                <a href="/shop/customer/modifyOrderState.jsp?state=배송중&ordersNo=<%= m.get("ordersNo") %>">
                                    <%= currentState %>
                                </a>
                            <% } else { %>
                                <%= currentState %>
                            <% } %>
                    </td>
                    <td>
                       		<% if ("배송완료".equals(currentState)) { 
                            int ordersNo = (Integer) m.get("ordersNo");
                            if (CommentDAO.hasComment(ordersNo)) { %>
                                <button type="button" class="btn btn-secondary" disabled>후기 작성 완료</button>
                            <% } else { %>
                                <form method="post" action="/shop/customer/addCommentACtion.jsp" >
                                    <input type="hidden" name="ordersNo" value="<%= ordersNo %>">
                                	<label for="score">평점:</label>
                                    <select name="score" id="score" class="form-select">
                                        <option value="5">5</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="1">1</option>
                                    </select>									                                                                                                  
                                    <br>
                                    <label for="content">내용:</label>
                                    <textarea name="content" id="content" cols="30" rows="5" class="form-control"></textarea>
                                    <br>
                                    <button type="submit" class="btn btn-primary">후기 작성</button>
                                </form>
                            <% }
                     	  		 } else { %>
                            <button type="button" class="btn btn-danger" disabled>후기 작성 불가</button>
                        <% } %>
                    </td>
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
				<a class="page-link " href="/shop/customer/orderCheck.jsp?currentPage=1&mail=<%=mail%>">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/orderCheck.jsp?<%=currentPage-1%>&mail=<%=mail%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/orderCheck.jsp?currentPage=1&mail=<%=mail%>">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/customer/orderCheck.jsp?<%=currentPage-1%>&mail=<%=mail%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/orderCheck.jsp?currentPage=<%=currentPage+1%>&mail=<%=mail%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/customer/orderCheck.jsp?currentPage=<%=lastPage%>&mail=<%=mail%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>
	</nav>	
</body>
</html>