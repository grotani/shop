package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;


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
	
	// 로그인 
	// 호출 : loginAction.jsp
	// return : HashMap(메일,이름) 
	public static HashMap<String, String> login (String mail, String pw) throws Exception {
		HashMap<String, String> map = null;
		Connection conn = DBHelper.getConnection();
		String sql ="select mail,name from customer where mail = ? and pw = password(?)";
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
	
	// 비밀번호 변경
	// 호출 : editPwAction.jsp
	// return : int(1,성공 , 0 실패)
	public static int updatePw(String mail, String oldPw, String newPw) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "update customer  set pw = password(?)  where mail = ? and pw = password(?)"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, oldPw);
		
		conn.close();
		return row;
	}
	
}
