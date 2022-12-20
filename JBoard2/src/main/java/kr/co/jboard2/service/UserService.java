package kr.co.jboard2.service;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

public enum UserService {
	
	INSTANCE;
	
	private UserDAO dao = UserDAO.getInstance();
	
	public int selectUserConfirm(String uid, String pass) {
		return dao.selectUserConfirm(uid, pass);
	}
	
	public int updateUser(UserVO vo) {
		return dao.updateUser(vo);
	}
	
	public int updateUserPassword(String uid, String pass) {
		return dao.updateUserPassword(pass, uid);
	}
	
	public int deleteUser(String uid) {
		return dao.deleteUser(uid);
	}
}
