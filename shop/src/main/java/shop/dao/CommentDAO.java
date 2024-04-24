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
	public static int addComment(int goodsNo, int ordersNo, int score, String content) throws Exception {
	    int row = 0;
	    Connection conn = DBHelper.getConnection();
	    
	    // 주문번호로 이미 후기가 존재하는지 확인
	    String checkSql = "SELECT COUNT(*) AS count FROM comment WHERE orders_no = ?";
	    PreparedStatement checkStmt = conn.prepareStatement(checkSql);
	    checkStmt.setInt(1, ordersNo);
	    ResultSet rs = checkStmt.executeQuery();
	    rs.next();
	    int count = rs.getInt("count");
	    checkStmt.close();
	    
	    // 이미 후기가 존재하면 추가하지 않음
	    if (count > 0) {
	        conn.close();
	        return row;
	    }
	    
	    // 주문번호가 존재하고, 주문이 배송완료 상태인 경우에만 후기를 추가
	    String sql = "INSERT INTO comment (goods_no, orders_no, score, content, update_date, create_date)"
	               + " SELECT ?, ?, ?, ?, NOW(), NOW()"
	               + " FROM orders o"
	               + " WHERE o.orders_no = ? AND o.state = '배송완료'";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, goodsNo);
	    stmt.setInt(2, ordersNo);
	    stmt.setInt(3, score);
	    stmt.setString(4, content);
	    stmt.setInt(5, ordersNo);
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
		  
		   String SqlPage = "SELECT COUNT(*) FROM comment"
		   		+ " INNER JOIN goods ON comment.goods_no = goods.goods_no"
		   		+ " WHERE goods.goods_no = ?";
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
				
