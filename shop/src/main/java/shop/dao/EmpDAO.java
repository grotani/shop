package shop.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class EmpDAO {
	public static int insertEmp(String empId, String empPw, String empName, String empJob) throws Exception {
	      int row = 0;
	      // DB 접근
	      Connection conn = DBHelper.getConnection();
	      String sql = "insert ...?";
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      stmt.setString(1, empId);
	      stmt.setString(2, empPw);
	      stmt.setString(3, empName);
	      stmt.setString(4, empJob);
	      
	      row = stmt.executeUpdate();
	       
	      conn.close();
	      return row;
	      
	   }
	   // HashMap<String, Object> : null이면 로그인실패, 아니면 성공
	   // String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	   
	   // 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	   public static HashMap<String, Object> empLogin(String empId, String empPw)
	                                       throws Exception {
	      HashMap<String, Object> resultMap = null;
	      
	      Connection conn = DBHelper.getConnection();
	      
	      String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
	      PreparedStatement stmt=conn.prepareStatement(sql);
	      stmt.setString(1,empId);
	      stmt.setString(2,empPw);
	      ResultSet rs = stmt.executeQuery();
	      if(rs.next()) {
	         resultMap = new HashMap<String, Object>();
	         resultMap.put("empId", rs.getString("empId"));
	         resultMap.put("empName", rs.getString("empName"));
	         resultMap.put("grade", rs.getInt("grade"));
	      }
	      conn.close();
	      return resultMap;
	   }
	   
	   // empList 페이징
	   public static int page () throws Exception {
		   int totalRow = 0;
		   
		   Connection conn = DBHelper.getConnection();
		   String SqlPage = "select count(*) from emp";
		   PreparedStatement stmt = conn.prepareStatement(SqlPage);
		   ResultSet rs = stmt.executeQuery();
		   
		   if(rs.next()) {
			   totalRow = rs.getInt("count(*)");
			   
		   }
		   conn.close();
		   return totalRow;
	   }
	   
	   public static ArrayList<HashMap<String, Object>> empList (int startRow, int rowPerPage) throws Exception {
		   ArrayList<HashMap<String,Object>> list =
					new ArrayList<HashMap<String,Object>>();
		   Connection conn = DBHelper.getConnection();
		   
			String sql="select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active From emp Order by hire_date desc limit ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1,startRow);
			stmt.setInt(2,rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>(); 
				m.put("empId", rs.getString("empId"));
				m.put("empName", rs.getString("empName"));
				m.put("empJob", rs.getString("empJob"));
				m.put("hireDate", rs.getString("hireDate"));
				m.put("active", rs.getString("active"));
				list.add(m);
		
	   }
			conn.close();
			return list;
	   }
	   
	   // 직원상세정보 보기
	   // 호출 : empOne.jsp
	   // return Array<HashMap<String, Object>
	   
	   public static ArrayList<HashMap<String, Object>> empOne (String empName) throws Exception {
		   ArrayList<HashMap<String,Object>> list = 
				   new  ArrayList<HashMap<String,Object>>();
		   Connection conn = DBHelper.getConnection();
		   
		   String sql = "select emp_id empId, grade, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_name = ?";
		   PreparedStatement stmt = conn.prepareStatement(sql);
		   stmt.setString(1,empName );
		   
		   ResultSet rs = stmt.executeQuery();
		   while (rs.next()) {
			   HashMap<String, Object> m = new HashMap<String, Object>();
			   m.put("empId", rs.getString("empId"));
			   m.put("grade", rs.getInt("grade"));
			   m.put("empName", rs.getString("empName"));
			   m.put("empJob", rs.getString("empJob"));
			   m.put("hireDate", rs.getString("hireDate"));
			   m.put("active", rs.getString("active"));
			   list.add(m);
		   }
		   conn.close();
		   return list;
		   
		   
	   }
	   
	   // 직원 권한변경 SQL 관리자만이 가능함
	   // 호출 : modifyEmpActive.jsp
	   // return : int (권한변경실패 0 , 권한변경성공 1)
	   public static int modifyEmp(String active, String empId) throws Exception {
			
			int row = 0 ;
			Connection conn = DBHelper.getConnection();
			String sql = "update emp set active = ? where emp_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			if(active.equals("ON")){
				stmt.setString(1,"OFF");
			}else if(active.equals("OFF")){
				stmt.setString(1,"ON");
			}
			stmt.setString(2,empId);
			
			row = stmt.executeUpdate(); 
			
			conn.close();
			return row;
		}
	   
	}
