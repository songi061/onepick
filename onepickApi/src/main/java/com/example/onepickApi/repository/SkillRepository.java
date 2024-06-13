package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.Skill;

public interface SkillRepository extends JpaRepository<Skill, Long>{

	@Query(value="select * from skill where jno=:jno", nativeQuery=true)
	public List<Skill> findAllByJno(@Param("jno") Long jno);
}
