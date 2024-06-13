package com.example.onepickApi.entity;

import java.time.LocalDate;

import jakarta.persistence.Column;
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
public class JobAd extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long jno;

	@ManyToOne
	@JoinColumn(name = "cid", referencedColumnName = "username", nullable = false)
	private Company company;

	@Column(name = "sector1", nullable = false, length = 30)
	private String sector1;
	
	@Column(nullable = false, length = 30)
	private String sector2;

	@Column(nullable = false, length = 100)
	private String wantedTitle;

	@Column(nullable = false, length = 30)
	private String position1;
	
	@Column(nullable = false, length = 30)
	private String position2;

	@Column(nullable = false, columnDefinition = "TEXT")
	private String jobCont;
	
	@Column(name = "receiptCloseDt", nullable = false)
	private LocalDate receiptCloseDt;

	@Column(name = "empTpNm", nullable = false, length = 30)
	private String empTpNm;

	@Column(name = "collectPsncnt", nullable = false)
	private int collectPsncnt;

	@Column(name = "salTpNm", nullable = false, length = 30)
	private String salTpNm;

	@Column(name = "mltsvcExcHope",length = 10)
	private String mltsvcExcHope;

	@Column(name = "region1", nullable = false, length = 10)
	private String region1;
	
	@Column(name = "region2", nullable = false, length = 10)
	private String region2;

	@Column(name = "WkdWkhCnt", nullable = false, length = 50)
	private String WkdWkhCnt;

	@Column(name = "retirepay", length = 30)
	private String retirepay;

	@Column(name = "etcWelfare", nullable = false, columnDefinition = "TEXT")
	private String etcWelfare;

	private String fileName;
	private String filePath;
	private Long fileSize;

	@Column(name = "empName", nullable = false, length = 30)
	private String empName;

	@Column(name = "empEmail", nullable = false, length = 40)
	private String empEmail;

	@Column(name = "empTel", nullable = false, length = 20)
	private String empTel;
	private String experience;
	
	
}