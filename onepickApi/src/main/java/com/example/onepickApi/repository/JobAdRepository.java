package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.JobAd;

public interface JobAdRepository extends JpaRepository<JobAd, Long> {

	@Query(value="select * from job_ad where cid=:username", nativeQuery=true)
	List<JobAd> findByUsername(@Param("username") String username);
}
