package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/commentWrite.do")
public class CommentWriteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/x-json; charset=UTF-8");
		ArticleVO comment = new ArticleVO();
		comment.setParent(req.getParameter("parent"));
		comment.setUid(req.getParameter("uid"));
		comment.setContent(req.getParameter("content"));
		comment.setRegip(req.getRemoteAddr());
		
		ArticleVO vo = ArticleDAO.getInstance().insertComment(comment);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(vo);
		PrintWriter writer = resp.getWriter();
		writer.print(jsonData);
	}
}
