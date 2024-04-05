<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	
	
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println(loginEmp + "<=로그인ID");
	
	
	if(loginEmp != null) { 
		response.sendRedirect("/shop/emp/empList.jsp"); 
		return;
	}	
	
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
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
<body class="font"  style="text-align: center;">
	<h1>로그인</h1>
	
	<%
		if(errMsg != null) {
			// 로그인 하지 않았을때 에러 메세지 
	%>
		<%=errMsg %>
	<% 
		} else if(logoutMsg != null) {
	%>
		<%=logoutMsg %>
	<% 		
		} 
	%>
	<div style="display: flex;">
		<div style="margin: auto;">
		<form method="post" action="/shop/emp/empLoginAction.jsp" style="margin: 0 auto">
			<table>
			<tr>
				<td>ID:</td>
				<td><input type="text" name="empId"></td>
			</tr>
			<tr>
				<td>PW:</td> 
				<td><input type="password" name="empPw"></td>
			</tr>
			
			
			</table>
			<button type="submit">로그인</button>
		</form>
		</div>
	</div>
</body>
</html>