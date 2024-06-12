package com.example.onepickApi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.repository.JobAdRepository;

@CrossOrigin("*")
@RequestMapping("/api/v1/recruit")
@RestController
public class RecruitController_jia {

	
	@Autowired
	private JobAdRepository jobAdRepo;
	
	@GetMapping("/{jno}")
	public ResponseEntity<JobAd> getComList(@PathVariable("jno") Long jno) {
			return new ResponseEntity<>(jobAdRepo.findById(jno).get(), HttpStatus.OK);
	}
}
