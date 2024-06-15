package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainControllerJs {

	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
}
