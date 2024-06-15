package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserControllerJs {

	@RequestMapping("/userEdit")
	public String userEdit() {
		return "/user/userEdit";
	}
	
}
