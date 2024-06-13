package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController_msi {
	@RequestMapping("/resumeForm")
	public String resumeForm() {
		return "user/resumeForm";
	}
}
