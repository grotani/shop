<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
    // 인증분기 
    if(session.getAttribute("loginCustomer") == null) { 
        response.sendRedirect("/shop/customer/loginForm.jsp"); 
        return;
    }   
    
    // 상품번호 가져오기
    int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    System.out.println(goodsNo + " <== 상품번호");

    // 굿즈 상세정보 가져오기
    HashMap<String, Object> goodsOne = GoodsDAO.selectCustGoodsOne(goodsNo);
    
    // 세션에서 이메일 가져오기
    String mail = (String) session.getAttribute("mail");
    System.out.println(mail +"<==사용자메일");
    
 	// 상품후기List 페이징
 	int currentPage = 1;
 	if(request.getParameter("currentPage") != null) {
 		currentPage = Integer.parseInt(request.getParameter("currentPage"));
 	}
 	int rowPerPage = 5; 
 	int startRow = ((currentPage-1) * rowPerPage);
 	
 	// totalRow sql
 	int totalRow = CommentDAO.commentPage(goodsNo);
 	System.out.println(totalRow + "<==totalROw");
 	
 	int lastPage = totalRow / rowPerPage;
 	if(totalRow%rowPerPage != 0) {
 		lastPage = lastPage+1;
 	}
 	System.out.println(lastPage + "<==lastPage");
 	
    // 상품후기 List
    ArrayList<HashMap<String, Object>> selectCommentList = CommentDAO.selectCommentList(goodsNo, startRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세정보</title>
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
        a:link {text-decoration: none;}
        .list-group-item a {
            color: black; /* 텍스트 색상을 검은색으로 설정합니다. */
        }
        .star-rating {
            display: flex;
        }
        .star-rating .star {
            font-size: 2em;
            color: gray;
            cursor: pointer;
        }
        .star-rating .star.active {
            color: gold;
        }
    </style>
</head>
<body class="container-fluid font">
    <!-- 메인메뉴 -->
    <div>
        <jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
    </div>
    <h1>상품상세</h1>
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"> <img src="/shop/upload/<%= goodsOne.get("filename") %>" width="200"></li>
                        <li class="list-group-item">카테고리: <%= goodsOne.get("category") %></li>
                        <li class="list-group-item">상품명: <%= goodsOne.get("goodsTitle") %></li>                                
                        <li class="list-group-item">상품 설명: <%= goodsOne.get("goodsContent") %></li>
                        <li class="list-group-item">상품 가격: <%= String.format("%,d", goodsOne.get("goodsPrice")) %>원</li>
                    </ul>
                    <div>
                    	
                    	
						<h2>주문하기</h2>
						<form method="post" action="/shop/customer/ordersGoodsAction.jsp">
						    <ul>
						        <li class="list-group-item">수량선택: <input type="number" name="totalAmount"></li>
						        <li class="list-group-item">배송지: <input type="text" name="addres"></li>
						        
							      <input type="hidden" name="goodsNo" value="<%= goodsNo %>">
							      <input type="hidden" name="goodsAmount" value="<%= goodsOne.get("goodsAmount") %>">
							      <input type="hidden" name="goodsPrice" value="<%= goodsOne.get("goodsPrice") %>">
							      <input type="hidden" name="mail" value="<%= mail %>">
							      <button type="submit">주문하기</button>
						    </ul>
						</form>
						<h2>상품후기</h2>
	                    	<div>
	                    		<%=currentPage %> / <%=lastPage %> page
	                    	</div>
                    		<table class="table border">
                    			<tr>
                    				<th>별점</th>
                    				<th>리뷰</th>
                    				<th>리뷰작성일</th>
                    			</tr>
                    			<%
                    				for(HashMap<String, Object> m : selectCommentList) {
                    			%>
	                    				<tr>
	                    					<td>
					                			<div class="star-rating">
								                <!-- 상품후기 별모양으로 보여주기 -->
								                    <% 
								                    	int score = Integer.parseInt((String) m.get("score"));
								                        for(int i = 1; i <= 5; i++) {
								                            if(i <= score) { %>
								                                <span class="star active">&#9733;</span>
								                            <% } else { %>
								                                <span class="star">&#9733;</span>
								                            <% }
								                        } 
								                    %>
								                </div>
								            </td>
	                    					<td><%=(String)(m.get("content")) %></td>
	                    					<td><%=(String)(m.get("createDate")) %></td>	                    					
	                    				</tr>
                    			<% 		
                    				}
                    			%>
                    		</table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
