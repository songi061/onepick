package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@RequestMapping("/userList")
	public void userList() {}
	
	@RequestMapping("/companyList")
	public void companyList() {}
	
	@RequestMapping("/recruitList")
	public void recruitList() {}
	
	@RequestMapping("/dashboard")
	public void dashboard() {}
	
	@RequestMapping("/boardReportList")
	public void boardReportList() {}
	
	@RequestMapping("/replyReportList")
	public void replyReportList() {}
	
}
