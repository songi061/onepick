package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.ApplyList;

public interface ApplyListRepository extends JpaRepository<ApplyList, Long> {

	@Query(value="select * from apply_list where cid=:cid", nativeQuery=true)
	public List<ApplyList> findByCid(@Param("cid") String cid);
}
