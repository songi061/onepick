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
import com.example.onepickApi.dto.CompanyReplyDto;
import com.example.onepickApi.dto.UserReplyDto;
import com.example.onepickApi.entity.BoardReport;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.CompanyBoard;
import com.example.onepickApi.entity.CompanyReply;
import com.example.onepickApi.entity.ReplyReport;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserBoard;
import com.example.onepickApi.entity.UserReply;
import com.example.onepickApi.repository.BoardReportRepository;
import com.example.onepickApi.repository.CompanyBoardRepository;
import com.example.onepickApi.repository.CompanyReplyRepository;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.ReplyReportRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RestController // 기업 커뮤니티
@RequestMapping("/api/v1/company")
public class CompanyCommunityController {

	@Autowired
	CompanyRepository cRepo;
	@Autowired
	CompanyBoardRepository cbRepo;
	@Autowired
	CompanyReplyRepository crRepo;
	@Autowired
	BoardReportRepository brRepo;
	@Autowired
	ReplyReportRepository rrRepo;

	
	// 게시글 등록
	@PostMapping("/community-board")
	public CompanyBoard communityForm(HttpServletRequest request, @RequestBody BoardDto boardDto) {

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
		System.out.println("boardDTo에서 나온 username : " + boardDto.getUsername());
		System.out.println("companyEntity에서 나온 username : " + com.getUsername());

		CompanyBoard cb_ = new CompanyBoard();
		cb_.setTitle(boardDto.getTitle());
		cb_.setContent(boardDto.getContent());
		cb_.setCategory(boardDto.getCategory());
		cb_.setCompany(com);
		CompanyBoard cb = cbRepo.save(cb_);

		System.out.println("saved companyBoard : " + cb);

		return cb;
	}

	// 커뮤니티 전체 게시물 리스트
	@GetMapping("/community-board")
	public List<CompanyBoard> communityList(@RequestParam(value = "category", required = false) String category) {

		// category에 따른 리스트
		System.out.println(category);
		List<CompanyBoard> result = cbRepo.findByCategory(category);
		System.out.println(result);

		return result;
	}

	// 게시물 상세보기
	@GetMapping("/community-board/{cbno}")
	public CompanyBoard communityDetail(@PathVariable("cbno") Long cbno) {
		CompanyBoard cb = cbRepo.findById(cbno).get();

		return cb;
	}

	// 게시물의 댓글보기
	@GetMapping("/community-comment")
	public List<CompanyReply> communityReply(@RequestParam("cbno") Long cbno) {
		// Map<String, Optional> map = new HashMap<>();
		CompanyBoard cb = cbRepo.findById(cbno).get();
		List<CompanyReply> cr = crRepo.findByCompanyBoard(cb);
		return cr;
	}

	
	// 기업 마이페이지 - 내가 쓴 댓글 목록 조회
	@GetMapping("/community-myComment")
	public List<CompanyReply> communityMyComment(HttpServletRequest request){
		
		String username = request.getHeader("username");
		Company company = new Company();
		company.setUsername(username);
		
		List<CompanyReply> cr = crRepo.findByCompany(company);
	    if (cr != null) {
	        return cr;
	    }else {
	    	return null;
	    } 
	}
	
	
	// 댓글 등록
	@PostMapping("/community-comment")
	public CompanyReply registReply(@RequestBody CompanyReplyDto crDto) {

		Long cbno_ = crDto.getCbno();
		System.out.println("************cbno************"+ cbno_);
		String content_ = crDto.getContent();
		Integer report_ = crDto.getReport();
		Company company = new Company();
		company.setUsername(crDto.getUsername());

		CompanyReply cr = new CompanyReply();
		cr.setCompany(company);
		CompanyBoard cb = cbRepo.findById(cbno_).get();
		cr.setCompanyBoard(cb);
		cr.setContent(content_);
		cr.setRegdate(new Date());
		cr.setReport(report_);
		System.out.println(cr);
		CompanyReply cr2 = crRepo.save(cr);

		return cr2;
	}

