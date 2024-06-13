package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.Member;

public interface CompanyRepository extends JpaRepository<Company, String> {

	public Member findByUsername(String username);
	
}
