package kr.co.jboard2.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {
	
	INSTANCE;
	
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	public int insertArticle(ArticleVO vo)	{
		return dao.insertArticle(vo);
	}
	
	public void insertFile(int parent, String newName, String oriName) {
		dao.insertFile(parent, newName, oriName);
	}
	
	public ArticleVO selectArticle(String no) {
		 return dao.selelctArticle(no);
	}
	
	public List<ArticleVO> selectArticles(int start) {
		return dao.selelctArticles(start);
	}
	
	public List<ArticleVO> selectArticleByKeyword(String keyword, int start) {
		return dao.selectArticleByKeyword(keyword, start);
	}
	
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	public int selectCountTotal(String keyword) {
		return dao.selectCountTotal(keyword);
	}
	
	
	public void updateArticle()	{}
	public void deleteArticle()	{}

	public MultipartRequest uploadFile(HttpServletRequest req, String savePath) throws IOException {
		File mdfile = new File(savePath);
		if(!mdfile.exists()) mdfile.mkdirs();
		int maxSize = 1024 * 1024 * 10;
		return new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public String renameFile(String file, String uid, String path) {
		int idx = file.lastIndexOf(".");
		String ext = file.substring(idx);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String nFile= now + uid + ext;
		File oriFile = new File(path + "/" + file);
		File newFile = new File(path + "/" + nFile);
		oriFile.renameTo(newFile);
		return nFile;
	}
	
	public int getLastPageNum(int total) {
		
		int lastPageNum = 0;
		
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = total / 10 + 1;
		}
		
		return lastPageNum;
	}
	
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		int pageGroupStart = (currentPageGroup - 1) * 10 + 1;
		int pageGroupEnd = currentPageGroup * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		int[] result = {pageGroupStart, pageGroupEnd};
		
		return result;
	}
	
	public int getPageStartNum(int total, int currentPage) {
		int start = (currentPage - 1) * 10;
		return total - start;
	}
	
	public int getCurrentPage(String pg) {
		int currentPage = 1;
		
		if(pg != null){
			currentPage = Integer.parseInt(pg);	
		}
		
		return currentPage;
	}
	
	public int getStartNum(int currentPage) {
		return (currentPage - 1) * 10;
	}
	
	public String getBody(HttpServletRequest request) throws IOException {
		 
		BufferedReader input = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder builder = new StringBuilder();
        String buffer;
        while ((buffer = input.readLine()) != null) {
            if (builder.length() > 0) {
                builder.append("\n");
            }
            builder.append(buffer);
        }
        return builder.toString();
    }
}
