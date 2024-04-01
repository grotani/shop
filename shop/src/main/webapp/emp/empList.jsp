<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 인증분기 : 세션 변수 이름 = > loginEmp
	
	if(session.getAttribute("loginEmp") == null) { 
		response.sendRedirect("/shop/emp/empLoginForm.jsp"); 
		return;
	}
	
	String sql = "Select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active From emp Order by active asc, hire_date desc";
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();


%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>사원목록</h1>
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	<hr>
	<table border="1">
		<%
			while (rs.next()) { 
		%>
		<tr>
			<th>ID</th>
			<th><%=rs.getString("empId") %></th>	
		</tr>
		<tr>
			<th>Name</th>
			<th><%=rs.getString("empName") %></th>
		</tr>
		<tr>
			<th>empJob</th>
			<th><%=rs.getString("empJob") %></th>
		</tr>
		<tr>
			<th>hireDate</th>
			<th><%=rs.getString("hireDate") %></th>
		</tr>
		<tr>
			<th>active</th>
			<th><%=rs.getString("active") %>	
				<a href="/shop/emp/modifyEmpActive.jsp?empId=<%=rs.getString("empId")%>&active=<%=rs.getString("active")%>">권한변경</a>
			</th>
		</tr>
	<%
		}
	 %>	
	</table>
	
</body>
</html>