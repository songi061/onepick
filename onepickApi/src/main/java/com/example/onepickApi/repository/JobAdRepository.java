package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.dto.JobAdDto;
import com.example.onepickApi.entity.JobAd;

public interface JobAdRepository extends JpaRepository<JobAd, Long> {

	@Query(value="select * from job_ad where cid=:username", nativeQuery=true)
	List<JobAd> findByUsername(@Param("username") String username);
	
	@Query("SELECT j FROM JobAd j JOIN FETCH j.company WHERE j.id = :jno")
	JobAd findByIdWithCompany(@Param("jno") Long jno);
	
	// 마감일 기준으로 정렬하여 모든 공고 조회
	@Query(value="SELECT j.jno, j.cid, j.wanted_title, j.sector1, j.position1, j.job_cont, j.receipt_close_dt, j.emp_tp_nm, j.collect_psncnt ,j.sal_tp_nm ,j.mltsvc_exc_hope ,j.region1 ,j.region2, j.wkd_wkh_cnt, j.retirepay, c.name, c.file_name FROM Job_ad j JOIN company c  ON j.cid = c.username ORDER BY  j.receipt_close_dt ASC", nativeQuery=true)
    List<JobAdDto> findAllJobAdsWithCompanyOrderedByReceiptCloseDt();
}
