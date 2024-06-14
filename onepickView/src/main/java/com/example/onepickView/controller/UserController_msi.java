package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController_msi {
	
	@RequestMapping("/resumeForm")
	public String resumeForm() {
		return "user/resumeForm";
	}

	@RequestMapping("/resumeList")
	public String resumeList() {
		return "user/resumeList";
	}
	
	
	@RequestMapping("/resumeDetail")
	public String resumeDetail(@RequestParam("rno")Long rno, Model model) {
		model.addAttribute("rno",rno);
		
		return "user/resumeDetail";
	}
}
