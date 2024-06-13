package com.example.onepickApi.secu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.onepickApi.entity.Member;
import com.example.onepickApi.repository.CompanyRepository;
import com.example.onepickApi.repository.UserRepository;

@Service
public class CustomUserDetailService implements UserDetailsService{
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CompanyRepository companyRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		Member member = userRepository.findByUsername(username);
		
		if(member == null) {
			member = companyRepository.findByUsername(username);
		}
		
		
		System.out.println("member11111 : " + member);
		
		if(member != null) {
			CustomUserDetails memberData = new CustomUserDetails(member);
			return memberData;
		}
		
		return null;
	}

	
}
