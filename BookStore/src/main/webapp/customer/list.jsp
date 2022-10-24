<%@page import="Bean.CustomerBean"%>
<%@page import="Bean.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerBean> cus = new ArrayList<>();	

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
		
		while(rs.next()){
			CustomerBean ub = new CustomerBean();
			ub.setCustId(rs.getInt(1));
			ub.setName(rs.getString(2));
			ub.setAddress(rs.getString(3));
			ub.setPhone(rs.getString(4));
			
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
		<title>customer::list</title>
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="/BookStore/index.jsp">처음으로</a>
		<a href="/BookStore/customer/register.jsp">고객등록</a>
		
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			
			<% for(CustomerBean ub : cus){ %>
			<tr>
				<td><%= ub.getCustId() %></td>
				<td><%= ub.getName() %></td>
				<td><%= ub.getAddress() %></td>
				<td><%= ub.getPhone() %></td>
				<td>
					<a href="./modify.jsp?custId=<%= ub.getCustId() %>">수정</a>
					<a href="./delete.jsp?custId=<%= ub.getCustId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>
