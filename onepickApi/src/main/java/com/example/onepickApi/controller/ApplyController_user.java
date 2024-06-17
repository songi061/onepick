package com.example.onepickApi.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.ApplyList;
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.ApplyListRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.UserRepository;


import jakarta.servlet.http.HttpServletRequest;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
public class ApplyController_user {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ApplyListRepository applyRepo;
	
	@Autowired
	private JobAdRepository jobadRepo; 
	
	
	@Autowired
	private ResumeRepository resumeRepo;	
	
	
	//지원하기
	@PostMapping("/apply")
	public ResponseEntity<String> applyRegist(HttpServletRequest request, @RequestParam("jno")Long jno, @RequestParam("rno")Long rno ) {
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		JobAd jobad = jobadRepo.findById(jno).get();
		Resume resume = resumeRepo.findById(rno).get();
		
		ApplyList applyList = new ApplyList();
		applyList.setStatus("지원완료");
		applyList.setUser(user);
		
		applyList.setJobAd(jobad);
		applyList.setResume(resume);
		
		applyRepo.save(applyList);
		
		System.out.println("지원내역 출력 : " + applyList);
		
		return ResponseEntity.ok("지원 완료!!");
		
	}
	
	
	//구직자 지원내역 리스트 불러오기
	@GetMapping("/myapply")
	public List<ApplyList> myApplyList(HttpServletRequest request) {
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		
		List<ApplyList> applyList = applyRepo.findByUser(user);
		
		System.out.println("지원내역 출력 : " + applyList);
		
		return applyList;
		
	}
	
	
	//지원내역 삭제
	@DeleteMapping("/apply/{ano}")
	public ResponseEntity<String> deleteApplyList(@PathVariable("ano")Long ano) {
		applyRepo.deleteById(ano);
		
		return new ResponseEntity<>("지원 취소 성공!", HttpStatus.OK);
	}
	
	
	
}
