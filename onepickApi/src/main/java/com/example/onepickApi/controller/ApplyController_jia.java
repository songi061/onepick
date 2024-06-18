package com.example.onepickApi.controller;

import java.util.ArrayList;
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
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.repository.ApplyListRepository;
import com.example.onepickApi.repository.JobAdRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/apply")
@RestController
public class ApplyController_jia {

	@Autowired
	private ApplyListRepository applyListRepo;
	@Autowired
	private JobAdRepository jobadRepo;
	
	//우리회사 지원한 지원자 리스트 뽑기
	@GetMapping("/company")
	public ResponseEntity<List<ApplyList>> getApplyListForComMyPage(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		List<JobAd> myJobAdList = jobadRepo.findByUsername(request.getHeader("username"));
		System.out.println(myJobAdList);
		List<Long> jnoList = new ArrayList<>();
		List<ApplyList> applyList = new ArrayList<>();
		for(JobAd ja : myJobAdList) {
			Long jno = ja.getJno();
			jnoList.add(jno);
		}
		System.out.println(jnoList);
		for(Long jno : jnoList) {
			ApplyList al = applyListRepo.findByJno(jno);
			if(al != null) {
				applyList.add(al);
			}
		}
		System.out.println(applyList);
			return new ResponseEntity<>(applyList, HttpStatus.OK);
	}
	
	
}
