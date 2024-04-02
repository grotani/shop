<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Control Layer -->
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}	
%>	

<%
	// request분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage-1) *rowPerPage;
	
	
	
%>

<!-- Model Layer -->
<%
	// 모델(특수한 형태의 데이터 (RDBMS:mairadb)자료구조 값) 
	// -> API 사용(JDBD API)해서 자료구조(ResultSet) 취득한다 
	// -> 일반화된 자료구조로 (ArrayList<Hashmap>)로  변경을 해야 한다 -> 모델 취득
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql="select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active From emp Order by hire_date desc limit ?, ?";
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,startRow);
	stmt.setInt(2,rowPerPage);
	rs = stmt.executeQuery();  
	// JDBD API 종속된 자료구조를  -> 기본API 자료구조형(ArrayList) 으로 변경
	
	
	
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	// ResultSet -> ArratList <HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>(); 
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);
	}
	// JDBC API 사용이 끝났다면  DB 자원들을 반납
	
%>

<!-- View Layer : 모델 (ArrayList<HashMap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>사원목록</h1>
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	<table border="1">
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>	
		</tr>
		<%
			for(HashMap<String,Object> m : list) {
		%>
			<tr>
				<td><%=(String)(m.get("empId"))%></td>
				<td><%=(String)(m.get("empName"))%></td>
				<td><%=(String)(m.get("empJob"))%></td>
				<td><%=(String)(m.get("hireDate"))%></td>
				<td>
					<a href='/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active")) %>&empId=<%=(String)(m.get("empId"))%>'>
						<%=(String)(m.get("active"))%>
					</a>
				</td>
			</tr>
		<% 		
			}
		%>
		
		
	</table>
	
</body>
</html>