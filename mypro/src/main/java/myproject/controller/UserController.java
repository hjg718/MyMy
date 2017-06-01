package myproject.controller;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

import myproject.service.UserService;
import myproject.usermodel.UserVO;


@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	UserService svc;
	
	@RequestMapping(value="loginForm")
	public String login(){
		return "user/loginForm";
	}
	
	@RequestMapping(value="join",method=RequestMethod.GET)
	public String join(UserVO vo){
		return "user/joinForm";
	}
	
	@RequestMapping(value="join",method=RequestMethod.POST)
	public String join(@Valid UserVO vo, BindingResult result, Model model){
		if(result.hasErrors()){
			return "user/joinForm";
		}
		boolean pass = svc.join(vo);
		if(pass){
			model.addAttribute("join", true);
		}else{
			model.addAttribute("overlap", true);
			return "user/joinForm";
		}
		return "user/loginForm";
	}
	@RequestMapping("check")
	@ResponseBody
	public String check(@RequestParam("id") String id){
		String ok = svc.check(id);
		return ok;
	}
	
	@RequestMapping(value="findId", method = RequestMethod.GET)
	public String findId(){
		return "user/findId";
	}
	@RequestMapping(value="findId", method = RequestMethod.POST)
	@ResponseBody
	public String findId(UserVO vo){
		String id = svc.findId(vo);
		return id;
	}
		
}
