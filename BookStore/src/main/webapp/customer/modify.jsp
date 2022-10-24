<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="Bean.CustomerBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String custId = request.getParameter("custId");
	
	CustomerBean ub = null;
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer` WHERE `custId`='"+custId+"'");
		
		if(rs.next()){
			ub = new CustomerBean();
			ub.setCustId(rs.getInt(1));
			ub.setName(rs.getString(2));
			ub.setAddress(rs.getString(3));
			ub.setPhone(rs.getString(4));
			
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
		<title>customer::modify</title>
	</head>
	<body>
		<h3>고객수정</h3>
		
		<a href="/BookStore/index.jsp">처음으로</a>
		<a href="/BookStore/customer/list.jsp">고객목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>고객번호</td>
					<td><input type="number" name="custId" readonly value="<%= ub.getCustId() %>"></td> 
				</tr>
				<tr>
					<td>고객</td>
					<td><input type="text" name="name" value="<%= ub.getName() %>"></td> 
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value="<%= ub.getAddress() %>"></td> 
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" value="<%= ub.getPhone() %>"></td> 
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정">
					</td> 
				</tr>
			</table>
		</form>
	</body>
</html>
