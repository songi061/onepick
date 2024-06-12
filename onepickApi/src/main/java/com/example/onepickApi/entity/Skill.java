package com.example.onepickApi.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
public class Skill extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long scno;
	
	@ManyToOne
	@JoinColumn(name = "jno", referencedColumnName = "jno", nullable = false)
	private JobAd jobAd;
	
	@ManyToOne
	@JoinColumn(name = "cid", referencedColumnName = "username", nullable = false)
	private Company company;
	
	private String skillName;
}
