package com.example.onepickApi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.example.onepickApi.filter.LoginFilter;
import com.example.onepickApi.jwtToken.JWTUtil;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	
	private final AuthenticationConfiguration authenticationConfiguration;
	
	private final JWTUtil jwtUtil;
	
	public SecurityConfig(AuthenticationConfiguration authenticationConfiguration, JWTUtil jwtUtil) {
		this.authenticationConfiguration = authenticationConfiguration;
		this.jwtUtil = jwtUtil;
	}
	
	
	public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception{
		return configuration.getAuthenticationManager();
	}
	
	
	@Bean //패스워드 암호화 메소드 빈으로 등록
	public BCryptPasswordEncoder BCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf(auth -> auth.disable());
		
		//http.httpBasic(auth -> auth.disable());
		
		//http.authorizeHttpRequests(auth -> auth.anyRequest().permitAll());
		
		http.httpBasic(auth -> auth.disable());
		http.formLogin(auth -> auth.disable());
		
		http.authorizeHttpRequests(auth -> auth
				.requestMatchers("/**").permitAll()
				//.requestMatchers("/swagger-ui/**").permitAll()
				//.requestMatchers("/admin/**").hasRole("ADMIN")
				//.requestMatchers("/user/mypage/**").hasRole("USER")
				//.requestMatchers("/company/mypage/**", "/company/community/**").hasRole("COMPANY")
				.anyRequest().authenticated()
				);
		
		
		http.sessionManagement((session) -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		
		
		http.addFilterAfter(new LoginFilter(authenticationManager(authenticationConfiguration), jwtUtil), UsernamePasswordAuthenticationFilter.class);
		
		return http.build();
	}
	
}
