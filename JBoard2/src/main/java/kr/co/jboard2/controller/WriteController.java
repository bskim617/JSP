package kr.co.jboard2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/write.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String savePath = req.getServletContext().getRealPath("/file");
		MultipartRequest mr = service.uploadFile(req, savePath);
		
		String uid = mr.getParameter("uid");
		String file = mr.getFilesystemName("file");
		
		ArticleVO vo = new ArticleVO();
		vo.setTitle(mr.getParameter("title"));
		vo.setContent(mr.getParameter("content"));
		vo.setUid(uid);
		vo.setFile(file == null ? 0 : 1);
		vo.setRegip(req.getRemoteAddr());
		
		int parent = service.insertArticle(vo);
		
		// 파일 첨부 처리
		if(file != null) {
			String nFile = service.renameFile(file, uid, savePath);
			
			// 파일테이블 저장
			service.insertFile(parent, nFile, file);
			
		}
		resp.sendRedirect("/JBoard2/list.do");
	}
}
