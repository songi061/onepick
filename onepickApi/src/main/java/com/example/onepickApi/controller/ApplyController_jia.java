package com.example.onepickApi.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		//해당 기업이 올린 공고 모두 부르기
		List<JobAd> myJobAdList = jobadRepo.findByUsername(request.getHeader("username"));
		System.out.println(myJobAdList);
		List<Long> jnoList = new ArrayList<>();
		List<ApplyList> applyList = new ArrayList<>();
		
		//해당기업이 올린 공고들의 jno만 뽑아서 list만들어주기
		for(JobAd ja : myJobAdList) {
			Long jno = ja.getJno();
			jnoList.add(jno);
		}
		
		//해당기업이 올린 공고의 jno를 이용해서 해당 공고에 지원한 지원내역을 모두 뽑음
		for(Long jno : jnoList) {
			List<ApplyList> al = applyListRepo.findByJno(jno);
			if(al !=null) {
				for(ApplyList a : al) {
					applyList.add(a);
				}
			}
		}
		System.out.println(applyList);
			return new ResponseEntity<>(applyList, HttpStatus.OK);
	}
	
	@PutMapping("/status")
	public ResponseEntity<String> changeStatus(HttpServletRequest request, @RequestParam("status") String status, @RequestParam("rno") Long rno,@RequestParam("jno") Long jno){
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		
		System.out.println(rno);
		System.out.println(status);
		System.out.println(jno);
		ApplyList al = applyListRepo.findApplyByJnoAndRno(jno, rno);
		System.out.println("ddddd");
		System.out.println(al);
		al.setStatus(status);
		applyListRepo.save(al);
		
		return new ResponseEntity<>("done", HttpStatus.OK);
	}
	
	
}
