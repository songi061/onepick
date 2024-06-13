package com.example.onepickView.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf(auth -> auth.disable());
		
		http.httpBasic(auth -> auth.disable());
		
		//http.authorizeHttpRequests(auth -> auth.anyRequest().permitAll());
		
		// 인증하지 않겠다(permitAll)나머지는 인증을 거친다(anyRequest)
		http.authorizeHttpRequests((auth) -> auth
			.requestMatchers("/user/**").hasAnyRole("ADMIN", "USER") //ROLE_는 자동 붙어짐
			.requestMatchers("/company/**").hasAnyRole("ADMIN", "COMPANY") //ROLE_는 자동 붙어짐
			.requestMatchers("/admin/**").hasAnyRole("ADMIN")
			.anyRequest().permitAll()
		);
				
		// 로그인에 대한 설정
		//http.formLogin((auth) -> auth
			//.loginPage("/login") // 로그인 폼 지정(직접 만든 로그인 페이지 경로) - 쓰지 않으면 Spring Security가 제공하는 로그인 폼 사용
			//.loginProcessingUrl("/loginProc") // 로그인 폼 지정 후 폼 파라미터 보내는 경로 지정(실제로 처리하는 url, 컨트롤러를 만들지 않음) - 컨트롤러에 직접 만들지 않는다.(Spring Security)
			//.defaultSuccessUrl("/") // 로그인 성공했을 때 갈 페이지
			//.permitAll()
		//);
				
		return http.build();
	}
}
