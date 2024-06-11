package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.UserReview;

public interface UserReviewRepository extends JpaRepository<UserReview, Long>{

}
