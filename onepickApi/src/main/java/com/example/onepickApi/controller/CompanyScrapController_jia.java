package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.InterestedUser;
import com.example.onepickApi.repository.InterestedUserRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("api/v1")
@RestController
public class CompanyScrapController_jia {

	
	@Autowired
	private InterestedUserRepository interestedUserRepo;
	
	@GetMapping("/resume-scrap")
	public ResponseEntity<List<InterestedUser>> getScrapList(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
			return new ResponseEntity<>(interestedUserRepo.findByCid(request.getHeader("username")), HttpStatus.OK);
	}
}
