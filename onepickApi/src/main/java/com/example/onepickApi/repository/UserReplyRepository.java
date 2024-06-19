package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.User;
import com.example.onepickApi.entity.UserBoard;
import com.example.onepickApi.entity.UserReply;

public interface UserReplyRepository extends JpaRepository<UserReply, Long>{

	List<UserReply> findByUserBoard(UserBoard ub);
	
	List<UserReply> findByUser(User user);
}
