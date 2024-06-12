package com.example.onepickApi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.QnaDto;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.Qna;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.QnaRepository;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/")
public class QnaController {
	
	@Autowired
	private QnaRepository qnaRepository;
	
	@PostMapping("/qna")
	public String qnaRegist(@RequestBody QnaDto qnaDto, @RequestParam("secret") boolean secret) {
		Qna qna = new Qna();
		qna.setTitle(qnaDto.getTitle());
		qna.setContent(qnaDto.getContent());
		qna.setCategory(qnaDto.getCategory());
		qna.setSecret(secret);
		
		User user = new User();
		user.setUsername("test_user");
		qna.setUser(user);
		
		Company company = new Company();
		company.setUsername("test_company");
		qna.setCompany(company);
		
		
//		User user = new User();
//		user.setUsername(qnaDto.getUser().getUsername());
//		qna.setUser(user);
//		
//		Company company = new Company();
//		company.setUsername(qnaDto.getCompany().getUsername());
//		qna.setCompany(company);
		
		Qna result = qnaRepository.save(qna);
		return result.toString();
	}
	
	@GetMapping("/qna/{bno}")
	public String qnaEdit(@RequestParam("bno") String bno) {
		return "";
	}
}
