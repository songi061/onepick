package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.InterestedUser;

public interface InterestedUserRepository extends JpaRepository<InterestedUser, Long>{

	@Query(value="select * from interested_user where cid=:cid", nativeQuery=true)
	public List<InterestedUser> findByCid(@Param("cid") String cid);
}
