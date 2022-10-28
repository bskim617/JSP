<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.shop.bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shop.db.Sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerBean> cus = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_CUSTOMER);
		
		while(rs.next()){
			CustomerBean ub = new CustomerBean();
			ub.setCustid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setHp(rs.getString(3));
			ub.setAddr(rs.getString(4));
			ub.setRdate(rs.getString(5));
			
			cus.add(ub);
		}
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Shop::customer</title>
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>주소</th>
				<th>가입일</th>
			</tr>
			<% for(CustomerBean ub : cus){ %>
			<tr>
				<td><%= ub.getCustid() %></td>
				<td><%= ub.getName() %></td>
				<td><%= ub.getHp() %></td>
				<td><%= ub.getAddr() %></td>
				<td><%= ub.getRdate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>
