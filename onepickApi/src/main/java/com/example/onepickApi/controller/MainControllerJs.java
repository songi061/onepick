package com.example.onepickApi.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.JobAdRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/main")
@RestController
public class MainControllerJs {

	@Autowired
	JobAdRepository jobAdRepository;
	
	@Autowired
	CompanyRepository companyRepository;
	
	@GetMapping("/recruit/receipt-closedate")
	public ResponseEntity<List<JobAd>> getReceiptClosedate(HttpServletRequest request){
		System.out.println("마감일 공고 출력");
		List<JobAd> list = jobAdRepository.findAllJobAdsWithCompanyOrderedByReceiptCloseDt();
		
		System.out.println(list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/recruit/suggestion")
	public ResponseEntity<List<JobAd>> getReceiptSuggestion(HttpServletRequest request){
		System.out.println("추천 공고 출력");
		List<JobAd> list = jobAdRepository.findAllJobAdsWithCompanyOrderedByReceiptCloseDt();
		
		System.out.println(list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}
