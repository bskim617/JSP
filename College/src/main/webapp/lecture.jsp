<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.bean.LectureBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<LectureBean> lbs = new ArrayList<>();	

	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT * FROM `lecture`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			LectureBean lb = new LectureBean();
			lb.setLecNo(rs.getInt(1));
			lb.setLecName(rs.getString(2));
			lb.setLecCredit(rs.getInt(3));
			lb.setLecTime(rs.getInt(4));
			lb.setLecClass(rs.getString(5));
			
			lbs.add(lb);
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
		<title>강좌관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				// 등록버튼 
				$('.btnClass').click(function(){
					$('section').show().find().val(); 
				});
				
				// 닫기버튼
				$('.btnCloss').click(function(){
					$('section').hide();
				});
				
				// 추가버튼
				$('input[type=submit]').click(function(){
					let lecNo = $('input[name=lecNo]').val();
					let lecName = $('input[name=lecName]').val();
					let lecCredit = $('input[name=lecCredit]').val();
					let lecTime = $('input[name=lecTime]').val();
					let lecClass = $('input[name=lecClass]').val();
					
					
					let jsonData = {
							"lecNo" : lecNo,
							"lecName" : lecName,
							"lecCredit" : lecCredit,
							"lecTime" : lecTime,
							"lecClass" : lecClass
					};
					
					console.log(jsonData);
					
					
					$.ajax({
						url :'/College/lectureProc.jsp',
						type : 'POST',
						data : jsonData ,
						dataType : 'json',
						success : function(data){
							if(data.result == 1){
								alert('입력성공');
							}else{
								alert('입력실패');
							}
						}
					});
					
				});
			});
		
		</script>
	</head>
	<body>
		<h3>강좌관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>강좌현황</h4>
		<button class="btnClass">등록</button>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장</th>
			</tr>
			<% for(LectureBean lb : lbs){ %>
			<tr>
				<td><%= lb.getLecNo() %></td>
				<td><%= lb.getLecName() %></td>
				<td><%= lb.getLecCredit() %></td>
				<td><%= lb.getLecTime() %></td>
				<td><%= lb.getLecClass() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none;">
			<h4>강좌등록</h4>
			<button class="btnCloss">닫기</button>
			<table border="1">
				<tr>
					<td>번호</td>
					<td><input type="text" name="lecNo"></td>
				</tr>
				<tr>
					<td>강좌명</td>
					<td><input type="text" name="lecName"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" name="lecCredit"></td>
				</tr>
				<tr>
					<td>시간</td>
					<td><input type="text" name="lecTime"></td>
				</tr>
				<tr>
					<td>강의장</td>
					<td><input type="text" name="lecClass"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="추가"></td>
				</tr>
			</table>
		</section>
		
		
	</body>
</html>
