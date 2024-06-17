package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;

public interface ResumeRepository extends JpaRepository<Resume, Long>{
	
	List<Resume> findByUser(User user);

	@Query(value="SELECT * FROM resume WHERE uid =:username AND def = :def", nativeQuery=true)
	Resume findByUserAndDef(@Param("username") String username, @Param("def") String def);
}
