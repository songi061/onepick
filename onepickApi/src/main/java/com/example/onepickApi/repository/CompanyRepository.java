package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Company;

public interface CompanyRepository extends JpaRepository<Company, String> {

}
