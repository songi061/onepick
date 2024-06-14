package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.ApplyList;

public interface ApplyListRepository extends JpaRepository<ApplyList, Long> {

	@Query(value="select * from apply_list where cid=:cid", nativeQuery=true)
	public List<ApplyList> findByCid(@Param("cid") String cid);
	
	@Query(value="select * from apply_list where cid=:cid and status='면접완료' and rating_status='false'", nativeQuery=true)
	public List<ApplyList> findIntervieweesByCid(@Param("cid") String cid);
	
	@Query(value="select * from apply_list where cid=:cid and uid=:uid and jno=:jno", nativeQuery=true)
	public ApplyList findInterviewee(@Param("cid") String cid, @Param("uid") String uid, @Param("jno") Long jno);
}
