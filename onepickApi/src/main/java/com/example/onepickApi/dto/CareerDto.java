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
public class CareerDto {
	private Long cno;
    private Resume resume;
    private User user;
    private LocalDate startDate;
    private LocalDate endDate;
    private String companyName;
    private String rank;
    private String career_status;
    private String c_type;
    private String position;
    private String work;
    
	public CareerDto(LocalDate startDate, LocalDate endDate, String companyName, String rank, String career_status,
			String c_type, String position, String work) {

		this.startDate = startDate;
		this.endDate = endDate;
		this.companyName = companyName;
		this.rank = rank;
		this.career_status = career_status;
		this.c_type = c_type;
		this.position = position;
		this.work = work;
	}
    
    
	
    
    
    
}
