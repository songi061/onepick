package com.example.onepickApi.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class BoardReport {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long reno;
	
	@ManyToOne
	@JoinColumn(name = "uid", referencedColumnName = "username")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "cid", referencedColumnName = "username")
	private Company company;
	
	@ManyToOne
    @JoinColumn(name = "ubno", referencedColumnName = "ubno")
    private UserBoard ub;
	
	@ManyToOne
    @JoinColumn(name = "cbno", referencedColumnName = "cbno")
    private CompanyBoard cb;
	
	private Date report_date;
	
}
