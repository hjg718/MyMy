package myproject.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import myproject.boardmodel.BoardDAO;
import myproject.boardmodel.BoardVO;
import myproject.boardmodel.FileVO;
import myproject.boardmodel.TotalVO;
import sun.misc.JavaObjectInputStreamAccess;

@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlST;

	public boolean write(BoardVO vo) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int row = dao.write(vo);
		if (row > 0) {
			return true;
		}
		return false;
	}

	public boolean writeFile(BoardVO vo) {

		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int row = dao.write(vo);
		if (row <= 0) {
			return false;
		}
		for (int i = vo.getFiles().size() - 1; i >= 0; i--) {
			MultipartFile file = vo.getFiles().get(i);
			if (file.getSize() == 0) {
				vo.getFiles().remove(i);
				continue;
			}
			InputStream inputStream = null;
			OutputStream outputStream = null;
			FileVO fvo = new FileVO();
			fvo.setAuthor(vo.getAuthor());
			String origin = file.getOriginalFilename();
			String save = null;
			fvo.setOriginName(origin);
			save = origin;
			File savedFile = new File("D:/profile");
			String[] sfile = savedFile.list();
			for (int j = 0; j < sfile.length; j++) {
				if (sfile[j].equals(origin)) {
					save = origin.split("\\.")[0] + new Date().getTime() + "." + origin.split("\\.")[1];
				}

			}
			fvo.setSaveName(save);
			fvo.setfSize((int) file.getSize());
			try {
				inputStream = file.getInputStream();
				File f = new File("D:/profile/" + save);
				outputStream = new FileOutputStream(f);
				int read = 0;
				byte[] buf = new byte[1024];
				while ((read = inputStream.read(buf)) != -1) {
					outputStream.write(buf, 0, read);
					outputStream.flush();
				}
				if (dao.upload(fvo) <= 0) {
					return false;
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return true;
	}

	public TotalVO recent(String id) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		TotalVO tvo = new TotalVO();
		BoardVO vo = dao.recent(id);
		List<FileVO> fileList = dao.recentFile(id);
		tvo.setBoard(vo);
		tvo.setFvo(fileList);
		return tvo;
	}

	public TotalVO list(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		return dao.list(num);
	}

	public TotalVO read(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		TotalVO tvo = new TotalVO();
		BoardVO vo = dao.read(num);
		tvo.setBoard(vo);
		tvo.setFvo(dao.readFile(num));
		return tvo;
	}

	public boolean update(BoardVO vo) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int row = dao.update(vo);
		if (row > 0) {
			return true;
		}
		return false;
	}

	public boolean remove(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int row = dao.remove(num);
		if (row > 0) {
			dao.removefile(num);
			return true;
		}
		return false;
	}

	public String getPage(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		TotalVO tvo = dao.list(num);
		List<BoardVO> list = tvo.getBoardList();
		JSONArray jArr = new JSONArray();

		for (int i = 0; i < list.size(); i++) {
			JSONObject jObj = new JSONObject();
			BoardVO vo = list.get(i);
			jObj.put("title", vo.getTitle());
			jObj.put("author", vo.getAuthor());
			jObj.put("num", vo.getNum());
			jArr.add(jObj);
		}
		String result = jArr.toJSONString();
		return result;
	}

	public String search(String cat,String keyword,int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cat", cat);
		map.put("keyword", keyword);
		map.put("num", num);
		TotalVO tvo  = dao.search(map);
		JSONArray jArr = new JSONArray();
		JSONObject jObj = new JSONObject();
		if(tvo==null){
			jObj.put("false", false);
			
			
			return jObj.toJSONString();
		}
		jObj.put("cat", cat);
		jObj.put("keyword", keyword);
		jObj.put("tpg", tvo.getTpg());
		jObj.put("page", tvo.getPage());
		jArr.add(jObj);

		List<BoardVO> list = tvo.getBoardList();
		for (int i = 0; i < list.size(); i++) {
			BoardVO vo = list.get(i);
			JSONObject jjObj = new JSONObject();
			jjObj.put("title", vo.getTitle());
			jjObj.put("author", vo.getAuthor());
			jjObj.put("num", vo.getNum());
			jArr.add(jjObj);
		}
		String result = jArr.toJSONString();
		return result;
	}

	public boolean fileDel(String name) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int row = dao.fileDel(name);
		if(row>0){
			return true;
		}
		return false;
	}

}
