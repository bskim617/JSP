<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Bean.BookBean"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String bookId = request.getParameter("bookId");
	
	BookBean ub = null;
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `book` WHERE `bookId`='"+bookId+"'");
		
		if(rs.next()){
			ub = new BookBean();
			ub.setBookId(rs.getInt(1));
			ub.setBookName(rs.getString(2));
			ub.setPublisher(rs.getString(3));
			ub.setPrice(rs.getInt(4));
			
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
		<title>book::modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		
		<a href="/BookStore/index.jsp">처음으로</a>
		<a href="/BookStore/book/list.jsp">도서목록</a>
		
		<form action="./modifyrProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookId" readonly value="<%= ub.getBookId() %>" ></td> 
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" value="<%= ub.getBookName() %>"></td> 
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="<%= ub.getPublisher() %>"></td> 
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" value="<%= ub.getPrice() %>"></td> 
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
