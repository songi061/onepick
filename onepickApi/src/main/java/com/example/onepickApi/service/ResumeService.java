package com.example.onepickApi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.example.onepickApi.repository.CareerRepository;
import com.example.onepickApi.repository.ExperienceRepository;
import com.example.onepickApi.repository.LicenseRepository;
import com.example.onepickApi.repository.OaRepository;
import com.example.onepickApi.repository.ResumeRepository;
import com.example.onepickApi.repository.SchoolRepository;

import jakarta.servlet.http.HttpServletRequest;
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
		
		//User user = new User();
		//user.setUsername("user1");
		//resume.setUser(user); //추후 시큐리티 적용하면 수정(유저네임)
		
		
		Resume savedResume = resumeRepo.save(resume);
		
		
		ex.setResume(savedResume);
		experienceRepo.save(ex);
		
		
		
		ca.setResume(savedResume);
		careerRepo.save(ca);
		
		
		
		oa.setResume(savedResume);
		oaRepo.save(oa);
		
		
		
		sc.setResume(savedResume);
		schoolRepo.save(sc);
		
		
		
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
	
	

	
		@Transactional
		public String updateResume(Long rno, ResumeDto resumeDto, CareerDto careerDto, ExperienceDto experienceDto,
		                           LicenseDto licenseDto, OaDto oaDto, SchoolDto schoolDto) {
		
		    // 이력서 정보 업데이트
		    Optional<Resume> optionalResume = resumeRepo.findById(rno);
		    if (optionalResume.isPresent()) {
		        Resume resume = optionalResume.get();
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
		
		        resumeRepo.save(resume); // 변경된 이력서 정보 저장
		
		        // 경력 정보 업데이트
		        updateCareer(rno, careerDto);
		
		        // 경험 정보 업데이트
		        updateExperience(rno, experienceDto);
		
		        // 라이선스 정보 업데이트
		        updateLicense(rno, licenseDto);
		
		        // 학력 정보 업데이트
		        updateSchool(rno, schoolDto);
		
		        // OA 정보 업데이트
		        updateOa(rno, oaDto);
		
		        return "이력서가 성공적으로 수정되었습니다.";
		    } else {
		        throw new RuntimeException("해당 이력서 번호가 존재하지 않습니다.");
		    }
		}
		
		private void updateCareer(Long rno, CareerDto careerDto) {
		    
		        Career career = careerRepo.findByResumeRno(rno);
		        career.setStartDate(careerDto.getStartDate());
		        career.setEndDate(careerDto.getEndDate());
		        career.setCompanyName(careerDto.getCompanyName());
		        career.setRank(careerDto.getRank());
		        career.setCareer_status(careerDto.getCareer_status());
		        career.setC_type(careerDto.getC_type());
		        career.setPosition(careerDto.getPosition());
		        career.setWork(careerDto.getWork());
		
		        careerRepo.save(career); // 변경된 경력 정보 저장
		    
		}
		
		private void updateExperience(Long rno, ExperienceDto experienceDto) {
		    	Experience experience = experienceRepo.findByResumeRno(rno);

		        experience.setStartDay(experienceDto.getStartDay());
		        experience.setEndDay(experienceDto.getEndDay());
		        experience.setEx_org(experienceDto.getEx_org());
		        experience.setEx_content(experienceDto.getEx_content());
		
		        experienceRepo.save(experience); // 변경된 경험 정보 저장
		    
		}
		
		private void updateLicense(Long rno, LicenseDto licenseDto) {
		 
		        License license = licenseRepo.findByResumeRno(rno);
		        license.setLname(licenseDto.getLname());
		        license.setOrg(licenseDto.getOrg());
		        license.setGetDate(licenseDto.getGetDate());
		
		        licenseRepo.save(license); // 변경된 라이선스 정보 저장
		    
		}
		
		private void updateSchool(Long rno, SchoolDto schoolDto) {
		   
		        School school = schoolRepo.findByResumeRno(rno);
		        school.setAccDate(schoolDto.getAccDate());
		        school.setGradDate(schoolDto.getGradDate());
		        school.setEduName(schoolDto.getEduName());
		        school.setMajor(schoolDto.getMajor());
		        school.setScore(schoolDto.getScore());
		        school.setS_status(schoolDto.getS_status());
		
		        schoolRepo.save(school); // 변경된 학력 정보 저장
		    
		}
		
		private void updateOa(Long rno, OaDto oaDto) {
				Oa oa = oaRepo.findByResumeRno(rno);
		        oa.setSkillName(oaDto.getSkillName());
		        oa.setOa_content(oaDto.getOa_content());
		
		        oaRepo.save(oa); // 변경된 OA 정보 저장
		    
	
		}
	
	
	
		@Transactional
	    public String setDefResume(Long rno) {
			resumeRepo.resetAllDefResumes();
			
	        Optional<Resume> optionalResume = resumeRepo.findById(rno);
	        if (optionalResume.isPresent()) {
	            Resume resume = optionalResume.get();
	            resume.setDef("Y"); // 대표 이력서로 설정
	            resume.setDisclo("public");
	            resumeRepo.save(resume); // 변경 사항 저장
	            return "대표 이력서로 설정되었습니다.";
	        } else {
	            throw new RuntimeException("해당 이력서를 찾을 수 없습니다.");
	        }
	    }
	
	
	
		
