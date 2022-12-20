package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.service.UserService;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/myInfo.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/myInfo.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserVO vo = new UserVO();
		vo.setUid(req.getParameter("uid"));
		vo.setName(req.getParameter("pass"));
		vo.setName(req.getParameter("name"));
		vo.setNick(req.getParameter("nick")); 
		vo.setEmail(req.getParameter("email"));
		vo.setHp(req.getParameter("hp"));
		vo.setZip(req.getParameter("zip"));
		vo.setAddr1(req.getParameter("addr1"));
		vo.setAddr2(req.getParameter("addr2"));
		
		int result = service.updateUser(vo);
		if(result > 0) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			resp.sendRedirect("/JBoard2/list.do");
		}else {
			resp.sendRedirect("/JBoard2/user/login.do");
		}
		
	}

}
