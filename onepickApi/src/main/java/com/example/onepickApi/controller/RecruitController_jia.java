package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.repository.JobAdRepository;

import jakarta.servlet.http.HttpServletRequest;

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
	@GetMapping("/myrecruit")
	public ResponseEntity<List<JobAd>> myrecruit(HttpServletRequest request) {
		
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		List<JobAd> myJobAdList = jobAdRepo.findByUsername(request.getHeader("username"));
			return new ResponseEntity<>(myJobAdList, HttpStatus.OK);
	}
	@DeleteMapping("/{jno}")
	public ResponseEntity<String> deleteJobad(@PathVariable("jno") Long jno) {
			jobAdRepo.deleteById(jno);
			return new ResponseEntity<>("done", HttpStatus.OK);
	}
	@PutMapping("/{jno}")
	public ResponseEntity<String> editJobad(@PathVariable("jno") Long jno) {
//			jobAdRepo.save();
			return new ResponseEntity<>("done", HttpStatus.OK);
	}
}
