package com.example.onepickApi.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.Skill;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.JobAdRepository;
import com.example.onepickApi.repository.SkillRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/recruit")
@RestController
public class RecruitController_jia {

	
	@Autowired
	private JobAdRepository jobAdRepo;
	@Autowired
	private CompanyRepository companyRepo;
	@Autowired
	private SkillRepository skillRepo;
	private final Path rootLocation = Paths.get("/upload");
	
	
	@GetMapping("/{jno}")
	public ResponseEntity<Map<String,Object>> getComList(@PathVariable("jno") Long jno) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("jobad", jobAdRepo.findById(jno).get());
		map.put("skill", skillRepo.findAllByJno(jno));
		
			return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@GetMapping("/myrecruit")
	public ResponseEntity<List<JobAd>> myrecruit(HttpServletRequest request) {
		
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		List<JobAd> myJobAdList = jobAdRepo.findByUsername(request.getHeader("username"));
			return new ResponseEntity<>(myJobAdList, HttpStatus.OK);
	}
	
	@DeleteMapping("/{jno}")
	public ResponseEntity<String> deleteJobad(@PathVariable("jno") Long jno) {
			jobAdRepo.deleteById(jno);
			return new ResponseEntity<>("done", HttpStatus.OK);
	}
	
	@PutMapping("/{jno}")
	public ResponseEntity<String> editJobad(@PathVariable("jno") Long jno) {
//			jobAdRepo.save();
			return new ResponseEntity<>("done", HttpStatus.OK);
	}
	
	@PostMapping("/")
	public ResponseEntity<String> regJobad( HttpServletRequest request, @ModelAttribute JobAd jobAd, @RequestParam("attachFileUrl") MultipartFile file) {
		String jno = null;
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
				
				 try {
			            // 만약 업로드할 폴더 없으면 만들기
			            if (!Files.exists(rootLocation)) {
			                Files.createDirectories(rootLocation);
			            }

			            if (file != null && !file.isEmpty()) {
			                // 파일업로드
			                String originalFilename = file.getOriginalFilename();
			                String extension = originalFilename.substring(originalFilename.lastIndexOf('.'));
			                String filename = UUID.randomUUID().toString() + extension;
			                Path destinationFile = this.rootLocation.resolve(Paths.get(filename)).normalize().toAbsolutePath();

			                // 파일이 이미 존재하면 덮어쓰기 또는 다른 처리를 해야 할 수 있음
			                Files.copy(file.getInputStream(), destinationFile);

			                String filePath = destinationFile.toString();

			                // jobad 엔티티에 파일 정보 설정
			                jobAd.setFileName(filename);
			                jobAd.setFilePath(filePath);
			                jobAd.setFileSize(file.getSize());
			                
			            }
			            jobAd.setCompany(companyRepo.findById(request.getHeader("username")).get());
			            System.out.println(jobAd);
			              
		                // jobad 엔티티 저장
		    			JobAd jobad = jobAdRepo.save(jobAd);
		    			jno = Long.toString(jobad.getJno());

			        } catch (IOException e) {
			            throw new RuntimeException("Could not create upload directory or save file!", e);
			        }
			}
		}
			return new ResponseEntity<>(jno, HttpStatus.OK);
	}
	
	@PostMapping("/skill")
	public ResponseEntity<String> regSkill(@RequestParam("jno") Long jno, HttpServletRequest request, @RequestBody List<String> list) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		
		for(int i = 0; i<list.size(); i++) {
			Skill skill = new Skill();
			
		//skill 엔티티에 정보 저장
	       skill.setJobAd(jobAdRepo.findById(jno).get());
	       skill.setCompany(companyRepo.findById(request.getHeader("username")).get());
	       skill.setSkillName(list.get(i));
	       
	     //skill 엔티티에 정보 저장
			skillRepo.save(skill);
		}
			return new ResponseEntity<>("done", HttpStatus.OK);
	}
}
