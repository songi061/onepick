package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class QnaController {
	
	@RequestMapping("/qnaForm")
	public void qnaForm() {	
	}
	
	@RequestMapping("/qnaList")
	public String qnaList() {
		return "admin/qnaList";
	}
	
	@RequestMapping("/qnaDetail")
	public void qnaDetail(@RequestParam("bno") Long bno, Model model) {
		model.addAttribute("bno", bno);
	}
	
	@RequestMapping("/qnaEdit")
	public void qnaEdit(@RequestParam("bno") Long bno, Model model) {
		model.addAttribute("bno", bno);
	}
	
	@RequestMapping("user/myQnaList")
	public void userMyQnaList() {
	}
	
	@RequestMapping("company/myQnaList")
	public void companyMyQnaList() {
	}
}
