package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.CompanyBoard;
import com.example.onepickApi.entity.ReplyReport;

public interface ReplyReportRepository extends JpaRepository<ReplyReport, Long>{
	@Query(value="DELETE FROM reply_report WHERE cbno= :cbno", nativeQuery=true)
	void deleteByCompanyBoard(@Param("cb") CompanyBoard cb);
}
