package shop.dao;
import java.sql.*;
import java.util.*;
import java.sql.Connection;

public class GoodsDAO {
	
	// goods 목록 보여주기 
	public static ArrayList<HashMap<String,Object>> selectGoodsList (
	String category, String serchWord, int startRow, int rowPerPage)  throws Exception {
	ArrayList<HashMap<String,Object>> list =
			new ArrayList<HashMap<String,Object>>();
	
		Connection conn = DBHelper.getConnection();
		
		String sql = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category Like ? and (goods_title Like ?) limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,"%"+category+"%");
		stmt.setString(2,"%"+serchWord+"%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		
		System.out.println(stmt);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object> ();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
	
	public static int insertGoods (String category, String goodsTitle, String filename, String goodsContent, int goodsPrice, int goodsAmount) 
		throws Exception {
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO goods(category, emp_id, goods_title ,filename, goods_content , goods_price , goods_amount , update_date, create_date) VALUES(?,'admin',?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,category);
		stmt.setString(2,goodsTitle);
		stmt.setString(3,filename);
		stmt.setString(4,goodsContent);
		stmt.setInt(5,goodsPrice);
		stmt.setInt(6,goodsAmount );
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}
	
	public static int deleteGoods (String goodsNo) throws Exception {
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, goodsNo);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;

	}
	
	// goods 상세보기 
	public static ArrayList<HashMap<String,Object>> goodsOne (int goodsNo)throws Exception {
		ArrayList<HashMap<String,Object>> list =
				new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("createDate", rs.getString("createDate"));
			list.add(m);
			
			
	}
			conn.close();
			return list;
	}
	
	public static int updateGoods (int goodsNo, String goodsTitle,
							String goodsContent, int goodsPrice, int goodsAmount) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE goods SET goods_title =?, goods_content =?, goods_price=?, goods_amount=?, update_date=NOW() WHERE goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,goodsTitle);
		stmt.setString(2,goodsContent);
		stmt.setInt(3,goodsPrice);
		stmt.setInt(4,goodsAmount);
		stmt.setInt(5,goodsNo);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	public static int updateGoodsform (int goodsNo) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT category, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;

	}
	
	public static int page (String category) throws Exception {
		int totalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sqlPage = "select count(*) from goods where category like ?";
		PreparedStatement stmt = conn.prepareStatement(sqlPage);
		stmt = conn.prepareStatement(sqlPage);
		stmt.setString(1, "%"+category+"%");
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow = rs.getInt("count(*)");
		}
		conn.close();
		return totalRow;
	}
	
	
	
	// 고객 로그인 후 상품목록 페이지
	// customer/custGoodsList.jsp
	// param : void 
	// return : Goods의 일부속성이 필요 배열 => ArrayList<HashMap<String, Object>
	
	public static ArrayList<HashMap<String, Object>> selectGoodsList (
			String category, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		if(category != null || category.equals("")) {
			sql = "select goods_no goodsNo, category, goods_title goodsTitle,"
					+ " goods_price goodsPrice"
					+ " from goods "
					+ " where category = ?"					
					+ " order by goods_no desc "
					+ " offset ? rows fetch next ? rows only"; // DB수정하기 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			
		} else {
			sql = "select goods_no goodsNo, category, goods_title goodsTitle,"
					+ " goods_price goodsPrice"
					+ " from goods order by goods_no desc offset ? rows fetch next ? rows only"; // DB수정하기 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);	
		}
		rs = stmt.executeQuery();
		return list;
	}
	
}
