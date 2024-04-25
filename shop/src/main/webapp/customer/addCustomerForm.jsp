<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mail = request.getParameter("mail");
    if(mail == null) {
        mail = "";
    }
    String cm = request.getParameter("cm");
    if(cm == null) {
        cm = "";
    }
    String msg = "";
    if(cm.equals("o")) {
        msg = "회원가입이 가능합니다";
    } else if(cm.equals("x")) {
        msg = "중복된 이메일 회원가입이 불가능합니다.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입페이지</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- 폰트 설정 -->
    <style>
        @font-face {
            font-family: 'TTHakgyoansimMonggeulmonggeulR';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimMonggeulmonggeulR.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
        body {
            font-family: 'TTHakgyoansimMonggeulmonggeulR', sans-serif;
            background-color: #f8f9fa;
            padding-top: 50px;
            padding-bottom: 50px;
        }
        .container {
            max-width: 600px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        input[type="email"],
        input[type="password"],
        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #000000;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #A6A6A6;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>회원가입</h1>
    <div>
        <form method="post" action="/shop/customer/checkIdAction.jsp">
            <div>
                mail 확인:
                <input type="email" name="mail" value="<%=mail%>">
                <span><%=msg %></span>
                <button type="submit">중복확인</button>
            </div>
        </form>
        <form method="post" action="/shop/customer/addCustomerAction.jsp">
            <div>
                mail :
                <% if(cm.equals("o")) { %>
                    <input value="<%=mail %>" type="text" name="mail" readonly="readonly">
                <% } else { %>
                    <input type="email" name="mail" readonly="readonly">
                <% } %>
            </div>
            <div>
                pw :
                <input type="password" name="pw">
            </div>
            <div>
                이름 :
                <input type="text" name="name">
            </div>
            <div>
                생일 :
                <input type="date" name="birth">
            </div>
            <div>
                성별 :
                <input type="radio" name="gender" value="남">남
                <input type="radio" name="gender" value="여">여
            </div>
            <button type="submit">회원가입</button>
        </form>
    </div>
</div>
</body>
</html>
