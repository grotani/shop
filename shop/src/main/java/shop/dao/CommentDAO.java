package shop.dao;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CommentDAO {
	
	// 고객 배송완료 상태 변경되면 리뷰쓰기
	// 호출 : addCommentForm.jsp
	// return : int
	public static int addComment (int score, String content)
						throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "insert into comment (orders_no, score, content, update_date, create_date)"
				+ " select o.orders_no, ?, ?, NOW(), NOW()"
				+ " from orders o"
				+ " left join comment c ON o.orders_no = c.orders_no"
				+ " where o.state = '배송완료' AND c.orders_no IS NULL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, score);
		stmt.setString(2, content);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
		// 후기 작성된 주문번호 확인 하여 후기작성완료 처리 해주기
		// 호출 : orderCheck.jsp 
		// return : boolean (true = 후기작성완료 / false= 후기미작성)
	  public static boolean hasComment(int ordersNo) throws Exception {
	        boolean hasComment = false;	// 후기가 없으면          
		  	Connection conn = DBHelper.getConnection();
	        String sql = "SELECT COUNT(*) AS count FROM comment WHERE orders_no = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, ordersNo);
	        ResultSet rs = stmt.executeQuery();
	      
	        hasComment = rs.next() && rs.getInt("count") > 0;

	        conn.close();
	        return hasComment;
		
        
    }
	  // 고객이 작성한 후기 보기 & 페이징 
	  // 호출 :  commentList.jsp
	  // return : ArrayList<Hash<String,Object>
	  // commentList 페이징
	   public static int page () throws Exception {
		   int totalRow = 0;
		   
		   Connection conn = DBHelper.getConnection();
		   String SqlPage = "select count(*) from comment";
		   PreparedStatement stmt = conn.prepareStatement(SqlPage);
		   ResultSet rs = stmt.executeQuery();
		   
		   if(rs.next()) {
			   totalRow = rs.getInt("count(*)");
			   
		   }
		   conn.close();
		   return totalRow;
	   }
	  
	  public static ArrayList<HashMap<String, Object>> commentList (int startRow, int rowPerPage) throws Exception {
		  ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		  Connection conn = DBHelper.getConnection();
		  String sql = "select orders_no ordersNo, score, content, update_date updateDate, create_date createDate"
		  		+ " from comment"
		  		+ " order by create_date desc LIMIT ?, ?";		
		  PreparedStatement stmt = conn.prepareStatement(sql);
		  stmt.setInt(1,startRow );
		  stmt.setInt(2,rowPerPage );
		  
		  ResultSet rs = stmt.executeQuery();
		  while (rs.next()) {
			  HashMap<String, Object> m = new HashMap<String, Object>();
			  m.put("ordersNo", rs.getInt("ordersNo"));
			  m.put("score", rs.getInt("score"));
			  m.put("content",rs.getString("content"));
			  m.put("updateDate",rs.getString("updateDate"));
			  m.put("createDate",rs.getString("createDate"));
			  list.add(m);
		  }
		  conn.close();
		  return list;
		  
	  }
	  // 고객이 작성한 후기 삭제하기 악플방지
	  // 호출 : deleteCommentList.jsp
	  // return : int  (리뷰삭제 실패 0 , 리뷰삭제 성공 1)
	  public static int deleteComment (int ordersNo) throws Exception {
		  int row = 0;
		  Connection conn = DBHelper.getConnection();
		  String sql ="DELETE FROM comment WHERE orders_no= ?";
		  PreparedStatement stmt = conn.prepareStatement(sql);
		  stmt.setInt(1, ordersNo);
		  row = stmt.executeUpdate();
		  
		  conn.close();
		  return row;
	  }
	  
	  // (관리자)상품상세보기에서 후기 보여주기 
	  // 호출 : emp / goodsOne.jsp
	  // return : ArrayList<HashMap<String,Object>>
	  public static ArrayList<HashMap<String,Object>> selectCommentList (
			  int goodsNo, int startRow, int rowPerPage) throws Exception {
		  ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		  Connection conn = DBHelper.getConnection();
		  String sql ="SELECT c.score, c.content, c.create_date createDate"
		  		+ " FROM COMMENT c INNER JOIN orders o"
		  		+ " ON c.orders_no = o.orders_no"
		  		+ " WHERE o.goods_no = ?"
		  		+ " LIMIT ?,?";
		  PreparedStatement stmt = conn.prepareStatement(sql);
		  stmt.setInt(1,goodsNo);
		  stmt.setInt(2,startRow);
		  stmt.setInt(3,rowPerPage);
		  ResultSet rs = stmt.executeQuery();
		  while (rs.next()) {
			  HashMap<String, Object> m = new HashMap<String, Object>();
			  m.put("score", rs.getString("score"));
			  m.put("content", rs.getString("content"));
			  m.put("createDate", rs.getString("createDate"));
			  list.add(m);
		  }
		  conn.close();
		  return list;
	  }
	// (관리자)상품상세보기에서 후기 보여주기 페이징 
	// 호출 : emp / goodsOne.jsp
	// return : int 
	   public static int commentPage (int goodsNo ) throws Exception {
		   int totalRow = 0;
		   
		   Connection conn = DBHelper.getConnection();
		   String SqlPage = "SELECT COUNT(*) FROM comment INNER JOIN goods g"
		   		+  " WHERE g.goods_no = ?";
		   PreparedStatement stmt = conn.prepareStatement(SqlPage);
		   stmt.setInt(1,goodsNo);
		   ResultSet rs = stmt.executeQuery();
		   
		   if(rs.next()) {
			   totalRow = rs.getInt("count(*)");
			   
		   }
		   conn.close();
		   return totalRow;
	   }
	  
}
				
