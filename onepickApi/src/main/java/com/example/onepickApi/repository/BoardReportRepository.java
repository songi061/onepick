package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.BoardReport;
import com.example.onepickApi.entity.CompanyBoard;

public interface BoardReportRepository  extends JpaRepository<BoardReport, Long> {

//	@Query(value="SELECT COUNT(*) FROM board_report WHERE cbno=:cbno", nativeQuery=true)
//	Integer findByCompany(@Param("cbno") Long cbno);
	
	//@Query(value="DELETE FROM company_reply WHERE cbno= :cbno", nativeQuery=true)
	//void deleteByCompanyBoardCbno(@Param("cbno") Long cbno);
	
	@Query(value="DELETE FROM board_report WHERE cbno = :cbno", nativeQuery=true)
    void deleteByCompanyBoardCbno(@Param("cbno") Long cbno);
	
	@Query(value="DELETE FROM board_report WHERE ubno = :ubno", nativeQuery=true)
    void deleteByUserBoardUbno(@Param("ubno") Long ubno);
}
