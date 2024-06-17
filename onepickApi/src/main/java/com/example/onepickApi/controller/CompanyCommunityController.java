package com.example.onepickApi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.BoardDto;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.CompanyBoard;
import com.example.onepickApi.repository.CompanyBoardRepository;
import com.example.onepickApi.repository.CompanyReplyRepository;
import com.example.onepickApi.repository.CompanyRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RestController		// 기업 커뮤니티
@RequestMapping("/api/v1/company")
public class CompanyCommunityController {

	@Autowired
	CompanyRepository cRepo;
	@Autowired
	CompanyBoardRepository cbRepo;
	@Autowired
	CompanyReplyRepository crRepo;

	// 게시글 등록
	@PostMapping("/community-board")
	public CompanyBoard communityForm(HttpServletRequest request, @RequestBody BoardDto boardDto){
		
		System.out.println("xxxxxxxxxxxxxxxxxxxxxx");
		System.out.println("봐라 : " + boardDto);
		
		// 요청헤더에 실린 jwt 토큰 및 사용자 정보 받기
		String username = request.getHeader("username");
		String role = request.getHeader("role");
		
//		if(username == null | username.isEmpty()) {
//			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username header is missing");
//		}
		
		Company com = new Company();
		com.setUsername(boardDto.getUsername());
		System.out.println("boardDTo에서 나온 username : " +boardDto.getUsername());
		System.out.println("companyEntity에서 나온 username : " +com.getUsername());
		
		CompanyBoard cb_ = new CompanyBoard();
		cb_ .setTitle(boardDto.getTitle());
		cb_ .setContent(boardDto.getContent());
		cb_ .setCategory(boardDto.getCategory());
		cb_ .setCompany(com);
		CompanyBoard cb = cbRepo.save(cb_);
		
		System.out.println("saved companyBoard : " + cb);
		
		return cb;
	}
	
	// 커뮤니티 전체 게시물 리스트
	@GetMapping("/community-board")
	public List<CompanyBoard> communityList(@RequestParam(value= "category", required = false) String category){
		
		// category에 따른 리스트
		System.out.println(category);
		List<CompanyBoard> result= cbRepo.findByCategory(category);
		System.out.println(result);
			
		return result;
	}
	
	
	
}
