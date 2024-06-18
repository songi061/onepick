package com.example.onepickApi.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.JobAd;

public interface JobAdRepository extends JpaRepository<JobAd, Long> {

	@Query(value="select * from job_ad where cid=:username", nativeQuery=true)
	List<JobAd> findByUsername(@Param("username") String username);
	
	@Query("SELECT j FROM JobAd j JOIN FETCH j.company WHERE j.id = :jno")
	JobAd findByIdWithCompany(@Param("jno") Long jno);
	
	// 마감일 기준으로 정렬하여 모든 공고 조회
	@Query(value="SELECT * FROM job_ad WHERE receipt_close_dt >= NOW() ORDER BY receipt_close_dt ASC LIMIT 6", nativeQuery=true)
    List<JobAd> findAllJobAdsWithCompanyOrderedByReceiptCloseDt();

	@Query(value="SELECT * FROM job_ad WHERE jno=:jno and receipt_close_dt >= NOW()", nativeQuery=true)
	JobAd findByJnoAndReceiptCloseDtAfterReceiptCloseDt(@Param("jno") Long jno);
	
	@Query(value="SELECT * FROM job_ad WHERE receipt_close_dt >= NOW()", nativeQuery=true)
	List<JobAd> findByReceiptCloseDtAfterReceiptCloseDt();
	
	@Query(value="SELECT * FROM job_ad WHERE receipt_close_dt >= NOW() AND wanted_title LIKE %:keyword%", nativeQuery=true)
    List<JobAd> findByReceiptCloseDtAfterAndWantedTitleContaining(@Param("keyword") String keyword);

	public List<JobAd> findByCompany_UsernameContainingOrCompany_NameContainingOrWantedTitleContaining(String companyUsername,
			String companyName, String wantedTitle);
	
	@Query("SELECT j.cid FROM Jobad j WHERE j.jno = :jno")
	Company findCidByJno(@Param("jno") Long jno);
}
