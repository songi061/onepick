package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Resume;

public interface ResumeRepository extends JpaRepository<Resume, Long>{

}
