package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Member;
import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;

public interface ResumeRepository extends JpaRepository<Resume, Long>{
	
	List<Resume> findByUser(User user);
}
