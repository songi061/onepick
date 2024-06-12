package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/company")
public class Controller_jia {

	@RequestMapping("/companyDetail")
	public void companyDetail(@RequestParam("username") String username, Model model) {
		model.addAttribute("username", username);
	}
	@RequestMapping("/companyList")
	public void companyList() {
	}
}
