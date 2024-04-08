<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.nio.file.*" %>
<%
	
	// goods 삭제요청값 
	String goodsNo = request.getParameter("goodsNo");
	String category = request.getParameter("category");
	System.out.println(goodsNo+"삭제할굿즈");
	System.out.println(category+"카테고리");
	
	System.out.println(request.getParameter("filename"));
	String sql = "DELETE FROM goods WHERE goods_no = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, goodsNo);
	
	int row = stmt.executeUpdate();
	
	if(row == 1) {
		String filePath = request.getServletContext().getRealPath("upload");
		File df = new File(filePath, request.getParameter("filename"));
		df.delete();
		
		System.out.println("삭제");
		response.sendRedirect("/shop/emp/goodsList.jsp?category="+URLEncoder.encode(category,"utf-8"));
		
	} else {
		System.out.println("안 걸리니?");

	}
	
%>