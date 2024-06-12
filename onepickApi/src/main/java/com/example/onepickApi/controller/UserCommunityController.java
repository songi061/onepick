package com.example.onepickApi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.userBoardDto;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserBoard;
import com.example.onepickApi.repository.UserBoardRepository;
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

	@PostMapping("/community-board")
	public UserBoard communityForm(HttpServletRequest request, @RequestBody userBoardDto boardDto){
		
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
		User user = uRepo.findById(boardDto.getUid()).get();
		
		
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
	public List<UserBoard> communityList(){
		List<UserBoard> ubList = ubRepo.findAll();
		
		
		
		return null;
	}
	
//	// 커뮤니티 게시물 상세보기
//	@GetMapping("/community-board")
//	public String communityDetail(){
//		return "";
//	}
	
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
