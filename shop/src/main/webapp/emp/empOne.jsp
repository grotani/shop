<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String empName = request.getParameter("empName");
	System.out.println(empName + "사원이름");
	
	ArrayList<HashMap<String, Object>> list = EmpDAO.empOne(empName);
	
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
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
	<h1>직원정보</h1>
	<div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
							<%
								for(HashMap<String, Object> m : list) {
							%>		
                            	<li class="list-group-item">ID: <%=m.get("empId")%></li>
                            	<li class="list-group-item">grade: <%=m.get("grade")%></li>
                            	<li class="list-group-item">name: <%=m.get("empName")%></li>
                            	<li class="list-group-item">job: <%=m.get("empJob")%></li>
                            	<li class="list-group-item">hireDate: <%=m.get("hireDate")%></li>
                            	<li class="list-group-item">active: <%=m.get("active")%></li>	
						</ul>
				</div>
			</div>
		</div>
	</div>
	<%		
		}
	%>
	
</body>
</html>