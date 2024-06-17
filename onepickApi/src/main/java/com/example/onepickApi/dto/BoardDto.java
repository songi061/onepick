package com.example.onepickApi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class BoardDto {
	private Long cbno = 0L;
	private Long ubno = 0L;
	private String username;
	private String title;
	private String content;
	private String category;
	private Integer report;
}
       