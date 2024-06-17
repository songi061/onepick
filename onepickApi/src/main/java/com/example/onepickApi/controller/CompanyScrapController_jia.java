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
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.InterestedCopRepository;
import com.example.onepickApi.repository.InterestedUserRepository;
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
	private CompanyRepository companyRepo;
	@Autowired
	private UserRepository userRepo;
	
	@GetMapping("/resume-scrap")
	public ResponseEntity<List<InterestedUser>> getScrapList(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
			return new ResponseEntity<>(interestedUserRepo.findByCid(request.getHeader("username")), HttpStatus.OK);
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
	
	
	
	/*
	 * @GetMapping("/interested-company") public ResponseEntity<String>
	 * checkLikeCompany(HttpServletRequest request, @RequestParam("cid") String cid)
	 * {
	 * 
	 * if(interestedCopRepo.findByCidAndUid(cid, request.getHeader("username")) !=
	 * null) { //이미존재한다면 알려주기 return new ResponseEntity<>("existed", HttpStatus.OK);
	 * }else { return new ResponseEntity<>("not existed", HttpStatus.OK); } }
	 */
	
	
	/*
	 * @PostMapping("/interested-company") public ResponseEntity<String>
	 * LikeCompany(HttpServletRequest request, @RequestParam("cid") String cid) {
	 * InterestedCop interestedCop = new InterestedCop(); Company company =
	 * companyRepo.findById(cid).get(); User user =
	 * userRepo.findById(request.getHeader("username")).get();
	 * interestedCop.setCompany(company); interestedCop.setUser(user);
	 * interestedCopRepo.save(interestedCop); return new ResponseEntity<>("done",
	 * HttpStatus.OK); }
	 */
	
	
	/*
	 * @DeleteMapping("/interested-company") public ResponseEntity<String>
	 * deleteInterestedCompany(HttpServletRequest request, @RequestParam("cid")
	 * String cid) { String uid = request.getHeader("username");
	 * interestedCopRepo.delete(interestedCopRepo.findByCidAndUid(cid, uid)); return
	 * new ResponseEntity<>("done", HttpStatus.OK); }
	 */
	
	
	
}