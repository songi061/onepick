package com.example.onepickApi.entity;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
public class Company extends BaseEntity implements Member{

		@Id
		private String username;
		@Column(nullable = false)
		private String password;
		@Column(nullable = false)
		private String role;
	    @Column(name = "logo")
	    private String logo;
	    private String name;
	    @Column(nullable = false)
	    private String ceo;
	    @Column(nullable = false)
	    private String num;
	    @Column(nullable = false)
	    private String addr;
	    @Column(nullable = false)
	    private String sector;
	    @Column(nullable = false)
	    private int employeesNum;
	    private String fileName;
		private String filePath;
		private Long fileSize;
	    @Column(nullable = false)
	    private String size;
	    @Column(nullable = false)
	    private String yrSales;
	    private String token;
	    
//	    // Company는 여러 JobAd를 가질 수 있음 (일대다 관계)
//	    @OneToMany(mappedBy = "company", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//	    private List<JobAd> jobAds;

	
}
