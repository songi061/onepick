package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Experience;
import com.example.onepickApi.entity.Oa;

public interface OaRepository extends JpaRepository<Oa, Long> {
	List<Oa> findByResume_Rno(Long rno);
}
