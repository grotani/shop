<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
	
	int rowPerPage = 10;
	int startRow = ((currentPage-1) *rowPerPage);
	
	// totalrRow Sql
	int totalRow = EmpDAO.page();
	
	System.out.println(totalRow +"<==totalROw");
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0) {
		lastPage = lastPage+1;
	}
		System.out.println(lastPage +"<==lastPage");

%>

<!-- Model Layer -->
<%
	// 모델(특수한 형태의 데이터 (RDBMS:mairadb)자료구조 값) 
	// -> API 사용(JDBD API)해서 자료구조(ResultSet) 취득한다 
	// -> 일반화된 자료구조로 (ArrayList<Hashmap>)로  변경을 해야 한다 -> 모델 취득
	
	
	ArrayList<HashMap<String,Object>> empList = EmpDAO.empList(startRow, rowPerPage);

%>

<!-- View Layer : 모델 (ArrayList<HashMap<String, Object>>) 출력 -->
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
		
		 button[type="submit"]:hover {
            background-color: #A6A6A6;
        }	
	</style>
</head>
<body class="container font">
<!-- empMenu.jsp include : 주제(서버) vs redirect (주체:클라이언트) -->
<!-- 주체가 서버이기에 include 할때 절대 주소가 /shop/ 부터 시작하지 않음 -->
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
	<h1>사원목록</h1>
	
	<div class= "d-flex justify-content-end">
		<a href="/shop/emp/empLogout.jsp" class="btn btn-dark">로그아웃</a>
	</div>
	<br>
		<div>
			<%=currentPage %> / <%=lastPage %> page
		</div>
	
	<table class="table border">
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>	
		</tr>
		<%
			for(HashMap<String,Object> m : empList) {
		%>
			<tr>
				<td><%=(String)(m.get("empId"))%></td>
				<td><%=(String)(m.get("empName"))%></td>
				<td><%=(String)(m.get("empJob"))%></td>
				<td><%=(String)(m.get("hireDate"))%></td>
				<td>
					<%
					HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
						if((Integer)(sm.get("grade")) > 0) {
					%>
					<a href='/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active")) %>&empId=<%=(String)(m.get("empId"))%>' class="btn btn-dark">
						<%=(String)(m.get("active"))%>
					</a>
					<% 
						}
					%>
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
				<a class="page-link " href="/shop/emp/empList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/empList.jsp?"<%=currentPage-1%>">이전페이지</a> 
			</li>
		<%
			} else {
		%>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class="page-item disabled">
				<a class="page-link" href="/shop/emp/empList.jsp?"<%=currentPage-1%>">이전페이지</a> 
			</li>
		<%		
			} if (currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a> 
			</li>
			<li class="page-item">
				<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">마지막페이지</a> 
			</li>
		<% 		
			}
		%>
		</ul>
		
</body>
</html>