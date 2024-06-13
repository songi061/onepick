package com.example.onepickApi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class OnepickApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(OnepickApiApplication.class, args);
	}

}
