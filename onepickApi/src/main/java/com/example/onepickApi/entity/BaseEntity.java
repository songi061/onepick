package com.example.onepickApi.entity;


import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@MappedSuperclass
@Data
public abstract class BaseEntity {

   
    private Date regdate;
    private Date moddate;
    @PrePersist
    protected void onCreate() {
        regdate = new Date();
    }
    @PreUpdate
    protected void onUpdate() {
        moddate = new Date();
    }
}