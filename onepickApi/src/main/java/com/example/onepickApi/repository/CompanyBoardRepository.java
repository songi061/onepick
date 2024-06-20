package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.CompanyBoard;

public interface CompanyBoardRepository extends JpaRepository<CompanyBoard, Long>{

	List<CompanyBoard> findByCategory(String category);
	List<CompanyBoard> findByCompany(Company company);
	
	@Query(value="DELETE FROM company_board WHERE cbno= :cbno", nativeQuery=true)
	void deleteByCbno(@Param("cbno") Long cbno);
}
