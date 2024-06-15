package com.example.onepickApi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.onepickApi.entity.Career;
import com.example.onepickApi.entity.Experience;
import com.example.onepickApi.entity.License;
import com.example.onepickApi.entity.Oa;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.School;
import com.example.onepickApi.entity.User;
import com.example.onepickApi.repository.CareerRepository;
import com.example.onepickApi.repository.ExperienceRepository;
import com.example.onepickApi.repository.LicenseRepository;
import com.example.onepickApi.repository.OaRepository;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.SchoolRepository;

import jakarta.transaction.Transactional;

@Service
public class ResumeService {
	
	@Autowired
	private ResumeRepository resumeRepo;
	
	@Autowired
	private ExperienceRepository experienceRepo;
	
	@Autowired
	private CareerRepository careerRepo;
	
	@Autowired
	private OaRepository oaRepo;
	
	@Autowired
	private SchoolRepository schoolRepo;
	
	@Autowired
	private LicenseRepository licenseRepo;
	
	
	//rno를 불러와서 외래키 컬럼에 저장하기
	@Transactional
	public String saveResume(Resume resume, Experience ex, Career ca, Oa oa, School sc, License li) {
		
		User user = new User();
		user.setUsername("user1");
		resume.setUser(user); //추후 시큐리티 적용하면 수정(유저네임)
		
		
		Resume savedResume = resumeRepo.save(resume);
		
		ex.setUser(user);
		ex.setResume(savedResume);
		experienceRepo.save(ex);
		
		
		ca.setUser(user);
		ca.setResume(savedResume);
		careerRepo.save(ca);
		
		
		oa.setUser(user);
		oa.setResume(savedResume);
		oaRepo.save(oa);
		
		
		sc.setUser(user);
		sc.setResume(savedResume);
		schoolRepo.save(sc);
		
		
		li.setUser(user);
		li.setResume(savedResume);
		licenseRepo.save(li);
		
		
		return "등록완료";
		
	}
	
	
	@Transactional
    public void deleteResumeById(Long rno) {
		Optional<Resume> result = resumeRepo.findById(rno);
		Resume resume = result.get();
	
		
        // 자식 엔티티 삭제
        List<Experience> experiences = experienceRepo.findByResume_Rno(resume.getRno());
        experienceRepo.deleteAll(experiences);
        
        
        List<Career> careers = careerRepo.findByResume_Rno(resume.getRno());
        careerRepo.deleteAll(careers);
        
        
        List<Oa> oa = oaRepo.findByResume_Rno(resume.getRno());
        oaRepo.deleteAll(oa);
        
        
        List<School> sc = schoolRepo.findByResume_Rno(resume.getRno());
        schoolRepo.deleteAll(sc);
        
        
        List<License> li = licenseRepo.findByResume_Rno(resume.getRno());
        licenseRepo.deleteAll(li);

        // 부모 엔티티 삭제
        resumeRepo.deleteById(rno);
    }
	
	
	@Transactional
    public Map<String, Object> getResumeDetails(Long rno) {
        Optional<Resume> resumeResult = resumeRepo.findById(rno);

        if (!resumeResult.isPresent()) {
            throw new IllegalArgumentException("Resume not found for rno: " + rno);
        }

        Resume resume = resumeResult.get();

        // 자식 엔티티 조회
        List<Experience> experiences = experienceRepo.findByResume_Rno(rno);
        List<Career> careers = careerRepo.findByResume_Rno(rno);
        List<Oa> oaList = oaRepo.findByResume_Rno(rno);
        List<School> schools = schoolRepo.findByResume_Rno(rno);
        List<License> licenses = licenseRepo.findByResume_Rno(rno);

        // 결과를 맵에 담기
        Map<String, Object> result = new HashMap<>();
        result.put("resume", resume);
        result.put("experiences", experiences);
        result.put("careers", careers);
        result.put("oaList", oaList);
        result.put("schools", schools);
        result.put("licenses", licenses);

        return result;
    }
	
}
