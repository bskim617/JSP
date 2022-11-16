<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.bean.RegisterBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<RegisterBean> rbs = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT a.`regStdNO`, b.`stdName`, c.`lecName`, a.`regLecNo`, a.`regMidScore`, a.`regFinalScore`, a.`regTotalScore`, a.`regGrade` FROM `register` AS a ";
			   sql += "JOIN `student` AS b ON a.`regStdNO` = b.`stdNo`";
			   sql += "JOIN `lecture` AS c ON a.`regLecNo` = c.`lecNO`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			RegisterBean rb = new RegisterBean();
			rb.setRegStdNo(rs.getString(1));
			rb.setStdName(rs.getString(2));
			rb.setLecName(rs.getString(3));
			rb.setRegLecNo(rs.getInt(4));
			rb.setRegMidScore(rs.getInt(5));
			rb.setRegFinalScore(rs.getInt(6));
			rb.setRegTotalScore(rs.getInt(7));
			rb.setRegGrade(rs.getString(8));
			
			rbs.add(rb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수강관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				// 수강신청 버튼 
				$('.btnSc').click(function(){
					$('section').show().find().val(); 
				});
				
				// 검색 버튼
				$('.btnSerch').click(function(){
					let regStdNo = $(this).val();
					$('.tb').find('input[name=no]').val(no).show(); 
				});
				
				// 닫기 버튼
				$('.btnCloss').click(function(){
					$('section').hide();
				});
				

				
				
			});
			
		
		
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>수강현황</h4>
		<input type="text" name="no">
		<button class="btnSerch">검색</button>
		<button class="btnSc">수강신청</button>
		<table class="tb" border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
			<% for(RegisterBean rb : rbs){ %>
			<tr>
				<td><%= rb.getRegStdNo() %></td>
				<td><%= rb.getStdName() %></td>
				<td><%= rb.getLecName() %></td>
				<td><%= rb.getRegLecNo() %></td>
				<td><%= rb.getRegMidScore() %></td>
				<td><%= rb.getRegFinalScore() %></td>
				<td><%= rb.getRegTotalScore() %></td>
				<td><%= rb.getRegGrade() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none;">
			<h4>수강관리</h4>
			<button class="btnCloss">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="regStdNo"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td>
						<select class="class">
							<option>강좌선택</option>
							<option>인지행동심리학</option>
							<option>운영체제론</option>
							<option>중급 영문법</option>
							<option>세범개론</option>
							<option>빅데이터 개론</option>
							<option>컴퓨팅사고와 코딩</option>
							<option>컴퓨터 구조론</option>
							<option>사회복지 마케팅</option>
						</select>
					</td>
				</tr>
					<td colspan="2" align="right"><input type="submit" value="신청"></td>
				</tr>
			</table>
		</section>
		
		
	</body>
</html>
