package com.example.onepickApi.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.BoardDto;
import com.example.onepickApi.dto.UserReplyDto;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserBoard;
import com.example.onepickApi.entity.UserReply;
import com.example.onepickApi.repository.UserBoardRepository;
import com.example.onepickApi.repository.UserReplyRepository;
import com.example.onepickApi.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RestController		// 구직자 커뮤니티
@RequestMapping("/api/v1/user")
public class UserCommunityController {
	
	@Autowired
	UserRepository uRepo;
	@Autowired
	UserBoardRepository ubRepo;
	@Autowired
	UserReplyRepository urRepo;

	// 게시물 등록
	@PostMapping("/community-board")
	public ResponseEntity<?> communityForm(HttpServletRequest request, @RequestBody BoardDto boardDto){
		
		System.out.println("xxxxxxxxxxxxxxxxxxxxxx");
		System.out.println("봐라 : " + boardDto);
		
		// 요청헤더에 실린 jwt 토큰 및 사용자 정보 받기
		String username = request.getHeader("username");
		
		if(username == null | username.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username header is missing");
		}
		
		User user = new User();
		user.setUsername(boardDto.getUsername());
		
		System.out.println(user.getUsername());
		
		UserBoard ub_ = new UserBoard();
		ub_.setTitle(boardDto.getTitle());
		ub_.setContent(boardDto.getContent());
		ub_.setCategory(boardDto.getCategory());
		ub_.setUser(user);
		UserBoard ub = ubRepo.save(ub_);
		
		System.out.println("saved userBoard : " + ub);
		
		return ResponseEntity.ok(ub);
	}
	
	// 커뮤니티 전체 게시물 리스트
	@GetMapping("/community-board")
	public List<UserBoard> communityList(@RequestParam(value= "category", required = false) String category){
		
		// category에 따른 리스트
		System.out.println(category);
		List<UserBoard> result= ubRepo.findByCategory(category);
		System.out.println(result);
			
		return result;
	}
	
	// 게시물 상세보기
	@GetMapping("/community-board/{ubno}")
	public UserBoard communityDetail(@PathVariable("ubno") Long ubno){
		UserBoard ub = ubRepo.findById(ubno).get();
		
		return ub;
	}
	
	// 게시물의 댓글보기
	@GetMapping("/community-comment")
	public List<UserReply> communityReply(@RequestParam("ubno") Long ubno){
		// Map<String, Optional> map = new HashMap<>();
		UserBoard ub = ubRepo.findById(ubno).get();
		List<UserReply> ur = urRepo.findByUserBoard(ub);
		return ur;
	}
	
	// 댓글 등록
	@PostMapping("/community-comment")
	public UserReply registReply(@RequestBody UserReplyDto urDto) {
		
		Long ubno_ = urDto.getUbno();
		System.out.println("************ubno************"+ubno_);
		String content_ = urDto.getContent();
		Integer report_=urDto.getReport();
		User user = new User();
		user.setUsername(urDto.getUsername());
		
		UserReply ur = new UserReply();
		ur.setUser(user);
		UserBoard ub = ubRepo.findById(ubno_).get();
		ur.setUserBoard(ub);
		ur.setContent(content_);
		ur.setRegdate(new Date());	
		ur.setReport(report_);
		System.out.println(ur);
		UserReply ur2 = urRepo.save(ur);
		
		return ur2;
	}
	
	// 게시글 수정
	@PutMapping("/community-board")
	public ResponseEntity<String> community(HttpServletRequest request, @RequestBody BoardDto boardDto){
		System.out.println("dddddddd");
		UserBoard ub_ = ubRepo.findById(boardDto.getUbno()).get();
		ub_.setTitle(boardDto.getTitle());
		ub_.setContent(boardDto.getContent());
		ub_.setCategory(boardDto.getCategory());
		UserBoard ub = ubRepo.save(ub_);
		
		System.out.println("수정된 userBoard : " + ub);
		UserBoard result = ubRepo.save(ub);
		if(result != null) {
			return new ResponseEntity<>("수정완료", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}
	}
	
	// 게시글 삭제
	@DeleteMapping("/community-board")
	public String communityDeletion(){
		return "";
	}
	
	
	// 구직자 마이페이지 - 내가 쓴 게시글 목록 조회
	@GetMapping("/community-myboard")
	public List<UserBoard> communityMyBoardList(@RequestBody BoardDto boardDto){
		User user = new User();
		user.setUsername(boardDto.getUsername());
		
		List<UserBoard> ubList = ubRepo.findByUser(user);
		
		return ubList;
	}
	
	// 유저 커뮤니티 검색 리스트
	@GetMapping("/community-board/search-result/{keyword}")
	public ResponseEntity<List<UserBoard>> getKeywordList(@PathVariable("keyword") String keyword){
		System.out.println("유저 커뮤니티 검색~");
		List<UserBoard> list = ubRepo.findByTitleContainingOrContentContaining(keyword, keyword);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
}
