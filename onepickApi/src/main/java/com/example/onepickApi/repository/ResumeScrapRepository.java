package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.InterestedUser;
import com.example.onepickApi.entity.JobadScrap;
import com.example.onepickApi.entity.ResumeScrap;

public interface ResumeScrapRepository extends JpaRepository<ResumeScrap, Long>{

	
	@Query(value="select * from resume_scrap where rno=:rno and cid=:cid", nativeQuery=true)
	public ResumeScrap findByRnoAndCid(@Param("rno") Long rno, @Param("cid") String cid);
	
	

	@Query(value="select * from resume_scrap where cid=:cid", nativeQuery=true)
	public List<ResumeScrap> findByCid(@Param("cid") String cid);
}
