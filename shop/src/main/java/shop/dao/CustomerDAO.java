package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.spi.DirStateFactory.Result;


public class CustomerDAO {
	// 회원가입 메일 중복확인 
	// 호출 : checnkIdAction.jsp
	// return :  boolean (사용가능 true, 불가 false)
	public static boolean checkMail(String mail) throws Exception {
		boolean result = false; // false 면 회원가입가능 
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT mail FROM customer WHERE mail =?"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		ResultSet rs = stmt.executeQuery();
		if(!rs.next()) {
			result = true;
		}
			
		conn.close();
		return result;
	}
	
	// 회원가입 Action
	// 호출 : addCustomerAction.jsp
	// return : int (입력실패 0 , 입력성공 1)
	public static int insertCustomer(String mail, String pw, String name, String birth, String gender)
		throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql="INSERT INTO customer(mail, pw, name, birth, Gender,update_date, create_date)VALUES (?, PASSWORD(?), ?, ?, ?,NOW(),NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
	// 회원가입시 고객 pw테이블 이력적재 추후 pw변경시 기존 pw 재사용 불가를 위한
	// 호출 : addCustomerAction.jsp
	// return : int 
	public static int inertCustompw(String mail, String pw) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO cpw_history(mail, pw, createdate)"
				+ " VALUES(?, PASSWORD(?), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
				 
	}
	// 로그인 
	// 호출 : loginAction.jsp
	// return : HashMap(메일,이름) 
	public static HashMap<String, String> login (String mail, String pw) throws Exception {
		HashMap<String, String> map = null;
		Connection conn = DBHelper.getConnection();
		/*String sql ="select mail,name from customer where mail = ? and pw = password(?)";*/
		String sql = "SELECT c.mail, c.name"
				+ " FROM"
				+ " (SELECT c.mail, c.name, ph.pw, ph.createdate"
				+ " FROM customer c INNER JOIN cpw_history ph"
				+ " ON c.mail = ph.mail"
				+ " WHERE c.mail= ?"
				+ " ORDER BY ph.createdate DESC"
				+ " LIMIT 0,1) c"
				+ " WHERE c.pw= PASSWORD(?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, String>();
			map.put("mail", rs.getString("mail"));
			map.put("name", rs.getString("name"));
		}
		conn.close();
		return map;
		
	}
	// 비밀번호 변경시 중복 확인 
	// 호출 : cpwCheckAction.jsp 
	// return : boolean (true 사용가능 , false 사용불가능 )
	public static boolean checkPw(String mail, String pw) throws Exception {
		boolean result = false;
		Connection conn = DBHelper.getConnection();
	    String sql = "SELECT * FROM cpw_history WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if(!rs.next()) {
			result = true;
		}
		conn.close();
		return result;
	}
	
	
	// 비밀번호 변경
	// 호출 : editPwAction.jsp
	// return : int(1,성공 , 0 실패)
	public static int updatePw(String mail, String newPw) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		/*String sql = "update customer  set pw = password(?), update_date = now()  where mail = ? and pw = password(?)";*/ 
		String sql = "INSERT INTO cpw_history(mail, pw, createdate"
				+ " VALUES(?,PASSWORD(?), NOW())";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, newPw);		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	 
	
	// 회원정보 보여주기
	// 호출 : customerOne.jsp
	// param : String(mail, name, birth, gender)
	// return : ArrayListHashMap 
	public static ArrayList<HashMap<String, Object>> customerOne (String name) throws Exception {
		ArrayList<HashMap<String, Object>> list  = new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT mail, pw, NAME, birth, gender, update_date updateDate, create_date createDate FROM customer WHERE NAME = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,name);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			m.put("birth", rs.getString("birth"));
			m.put("pw", rs.getString("pw"));
			m.put("gender", rs.getString("gender"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	// 회원 탈퇴
	// 호출 : deleteCustomer.jsp 
	// param : String (세션안 mail),String(pw)
	// return : int(1이면 탈퇴, 0이면 탈퇴실패)
	
	public static int deleteCustomer(String mail, String pw) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "delete from customer where mail = ? and pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}
	// 관리자 페이지에서 전체 회원정보 보기 (pw제외)
	// 호출 emp/customerList.jsp
	// param : void
	// return : customer 배열 (리스트) ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectCustomerListByPage(
			int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select mail, name, birth, gender, update_date updateDate,"
				+ " create_date createDate"
				+ " from customer"
				+ " order by mail"
				+ " limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			m.put("birth", rs.getString("birth"));
			m.put("gender", rs.getString("gender"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			list.add(m);
			
		}
		conn.close();
		return list;
	}
	
	
	
}
