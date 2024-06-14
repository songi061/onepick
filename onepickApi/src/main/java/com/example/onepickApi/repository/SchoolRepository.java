package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Experience;
import com.example.onepickApi.entity.School;

public interface SchoolRepository extends JpaRepository<School, Long>{
	List<School> findByResume_Rno(Long rno);
}
