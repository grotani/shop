<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>

<!-- Control Layer -->
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
	int rowPerPage = 12; // 한페이지에 보여줄 상품 개수 
	int startRow = ((currentPage-1)*rowPerPage);
	
	String category = request.getParameter("category");
	if(category == null) {
		category = "";
	}
	int totalRow = GoodsDAO.page(category);
	System.out.println(totalRow +"페이지확인");
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
	

	System.out.println(currentPage + "    currentPage");
	System.out.println(lastPage + "    lastPage");
	System.out.println(totalRow + "    totalRow");

%>	

<!-- Model Layer -->
<%
		//카테고리 목록 개수
		ArrayList<HashMap<String,Object>> categoryList = GoodsDAO.selectCategoryCount();
		System.out.println(categoryList);
	
		
	
		
		// goods 목록 리스트  
		String serchWord = ""; 
		if(request.getParameter("serchWord") != null) { 
			serchWord = request.getParameter("serchWord");
		}
		
		ArrayList<HashMap<String,Object>> goodsList = GoodsDAO.selectGoodsList(category, serchWord, startRow, rowPerPage);

	
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
		
		a:link {text-decoration: none;}
		
		.list-group-item a {
        color: black; /* 텍스트 색상을 검은색으로 설정합니다. */
  			  }
  	  	.product-cards .card {
   		height: 100%; /* 필요에 따라 높이를 조절하세요 */
		}	
</style>
</head>
<body class="container font">
	<!-- 메인메뉴  -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	
     <!-- 검색창 -->
	<div class="col-md-6">
	    <form method="get" action="/shop/emp/goodsList.jsp" class="input-group mb-3">
	        <input type="text" class="form-control" placeholder="상품 검색" aria-label="Recipient's username" aria-describedby="button-addon2" name="serchWord">
	        <button class="btn btn-dark" type="submit" id="button-addon2">검색</button>
	    </form>
	</div>
	
	<div class="container">
    <div class="row">
        <!-- 카테고리 목록 -->
        <div class="col-md-3">
            <h2>카테고리</h2>
            <ul class="list-group">
                <li class="list-group-item"><a href="/shop/emp/goodsList.jsp">전체</a></li>
                <% for(HashMap <String,Object> m : categoryList) { %>
                <li class="list-group-item">
                    <a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
                        <%=(String)(m.get("category"))%> (<%=(Integer)(m.get("cnt"))%>)
                    </a>
                </li>    
                <% } %>
            </ul>
            <!-- 상품 등록 버튼 -->
		    <div class="container">
			    <div class="row justify-content-end">
					<div class="col-auto">
				<a href="/shop/emp/addGoodsForm.jsp" class="btn btn-dark  btn-lg mt-4">상품등록</a>
					</div>
				</div>
			</div>   
        </div>
   	 
   
        <!-- 상품 목록 -->
        <div class="col-md-9">
            <h1 class="text-center">상품 목록</h1>
            <div class="row product-cards">
                <% for(HashMap<String,Object> m : goodsList) { %>
                <div class="col-md-4">
                    <div class="card mb-4">
                    <div>
                   			<a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer) m.get("goodsNo") %>">
                        	<img src="/shop/upload/<%= m.get("filename") %>" class="card-img-top" alt="상품 이미지"></a>
                     </div> 
                      <div class="card-body">
                            <h5 class="card-title"><%= m.get("goodsTitle") %></h5>
                   			<p class="card-text">가격: <%= String.format("%,d", m.get("goodsPrice")) %>원</p> <!-- 가격에 쉼표 추가 -->
							<a href="/shop/emp/deleteGoodsAction.jsp?goodsNo=<%= m.get("goodsNo") %>&category=<%= m.get("category") %>&filename=<%= m.get("filename") %>" class="btn btn-danger">상품 삭제</a>
	                   </div>
                    </div>
                </div>
                <% } %>
            </div>
            
   
            
            <!-- 페이징 버튼 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-end">
                    <% if(currentPage>1) { %>
                    <li class="page-item">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a> 
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
                    </li>
                    <% } else { %>
                    <li class="page-item disabled">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a> 
                    </li>
                    <li class="page-item disabled">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?<%=currentPage-1%>&category=<%=category%>">이전페이지</a> 
                    </li>
                    <% } if (currentPage < lastPage) { %>
                    <li class="page-item">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a> 
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a> 
                    </li>
                    <% } else  { %>
                    <li class="page-item disabled">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a> 
                    </li>
                    <li class="page-item disabled">
                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a> 
                    </li>
                    <% } %>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>