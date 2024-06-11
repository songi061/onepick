package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.UserBoard;

public interface UserBoardRepository extends JpaRepository<UserBoard, Long>{

}
