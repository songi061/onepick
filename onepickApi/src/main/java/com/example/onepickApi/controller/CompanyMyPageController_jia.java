package com.example.onepickApi.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.repository.CompanyRepository;

import jakarta.servlet.http.HttpServletRequest;

@CrossOrigin("*")
@RequestMapping("/api/v1/company")
@RestController
public class CompanyMyPageController_jia {

	@Autowired
	private CompanyRepository companyRepo;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private final Path rootLocation = Paths.get("/upload");
	
	@GetMapping("/detail")
	public ResponseEntity<Company> getComDetail(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			System.out.println(headers.nextElement());
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		if(!companyRepo.findById(request.getHeader("username")).isEmpty()) {
			return new ResponseEntity<>(companyRepo.findById(request.getHeader("username")).get(), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("/")
	public ResponseEntity<List<Company>> getComList() {
		List<Company> companyList = companyRepo.findAll();
			return new ResponseEntity<>(companyList, HttpStatus.OK);
	}
	
	@GetMapping("/mydetail")
	public ResponseEntity<Company> getMydetail(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames();
		while(headers.hasMoreElements()) {
			System.out.println(headers.nextElement());
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
			}
		}
		Company company = companyRepo.findById(request.getHeader("username")).get();
			return new ResponseEntity<>(company, HttpStatus.OK);
	}
	
	
	@PutMapping("/")
	public ResponseEntity<String> postCompany(@RequestBody Company company){
		System.out.println("company 회원가입 중.." + company);
		String newPw = bCryptPasswordEncoder.encode(company.getPassword());
		String role = "ROLE_COMPANY";
		
		company.setPassword(newPw);
		company.setRole(role);
		Company result = companyRepo.save(company);
		
		if(result != null) {
			
			return new ResponseEntity<>("수정 성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<>("수정 실패", HttpStatus.OK);
		}
	}
	
	@PutMapping("/file")
	public ResponseEntity<Company> updateFile(HttpServletRequest request, @RequestParam("file") MultipartFile file){
		System.out.println("사진 업데이트 중...");
		Enumeration<String> headers = request.getHeaderNames();
		Company company = new Company();
		while(headers.hasMoreElements()) {
			if(headers.nextElement().equals("username")) {
				System.out.println(request.getHeader("username"));
				String username = request.getHeader("username");
				 try {
			            // 만약 업로드할 폴더 없으면 만들기
			            if (!Files.exists(rootLocation)) {
			                Files.createDirectories(rootLocation);
			            }

			            //if (file != null && !file.isEmpty()) {
			                // 파일업로드
			                String originalFilename = file.getOriginalFilename();
			                String extension = originalFilename.substring(originalFilename.lastIndexOf('.'));
			                String filename = UUID.randomUUID().toString() + extension;
			                Path destinationFile = this.rootLocation.resolve(Paths.get(filename)).normalize().toAbsolutePath();

			                // 파일이 이미 존재하면 덮어쓰기 또는 다른 처리를 해야 할 수 있음
			                Files.copy(file.getInputStream(), destinationFile);

			                String filePath = destinationFile.toString();
			                
			                Optional<Company> result = companyRepo.findById(username);
			                
			                company = result.get();
			                
			                // jobad 엔티티에 파일 정보 설정
			                company.setFileName(filename);
			                company.setFilePath(filePath);
			                company.setFileSize(file.getSize());
			                
			            //}else {
			            	//파일 수정된거 없으면 원래 등록되어있던 파일 다시 넣어주기
			            	//jobAd.setFileName(jobAdRepo.findById(jnoLong).get().getFileName());
			                //jobAd.setFilePath(jobAdRepo.findById(jnoLong).get().getFilePath());
			                //jobAd.setFileSize(jobAdRepo.findById(jnoLong).get().getFileSize());
			            //}
			            //jobAd.setCompany(companyRepo.findById(request.getHeader("username")).get());
			            System.out.println(company);
			            companyRepo.updateFileInfo(username, filename, filePath, file.getSize());
			              
		                // jobad 엔티티 저장
		    			//JobAd jobad = jobAdRepo.save(jobAd);
		    			//jno = Long.toString(jobad.getJno());

			        } catch (IOException e) {
			            throw new RuntimeException("Could not create upload directory or save file!", e);
			        }
			}
		}
			            
		return new ResponseEntity<>(company, HttpStatus.OK);
	}
	
	
}
