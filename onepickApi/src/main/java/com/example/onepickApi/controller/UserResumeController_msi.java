package com.example.onepickApi.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.onepickApi.dto.CareerDto;
import com.example.onepickApi.dto.ExperienceDto;
import com.example.onepickApi.dto.LicenseDto;
import com.example.onepickApi.dto.OaDto;
import com.example.onepickApi.dto.ResumeDto;
import com.example.onepickApi.dto.SchoolDto;
import com.example.onepickApi.entity.Career;
import com.example.onepickApi.entity.Experience;
import com.example.onepickApi.entity.License;
import com.example.onepickApi.entity.Oa;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.School;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.service.ResumeService;

import jakarta.websocket.server.PathParam;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
public class UserResumeController_msi {

	@Autowired
	private ResumeRepository repo;

	@Autowired
	private ResumeService resumeService;

	// 이력서 등록하기
	@PostMapping("/resume")
	public ResponseEntity<String> registResume(ResumeDto resumeDto, CareerDto careerDto, ExperienceDto experienceDto,
			LicenseDto licenseDto, OaDto oaDto, SchoolDto schoolDto) {
		// resume 엔티티 저장

		Resume resume = new Resume();
		resume.setDisclo(resumeDto.getDisclo());
		resume.setTitle(resumeDto.getTitle());
		resume.setSelfInfoTitle(resumeDto.getSelfInfoTitle());
		resume.setSelfInfoContent(resumeDto.getSelfInfoContent());
		resume.setRegion1(resumeDto.getRegion1());
		resume.setRegion1_1(resumeDto.getRegion1_1());
		resume.setRegion2(resumeDto.getRegion2());
		resume.setRegion2_1(resumeDto.getRegion2_1());
		resume.setSector(resumeDto.getSector());
		resume.setJob(resumeDto.getJob());
		resume.setPortfolioUrl(resumeDto.getPortfolioUrl());

		// experience 엔티티 저장

		Experience ex = new Experience();
		ex.setStartDay(experienceDto.getStartDay());
		ex.setEndDay(experienceDto.getEndDay());
		ex.setEx_org(experienceDto.getEx_org());
		ex.setEx_content(experienceDto.getEx_content());

		// license 엔티티 저장
		License li = new License();
		li.setLname(licenseDto.getLname());
		li.setOrg(licenseDto.getOrg());
		li.setGetDate(licenseDto.getGetDate());

		// School 엔티티 저장
		School sc = new School();
		sc.setAccDate(schoolDto.getAccDate());
		sc.setGradDate(schoolDto.getGradDate());
		sc.setEduName(schoolDto.getEduName());
		sc.setMajor(schoolDto.getMajor());
		sc.setScore(schoolDto.getScore());
		sc.setS_status(schoolDto.getS_status());

		// Career 엔티티 저장
		Career ca = new Career();
		ca.setStartDate(careerDto.getStartDate());
		ca.setEndDate(careerDto.getStartDate());
		ca.setCompanyName(careerDto.getCompanyName());
		ca.setRank(careerDto.getRank());
		ca.setCareer_status(careerDto.getCareer_status());
		ca.setC_type(careerDto.getC_type());
		ca.setPosition(careerDto.getPosition());
		ca.setWork(careerDto.getWork());

		// OA 엔티티 저장
		Oa oa = new Oa();
		oa.setSkillName(oaDto.getSkillName());
		oa.setOa_content(oaDto.getOa_content());

		String result = resumeService.saveResume(resume, ex, ca, oa, sc, li);

		if (result != null) {
			return ResponseEntity.ok(result); // 200 OK
		} else {
			return ResponseEntity.notFound().build(); // 404 Not Found
		}

	}

	// 이력서 가져오기
	@GetMapping("/resume")
	public List<Resume> getResumeList() {
		List<Resume> resumeList = repo.findAll();
		System.out.println("이력서 전체 불러오기 : " + resumeList);
		return resumeList;
	}

	
	
	// 개별이력서 가져오기
	/*
	 * @GetMapping("/{rno}") public Resume getResume(@PathVariable("rno") Long rno)
	 * { Optional<Resume> result = repo.findById(rno); Resume resume = result.get();
	 * System.out.println("이력서 개별 출력 : " + resume); return resume; }
	 */
	
	 @GetMapping("/resume/{rno}")
    public ResponseEntity<?> getResume(@PathVariable("rno") Long rno) {
        Optional<Resume> result = repo.findById(rno);
        
        if (result.isPresent()) {
            Resume resume = result.get();
            System.out.println("이력서 개별 출력 : " + resume);
            return ResponseEntity.ok(resume);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

	
	
	// 이력서 수정하기
	@PutMapping("/resume")
	public String updateResume() {
		return "";
	}

	
	//이력서 삭제하기
    @DeleteMapping("/resume/{rno}") 
    public ResponseEntity<String> deleteResume(@PathVariable("rno") Long rno) {
	  
	    resumeService.deleteResumeById(rno);
	  
 	    return ResponseEntity.ok("Deleted resume with rno=" + rno); 
    }
		 
    
    
    
    
    
    
    
    
    
    
    
    
    
	
}
