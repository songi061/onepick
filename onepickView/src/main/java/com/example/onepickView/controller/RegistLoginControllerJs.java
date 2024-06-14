package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegistLoginControllerJs {

	@RequestMapping("/regForm")
	public String regForm() {
		System.out.println("회원가입 폼 가자..");
		return "regForm";
	}
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		System.out.println("로그인 폼 가자..");
		return "loginForm";
	}
	
	@RequestMapping("/custom403page")
	public String custom403page() {
		System.out.println("custom403page 가자..");
		return "custom403page";
	}
	
//	@RequestMapping("/test")
//	public String test() {
//		System.out.println("test 가자..");
//		return "test";
//	}
}
