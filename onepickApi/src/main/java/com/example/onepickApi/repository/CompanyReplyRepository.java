package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.CompanyBoard;
import com.example.onepickApi.entity.CompanyReply;

public interface CompanyReplyRepository extends JpaRepository<CompanyReply, Long>{

	List<CompanyReply> findByCompanyBoard(CompanyBoard cb);
	
	List<CompanyReply> findByCompany(Company company);
}
