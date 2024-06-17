package com.example.onepickApi.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Career;
import com.example.onepickApi.entity.Experience;

public interface CareerRepository extends JpaRepository<Career, Long> {
	List<Career> findByResume_Rno(Long rno);
	
	Career findByResumeRno(Long rno);
}
