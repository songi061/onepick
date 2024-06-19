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
import com.example.onepickApi.entity.BoardReport;
import com.example.onepickApi.entity.ReplyReport;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserBoard;
import com.example.onepickApi.entity.UserReply;
import com.example.onepickApi.repository.BoardReportRepository;
import com.example.onepickApi.repository.ReplyReportRepository;
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
	@Autowired
	BoardReportRepository brRepo;
	@Autowired
	ReplyReportRepository rrRepo;

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
	public UserBoard communityDetail(HttpServletRequest request, @PathVariable("ubno") Long ubno){
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
	public ResponseEntity<String> communityEdit(HttpServletRequest request, @RequestBody BoardDto boardDto){
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
	
	// 댓글 수정
	@PutMapping("/community-reply")
	public ResponseEntity<String> replyEdit(HttpServletRequest request, @RequestBody UserReplyDto replyDto){
		System.out.println("ooooooooooooooooooo");
		
		String username = request.getHeader("username");
		User user = new User();
		user.setUsername(username);
		
		UserBoard ub = new UserBoard();
		ub.setUbno(replyDto.getUbno());
		UserReply ur_ = urRepo.findById(replyDto.getReplyno()).get();
		ur_.setContent(replyDto.getContent());
		ur_.setReplyno(replyDto.getReplyno());
		ur_.setUser(user);
		ur_.setUserBoard(ub);
		UserReply ur = urRepo.save(ur_);
		
		System.out.println("수정된 userReply : " + ur);
		UserReply result = urRepo.save(ur);
		if(result != null) {
			return new ResponseEntity<>("댓글수정완료", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}
	}
	
	
	// 게시글 삭제
	@DeleteMapping("/community-board")
	public String communityDeletion(){
		return "";
	}
	
	
	// 게시글 신고
	@PostMapping("/community-report")
	public ResponseEntity<String> communityReport(HttpServletRequest request, @RequestParam("ubno") Long ubno) {
		// 사용자 정보 - username 받기
		String username = request.getHeader("username");
		
		User user = new User();
		user.setUsername(username);
		
		UserBoard ub = new UserBoard();
		ub.setUbno(ubno);
		
		BoardReport boardReport = new BoardReport();
		boardReport.setUser(user);
		boardReport.setUb(ub);
		brRepo.save(boardReport);
		
		
		return new ResponseEntity<>("게시글신고완료", HttpStatus.OK);
	}
	
	// 댓글 신고
	@PostMapping("/reply-report")
	public ResponseEntity<String> replyReport(HttpServletRequest request, @RequestParam("ubno") Long ubno) {
		// 사용자 정보 - username 받기
		String username = request.getHeader("username");
		// 신고자 정보
		User user = new User();
		user.setUsername(username);

		// 신고당한 댓글 번호 - ubno로 알 수 있잖아!
		UserBoard userBoard = new UserBoard();
		userBoard.setUbno(ubno);

		UserReply ur = new UserReply();
		ur.setReplyno(userBoard.getUbno());
		System.out.println("!!!!!!user replyno : " + userBoard.getUbno());

		// 댓글 신고 엔티티에 이제 다넣어 (replyno, username)
		ReplyReport replyReport = new ReplyReport();
		replyReport.setUser(user);
		replyReport.setUReply(ur);
		replyReport.setReport_date(new Date());
		rrRepo.save(replyReport);

		return new ResponseEntity<>("댓글신고완료", HttpStatus.OK);
	}
	
	// http://localhost:9001/api/v1/user/community-myboard
	// 구직자 마이페이지 - 내가 쓴 게시글 목록 조회
	@GetMapping("/community-myboard")
	public List<UserBoard> communityMyBoardList(HttpServletRequest request){
		
		String username = request.getHeader("username");
		User user = new User();
		user.setUsername(username);
		
		List<UserBoard> ubList = ubRepo.findByUser(user);
		System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnn"+ubList);
		return ubList;
	}
	
//	// 구직자 마이페이지 - 내가 쓴 게시글 디테일
//	@GetMapping("/community-myboardDetail")
//	public UserBoard communityMyBoard(HttpServletRequest request, @RequestParam("ubno") Long ubno){
//		
//		String username = request.getHeader("username");
//		User user = new User();
//		user.setUsername(username);
//		
//		UserBoard ub = ubRepo.findById(ubno).get();
//		System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnn"+ub);
//		return ub;
//	}
	
	
	
	// 유저 커뮤니티 검색 리스트
	@GetMapping("/community-board/search-result/{keyword}")
	public ResponseEntity<List<UserBoard>> getKeywordList(@PathVariable("keyword") String keyword){
		System.out.println("유저 커뮤니티 검색~");
		List<UserBoard> list = ubRepo.findByTitleContainingOrContentContaining(keyword, keyword);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
}
