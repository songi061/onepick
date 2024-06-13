package com.example.onepickApi.dto;

import com.example.onepickApi.entity.Resume;
import com.example.onepickApi.entity.User;

import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OaDto {
	private Long ono;
	private Resume resume;
	private User user;
    private String skillName;
    private String oa_content;
    
	public OaDto(String skillName, String oa_content) {
		this.skillName = skillName;
		this.oa_content = oa_content;
	}
    
    
}
