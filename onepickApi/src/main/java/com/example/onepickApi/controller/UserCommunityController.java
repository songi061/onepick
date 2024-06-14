package com.example.onepickApi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.UserBoardDto;
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

	@PostMapping("/community-board")
	public UserBoard communityForm(HttpServletRequest request, @RequestBody UserBoardDto boardDto){
		
		System.out.println("xxxxxxxxxxxxxxx");
		System.out.println(boardDto);
		//User user_ = uRepo.findByUsername(boardDto.getUser());
		//User user = uRepo.save(user_);
		// 토큰으로 user 구분
		//System.out.println("user : " + user);
		
		/*
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			System.out.println(headers.nextElement());
			if(headers.nextElement().equals("writer")) {
				System.out.println(request.getHeader("writer"));
			}
		}
		
		String writer = request.getHeader("writer");
		*/
		User user = uRepo.findById(boardDto.getUsername()).get();
		
		UserBoard ub_ = new UserBoard();
		ub_.setTitle(boardDto.getTitle());
		ub_.setContent(boardDto.getContent());
		ub_.setCategory(boardDto.getCategory());
		ub_.setUser(user);
		UserBoard ub = ubRepo.save(ub_);
		
		System.out.println("userBoard : " + ub);
		
		return ub;
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

		UserBoard ub = ubRepo.findById(ubno).get();
		List<UserReply> ur = urRepo.findByUserBoard(ub);
		return ur;
	}
	
	// 댓글등록
	@PostMapping("/community-comment")
	public void registReply(@RequestBody UserReplyDto urDto) {
		
		String username_ = urDto.getUsername();
		Long ubno_ = urDto.getUbno();
		String content_ = urDto.getContent();
		Integer report_=urDto.getReport();
		
		UserReply ur = new UserReply();
		User user = uRepo.findById(username_).get();
		UserBoard ub = ubRepo.findById(ubno_).get();
		ur.setUser(user);
		ur.setUserBoard(ub);
		ur.setContent(content_);
		ur.setRegdate(null);	// 이렇게 쓰는거 맞나?
		ur.setReport(report_);
		
		urRepo.save(ur);
	}
	
	// 댓글등록 후 바로 표시
	
	
	
	
	
	
	
	// 구직자 마이페이지 내가 쓴 게시물 리스트
	@GetMapping("/community-myboard")
	public String communityMyBoardList(){
		return "";
	}
	
//	@PutMapping("/community-board")
//	public String community(){
//		return "";
//	}
	
	@DeleteMapping("/community-board")
	public String communityDeletion(){
		return "";
	}
	
}
