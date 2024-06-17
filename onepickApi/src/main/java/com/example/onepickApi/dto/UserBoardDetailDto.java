package com.example.onepickApi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserBoardDetailDto {
	private Long ubno;
	private String category;
	private String title;
	private String content;
	private String username;
	private Integer boardReport;
	private Integer replyReport;
	private Integer views;
	private String reply_content;
	private String reply_username;
}
