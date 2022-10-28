<%@page import="kr.co.shop.db.Sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.shop.bean.ProductBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<ProductBean> pros = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_PRODUCT);
		
		while(rs.next()){
			
			ProductBean pb = new ProductBean();
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			
			pros.add(pb);
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
		<title>Shop::product</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.btnOrder').click(function(){
					let prdoNo = $(this).val();
					$('section').show().find('input[name=prodNo]').val(prdoNo); // 디스플레이 논이기 때문에 쇼가 먼저 나오고 그다음 파인드
				});
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				// 최종 주문하기 버튼
				$('input[type=submit]').click(function(){
					
					let prodNo      = $('input[name=prodNo]').val();
					let prodCount   = $('input[name=prodCount]').val();
					let prodOrderer = $('input[name=prodOrderer]').val();
					
					let jsonData = {
							"prodNo": prodNo,
							"prodCount": prodCount,
							"prodOrderer": prodOrderer
					};
					
					console.log('jsonData : ' + jsonData);
					
					$.ajax({
						url:'./registerProc.jsp',
						type: 'POST',
						data: jsonData,
						dataType: 'json',
						success:function(data){
							if(data.result == 1){
								alert('주문완료!');
							}else{
								alert('주문실패!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>상품목록</h3>
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<% for(ProductBean pb : pros){ %>
			<tr>
				<td><%= pb.getProdNo() %></td>
				<td><%= pb.getProdName() %></td>
				<td><%= pb.getStock() %></td>
				<td><%= pb.getPrice() %></td>
				<td><%= pb.getCompany() %></td>
				<td><button class="btnOrder" value="<%= pb.getProdNo() %>">주문</button></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none">
			<h4>주문하기</h4>
			<table border="1">
				<tr>
					<td>상품번호</td>
					<td><input type="text" name="prodNo" readonly="readonly"></td>
				</tr>
				<tr>
					<td>수량</td>
					<td><input type="text" name="prodCount"></td>
				</tr>
				<tr>
					<td>주문자</td>
					<td><input type="text" name="prodOrderer"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="주문하기"></td>
				</tr>
			</table>
			<button class="btnClose">닫기</button>
		</section>
		
	</body>
</html>
