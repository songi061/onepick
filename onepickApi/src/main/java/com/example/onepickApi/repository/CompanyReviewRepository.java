package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.CompanyReview;
import com.example.onepickApi.entity.UserReview;

public interface CompanyReviewRepository extends JpaRepository<CompanyReview, Long>{

	@Query(value="select * from company_review where cid=:cid", nativeQuery=true)
	public List<CompanyReview> findByCid(@Param("cid") String cid);
	
	@Query(value="select AVG(rating) FROM company_review where cid=:cid", nativeQuery=true)
	public Long getAvgScore(@Param("cid") String cid);
}
