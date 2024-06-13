package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Member;
import com.example.onepickApi.entity.User;

public interface UserRepository extends JpaRepository<User, String>{

	public Member findByUsername(String username);
	
}