	// 게시글 수정
	@PutMapping("/community-board")
	public ResponseEntity<String> community(HttpServletRequest request, @RequestBody BoardDto boardDto) {
		System.out.println("dddddddd");
		CompanyBoard cb_ = cbRepo.findById(boardDto.getCbno()).get();
		cb_.setTitle(boardDto.getTitle());
		cb_.setContent(boardDto.getContent());
		cb_.setCategory(boardDto.getCategory());
		CompanyBoard cb = cbRepo.save(cb_);

		System.out.println("수정된 CompanyBoard : " + cb);
		CompanyBoard result = cbRepo.save(cb);
		if (result != null) {
			return new ResponseEntity<>("수정완료", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}
	}

	
	// 댓글 수정
	@PutMapping("/community-reply")
	public ResponseEntity<String> replyEdit(HttpServletRequest request, @RequestBody CompanyReplyDto replyDto){
		System.out.println("ooooooooooooooooooo");
		
		String username = request.getHeader("username");
		Company company = new Company();
		company.setUsername(username);
		
		CompanyBoard cb = new CompanyBoard();
		cb.setCbno(replyDto.getCbno());
		CompanyReply cr_ = crRepo.findById(replyDto.getReplyno()).get();
		cr_.setContent(replyDto.getContent());
		cr_.setReplyno(replyDto.getReplyno());
		cr_.setCompany(company);
		cr_.setCompanyBoard(cb);
		CompanyReply cr = crRepo.save(cr_);
		
		System.out.println("수정된 companyReply : " + cr);
		CompanyReply result = crRepo.save(cr);
		if(result != null) {
			return new ResponseEntity<>("댓글수정완료", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}
	}
	
	// 댓글 삭제
	@DeleteMapping("/community-reply")
	public String replyDeletion(@RequestParam("replyno") Long replyno) {
		System.out.println("댓글 삭제 시도~~~~~~~");
		crRepo.deleteById(replyno);
		System.out.println("댓글 삭제 완1!!1!!!!!");
				
		return "댓글 삭제 완료";
	}
	
	// 게시글 삭제
	@DeleteMapping("/community-board")
	public String communityDeletion(@RequestParam("cbno") Long cbno) {
		
		// cbno가 외래키로 연결된 데이터를 다 삭제
		CompanyBoard cb = cbRepo.findById(cbno).get();
		System.out.println("cb 있음-----");
		
		CompanyReply cr = new CompanyReply();
		cr.setCompanyBoard(cb);
		
		crRepo.delete(cr);
		System.out.println("cr 삭제----");
		
		brRepo.deleteByCompanyBoardCbno(cbno);
		System.out.println("br에서 삭제----");
		
		cbRepo.deleteById(cbno);
		System.out.println("cb 삭제----");
		
		return "게시글 삭제 완료";
	}


	// 게시글 신고
	@PostMapping("/community-report")
	public ResponseEntity<String> communityReport(HttpServletRequest request, @RequestParam("cbno") Long cbno) {
		// 사용자 정보 - username 받기
		String username = request.getHeader("username");

		// 신고자 정보
		Company company = new Company();
		company.setUsername(username);

		// 신고당한 게시물 번호
		CompanyBoard cb = new CompanyBoard();
		cb.setCbno(cbno);

		BoardReport boardReport = new BoardReport();
		boardReport.setCompany(company);
		boardReport.setCb(cb);
		boardReport.setReport_date(new Date());
		brRepo.save(boardReport);

		return new ResponseEntity<>("게시글신고완료", HttpStatus.OK);
	}

	// 댓글 신고
	@PostMapping("/reply-report")
	public ResponseEntity<String> replyReport(HttpServletRequest request, @RequestParam("cbno") Long cbno) {
		// 사용자 정보 - username 받기
		String username = request.getHeader("username");
		// 신고자 정보
		Company company = new Company();
		company.setUsername(username);

		// 신고당한 댓글 번호 - cbno로 알 수 있잖아!
		CompanyBoard companyBoard = new CompanyBoard();
		companyBoard.setCbno(cbno);

		CompanyReply cr = new CompanyReply();
		cr.setReplyno(companyBoard.getCbno());
		System.out.println("!!!!!!company replyno : " + companyBoard.getCbno());

		// 댓글 신고 엔티티에 이제 다넣어 (replyno, username)
		ReplyReport replyReport = new ReplyReport();
		replyReport.setCompany(company);
		replyReport.setCReply(cr);
		replyReport.setReport_date(new Date());
		rrRepo.save(replyReport);

		return new ResponseEntity<>("댓글신고완료", HttpStatus.OK);
	}
	
	
	// http://localhost:9001/api/v1/company/community-myboard
	// 기업 마이페이지 - 내가 쓴 게시글 목록 조회
	@GetMapping("/community-myboard")
	public List<CompanyBoard> communityMyBoardList(HttpServletRequest request){
		
		String username = request.getHeader("username");
		Company company = new Company();
		company.setUsername(username);
		
		List<CompanyBoard> cbList = cbRepo.findByCompany(company);
		System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnn"+cbList);
		return cbList;
	}
	

}
