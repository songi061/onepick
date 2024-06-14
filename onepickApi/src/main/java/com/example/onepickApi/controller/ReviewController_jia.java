package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.ApplyList;
import com.example.onepickApi.entity.CompanyReview;
import com.example.onepickApi.entity.UserReview;
import com.example.onepickApi.repository.ApplyListRepository;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.CompanyReviewRepository;
import com.example.onepickApi.repository.UserRepository;
import com.example.onepickApi.repository.UserReviewRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("api/v1/company")
@RestController
public class ReviewController_jia {

	
	@Autowired
	private ApplyListRepository applyListRepo;
	@Autowired
	private UserReviewRepository userReviewRepo;
	@Autowired
	private CompanyReviewRepository companyReviewRepo;
	@Autowired
	private CompanyRepository companyRepo;
	@Autowired
	private UserRepository userRepo;
	
	
	
	//면접완료된 면접자의 리스트 보여주기 (기업이 평점남길 수 있는 면접자리스트)
	@GetMapping("/review")
	public ResponseEntity<List<ApplyList>> getIntervieweesList(HttpServletRequest request) {

		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		
		List<ApplyList> intervieweesList = applyListRepo.findIntervieweesByCid(request.getHeader("username"));
		
			return new ResponseEntity<>(intervieweesList, HttpStatus.OK);
	}
	//기업이 면접자에게 평점남기기
		@PostMapping("/review")
		public ResponseEntity<String> regReview(HttpServletRequest request, @RequestBody UserReview userReview) {
			String username = request.getParameter("uid");
			Long jno = Long.parseLong(request.getParameter("jno"));
		
			Enumeration<String> headers = request.getHeaderNames();
			while(headers.hasMoreElements()) {
				if(headers.nextElement().equals("username")) {
					System.out.println(request.getHeader("username"));
				}
			}
		    
			userReview.setCompany(companyRepo.findById(request.getHeader("username")).get());
			userReview.setUser(userRepo.findById(username).get());
			//리뷰 등록하기
			userReviewRepo.save(userReview);
			
			
			//해당 지원자를 applyList테이블에서 상태 변경해주기 ->더이상 면접완료x
			ApplyList ap = applyListRepo.findInterviewee(request.getHeader("username"),username, jno);
			ap.setRatingStatus(true);
			applyListRepo.save(ap);
			
			return new ResponseEntity<>("done", HttpStatus.OK);
		}
		//내가 쓴 리뷰리스트와 내가 받은 리뷰리스트 모두가져오기
		@GetMapping("/review-list")
		public ResponseEntity<Map<String, Object>> getBothList(HttpServletRequest request) {

			Enumeration<String> headers = request.getHeaderNames();
			while(headers.hasMoreElements()) {
				if(headers.nextElement().equals("username")) {
					System.out.println(request.getHeader("username"));
				}
			}
			Map<String, Object> map = new HashMap<>();
			//내가 쓴 리뷰리스트 불러오기
			List<UserReview> registeredList = userReviewRepo.findByCid(request.getHeader("username"));
			map.put("registeredList", registeredList);
			//내가 받은 리뷰리스트 불러오기
			List<CompanyReview> receivedList =companyReviewRepo.findByCid(request.getHeader("username"));
			map.put("receivedList", receivedList);
			return new ResponseEntity<>(map, HttpStatus.OK);
		}
	
}