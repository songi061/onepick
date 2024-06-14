package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


import com.example.onepickApi.entity.Experience;

public interface ExperienceRepository extends JpaRepository<Experience, Long>{

	 List<Experience> findByResume_Rno(Long rno);
}
