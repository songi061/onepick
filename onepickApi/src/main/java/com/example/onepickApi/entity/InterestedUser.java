package com.example.onepickApi.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class InterestedUser extends BaseEntity{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long interuno;

	@ManyToOne
	@JoinColumn(name = "uid", referencedColumnName = "username", nullable = false)
	private User user;

	@ManyToOne
	@JoinColumn(name = "cid", referencedColumnName = "username", nullable = false)
	private Company company;
	
	@ManyToOne
    @JoinColumn(name = "rno", referencedColumnName = "rno", nullable = false)
    private Resume resume;
}