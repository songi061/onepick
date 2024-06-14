package com.example.onepickApi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class UserReplyDto {
	
	private String username;
	private Long ubno;
	private String content;
	private Integer report;
}
