package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.JobadScrap;
import com.example.onepickApi.entity.User;

public interface JobadScrapRepository extends JpaRepository<JobadScrap, Long> {
	List<JobadScrap> findByUser(User user);
}
