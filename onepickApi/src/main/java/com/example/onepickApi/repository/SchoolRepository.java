package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.JobAd;
import com.example.onepickApi.entity.School;

public interface SchoolRepository extends JpaRepository<School, Long>{
	List<School> findByResume_Rno(Long rno);
	
	School findByResumeRno(Long rno);
	
	@Query(value="SELECT s.* FROM school s " +
            "JOIN resume re ON s.rno = re.rno " +
            "WHERE re.disclo LIKE %:keyword% " +
            "OR re.sector LIKE %:keyword% " +
            "OR re.region1 LIKE %:keyword% " +
            "OR re.region1_1 LIKE %:keyword% " +
            "OR re.job LIKE %:keyword% " +
            "OR s.major LIKE %:keyword%", nativeQuery=true)
	List<School> findByMultipleKeywords(@Param("keyword") String keyword);
	

	
	//@Query(value="SELECT s.sno, s.acc_date,  s.rno, major, sno, s.major, s.s_status, s_status FROM resume r JOIN school s ON r.rno = s.rno WHERE def='Y'", nativeQuery=true)
	//List<School> findByResumeDef();
}
