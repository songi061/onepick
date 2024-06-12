package com.example.onepickApi.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.UserRepository;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/register")
public class RegistControllerJs {

	@Autowired
	UserRepository userRepository;
	
	@Autowired
	CompanyRepository companyRepository;
	
	@GetMapping("/user")
	public ResponseEntity<String> userIdcheck(@RequestParam("username")String username) {
		System.out.println("user 아이디 중복 체크 중.." + userRepository.findById(username));
		Optional<User> result = userRepository.findById(username);
		if(result.isPresent()) {
			return new ResponseEntity<>("중복된 아이디입니다.",HttpStatus.OK);
		}else {
			return new ResponseEntity<>("사용가능한 아이디입니다.",HttpStatus.OK);
		}
		
	}
	
	@GetMapping("/company")
	public ResponseEntity<String> companyIdcheck(@RequestParam("username")String username) {
		System.out.println("user 아이디 중복 체크 중.." + userRepository.findById(username));
		Optional<Company> result = companyRepository.findById(username);
		if(result.isPresent()) {
			return new ResponseEntity<>("중복된 아이디입니다.",HttpStatus.OK);
		}else {
			return new ResponseEntity<>("사용가능한 아이디입니다.",HttpStatus.OK);
		}
		
	}
	
}
