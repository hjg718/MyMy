package myproject.validator;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import myproject.boardmodel.BoardVO;

@Service("validator")
public class FileValidator implements Validator  {

	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void validate(Object boardVO, Errors result) {
		BoardVO vo = (BoardVO)boardVO;
		boolean pass=false;
		for(int i=0;i<vo.getFiles().size();i++){
			if(vo.getFiles().get(i).getSize()!=0){
				pass=true;
			}
		}
		if(!pass){
			result.rejectValue("files","noFile","파일이없습니다.");
		}
		
	}

}
