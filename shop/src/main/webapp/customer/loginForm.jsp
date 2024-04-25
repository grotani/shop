<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if( session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/custGoodsList.jsp");
		return;
	}
	
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	String deleteMsg = request.getParameter("deleteMsg");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>로그인</h1>
        <% if (errMsg != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= errMsg %>
            </div>
        <% } else if (logoutMsg != null) { %>
            <div class="alert alert-success" role="alert">
                <%= logoutMsg %>
            </div>
        <% } else if (deleteMsg != null) { %>
        	<div class="alert alert-success" role="alert">
        		 <%= deleteMsg %>
        	</div>    
        <% } %>
        <form method="post" action="/shop/customer/loginAction.jsp">
            <div class="mb-3">
                <label for="email" class="form-label">이메일 주소</label>
                <input type="email" class="form-control" id="email" name="mail" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="pw" required>
            </div>
            <button type="submit" class="btn btn-dark btn-block">로그인</button>
            <a href="/shop/customer/addCustomerForm.jsp" class="btn btn-dark btn-block">회원가입</a>
        </form>
    </div>
</body>
</html>
