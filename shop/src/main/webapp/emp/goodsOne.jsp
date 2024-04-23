<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>

<%
	// DB 연결 
	
	int goodsNo= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo + "이미지");
	
	
	ArrayList<HashMap<String, Object>> goodsOne = GoodsDAO.goodsOne(goodsNo); 
	
	
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
	
	// commentList 보여주기 
	ArrayList<HashMap<String, Object>> selectCommentList = CommentDAO.selectCommentList(goodsNo, startRow, rowPerPage);
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
<body class="container font">
<!-- 메인메뉴  -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

<!-- 메인내용 -->
<h1>상품상세</h1>
	<div>
		<%
			for(HashMap<String,Object> m : goodsOne) {
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
<h2>상품후기</h2>	
	<div>
		<%=currentPage %> / <%=lastPage %> page
	</div>
	<table class="table border">
	<tr>
		<th>별점</th>
		<th>리뷰</th>
		<th>작성일</th>
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
	<!-- 페이징 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-end">
		<%
			if(currentPage>1) {
		%>
			<li class="page-item">
				<a class="page-link " href="/shop/emp/goodsOne.jsp?currentPage=1&goodsNo=<%=goodsNo%>">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsOne.jsp?<%=currentPage-1%>&goodsNo=<%=goodsNo%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/goodsOne.jsp?currentPage=1&goodsNo=<%=goodsNo%>">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/goodsOne.jsp?<%=currentPage-1%>&goodsNo=<%=goodsNo%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsOne.jsp?currentPage=<%=currentPage+1%>&goodsNo=<%=goodsNo%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/goodsOne.jsp?currentPage=<%=lastPage%>&goodsNo=<%=goodsNo%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>
	</nav>	
</body>
</html>