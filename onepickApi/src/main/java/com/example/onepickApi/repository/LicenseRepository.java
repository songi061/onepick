package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Experience;
import com.example.onepickApi.entity.License;

public interface LicenseRepository extends JpaRepository<License, Long> {
	List<License> findByResume_Rno(Long rno);
}
