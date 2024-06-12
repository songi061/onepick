package com.example.onepickApi.entity;

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
public class CompanyReview extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long crno;

    @ManyToOne
    @JoinColumn(name = "cid", referencedColumnName = "username", nullable = false)
    private Company company;

    @ManyToOne
    @JoinColumn(name = "uid", referencedColumnName = "username", nullable = false)
    private User user;

    @Column(nullable = false)
    private Integer rating;

}
