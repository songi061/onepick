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
public class Career extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cno;

    @ManyToOne
    @JoinColumn(name = "rno", referencedColumnName = "rno", nullable = false)
    private Resume resume;

    @ManyToOne
    @JoinColumn(name = "uid", referencedColumnName = "username", nullable = false)
    private User user;

    private LocalDate startDate;
    private LocalDate endDate;
    private String companyName;
    private String rank;
    private String career_status;
    private String c_type;
    private String position;
    private String work;
    
}
