package myproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import myproject.boardmodel.BoardVO;
import myproject.boardmodel.TotalVO;
import myproject.service.BoardService;
import myproject.validator.FileValidator;

@Controller
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	BoardService svc;
	@Autowired
	private FileValidator validator;

	
	@RequestMapping("list")
	public ModelAndView list(){
		return new ModelAndView("board/list","tvo",svc.list(1));
	}
	@RequestMapping("getPage")
	@ResponseBody
	public String getPage(@RequestParam("num") int num){
		String page = svc.getPage(num);
		return page;
	}
	
	@RequestMapping(value= "writeForm")
	public String writeForm(BoardVO vo){
		return "board/write";
	}
	@RequestMapping(value= "write", method=RequestMethod.POST)
	public ModelAndView write(BoardVO vo,BindingResult result){
		boolean pass= false;
		if(vo.getFiles()!=null){
			validator.validate(vo, result);
			if(result.hasErrors()){
				return new ModelAndView("board/write");
			}
		 pass = svc.writeFile(vo);
		}
		else{
			pass = svc.write(vo);
		}
		if(!pass){
			return new ModelAndView("board/write");
		}
		return new ModelAndView("board/recent","tvo",svc.recent(vo.getAuthor()));
	}
	
	@RequestMapping("read")
	public ModelAndView read(@RequestParam("num")int num){
		return new ModelAndView("board/read","tvo", svc.read(num));
	}
	
	@RequestMapping("rep")
	public  ModelAndView rep(BoardVO vo){
		svc.write(vo);
		return new ModelAndView("board/recent","tvo",svc.recent(vo.getAuthor()));
	}
	@RequestMapping("edit")
	public ModelAndView edit(@RequestParam int num){
		return new ModelAndView("board/editForm","tvo", svc.read(num));
	}
	@RequestMapping("update")
	@ResponseBody
	public Map<String, Boolean> update(BoardVO vo){
		boolean pass = svc.update(vo);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("pass", pass);
		return map;
	}
	@RequestMapping(value="remove", method=RequestMethod.POST)
	@ResponseBody
	public  Map<String, Boolean> remove(@RequestParam int num){
		boolean pass = svc.remove(num);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("pass", pass);
		return map;
	}
	@RequestMapping("search")
	@ResponseBody
	public String search(@RequestParam("cat") String cat, @RequestParam("keyword") String keyword,@RequestParam("num") int num){
		
		String list= svc.search(cat,keyword,num);
		return list;
	}
	
	 @RequestMapping("down")
	 @ResponseBody
	 public byte[] getImage(HttpServletResponse response,@RequestParam("saveName")String saveName,
			 @RequestParam("originName") String originName) throws IOException
	 {
	    File file = new File("D:/profile/"+saveName);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
	    String fn = new String(originName.getBytes("utf-8"), "iso_8859_1");
	  
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");
	    return bytes;
	 }
	 
	 @RequestMapping("fileDel")
	 @ResponseBody
	 public Map<String, Boolean> filedelete(@RequestParam("name")String name){
		boolean pass= svc.fileDel(name);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("pass", pass);
		 return map;
	 }
}
