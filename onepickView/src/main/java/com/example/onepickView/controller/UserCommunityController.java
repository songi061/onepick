package com.example.onepickView.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserCommunityController {

	@RequestMapping("/communityList")
	public String communityList() {
		return  "user/community/communityList";
	}
	
	@RequestMapping("/communityForm")
	public String communityForm() {
		return  "user/community/communityForm";
	}
	
	
}