//		@Transactional
//	    public void saveResumeObj(Map<String, List<Resume>> map) {
//	        for (Map.Entry<String, List<Resume>> entry : map.entrySet()) {
//	            List<Resume> list = entry.getValue();
//	            for (Resume resume : list) {
//	                resumeRepo.save(resume);
//	                System.out.println("저장 완료: " + entry.getKey() + " - " + resume.getLname());
//	            }
//	        }
//	    }
		
		
//		@Transactional
//	    public void saveToDatabase(Map<String, List<Object>> dataMap, User user) {
//			
//			Long rno;
//			
//	        // resume 리스트 저장
//	        List<Object> resumeList = dataMap.get("resume");
//	        if (resumeList != null) {
//	            for (Object obj : resumeList) {
//	                if (obj instanceof Resume) {
//	                    Resume resultResume = resumeRepo.save((Resume) obj);
//	                    rno = resultResume.getRno();
//	                } else {
//	                    throw new IllegalArgumentException("이력서가 올바르지 않습니다");
//	                }
//	            }
//	        }
//
//	        // licence 리스트 저장
//	        List<Object> licenceList = dataMap.get("licence");
//	        if (licenceList != null) {
//	            for (Object obj : licenceList) {
//	                if (obj instanceof License) {
//	                	((License) obj).setResume(resumeRepo.findById(rno).get());
//	                	((License) obj).setUser(user);
//	                    licenseRepo.save((License) obj);
//	                } else {
//	                    throw new IllegalArgumentException("자격증이 올바르지 않습니다");
//	                }
//	            }
//	        }
//	        
//	        
//	        
//	        List<Object> careerList = dataMap.get("career");
//	        if (careerList != null) {
//	            for (Object obj : careerList) {
//	                if (obj instanceof Career) {
//	                	((Career) obj).setResume(resumeRepo.findById(rno).get());
//	                	((Career) obj).setUser(user);
//	                    careerRepo.save((Career) obj);
//	                } else {
//	                    throw new IllegalArgumentException("경력사항이 올바르지 않습니다");
//	                }
//	            }
//	        }
//	        
//	        
//	        List<Object> experienceList = dataMap.get("experience");
//	        if (experienceList != null) {
//	            for (Object obj : experienceList) {
//	                if (obj instanceof Experience) {
//	                	((Experience) obj).setResume(resumeRepo.findById(rno).get());
//	                	((Experience) obj).setUser(user);
//	                	experienceRepo.save((Experience) obj);
//	                } else {
//	                    throw new IllegalArgumentException("사회경력이 올바르지 않습니다");
//	                }
//	            }
//	        }
//	        
//	        
//	        List<Object> oaList = dataMap.get("oa");
//	        if (oaList != null) {
//	            for (Object obj : oaList) {
//	                if (obj instanceof Oa) {
//	                	((Oa) obj).setResume(resumeRepo.findById(rno).get());
//	                	((Oa) obj).setUser(user);
//	                	oaRepo.save((Oa) obj);
//	                } else {
//	                    throw new IllegalArgumentException("스킬(OA)이 올바르지 않습니다");
//	                }
//	            }
//	        }
//	        
//	        
//	        List<Object> schoolList = dataMap.get("school");
//	        if (oaList != null) {
//	            for (Object obj : schoolList) {
//	                if (obj instanceof School) {
//	                	((School) obj).setResume(resumeRepo.findById(rno).get());
//	                	((School) obj).setUser(user);
//	                	schoolRepo.save((School) obj);
//	                } else {
//	                    throw new IllegalArgumentException("학력사항이 올바르지 않습니다");
//	                }
//	            }
//	        }
//
//	    }
		
		
		
		
		@Transactional
	    public String saveToDatabase(Map<String, List<Object>> dataMap, User user) {
			Resume savedResume = null;
			
			
		    // resume 리스트 저장
		    List<Object> resumeList = dataMap.get("resume");
		    if (resumeList != null) {
		        for (Object obj : resumeList) {
		            if (obj instanceof Resume) {
		                savedResume = resumeRepo.save((Resume) obj);
		                System.out.println("저장된 이력서 : " + savedResume);
		            } else {
		                throw new IllegalArgumentException("이력서가 올바르지 않습니다");
		            }
		        }
		    }

		    if (savedResume == null) {
		        throw new IllegalStateException("이력서 저장이 안되었어요");
		    }

	        // licence 리스트 저장
	        List<Object> licenceList = dataMap.get("licence");
	        if (licenceList != null) {
	            for (Object obj : licenceList) {
	                if (obj instanceof License) {
	                    License license = (License) obj;
	                    license.setResume(savedResume);
	                    license.setUser(user);
	                    licenseRepo.save(license);
	                } else {
	                    throw new IllegalArgumentException("자격증이 올바르지 않습니다");
	                }
	            }
	        }
	        
	        

	        // career 리스트 저장
	        List<Object> careerList = dataMap.get("career");
	        if (careerList != null) {
	            for (Object obj : careerList) {
	                if (obj instanceof Career) {
	                    Career career = (Career) obj;
	                    career.setResume(savedResume);
	                    career.setUser(user);
	                    careerRepo.save(career);
	                } else {
	                    throw new IllegalArgumentException("경력사항이 올바르지 않습니다");
	                }
	            }
	        }

	        // experience 리스트 저장
	        List<Object> experienceList = dataMap.get("experience");
	        if (experienceList != null) {
	            for (Object obj : experienceList) {
	                if (obj instanceof Experience) {
	                    Experience experience = (Experience) obj;
	                    experience.setResume(savedResume);
	                    experience.setUser(user);
	                    experienceRepo.save(experience);
	                } else {
	                    throw new IllegalArgumentException("사회경력이 올바르지 않습니다");
	                }
	            }
	        }

	        // oa 리스트 저장
	        List<Object> oaList = dataMap.get("oa");
	        if (oaList != null) {
	            for (Object obj : oaList) {
	                if (obj instanceof Oa) {
	                    Oa oa = (Oa) obj;
	                    oa.setResume(savedResume);
	                    oa.setUser(user);
	                    oaRepo.save(oa);
	                } else {
	                    throw new IllegalArgumentException("스킬(OA)이 올바르지 않습니다");
	                }
	            }
	        }

	        // school 리스트 저장
	        List<Object> schoolList = dataMap.get("school");
	        if (schoolList != null) {
	            for (Object obj : schoolList) {
	                if (obj instanceof School) {
	                    School school = (School) obj;
	                    school.setResume(savedResume);
	                    school.setUser(user);
	                    schoolRepo.save(school);
	                } else {
	                    throw new IllegalArgumentException("학력사항이 올바르지 않습니다");
	                }
	            }
	        }
	        
	        
	        
	        return "등록완료";
	        
	    }
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
}
