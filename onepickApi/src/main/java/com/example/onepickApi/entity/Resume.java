package com.example.onepickApi.entity;

import java.time.LocalDate;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
public class Resume extends BaseEntity{
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rno", nullable = false)
    private Long rno;

	@ManyToOne
	@JoinColumn(name = "uid", referencedColumnName = "username", nullable = false)
	private User user;
	@Column
    private String title;
	@Column
    private String def = "N"; //대표이력서 설정 ("Y","N")
	@Column
    private String disclo = "private"; //공개,비공개 설정("public","private")

    private String portfolioUrl;
    private String selfInfoTitle;
    @Lob
    @Column(length = 10000)
    private String selfInfoContent;
    private String region1;
    private String region1_1;
    private String region2;
    private String region2_1;
    private String sector;
    private String job;
}