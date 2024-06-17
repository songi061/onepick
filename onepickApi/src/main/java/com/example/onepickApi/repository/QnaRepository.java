package com.example.onepickApi.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Qna;

public interface QnaRepository extends JpaRepository<Qna, Long>{

	Optional<Qna> findByUserUsername(String username);

	Optional<Qna> findByCompanyUsername(String username);
	
	Page<Qna> findAll(Pageable pageable);

	List<Qna> findAllByCompanyUsername(String username);

	List<Qna> findAllByUserUsername(String username);

}
