<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String stdno = request.getParameter("stdno");
	String stdname = request.getParameter("stdname");
	String stdhp = request.getParameter("stdhp");
	String stdyear = request.getParameter("stdyear");
	String stdaddr = request.getParameter("stdaddr");
	
	String host = "jdbc:mysql://127.0.0.1:3306/java1db";
	String user = "root";
	String pass = "1234";
	
	try{
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>
