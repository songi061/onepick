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
		System.out.println(username);
		model.addAttribute("username", username);
	}
	@RequestMapping("/companyList")
	public void companyList() {
	}
	@RequestMapping("/recruitDetail")
	public void recruitDetail(@RequestParam("jno") Long jno, Model model) {
		model.addAttribute("jno", jno);
	}
	@RequestMapping("/myHome")
	public void myHome() {
	}
	@RequestMapping("/recruitList")
	public void recruitList() {
	}
	@RequestMapping("/recruitEdit")
	public void recruitEdit(@RequestParam("jno") Long jno, Model model) {
		model.addAttribute("jno", jno);
	}
	@RequestMapping("/recruitForm")
	public void recruitForm() {
	}
	@RequestMapping("/applyList")
	public void applyList() {
	}
	@RequestMapping("/scrapList")
	public void scrapList() {
	}
	@RequestMapping("/reviewForm")
	public void reviewForm() {
	}
	@RequestMapping("/reviewList")
	public void reviewList() {
	}
	
}
