package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersDAO {
	

	
	// 고객이 상품 주문하기
	// 호출 ordersGoodsAction.jsp
	// return : int (1이면 주문성공 , 0 이면 주문실패)
	public static int insertOrder (String mail, int goodNo, int totalAmount, int totalPrice, String addres) 
		throws Exception {
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql ="insert into orders(mail, goods_no, total_amount, total_price, addres, state, update_date, create_date)"
				+ " values(?,?,?,?,?,'결제완료',now(), now()";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodNo);
		stmt.setInt(3, totalAmount);
		stmt.setInt(4, totalPrice);
		stmt.setString(5, addres);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	
	// 고객이 자신의 주문 정보를 확인 
	// 호출 : orderCheck.jsp
	// param : void
	// return : orders & goods 테이블 join 결과를  ArrayList로  
	public static ArrayList<HashMap<String, Object>> selectOrderListByCustomer(
			String mail, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list
			= new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "select o.orders_no ordersNo,"
				+ " o.goods_no goodsNo, g.goods_title goodsTitle"
				+ " from orders o inner join goods g"
				+ " on o.goods_no = g.goods_no"
				+ " where o.mail = ?"
				+ " order by o.orders_no desc"
				+ " limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			list.add(m);
		}
		conn.close();
		return list;
	}

	// 
}
