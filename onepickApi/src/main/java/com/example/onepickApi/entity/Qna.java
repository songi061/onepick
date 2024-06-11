package com.example.onepickApi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class Qna extends BaseEntity {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bno;
	
	@ManyToOne
	@JoinColumn(name = "uid", referencedColumnName = "username")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "cid", referencedColumnName = "username")
	private Company company;
	
	@Column(nullable = false)
	private String title;

	@Column(columnDefinition = "TEXT", nullable = false)
	private String content;
	private String category;
	@Column(columnDefinition = "TEXT", nullable = false)
	private String response;
	
	private boolean secret;

}
