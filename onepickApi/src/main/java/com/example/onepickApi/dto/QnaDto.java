package com.example.onepickApi.dto;

import com.example.onepickApi.entity.Company;
import com.example.onepickApi.entity.User;

import lombok.Data;

@Data
public class QnaDto {
	private Long bno;
	private User user;
	private Company company;
	private String title;
	private String content;
	private String category;
	private String response;
	private boolean secret;
}
