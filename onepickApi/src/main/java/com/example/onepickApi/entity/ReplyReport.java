package com.example.onepickApi.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Entity
@Data
public class ReplyReport {
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
    @JoinColumn(name = "userReply", referencedColumnName = "replyno")
    private UserReply uReply;
	
	@ManyToOne
    @JoinColumn(name = "companyReply", referencedColumnName = "replyno")
    private CompanyReply cReply;
	
	private Date report_date;
	
}
