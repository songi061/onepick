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
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.InterestedCop;
import com.example.onepickApi.entity.JobadScrap;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.InterestedCopRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.JobadScrapRepository;
import com.example.onepickApi.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
public class UserScrapNInterestController_msi {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private JobadScrapRepository scrapRepo;
	
	@Autowired
	private InterestedCopRepository interestRepo;
	
	@Autowired
	private JobAdRepository jobadRepo;
	
	
	
	@PostMapping("/job-scrap/{jno}")
	public void registScrap(HttpServletRequest request) {
		//스크랩 추가
		
		
	}
	
	
	
	@GetMapping("/job-scrap")
	public List<JobadScrap> scrapList(HttpServletRequest request) {
		//스크랩 리스트 불러오기
		
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		List<JobadScrap> scrapList = scrapRepo.findByUser(user);
		
		System.out.println("스크랩 목록 : " + scrapList);

		return scrapList;
	}
	
	

	@DeleteMapping("/job-scrap/{scno}")
	public ResponseEntity<String> deleteScrap(@PathVariable("scno") Long scno) {
		//스크랩 삭제
		scrapRepo.deleteById(scno);
		return new ResponseEntity<>("삭제 성공!", HttpStatus.OK);
	}
	

	
	@PostMapping("/interested-company/{cid}")
	public void registInterCom() {
		//관심기업 추가
	}
	
	
	@GetMapping("/interested-company")
	public List<InterestedCop> interComList(HttpServletRequest request) {
		//관심기업 리스트 불러오기
		
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		List<InterestedCop> interComList = interestRepo.findByUser(user);
		System.out.println(interComList);
		
		return interComList;
		
	}
	
	
	@DeleteMapping("/interested-company/{interno}")
	public ResponseEntity<String> deleteInterCom(@PathVariable("interno")Long interno) {
		//관심기업 삭제
		interestRepo.deleteById(interno);
		
		return new ResponseEntity<>("삭제 성공!", HttpStatus.OK);
	}
	
	
	
}
