package com.example.onepickApi.entity;

import java.time.LocalDate;

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
public class License extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "lno", nullable = false)
	private Long lno;

	@ManyToOne
	@JoinColumn(name = "rno", referencedColumnName = "rno", nullable = false)
	private Resume resume;

	@ManyToOne
	@JoinColumn(name = "uid", referencedColumnName = "username", nullable = false)
	private User user;

	private String type;
	private String name;
	private String org;
	private LocalDate getDate;
	

}

