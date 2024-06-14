package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NoticeController {
	
	@RequestMapping("admin/noticeForm")
	public void noticeForm() {}
	
	@RequestMapping("admin/noticeList")
	public void adminNoticeList() {}
	
	@RequestMapping("/noticeList")
	public void NoticeList() {}
	
	@RequestMapping("admin/noticeDetail")
	public void adminNoticeDetail(@RequestParam("nno") Long nno, Model model) {
		model.addAttribute("nno", nno);
	}
	
	@RequestMapping("/noticeDetail")
	public void noticeDetail(@RequestParam("nno") Long nno, Model model) {
		model.addAttribute("nno", nno);
	}
	
	@RequestMapping("admin/noticeEdit")
	public void noticeEdit(@RequestParam("nno") Long nno, Model model) {
		model.addAttribute("nno", nno);
	}
	
}
