<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>student::register</title>
	</head>
	<body>
		<h3>student 등럭하기</h3>
		
		<form action="./registerProc.sjp" method="post">
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdno" placeholder="학번 입력"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdname" placeholder="이름 입력"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="stdhp" placeholder="전화번호 입력"></td>
				</tr>
				<tr>
					<td>학년</td>
					<td>
						<select name="stdyear">
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdaddr" placeholder="주소 입력"></td>
				</tr>
					<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록하기">
					</td> 
				</tr>
				
			</table>
		</form>
	</body>
</html>
