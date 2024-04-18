<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	// 로그인 세션 변수
	if( session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	String editPwMsg = request.getParameter("editPwMsg");
	String name = request.getParameter("name");
	
	System.out.println(name);
	
	ArrayList<HashMap<String,Object>> list = CustomerDAO.customerOne(name);
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
			
		a:link {text-decoration: none;}
		
		.list-group-item a {
        color: black; /* 텍스트 색상을 검은색으로 설정합니다. */
</style>
</head>
<body class="container-fluid font">
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	</div>
	<!-- 메인내용 -->
	<h1>회원정보</h1>
		<% if(editPwMsg != null) { %>
		<div><%=editPwMsg %></div>
		<%	} %>			
			 <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <%
                                for(HashMap<String,Object> m : list) {
                            %>
                                <li class="list-group-item">이메일: <%=m.get("mail")%></li>
                                <li class="list-group-item">이름: <%=m.get("name")%></li>
                                <li class="list-group-item">생년월일: <%=m.get("birth")%></li>
                                <li class="list-group-item">성별: <%=m.get("gender")%></li>
                                <li class="list-group-item">수정일: <%=m.get("updateDate")%></li>
                                <li class="list-group-item">가입일: <%=m.get("createDate")%></li>
				     </ul>
                    </div>
                </div>
            </div>
        </div>
		<div class="mt-3">
            <a href="/shop/customer/editPwForm.jsp?mail=<%=(String)(m.get("mail")) %>&name=<%=(String)(m.get("name"))%>" class="btn btn-secondary">비밀번호 변경</a>
            <a href="/shop/customer/deleteCustomerAction.jsp?mail=<%=(String)(m.get("mail"))%>&pw=<%=(String)m.get("pw")%>" class="btn btn-danger" onclick="return confirm('정말로 탈퇴하시겠습니까?')">회원 탈퇴</a>
        </div>
		<%
			}
		%>
		
</body>
</html>