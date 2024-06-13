package com.example.onepickApi.dto;

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
public class ResumeDto {
	private Long rno;
	private String user;
    private String title;
    private String def; //대표이력서 설정 ("Y","N")
    private String disclo; //공개 = public
    private String portfolioUrl;
    private String selfInfoTitle;
    private String selfInfoContent;
    private String region1;
    private String region1_1;
    private String region2;
    private String region2_1;
    private String sector;
    private String job;
}
