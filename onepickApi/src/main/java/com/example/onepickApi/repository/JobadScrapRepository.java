package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.InterestedCop;
import com.example.onepickApi.entity.JobadScrap;
import com.example.onepickApi.entity.User;

public interface JobadScrapRepository extends JpaRepository<JobadScrap, Long> {
	List<JobadScrap> findByUser(User user);
	
	@Query(value="select * from jobad_scrap where jno=:jno and uid=:uid", nativeQuery=true)
	public JobadScrap findByJnoAndUid(@Param("jno") Long jno, @Param("uid") String uid);

    @Query("SELECT j.jobAd, COUNT(j) " +
            "FROM JobadScrap j " +
            "GROUP BY j.jobAd.jno " +
            "ORDER BY COUNT(j) DESC")
     List<Object[]> findJobAdsOrderByScrapCountDesc();

}
