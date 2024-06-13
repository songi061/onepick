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

import com.example.onepickApi.entity.ApplyList;
import com.example.onepickApi.repository.ApplyListRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/apply")
@RestController
public class ApplyController_jia {

	@Autowired
	private ApplyListRepository applyListRepo;
	
	
	@GetMapping("/company")
	public ResponseEntity<List<ApplyList>> getApplyListForComMyPage(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		List<ApplyList> applyList = applyListRepo.findByCid(request.getHeader("username"));
			return new ResponseEntity<>(applyList, HttpStatus.OK);
	}
	
	
}
