package myproject.boardmodel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface BoardDAO {

	public int write(BoardVO vo);
	public int upload(FileVO fvo);
	public BoardVO recent(String id);
	public List<FileVO> recentFile(String id);
	public TotalVO list(int num);
	public BoardVO read(int num);
	public List<FileVO> readFile(int num);
	public int update(BoardVO vo);
	public int remove(int num);
	public int removefile(int num);
	public TotalVO search(HashMap<String, Object> map);
	public int fileDel(String name);
}
