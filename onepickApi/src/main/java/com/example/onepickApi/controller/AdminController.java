package com.example.onepickApi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.UserRepository;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/admin/")
public class AdminController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CompanyRepository companyRepository;
	
	// 개인회원
	@GetMapping("/user")
	public ResponseEntity<List<User>> userList() {
		List<User> list = userRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@DeleteMapping("/user/{username}")
	public ResponseEntity<String> userDelete(@PathVariable("username") String username) {
		userRepository.deleteById(username);
		return ResponseEntity.ok("삭제 : " + username);
	}
	
	@GetMapping("/user-search/{keyword}")
	public ResponseEntity<List<User>> getAlluserListKeyword(@PathVariable("keyword") String keyword){
		List<User> allList = userRepository.findByUsernameContainingOrNameContaining(keyword, keyword);
		return new ResponseEntity<>(allList,HttpStatus.OK);
	}
	
	// 기업회원
	@GetMapping("/company")
	public ResponseEntity<List<Company>> companyList(){
		List<Company> list = companyRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@DeleteMapping("/company/{username}")
	public ResponseEntity<String> companyDelete(@PathVariable("username") String username){
		companyRepository.deleteById(username);
		return ResponseEntity.ok("삭제 : " + username);
	}
	
	@GetMapping("/company-search/{keyword}")
	public ResponseEntity<List<Company>> getAllcompanyListKeyword(@PathVariable("keyword") String keyword){
		List<Company> allList = companyRepository.findByUsernameContainingOrNameContaining(keyword, keyword);
		return new ResponseEntity<>(allList,HttpStatus.OK);
	}

}
