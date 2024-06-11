package com.example.onepickApi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.onepickApi.entity.Notice;

public interface NoticeRepository extends JpaRepository<Notice, Long> {

}
