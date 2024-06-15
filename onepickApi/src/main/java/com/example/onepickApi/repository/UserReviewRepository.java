package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.UserReview;

public interface UserReviewRepository extends JpaRepository<UserReview, Long>{

	@Query(value="select * from user_review where cid=:cid", nativeQuery=true)
	public List<UserReview> findByCid(@Param("cid") String cid);
	
	@Query(value="select AVG(rating) FROM user_review where uid=:uid", nativeQuery=true)
	public Long getAvgScore(@Param("uid") String uid);
}
