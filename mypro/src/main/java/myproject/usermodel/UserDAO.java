package myproject.usermodel;

public interface UserDAO {

	public int join(UserVO vo);
	public String check(String id);
	public String findId(UserVO vo);
}
