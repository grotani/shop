package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
				
