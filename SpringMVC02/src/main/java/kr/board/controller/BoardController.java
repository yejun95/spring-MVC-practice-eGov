package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {

	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){
		List<Board> list = boardMapper.getLists();
		return list;
	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void insert(Board vo) {
		boardMapper.boardInsert(vo);
	};
	
	@RequestMapping("/boardDelete.do")
	public @ResponseBody void delete(@RequestParam("idx") int idx) {
		boardMapper.boardDelete(idx);
	};
	
	@RequestMapping("boardUpdate.do")
	public @ResponseBody void update(Board vo) {
		boardMapper.boardUpdate(vo);
	};

	@RequestMapping("boardContent.do")
	public @ResponseBody Board content(int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo;
	};
	
	@RequestMapping("boardCount.do")
	public @ResponseBody Board count(int idx) {
		boardMapper.boardCount(idx);
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}
	
}
