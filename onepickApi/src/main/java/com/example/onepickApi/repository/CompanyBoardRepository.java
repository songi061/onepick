package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.CompanyBoard;

public interface CompanyBoardRepository extends JpaRepository<CompanyBoard, Long>{

	List<CompanyBoard> findByCategory(String category);

}
