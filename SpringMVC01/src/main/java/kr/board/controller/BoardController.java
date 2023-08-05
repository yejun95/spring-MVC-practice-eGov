package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Board;

@Controller
public class BoardController {
	
	// boardList.do
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		
		Board vo = new Board();
		vo.setIdx(1);
		vo.setTitle("게시판실습");
		vo.setContent("안녕하세요");
		vo.setWriter("박매일");
		vo.setIndate("2022-05-10");
		vo.setCount(0);
		
		List<Board> list = new ArrayList<>();
		list.add(vo);

		model.addAttribute("list", list);
		return "boardList"; // /WEB-INF/views/boardList.jsp
	}
	
}