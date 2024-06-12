package com.example.onepickApi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
public class Company extends BaseEntity {

		@Id
	    private String username;

	    @Column(name = "logo")
	    private String logo;
	    private String name;
	    @Column(nullable = false)
	    private String password;
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
	    private String url;
	    @Column(nullable = false)
	    private String size;
	    @Column(nullable = false)
	    private String yrSales;
	
}
