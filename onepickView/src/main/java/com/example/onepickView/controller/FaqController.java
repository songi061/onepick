package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FaqController {
	
	@RequestMapping("admin/faqForm")
	public void faqForm() {}
	
	@RequestMapping("admin/faqList")
	public void adminFaqList() {}
	
	@RequestMapping("admin/faqEdit")
	public void faqEdit(@RequestParam("fqno") Long fqno, Model model) {
		model.addAttribute("fqno", fqno);
	}

	@RequestMapping("/faqList")
	public void faqList() {}
}
