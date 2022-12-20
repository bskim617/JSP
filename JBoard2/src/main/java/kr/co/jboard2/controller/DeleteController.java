package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDAO;

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		ArticleDAO dao = ArticleDAO.getInstance();
		String newName = dao.deleteArticle(no);
		String path = req.getServletContext().getRealPath("/file");
		if(newName != null) {
			File file = new File(path, newName);
			if(file.exists()) file.delete();
		}
		resp.sendRedirect("/JBoard2/list.do");
	}

}
