package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.ApplyList;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.CompanyReview;
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserReview;
import com.example.onepickApi.repository.ApplyListRepository;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.CompanyReviewRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.UserRepository;
import com.example.onepickApi.repository.UserReviewRepository;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
public class ReviewController_user {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private CompanyReviewRepository companyReviewRepo;
	
	@Autowired
	private UserReviewRepository userReviewRepo;
	
	@Autowired
	private ApplyListRepository applyListRepo;
	
	@Autowired
	private JobAdRepository jobadRepo;
	
	@Autowired
	private CompanyRepository companyRepo;
	
	@PostMapping("/review")
	public ResponseEntity<String>  registReview(HttpServletRequest request, @RequestBody CompanyReview companyReview) {
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		int score = Integer.parseInt(request.getParameter("score"));
		
		Long jno = Long.parseLong(request.getParameter("jno"));
		
		companyReview.setUser(user);
		
		JobAd jobad = jobadRepo.findById(jno).get();
		
		companyReview.setCompany(jobad.getCompany());
		
		companyReview.setRating(score);
		companyReviewRepo.save(companyReview);
		
		
		//jno,uid 가 일치하는 지원내역리스트에서 rating_statu값 바꿔주기(true)
		ApplyList ap = applyListRepo.findApply(username, jno);
		ap.setRatingStatus(true);
		System.out.println("ap출력 : " + ap);
		applyListRepo.save(ap);
		
		return new ResponseEntity<>("평점 등록 완료", HttpStatus.OK);
	}
	
	
	
	
	@GetMapping("/review/{rno}")
	public void getReviewList() {
		
	}
	
	
	
	
	
	//내가 쓴 리뷰리스트와 내가 받은 리뷰리스트 모두가져오기
	@GetMapping("/review-list")
	public ResponseEntity<Map<String, Object>> getBothList(HttpServletRequest request) {

//		Enumeration<String> headers = request.getHeaderNames();
//		while(headers.hasMoreElements()) {
//			if(headers.nextElement().equals("username")) {
//				System.out.println(request.getHeader("username"));
//			}
//		}
		String username = request.getHeader("username"); 
		Optional<User> result = userRepo.findById(username);
		User user = result.get();
		
		Map<String, Object> map = new HashMap<>();
		
		//내가 쓴 리뷰리스트 불러오기
		List<CompanyReview> registeredList = companyReviewRepo.findByUser(user);
		map.put("registeredList", registeredList);
		System.out.println("registeredList"+registeredList);
		
		
		//내가 받은 리뷰리스트 불러오기
		List<UserReview> receivedList =userReviewRepo.findByUser(user);
		map.put("receivedList", receivedList);
		System.out.println("receivedList"+receivedList);
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
