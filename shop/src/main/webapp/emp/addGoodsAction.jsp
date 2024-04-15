<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
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

	Part part =  request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx); // .png
	System.out.println(ext);
	
	UUID uuid = UUID.randomUUID(); // 절대 중복될 수 없는 
	String filename = uuid.toString().replace("-", "");
	filename = filename + ext;
	System.out.println(filename);
	
	
	int row = GoodsDAO.insertGoods(category, goodsTitle, filename, goodsContent, goodsPrice, goodsAmount);
	
	if(row == 1) { // insert 성공하면파일업로드 
		// part -> is -> os -> 빈파일로 
		// 1.
		InputStream is = part.getInputStream();
		// 3+2.
		String filePath = request.getServletContext().getRealPath("upload");
		File f  = new File(filePath, filename); // 빈파일 
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		os.close();
		is.close();
	}
	
	/*
	파일 삭제할 때 사용할 코드
	File df = new File(filePath, rs.getSting("filename"));
	df.delete();
	*/
%>
<!-- Controller Layer -->
<%
	if(row == 1) {
		response.sendRedirect("/shop/emp/goodsList.jsp");  
	} else {
		 response.sendRedirect("/shop/emp/goodsList.jsp");  
	}
	
	
%>
