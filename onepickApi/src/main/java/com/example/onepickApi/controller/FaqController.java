package com.example.onepickApi.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.example.onepickApi.dto.FaqDto;
import com.example.onepickApi.entity.Faq;
import com.example.onepickApi.repository.FaqRepository;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/")
public class FaqController {
	
	@Autowired
	private FaqRepository faqRepository;	
	
	@PostMapping("/faq")
	public ResponseEntity<Faq> faqRegist(@RequestBody FaqDto faqDto) {
		Faq faq = new Faq();
		faq.setTitle(faqDto.getTitle());
		faq.setResponse(faqDto.getResponse());
		
		System.out.println(faq);
		
		Faq result = faqRepository.save(faq);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@GetMapping("/faq")
	public ResponseEntity<List<Faq>> faqList() {
		List<Faq> list = faqRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/faq/{fqno}")
	public ResponseEntity<Optional<Faq>> faqData(@PathVariable("fqno") Long fqno) {
		Optional<Faq> result= faqRepository.findById(fqno);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@PutMapping("/faq")
	public ResponseEntity<Faq> faqEdit(@RequestBody FaqDto faqDto, @RequestParam("fqno") Long fqno) {
		Faq faq = faqRepository.findById(fqno).get();

		faq.setTitle(faqDto.getTitle());
		faq.setResponse(faqDto.getResponse());
		
		Faq result = faqRepository.save(faq);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@DeleteMapping("/faq/{fqno}")
	public ResponseEntity<String> deleteFaq(@PathVariable("fqno") Long fqno) {
		faqRepository.deleteById(fqno);
		return ResponseEntity.ok("삭제 : "+fqno);
	}
	
	
}
