<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	//인증분기 : 세션 변수 이름 = > loginEmp
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
	
	int rowPerPage = 10; // 한페이지에 보여줄 목록개수 
	int startRow = ((currentPage-1)*rowPerPage);
	
	ArrayList<HashMap<String,Object>> customerList = CustomerDAO.selectCustomerListByPage(startRow, rowPerPage);
	
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
<!-- 메인메뉴  -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
<div class="d-flex justify-content-end"></div>
    <h1>회원목록</h1>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">이메일</th>
                    <th scope="col">이름</th>
                    <th scope="col">생년월일</th>
                    <th scope="col">성별</th>
                    <th scope="col">수정일</th>
                    <th scope="col">가입일</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(HashMap<String,Object> m : customerList ){
                %>
                    <tr>
                        <td><%=m.get("mail")%></td>
                        <td><%=m.get("name")%></td>
                        <td><%=m.get("birth")%></td>
                        <td><%=m.get("gender")%></td>
                        <td><%=m.get("updateDate")%></td>
                        <td><%=m.get("createDate")%></td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>
    
		
</body>
</html>