package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class adminLoginControllerJs {

	@RequestMapping("/admin/loginForm")
	public String adminLoginForm() {
		return "/admin/loginForm";
	}
	
}
