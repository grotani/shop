<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
    // 인증분기 : 세션 변수 이름 = > loginEmp
    if(session.getAttribute("loginEmp") == null) { 
        response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
        return;
    }   
    
    // 카테고리 목록 가져오기
    ArrayList<String> categoryList = CategoryDAO.selectCategory();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품등록</title>
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
        .font {
            font-family: 'TTHakgyoansimMonggeulmonggeulR', sans-serif;
        }
        /* 전체 body 스타일 */
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }
        /* 폼 스타일 */
        form {
            margin-top: 50px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        /* 제목 스타일 */
        h1 {
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.5rem;
            color: #212529;
        }
        /* 선택 박스 스타일 */
        select {
            width: 100%;
            padding: .375rem .75rem;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: .25rem;
        }
        /* 버튼 스타일 */
        button[type="submit"] {
            width: 100%;
            padding: .75rem 1.5rem;
            font-size: 1.25rem;
            background-color: #000000;
            border: none;
            color: #fff;
            border-radius: .25rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button[type="submit"]:hover {
            background-color: #A6A6A6;
        }
        /* 입력 필드와 레이블 간격 조절 */
        label {
            margin-bottom: .5rem;
            display: block;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: .375rem .75rem;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: .25rem;
        }
    </style>
</head>
<body class="container font">
    <!-- 메인메뉴 -->
    <div>
    <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h1>상품등록</h1>
            <form method="post" action="/shop/emp/addGoodsAction.jsp" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="category" class="form-label">카테고리</label>
                    <select name="category" id="category" class="form-select">
                        <option value="">선택</option>
                        <% for(String c : categoryList) { %>
                            <option value="<%= c %>"><%= c %></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="goodsTitle" class="form-label">상품명</label>
                    <input type="text" name="goodsTitle" id="goodsTitle" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="goodsImg" class="form-label">상품 이미지</label>
                    <input type="file" name="goodsImg" id="goodsImg" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="goodsPrice" class="form-label">상품 가격</label>
                    <input type="number" name="goodsPrice" id="goodsPrice" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="goodsAmount" class="form-label">상품 수량</label>
                    <input type="number" name="goodsAmount" id="goodsAmount" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="goodsContent" class="form-label">상품 설명</label>
                    <textarea name="goodsContent" id="goodsContent" rows="5" class="form-control"></textarea>
                </div>
                <button type="submit" class="btn btn-dark">상품등록</button>
            </form>
        </div>
    </div>
</body>
</html>
