package com.example.onepickApi.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.InterestedCop;

public interface InterestedCopRepository extends JpaRepository<InterestedCop, Long>{

	@Query(value="select * from interested_cop where cid=:cid and uid=:uid", nativeQuery=true)
	public InterestedCop findByCidAndUid(@Param("cid") String cid, @Param("uid") String uid);
}
