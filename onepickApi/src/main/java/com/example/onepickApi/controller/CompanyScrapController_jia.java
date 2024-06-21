package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.InterestedCop;
import com.example.onepickApi.entity.InterestedUser;
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.JobadScrap;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.ResumeScrap;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.InterestedCopRepository;
import com.example.onepickApi.repository.InterestedUserRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.JobadScrapRepository;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.ResumeScrapRepository;
import com.example.onepickApi.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("api/v1")
@RestController
public class CompanyScrapController_jia {
	
	@Autowired
	private InterestedUserRepository interestedUserRepo;
	@Autowired
	private InterestedCopRepository interestedCopRepo;
	@Autowired
	private JobadScrapRepository jobadScrapRepo;
	@Autowired
	private ResumeScrapRepository resumeScrapRepo;
	@Autowired
	private JobAdRepository jobadRepo;	
	@Autowired
	private ResumeRepository resumeRepo;	
	@Autowired
	private CompanyRepository companyRepo;

	@Autowired
	private UserRepository userRepo;
	
	@GetMapping("/resume-scrap")
	public ResponseEntity<List<ResumeScrap>> getScrapList(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
//				System.out.println(request.getHeader("username"));
			}
		}
			return new ResponseEntity<>(resumeScrapRepo.findByCid(request.getHeader("username")), HttpStatus.OK);
	}
	
	@PostMapping("/recruit-scrap")
	public ResponseEntity<List<InterestedUser>> scrapJobAd(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
			return new ResponseEntity<>(interestedUserRepo.findByCid(request.getHeader("username")), HttpStatus.OK);
	}
	
	//멤버가 해당 기업을 구독하고있는 상태인지 체크
	 @GetMapping("/interested-company") 
	 public ResponseEntity<String> checkLikeCompany(HttpServletRequest request, @RequestParam("cid") String cid){
		 if(interestedCopRepo.findByCidAndUid(cid, request.getHeader("username")) !=null) { 
			 //이미존재한다면 알려주기 
			 return new ResponseEntity<>("existed", HttpStatus.OK);
		 }else { 
			 return new ResponseEntity<>("not existed", HttpStatus.OK); 
		 } 
	 }
	
	//멤버가 해당기업 구독하기
	 @PostMapping("/interested-company") 
	 public ResponseEntity<String> LikeCompany(HttpServletRequest request, @RequestParam("cid") String cid) {
		 InterestedCop interestedCop = new InterestedCop(); 
		 Company company =	 companyRepo.findById(cid).get(); 
		 User user = userRepo.findById(request.getHeader("username")).get();
	 
		 interestedCop.setCompany(company); 
		 interestedCop.setUser(user);
	 
		 interestedCopRepo.save(interestedCop); 
		 return new ResponseEntity<>("done",HttpStatus.OK); 
		 }

	//멤버가 해당기업 구독취소
	 @DeleteMapping("/interested-company") 
	 public ResponseEntity<String> deleteInterestedCompany(HttpServletRequest request, @RequestParam("cid") String cid) { 
		 String uid = request.getHeader("username");
		 interestedCopRepo.delete(interestedCopRepo.findByCidAndUid(cid, uid)); 
		 return new ResponseEntity<>("done", HttpStatus.OK); 
		 }
	 
	//공고 찜상태 체크
	 @GetMapping("/scrapped-recruit") 
	 public ResponseEntity<String> scrappedRecruit(HttpServletRequest request, @RequestParam("jno") Long jno){
		 if(jobadScrapRepo.findByJnoAndUid(jno, request.getHeader("username")) !=null) { 
			 //이미존재한다면 알려주기 
			 return new ResponseEntity<>("existed", HttpStatus.OK);
		 }else { 
			 return new ResponseEntity<>("not existed", HttpStatus.OK); 
		 } 
	 }
	
	//공고찜하기
	 @PostMapping("/scrapped-recruit") 
	 public ResponseEntity<String> scrapRecruit(HttpServletRequest request, @RequestParam("jno") Long jno) {
		 JobadScrap jobadScrap = new JobadScrap(); 
		 JobAd jobad =	jobadRepo.findById(jno).get(); 
		 User user = userRepo.findById(request.getHeader("username")).get();
		 jobadScrap.setUser(user);
		 jobadScrap.setJobAd(jobad);
		 jobadScrapRepo.save(jobadScrap); 
		 return new ResponseEntity<>("done",HttpStatus.OK); 
	 }

	//공고찜취소
	 @DeleteMapping("/scrapped-recruit") 
	 public ResponseEntity<String> deleteScrap(HttpServletRequest request, @RequestParam("jno") Long jno) { 
		 jobadScrapRepo.delete(jobadScrapRepo.findByJnoAndUid(jno, request.getHeader("username"))); 
		 return new ResponseEntity<>("done", HttpStatus.OK); 
	 }
	 
	//기업이 구직자 찜상태 체크
	 @GetMapping("/scrapped-resume") 
	 public ResponseEntity<String> scrappedResume(HttpServletRequest request, @RequestParam("rno") Long rno){
		 if(resumeScrapRepo.findByRnoAndCid(rno, request.getHeader("username")) !=null) { 
			 //이미존재한다면 알려주기 
			 return new ResponseEntity<>("existed", HttpStatus.OK);
		 }else { 
			 return new ResponseEntity<>("not existed", HttpStatus.OK); 
		 } 
	 }
	
	//기업이 구직자 이력서찜하기
	 @PostMapping("/scrapped-resume") 
	 public ResponseEntity<String> scrapResume(HttpServletRequest request, @RequestParam("rno") Long rno) {
		 ResumeScrap resumeScrap = new ResumeScrap(); 
		 Resume resume = resumeRepo.findById(rno).get(); 
		 Company company = companyRepo.findById(request.getHeader("username")).get();
		 resumeScrap.setCompany(company);
		 resumeScrap.setResume(resume);
		 resumeScrapRepo.save(resumeScrap); 
		 return new ResponseEntity<>("done",HttpStatus.OK); 
	 }

	//기업이 구직자 이력서찜취소
	 @DeleteMapping("/scrapped-resume") 
	 public ResponseEntity<String> deleteScrapResume(HttpServletRequest request, @RequestParam("rno") Long rno) { 
		 resumeScrapRepo.delete(resumeScrapRepo.findByRnoAndCid(rno, request.getHeader("username"))); 
		 return new ResponseEntity<>("done", HttpStatus.OK); 
	 }
		 
	
}