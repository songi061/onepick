package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class ResumeApplyController_jia {

	@RequestMapping("/resumeDetailForApply")
	public void reviewList(@RequestParam("jno") Long jno, @RequestParam("rno") Long rno, Model model) {
		model.addAttribute("rno", rno);
		model.addAttribute("jno", jno);
	}

	@RequestMapping("/resumeForm2")
	public void resumeFormTest() {
	}
}
