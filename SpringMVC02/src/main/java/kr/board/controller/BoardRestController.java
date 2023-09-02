package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RestController
@RequestMapping("/board")
public class BoardRestController {

	@Autowired
	BoardMapper boardMapper;
	
	@GetMapping("/selectAll")
	public List<Board> boardList(){
		List<Board> list = boardMapper.getLists();
		return list;
	}
	
	@GetMapping("/selectOne/{idx}")
	public Board content(@PathVariable("idx") int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo;
	};
	
	@PostMapping("/add")
	public void insert(Board vo) {
		boardMapper.boardInsert(vo);
	};
	
	@DeleteMapping("/delete/{idx}")
	public void delete(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	};
	
	@PutMapping("/update")
	public void update(@RequestBody Board vo) {
		boardMapper.boardUpdate(vo);
	};

	@PutMapping("/count/{idx}")
	public Board count(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx);
		Board vo = boardMapper.boardContent(idx);
		return vo;
	};
	
}
