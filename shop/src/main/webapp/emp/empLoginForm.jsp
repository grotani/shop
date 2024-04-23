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
		  body {
            font-family:'TTHakgyoansimMonggeulmonggeulR';
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
		 .login-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }	
         input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            width: calc(100% - 20px);
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: #ff0000;
            margin-bottom: 10px;
        }
	</style>
</head>
<body class="font">
	<div class="container">
	<h1>로그인</h1>
	
	<%
		if(errMsg != null) {
			// 로그인 하지 않았을때 에러 메세지 
	%>
		  <p class="error-message"><%=errMsg %></p>
	<% 
		} else if(logoutMsg != null) {
	%>
		<%=logoutMsg %>
	<% 		
		} 
	%>
	
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
</body>
</html>