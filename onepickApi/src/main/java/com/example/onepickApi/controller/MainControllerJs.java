package com.example.onepickApi.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.Oa;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.OaRepository;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.SkillRepository;
import com.example.onepickApi.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/main")
@RestController
public class MainControllerJs {

	@Autowired
	JobAdRepository jobAdRepository;
	
	@Autowired
	CompanyRepository companyRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	SkillRepository skillRepository;
	
	@Autowired
	ResumeRepository resumeRepository;
	
	@Autowired
	OaRepository oaRepository;
	
	@GetMapping("/recruit/receipt-closedate")
	public ResponseEntity<List<JobAd>> getReceiptClosedate(HttpServletRequest request){
		System.out.println("마감일 공고 출력");
		List<JobAd> list = jobAdRepository.findAllJobAdsWithCompanyOrderedByReceiptCloseDt();
		
		//System.out.println(list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	@GetMapping("/recruit/suggestion")
	public ResponseEntity<List<JobAd>> getReceiptSuggestion(HttpServletRequest request) {
	    System.out.println("추천 공고 출력");
	    String username = null;
	    Enumeration<String> headers = request.getHeaderNames();

	    // 헤더에서 "username"을 찾습니다.
	    while (headers.hasMoreElements()) {
	        String headerName = headers.nextElement();
	       //System.out.println(headerName);
	       
	        if ("username".equalsIgnoreCase(headerName)) {
	            username = request.getHeader(headerName);
	            System.out.println(username);
	            break;
	        }
	    }

	    // "username" 헤더가 없으면 NOT_FOUND를 반환합니다.
	    if (username == null) {
	    	 System.out.println("username null");
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }


	    // 기본 이력서를 찾습니다.
	    Resume resume = resumeRepository.findByUserAndDef(username, "Y");
	    if (resume == null) {
	    	System.out.println("resume null");
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	   
	    // Oa 객체를 조회합니다.
	    List<Oa> oaList = oaRepository.findByResume_Rno(resume.getRno());
	    if (oaList == null || oaList.isEmpty()) {
	        System.out.println("oaList is null or empty");
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    List<JobAd> jobAdList = new ArrayList<>();
	    Set<Long> processedJnoSet = new HashSet<>(); // 중복 제거를 위한 Set

	    for (Oa oa : oaList) {
	        String skillName = oa.getSkillName();
	        System.out.println("Skill Name: " + skillName);

	        List<Long> jnoList = skillRepository.findBySkillName(skillName);
	        if (jnoList.isEmpty()) {
	            System.out.println("jnoList is empty for skillName: " + skillName);
	            continue;
	        }

	        for (Long jno : jnoList) {
	            if (jobAdList.size() >= 5) {
	                break; // jobAdList에 5개 이상 추가되면 루프를 종료합니다.
	            }

	            if (!processedJnoSet.add(jno)) {
	                continue; // 이미 처리된 jno일 경우 다음으로 넘어갑니다.
	            }

	            JobAd jobAd = jobAdRepository.findByJnoAndReceiptCloseDtAfterReceiptCloseDt(jno);
	            if (jobAd != null) {
	                jobAdList.add(jobAd);
	            }
	        }
	    }

	    System.out.println("jobAdList " + jobAdList);
	    
	    if (jobAdList.isEmpty()) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    System.out.println(jobAdList);
	    return new ResponseEntity<>(jobAdList, HttpStatus.OK);
	}
	
	@GetMapping("/recruit/allList")
	public ResponseEntity<List<JobAd>> getAllList(){
		List<JobAd> allList = jobAdRepository.findByReceiptCloseDtAfterReceiptCloseDt();
		return new ResponseEntity<>(allList, HttpStatus.OK);
	} 
	
	@GetMapping("/recruit/allList/{keyword}")
	public ResponseEntity<List<JobAd>> getAllListKeyword(@PathVariable("keyword") String keyword){
		List<JobAd> allList = jobAdRepository.findByReceiptCloseDtAfterAndWantedTitleContaining(keyword);
		System.out.println("검색으로" + allList);
		return new ResponseEntity<>(allList, HttpStatus.OK);
	} 
	
	@GetMapping("/company/search-result/{keyword}")
	public ResponseEntity<List<Company>> getCompanyListKeyword(@PathVariable("keyword") String keyword){
		List<Company> list = companyRepository.findByNameContainingAndSectorContainingAndSizeContaining(keyword, keyword, keyword);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
}
