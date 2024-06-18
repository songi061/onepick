package com.example.onepickApi.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.School;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.SchoolRepository;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1")
public class CompanySearchControllerJs {
	
	@Autowired
	ResumeRepository resumeRepository;
	
	@Autowired
	SchoolRepository schoolRepository;
	
	@GetMapping("/resume-search")
	public ResponseEntity<List<School>> getResumeSearch(){
		List<School> list = schoolRepository.findAll();
		List<School> defList = new ArrayList<>();
		for(School aa : list) {
			if(aa.getResume().getDef().equals("Y")) {
				defList.add(aa);
			};
		}
		//System.out.println(defList);
		
		return new ResponseEntity<>(defList, HttpStatus.OK);
	}

	@GetMapping("/resume-search/{keyword}")
	public ResponseEntity<List<School>> getAllListKeyword(@PathVariable("keyword") String keyword){
		List<School> list = schoolRepository.findByMultipleKeywords(keyword);
		System.out.println("검색으로 list " + list);
		List<School> defList = new ArrayList<>();
		for(School aa : list) {
			if(aa.getResume().getDef().equals("Y")) {
				defList.add(aa);
			};
		}
		System.out.println(defList);
		System.out.println("검색으로" + defList);
		return new ResponseEntity<>(defList, HttpStatus.OK);
	} 
	
}
