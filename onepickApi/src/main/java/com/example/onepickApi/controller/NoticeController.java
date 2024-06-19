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

import com.example.onepickApi.dto.NoticeDto;
import com.example.onepickApi.entity.Notice;
import com.example.onepickApi.repository.NoticeRepository;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/")
public class NoticeController {
	
	@Autowired
	private NoticeRepository noticeRepository;
	
	@PostMapping("/notice")
	public ResponseEntity<Notice> noticeRegist(@RequestBody NoticeDto noticeDto) {
		Notice notice = new Notice();
		notice.setTitle(noticeDto.getTitle());
		notice.setContent(noticeDto.getContent());
		
		System.out.println(notice);
		
		Notice result = noticeRepository.save(notice);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
		
	}
	
	@GetMapping("/notice")
	public ResponseEntity<List<Notice>> noticeList() {
		List<Notice> list = noticeRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/notice/{nno}")
	public ResponseEntity<Optional<Notice>> noticeDetail(@PathVariable("nno") Long nno) {
		Optional<Notice> result = noticeRepository.findById(nno);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@PutMapping("/notice")
	public ResponseEntity<Notice> noticeEdit(@RequestBody NoticeDto noticeDto, @RequestParam("nno") Long nno) {
		Notice notice = noticeRepository.findById(nno).get();

		notice.setTitle(noticeDto.getTitle());
		notice.setContent(noticeDto.getContent());
		
		Notice result = noticeRepository.save(notice);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	@DeleteMapping("/notice/{nno}")
	public ResponseEntity<String> noticeDelete(@PathVariable("nno") Long nno) {
		noticeRepository.deleteById(nno);
		return ResponseEntity.ok("삭제: "+nno);
	}
	
}
