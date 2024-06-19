package com.example.onepickApi.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.entity.BoardReport;
import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.ReplyReport;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.BoardReportRepository;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.InterestedCopRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.JobadScrapRepository;
import com.example.onepickApi.repository.ReplyReportRepository;
import com.example.onepickApi.repository.SkillRepository;
import com.example.onepickApi.repository.UserRepository;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/admin/")
public class AdminController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private CompanyRepository companyRepository;

	@Autowired
	private JobAdRepository jobAdRepository;

	@Autowired
	private BoardReportRepository boardReportRepository;

	@Autowired
	private ReplyReportRepository replyReportRepository;

	@Autowired
	private InterestedCopRepository interestedCopRepository;

	@Autowired
	private JobadScrapRepository jobadScrapRepository;

	@Autowired
	private SkillRepository skillRepository;

	// 개인회원
	@GetMapping("/user")
	public ResponseEntity<List<User>> userList() {
		List<User> list = userRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

//	@DeleteMapping("/user/{username}")
//	public ResponseEntity<String> userDelete(@PathVariable("username") String username) {
//		userRepository.deleteById(username);
//		return ResponseEntity.ok("삭제 : " + username);
//	}

	@PutMapping("/user/{username}/active")
	public ResponseEntity<Void> setUserActive(@PathVariable("username") String username,
			@RequestParam("active") boolean active) {
		User user = userRepository.findById(username).get();
		user.setActive(active);
		userRepository.save(user);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/user-search/{keyword}")
	public ResponseEntity<List<User>> getAlluserListKeyword(@PathVariable("keyword") String keyword) {
		List<User> allList = userRepository.findByUsernameContainingOrNameContaining(keyword, keyword);
		return new ResponseEntity<>(allList, HttpStatus.OK);
	}

	// 기업회원
	@GetMapping("/company")
	public ResponseEntity<List<Company>> companyList() {
		List<Company> list = companyRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

//	@DeleteMapping("/company/{username}")
//	public ResponseEntity<String> companyDelete(@PathVariable("username") String username){
//		companyRepository.deleteById(username);
//		return ResponseEntity.ok("삭제 : " + username);
//	}

	@PutMapping("/company/{username}/active")
	public ResponseEntity<Void> setCompanyActive(@PathVariable("username") String username,
			@RequestParam("active") boolean active) {
		Company company = companyRepository.findById(username).get();
		company.setActive(active);
		companyRepository.save(company);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/company-search/{keyword}")
	public ResponseEntity<List<Company>> getAllcompanyListKeyword(@PathVariable("keyword") String keyword) {
		List<Company> allList = companyRepository.findByUsernameContainingOrNameContaining(keyword, keyword);
		return new ResponseEntity<>(allList, HttpStatus.OK);
	}

	// 공고 관리
	@GetMapping("/recruit")
	public ResponseEntity<List<JobAd>> jobAdList() {
		List<JobAd> list = jobAdRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@DeleteMapping("/recruit/{jno}")
	public ResponseEntity<String> jobAdDelete(@PathVariable("jno") Long jno) {
		System.out.println(jno);
		System.out.println("aaa");

		jobadScrapRepository.deleteByJno(jno);
		skillRepository.deleteByJno(jno);
		jobAdRepository.deleteById(jno);
		return ResponseEntity.ok("삭제 : " + jno);
	}

	@GetMapping("/recruit-search/{keyword}")
	public ResponseEntity<List<JobAd>> getAllJobAdListKeyword(@PathVariable("keyword") String keyword) {
		List<JobAd> list = jobAdRepository
				.findByCompany_UsernameContainingOrCompany_NameContainingOrWantedTitleContaining(keyword, keyword,
						keyword);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	// 신고 관리
	@GetMapping("/reported-board")
	public ResponseEntity<List<BoardReport>> boardReportList() {
		List<BoardReport> list = boardReportRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/reported-reply")
	public ResponseEntity<List<ReplyReport>> replyReportList() {
		List<ReplyReport> list = replyReportRepository.findAll();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	// 대시보드
	// 차트 컨트롤러
	@GetMapping("/dashboard-1")
	public ResponseEntity<Map<String, Object>> getDashboardData() {
		List<User> uList = userRepository.findAll();
		List<Company> cList = companyRepository.findAll();

		Map<String, Integer> userCountMap = new TreeMap<>();
		Map<String, Integer> companyCountMap = new TreeMap<>();
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 최근 일주일 날짜 생성
		for (int i = 6; i >= 0; i--) {
			LocalDate date = today.minusDays(i);
			String formattedDate = date.format(formatter);
			userCountMap.put(formattedDate, 0);
			companyCountMap.put(formattedDate, 0);
		}

		// 각 사용자의 가입 날짜를 확인하여 카운트
		for (User user : uList) {
			Date regDate = user.getRegdate();
			LocalDate localRegDate = regDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			String formattedDate = localRegDate.format(formatter);
			if (userCountMap.containsKey(formattedDate)) {
				userCountMap.merge(formattedDate, 1, Integer::sum);
			}
		}

		// 각 회사의 가입 날짜를 확인하여 카운트
		for (Company company : cList) {
			Date regDate = company.getRegdate();
			LocalDate localRegDate = regDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			String formattedDate = localRegDate.format(formatter);
			if (companyCountMap.containsKey(formattedDate)) {
				companyCountMap.merge(formattedDate, 1, Integer::sum);
			}
		}

		Map<String, Object> response = new HashMap<>();
		response.put("userCount", uList.size());
		response.put("companyCount", cList.size());
		response.put("weeklyUserRegistration", userCountMap);
		response.put("weeklyCompanyRegistration", companyCountMap);

		return ResponseEntity.ok(response);
	}

	// 인기 리스트 컨트롤러
	@GetMapping("/dashboard-2")
	public ResponseEntity<Map<String, List<Object[]>>> getPopularList() {
		List<Object[]> iList = interestedCopRepository.findCompaniesOrderByInterestCountDesc();
		List<Object[]> jList = jobadScrapRepository.findJobAdsOrderByScrapCountDesc();

		Map<String, List<Object[]>> result = new HashMap<>();
		result.put("interestedCompanies", iList);
		result.put("popularJobAds", jList);

		return ResponseEntity.ok(result);
	}

}
