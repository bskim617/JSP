package kr.co.shop.db;

public class Sql {
	public static final String SELECT_CUSTOMER = "SELECT * FROM `customer`";
	
	public static final String SELECT_ORDER = "SELECT a.*, b.`name`, c.`prodName` FROM `order` AS a "
			+ "JOIN `customer` AS b ON a.orderId = b.custid "
			+ "JOIN `product` AS c ON a.orderProduct = c.prodNo ";
											
	public static final String SELECT_PRODUCT = "SELECT * FROM `product`";
	
}
