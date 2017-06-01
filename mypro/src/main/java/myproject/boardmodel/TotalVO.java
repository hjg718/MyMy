package myproject.boardmodel;

import java.util.List;

public class TotalVO {
	private List<FileVO> fvo;
	private int page;
	private int tpg;
	private List<BoardVO> boardList;
	private BoardVO board;
	
	
	public BoardVO getBoard() {
		return board;
	}
	public void setBoard(BoardVO board) {
		this.board = board;
	}
	public List<FileVO> getFvo() {
		return fvo;
	}
	public void setFvo(List<FileVO> fvo) {
		this.fvo = fvo;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTpg() {
		return tpg;
	}
	public void setTpg(int tpg) {
		this.tpg = tpg;
	}
	public List<BoardVO> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<BoardVO> boardList) {
		this.boardList = boardList;
	}
}
