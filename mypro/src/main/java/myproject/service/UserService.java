package myproject.service;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import myproject.usermodel.UserDAO;
import myproject.usermodel.UserVO;

@Service
public class UserService {

	@Autowired
	private SqlSessionTemplate sqlST;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder; 
	
	public boolean join(UserVO vo){
		UserDAO dao= sqlST.getMapper(UserDAO.class);
		String id= dao.check(vo.getId());
		if(id!=null){
			return false;
		}
		String enpwd = passwordEncoder.encode(vo.getPwd());
		vo.setPwd(enpwd);
		int row = dao.join(vo);
		if(row>0){
			return true;
		}
		return false;
	}

	public String check(String id) {
		UserDAO dao= sqlST.getMapper(UserDAO.class);
		String res= dao.check(id);
		JSONObject jObj = new JSONObject();
		if(res!=null){
			jObj.put("ok", false);
		}
		else{
			jObj.put("ok", true);
		}
		return jObj.toJSONString();
	}

	public String findId(UserVO vo) {
		UserDAO dao = sqlST.getMapper(UserDAO.class);
		String id = dao.findId(vo);
		JSONObject jObj = new JSONObject();

		if(id!=null){
			jObj.put("id", id);
		}
		else{
			jObj.put("id", "검색된 아이디가 없습니다.");
		}
		return jObj.toJSONString();
	}
}
