<%@page import="config.DBCP"%>
<%@page import="Bean.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<BookBean> books = new ArrayList<>();	

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `book`");
		
		while(rs.next()){
			BookBean ub = new BookBean();
			ub.setBookId(rs.getInt(1));
			ub.setBookName(rs.getString(2));
			ub.setPublisher(rs.getString(3));
			ub.setPrice(rs.getInt(4));
			
			books.add(ub);
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
		<title>book::list</title>
	</head>
	<body>
		<h3>도서목록</h3>
		<a href="/BookStore/index.jsp">처음으로</a>
		<a href="/BookStore/book/register.jsp">도서등록</a>
		
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			
			<% for(BookBean ub : books){ %>
			<tr>
				<td><%= ub.getBookId() %></td>
				<td><%= ub.getBookName() %></td>
				<td><%= ub.getPublisher() %></td>
				<td><%= ub.getPrice() %></td>
				<td>
					<a href="./modify.jsp?bookId=<%= ub.getBookId() %>">수정</a>
					<a href="./delete.jsp?bookId=<%= ub.getBookId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>
