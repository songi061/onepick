package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainControllerJs {

	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/searchResult")
	public String getSearchResult(@RequestParam("keyword")String keyword, Model model){
		model.addAttribute("keyword", keyword);
		System.out.println("keyword" + keyword);
		return "searchResult";
	}
	
}
