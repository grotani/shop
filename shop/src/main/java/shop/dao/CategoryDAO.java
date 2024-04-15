package shop.dao;
import java.sql.*;
import java.util.*;

public class CategoryDAO {
	public static int addCategory (String category) throws Exception {
		int row = 0;
		// DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO category(category, create_date) VALUES (?, now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	public static  ArrayList<HashMap<String,Object>> categorylist (
			String category, String createDate) throws Exception {
			ArrayList<HashMap<String,Object>> list = 
					new ArrayList<HashMap<String,Object>>();
			
			Connection conn = DBHelper.getConnection();
			String sql = "SELECT category, create_date createDate FROM category";	
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				HashMap<String,Object> m = new HashMap<String,Object>();
				m.put("category",rs.getString("category"));
				m.put("createDate",rs.getString("createDate"));
				list.add(m);
			}
			
		conn.close();
		
		return list;
	}
	
	public static int deleteCategory (String category) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE FROM category WHERE category = ?"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	public static ArrayList<String> selectCategory() throws Exception{
		ArrayList<String> list = new ArrayList<String>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null; 

		String sql ="SELECT category FROM category";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			list.add(rs.getString("category"));
		}
		
		return list;
	}
	
}
