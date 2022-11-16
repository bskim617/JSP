<%@page import="kr.co.farmstory1.bean.UserBean"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDAO.getInstance().selectUser(uid, pass);
	
	if(ub != null){
		// 회원이 맞는 경우
		session.setAttribute("sessUser", ub);
		response.sendRedirect("/Farmstory1");
	}else {
		// 회원이 아닌 경우
		response.sendRedirect("/Farmstory1/user/login.jsp?success=100");
	}


%>