package com.example.onepickApi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class CompanyReplyDto {

	private String username;
	private Long cbno;
	private String content;
	private Integer report;
}
