package com.example.onepickApi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.JobAdDto;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.JobAdRepository;

@CrossOrigin("*")
@RequestMapping("/api/v1/main")
@RestController
public class MainControllerJs {

	@Autowired
	JobAdRepository jobAdRepository;
	
	@Autowired
	CompanyRepository companyRepository;
	
	@GetMapping("/recruit/receipt-closedate")
	public ResponseEntity<List<JobAdDto>> getReceiptClosedate(){
		System.out.println("마감일 공고 출력");
		List<JobAdDto> jobAds = jobAdRepository.findAllJobAdsWithCompanyOrderedByReceiptCloseDt();
		System.out.println(jobAds);
		return new ResponseEntity<>(jobAds, HttpStatus.OK);
	}
}
