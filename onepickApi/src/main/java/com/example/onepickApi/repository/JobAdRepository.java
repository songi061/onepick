package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.JobAd;

public interface JobAdRepository extends JpaRepository<JobAd, Long> {

}
