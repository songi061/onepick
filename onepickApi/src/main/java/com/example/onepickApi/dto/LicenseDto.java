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
public class LicenseDto {
	private Long lno;
	private String resume;
	private String user;
	private String type;
	private String lname;
	private String org;
	private LocalDate getDate;
	
	public LicenseDto(String lname, String org, LocalDate getDate) {
		this.lname = lname;
		this.org = org;
		this.getDate = getDate;
	}
	
	
}
