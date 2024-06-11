package com.example.onepickApi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Notice extends BaseEntity {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long nno;
	
	@Column(nullable = false)
	private String title;

	@Column(columnDefinition = "TEXT", nullable = false)
	private String content;
	
}
