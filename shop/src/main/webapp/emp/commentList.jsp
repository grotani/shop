<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>	
<%
	// commentList 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = ((currentPage-1) * rowPerPage);
	
	// totalRow sql
	int totalRow = CommentDAO.page();
	System.out.println(totalRow + "<==totalROw");
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
	System.out.println(lastPage + "<==lastPage");
	
%>
<%
	ArrayList<HashMap<String, Object>> commentList = CommentDAO.commentList(startRow, rowPerPage);

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
<body class="container font">
<!-- empMenu.jsp -->
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
	<h1>고객리뷰관리</h1>
		<div>
			<%=currentPage %> / <%=lastPage %> page
		</div>
	<table class="table border">
		<tr>
			<th>주문번호</th>
			<th>별점</th>
			<th>리뷰</th>
			<th>리뷰수정일</th>
			<th>리뷰등록일</th>				
			<th>리뷰삭제</th>				
		</tr>
		<%
			for(HashMap<String, Object> m : commentList) {
		%>
		<tr>
			<td><%=(Integer)(m.get("ordersNo")) %></td>
			<td><%=(Integer)(m.get("score")) %></td>
			<td><%=(String)(m.get("content")) %></td>
			<td><%=(String)(m.get("updateDate")) %></td>
			<td><%=(String)(m.get("createDate")) %></td>
			
		 	<td>
                <form action="/shop/emp/deleteCommentAction.jsp" method="post" onsubmit="return confirm('해당 후기를 삭제하시겠습니까?');">
                    <input type="hidden" name="ordersNo" value="<%=(Integer)(m.get("ordersNo")) %>">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </td>
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
				<a class="page-link " href="/shop/emp/commentList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/commentList.jsp?"<%=currentPage-1%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/commentList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/commentList.jsp?"<%=currentPage-1%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/commentList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/commentList.jsp?currentPage=<%=lastPage%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>	
</body>
</html>