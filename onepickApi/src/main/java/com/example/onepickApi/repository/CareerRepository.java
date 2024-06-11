package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Career;

public interface CareerRepository extends JpaRepository<Career, Long> {

}
