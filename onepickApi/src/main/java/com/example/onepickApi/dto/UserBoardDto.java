package com.example.onepickApi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserBoardDto {
	
	// 하드코딩 했으니 고쳐야 함.
	private Long ubno = 0L;
	private String username;
	private String title;
	private String content;
	private String category;
	//private String writer;
	//user, company 상관없이
	private Integer report;
}
