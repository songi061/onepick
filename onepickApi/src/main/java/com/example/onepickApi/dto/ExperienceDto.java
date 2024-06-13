package com.example.onepickApi.dto;

import java.time.LocalDate;

import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExperienceDto {
	private Long eno;
    private Resume resume;
    private String user;
    private LocalDate startDay;
    private LocalDate endDay;
    private String ex_org;
    private String ex_content;
    

    
	public ExperienceDto(LocalDate startDay, LocalDate endDay, String ex_org, String ex_content) {
		this.startDay = startDay;
		this.endDay = endDay;
		this.ex_org = ex_org;
		this.ex_content = ex_content;
	}
    
    
    
    
    
    
    
    
}	
