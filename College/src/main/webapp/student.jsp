<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.bean.StrudentBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<StrudentBean> sbs = new ArrayList<>();	
	
	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT * FROM `student`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			StrudentBean sb = new StrudentBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdName(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getInt(4));
			sb.setStdAddress(rs.getString(5));
			
			sbs.add(sb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
		
	}catch(Exception e) {
		e.printStackTrace();
	}


%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>학생관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				// 등고 버튼 
				$('.btnStudent').click(function(){
					$('section').show().find().val(); 
				});
				
				// 닫기 버튼
				$('.btnCloss').click(function(){
					$('section').hide();
				});
				
				// 등록 버튼
				$('input[type=submit]').click(function(){
					let stdNo = $('input[name=stdNo]').val();
					let stdName = $('input[name=stdName]').val();
					let stdHp = $('input[name=stdHp]').val();
					let stdYear = $('select[name=stdYear]').val();
					let stdAddress = $('input[name=stdAddress]').val();
					
					
					let jsonData = {
							"stdNo" : stdNo,
							"stdName" : stdName,
							"stdHp" : stdHp,
							"stdYear" : stdYear,
							"stdAddress" : stdAddress
					};
					
					console.log(jsonData);
					
					
					$.ajax({
						url :'/College/studentProc.jsp',
						type : 'POST',
						data : jsonData ,
						dataType : 'json',
						success : function(data){
							if(data.result == 1){
								alert('등록성공');
							}else{
								alert('등록실패');
							}
						}
					});
					
				});
				
			});
		
		</script>
	</head>
	<body>
		<body>
		<h3>학생관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>학생목록</h4>
		<button class="btnStudent">등록</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<% for(StrudentBean sb : sbs){ %>
			<tr>
				<td><%= sb.getStdNo() %></td>
				<td><%= sb.getStdName() %></td>
				<td><%= sb.getStdHp() %></td>
				<td><%= sb.getStdYear() %></td>
				<td><%= sb.getStdAddress() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none;">
			<h4>학생등록</h4>
			<button class="btnCloss">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp"></td>
				</tr>
				<tr>
					<td>학년</td>
					<td>
						<select name="stdYear">
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
							<option value="4">4학년</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록"></td>
				</tr>
			</table>
		</section>
	</body>
</html>
