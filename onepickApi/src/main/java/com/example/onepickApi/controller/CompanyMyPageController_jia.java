package com.example.onepickApi.controller;

import java.util.Enumeration;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.repository.CompanyRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/company")
@RestController
public class CompanyMyPageController_jia {

	@Autowired
	private CompanyRepository companyRepo;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@GetMapping("/detail")
	public ResponseEntity<Company> getComDetail(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			System.out.println(headers.nextElement());
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		if(!companyRepo.findById(request.getHeader("username")).isEmpty()) {
			return new ResponseEntity<>(companyRepo.findById(request.getHeader("username")).get(), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("/")
	public ResponseEntity<List<Company>> getComList() {
		List<Company> companyList = companyRepo.findAll();
			return new ResponseEntity<>(companyList, HttpStatus.OK);
	}
	
	@GetMapping("/mydetail")
	public ResponseEntity<Company> getMydetail(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			System.out.println(headers.nextElement());
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		Company company = companyRepo.findById(request.getHeader("username")).get();
			return new ResponseEntity<>(company, HttpStatus.OK);
	}
	
	
	@PutMapping("/")
	public ResponseEntity<String> postCompany(@RequestBody Company company){
		System.out.println("company 회원가입 중.." + company);
		String newPw = bCryptPasswordEncoder.encode(company.getPassword());
		String role = "ROLE_COMPANY";
		
		company.setPassword(newPw);
		company.setRole(role);
		Company result = companyRepo.save(company);
		
		if(result != null) {
			
			return new ResponseEntity<>("수정 성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<>("수정 실패", HttpStatus.OK);
		}
	}
	
	
	
}
