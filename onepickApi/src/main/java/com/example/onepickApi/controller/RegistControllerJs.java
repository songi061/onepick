package com.example.onepickApi.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
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
	
	@PostMapping("/user")
	public ResponseEntity<String> registUser(@RequestBody User user){
		System.out.println("user 회원가입 중.." + user);
		String newPw = bCryptPasswordEncoder.encode(user.getPassword());
		String role = "";
		if(user.getUsername().equals("admin")) {
			role = "ROLE_ADMIN";
		}else {
			role = "ROLE_USER";
		}
		
		user.setPassword(newPw);
		user.setRole(role);
		User result = userRepository.save(user);
		if(result != null) {
			return new ResponseEntity<>("가입 성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<>("가입 실패", HttpStatus.OK);
		}
		
	}
	
	
	@PostMapping("/company")
	public ResponseEntity<String> registCompany(@RequestBody Company company){
		System.out.println("company 회원가입 중.." + company);
		String newPw = bCryptPasswordEncoder.encode(company.getPassword());
		String role = "ROLE_COMPANY";
		
		company.setPassword(newPw);
		company.setRole(role);
		Company result = companyRepository.save(company);
		if(result != null) {
			return new ResponseEntity<>("가입 성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<>("가입 실패", HttpStatus.OK);
		}
		
	}
	
}
