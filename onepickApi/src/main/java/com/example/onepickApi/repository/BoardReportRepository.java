package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.BoardReport;

public interface BoardReportRepository  extends JpaRepository<BoardReport, Long> {

//	@Query(value="SELECT COUNT(*) FROM board_report WHERE cbno=:cbno", nativeQuery=true)
//	Integer findByCompany(@Param("cbno") Long cbno);
}
