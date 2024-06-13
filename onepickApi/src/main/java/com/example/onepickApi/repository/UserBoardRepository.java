package com.example.onepickApi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.onepickApi.dto.UserBoardDto;
import com.example.onepickApi.entity.UserBoard;

public interface UserBoardRepository extends JpaRepository<UserBoard, Long>{
	/*
	@Query(value="SELECT ub.ubno, ub.title, ub.content, u.username FROM user u\r\n"
			+ "RIGHT JOIN user_board ub\r\n"
			+ "ON ub.uid = u.username\r\n"
			+ "WHERE ub.category=:category", nativeQuery =true)
	List<UserBoard> findByCategory(@Param("category") String category);
	*/
	/*
	@Query(value="SELECT ub.ubno, ub.title, ub.content, ub.category, ub.report, u.username FROM user u "
			+ "RIGHT JOIN user_board ub "
			+ "ON ub.uid = u.username "
			, nativeQuery =true)
			*/
    List<UserBoard> findByCategory(@Param("category") String category);
	
	
}
