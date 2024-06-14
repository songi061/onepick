package com.example.onepickApi.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.QnaDto;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.Qna;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.QnaRepository;
import com.example.onepickApi.repository.UserRepository;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/")
public class QnaController {
	
	@Autowired
	private QnaRepository qnaRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CompanyRepository companyRepository;

	// memberRepo
	
	@PostMapping("/qna")
	public ResponseEntity<Qna> qnaRegist(@RequestBody QnaDto qnaDto, @RequestParam("username") String username) {
		System.out.println(username);
		Qna qna = new Qna();
		qna.setTitle(qnaDto.getTitle());
		qna.setContent(qnaDto.getContent());
		qna.setCategory(qnaDto.getCategory());
		
		
		Optional<User> result1 = userRepository.findById(username);
		Optional<Company> result2 = companyRepository.findById(username);
		
		if(result1.isPresent()) {
			System.out.println(result1);
			User user = new User();
			user.setUsername(qnaDto.getUser().getUsername());
			qna.setUser(user);
		}else if(result2.isPresent()) {
			System.out.println(result2);
			Company company = new Company();
			company.setUsername(qnaDto.getCompany().getUsername());
			qna.setCompany(company);
		}
		
//		User user = new User();
//		user.setUsername("test_user");
//		qna.setUser(user);
		
//		Company company = new Company();
//		company.setUsername("test_company");
//		qna.setCompany(company);
		
		Qna result = qnaRepository.save(qna);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@GetMapping("/qna")
	public ResponseEntity<List<Qna>> qnaList() {
		List<Qna> list = qnaRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	@GetMapping("/qna/{bno}")
	public ResponseEntity<Optional<Qna>> qnaDetail(@PathVariable("bno") Long bno) {
		Optional<Qna> result = qnaRepository.findById(bno);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@PutMapping("/qna")
	public ResponseEntity<Qna> qnaEdit(@RequestBody QnaDto qnaDto, @RequestParam("bno") Long bno) {
		Qna qna = new Qna();
		qna.setBno(bno);
		qna.setTitle(qnaDto.getTitle());
		qna.setContent(qnaDto.getContent());
		qna.setCategory(qnaDto.getCategory());
		Qna result = qnaRepository.save(qna);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@DeleteMapping("/qna/{bno}")
	public ResponseEntity<String> qnaDelete(@PathVariable("bno") Long bno) {
		qnaRepository.deleteById(bno);
		return ResponseEntity.ok("삭제 :" + bno);
	}
	
	@GetMapping("/usermyqna")
	public ResponseEntity<Qna> userMyQna(@RequestParam("username") String username) {
		Optional<User> result = userRepository.findById(username);
		if(result.isPresent()) {
			Optional<Qna> qna = qnaRepository.findByUserUsername(username);
			return new ResponseEntity<>(qna.get(), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("/companymyqna")
	public ResponseEntity<Qna> companyMyQna(@RequestParam("username") String username) {
		Optional<Company> result = companyRepository.findById(username);
		if(result.isPresent()) {
			Optional<Qna> qna = qnaRepository.findByCompanyUsername(username);
			return new ResponseEntity<>(qna.get(), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	

}
