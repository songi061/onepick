package com.example.onepickApi.jwtToken;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import com.example.onepickApi.entity.User;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JWTFilter extends OncePerRequestFilter {
	
	private final JWTUtil jwtUtil;
	
	public JWTFilter(JWTUtil jwtUtil) {
		this.jwtUtil = jwtUtil;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String authorization = request.getHeader("Authorization");
		
		if(authorization == null || !authorization.startsWith("Bearer ")) {
			System.out.println("token null............");
			filterChain.doFilter(request, response);
			
			return;
		}
		
	
		
		String token = authorization.split(" ")[1];
		System.out.println("token 발견!!!" + token);
		
		if(jwtUtil.isExpired(token)) {
			System.out.println("token 만료!!!");
			filterChain.doFilter(request, response);
			
			return;
		}
		
		String username = jwtUtil.getUsername(token);
		String role = jwtUtil.getRole(token);
		
		System.out.println("userdata : " + username + ", " + role);
		
		
		User user = new User();
		user.setUsername(username);
		user.setPassword("temppassword");
		user.setRole(role);
		
		
		
	}

}
