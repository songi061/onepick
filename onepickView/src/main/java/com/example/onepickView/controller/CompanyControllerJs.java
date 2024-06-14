package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/company")
public class CompanyControllerJs {

	@RequestMapping("companyEdit")
	public String companyEdit() {
		System.out.println("companyEdit....");
		return "/company/companyEdit";
	}
}
