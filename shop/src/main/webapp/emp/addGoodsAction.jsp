<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>
<!-- 세션 설정값  : 입력시 로그인 emp의 emp_id 값이 필요해서 -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>

<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String goodsContent = request.getParameter("goodsContent");
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));

	

	String sql = "INSERT INTO goods(category, emp_id, goods_title , goods_content , goods_price , goods_amount , update_date, create_date) VALUES(?,'admin',?,?,?,?,NOW(),NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	int row = 0;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	stmt.setString(2,goodsTitle);
	stmt.setString(3,goodsContent);
	stmt.setInt(4, goodsPrice);
	stmt.setInt(5,goodsAmount );
	
	
	System.out.println(stmt+"상품등록");
	row = stmt.executeUpdate();
	
%>
<!-- Controller Layer -->
<%
	if(row == 1) {
		response.sendRedirect("/shop/emp/goodsList.jsp");  
	} else {
		 response.sendRedirect("/shop/emp/goodsList.jsp");  
	}
	
	
%>
