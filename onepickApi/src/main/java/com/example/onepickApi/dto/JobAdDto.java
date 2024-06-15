package com.example.onepickApi.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class JobAdDto {
	private Long jno;
	private String cid;
	private String name;
	private String sector1;
	private String wantedTitle;
	private String position1;
	private String jobCont;
	private LocalDate receiptCloseDt;
	private String salTpNm;
	private String mltsvcExcHope;
	private String region1;
	private String region2;
	private String WkdWkhCnt;
	private String retirepay;
	private String etcWelfare;
	private String fileName;

}
