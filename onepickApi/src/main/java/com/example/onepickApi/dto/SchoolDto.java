package com.example.onepickApi.dto;

import java.time.LocalDate;

import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class SchoolDto {
	private Long sno;
	private String resume;
	private String user;
	private LocalDate accDate;
	private LocalDate gradDate;
	private String eduName;
	private String major;
	private String score;
	private String s_status;
	
	public SchoolDto(LocalDate accDate, LocalDate gradDate, String eduName, String major, String score, String s_status) {
		this.accDate = accDate;
		this.gradDate = gradDate;
		this.eduName = eduName;
		this.major = major;
		this.score = score;
		this.s_status = s_status;
	}
	
	
}
